# WriteR Version 0.160105.3

import wx, sys #, json
from wx.py.shell import Shell
from wx.aui import AuiManager, AuiPaneInfo
from threading import Thread, Event
from subprocess import Popen, PIPE, STDOUT
from os.path import join, split, isdir, expanduser, realpath
from os import walk
from time import asctime, sleep

print_option = False

# set up some ID tags
ID_CENTEREDTEXT = wx.NewId()
ID_RIGHTALIGNED = wx.NewId()
ID_BOLD = wx.NewId()
ID_ITALIC = wx.NewId()
ID_MATH = wx.NewId()
ID_SMALLCAPS = wx.NewId()
ID_STATUSBAR = wx.NewId()
ID_CHAPTER = wx.NewId()
ID_SECTION = wx.NewId()
ID_EQUATION = wx.NewId()
ID_ITEMIZE = wx.NewId()
ID_ENUMERATE = wx.NewId()
ID_FIGURE = wx.NewId()

ID_TEST = wx.NewId()
ID_BUILD = wx.NewId()

ID_SETTINGS = wx.NewId()
# set up global text strings
SBText = "This program is for starting R Markdown files"


def dcf_dumps(data, sort_keys=True):
    string = ""
    for k, v in sorted(data.iteritems()):
        if v is None: v = 'None'
        string += "{:}: {:}\n".format(k, v.replace('\n', '\n '))
    return string


def dcf_loads(string):
    dictionary = {}
    last_key = None
    for l in string.split('\n'):
        if l == '': continue
        elif l[0] == ' ': dictionary[last_key] += "\n{:}".format(l[1:])
        else:
            k, v = l.split(': ')
            if v == 'None': v = None
            dictionary[k] = v
            last_key = k
    return dictionary


def printing(*args):
    if print_option: print args


class BashProcessThread(Thread):
    def __init__(self, flag, input_list, writelineFunc):
        Thread.__init__(self)

        self.flag = flag
        self.writelineFunc = writelineFunc
        self.setDaemon(True)
        self.input_list = input_list
        printing(input_list)
        self.comp_thread = Popen(input_list, stdout=PIPE, stderr=STDOUT)

    def run(self):
        printing('hello')
        self.writelineFunc(self.comp_thread.communicate()[0])

        # while True:
        #     if self.flag.isSet():
        #         self.comp_thread.terminate()
        #         return
        #     for line in iter(self.comp_thread.stdout.readline, b''):
        #         if self.flag.isSet():
        #             self.comp_thread.terminate()
        #             return
        #         printing("line", line)
        #         self.writelineFunc(line)
        printing("on my way out")


class MyInterpretor(object):
    def __init__(self, locals, rawin, stdin, stdout, stderr):
        self.introText = "Welcome to stackoverflow bash shell"
        self.locals = locals
        self.revision = 1.0
        self.rawin = rawin
        self.stdin = stdin
        self.stdout = stdout
        self.stderr = stderr

        self.more = False

        # bash process
        self.bp = Popen(['python', '-u', 'test_out.py'], shell=False, stdout=PIPE, stdin=PIPE, stderr=STDOUT)

        # start output grab thread
        self.outputThread = BashProcessThread(self.bp.stdout.readline)
        self.outputThread.start()

        # start err grab thread
        # self.errorThread = BashProcessThread(self.bp.stderr.readline)
        # self.errorThread.start()

    def getAutoCompleteKeys(self):
        return [ord('\t')]

    def getAutoCompleteList(self, *args, **kwargs):
        return []

    def getCallTip(self, command):
        return ""

    def push(self, command):
        printing("command", command)
        command = command.strip()
        if not command: return

        self.bp.stdin.write(command + "\n")
        # wait a bit
        sleep(.1)

        # print output
        self.stdout.write(self.outputThread.getOutput())

        # print error
        # self.stderr.write(self.errorThread.getOutput())


ID_DIRECTORY_CHANGE = wx.NewId()
ID_R_PATH = wx.NewId()
ID_BUILD_COMMAND = wx.NewId()


class SettingsDialog(wx.Dialog):
    def __init__(self, parent, ID, title, size=wx.DefaultSize, pos=wx.DefaultPosition,
                 style=wx.DEFAULT_DIALOG_STYLE):
        wx.Dialog.__init__(self, parent, wx.ID_ANY, "Settings", pos, size, style)

        self._frame = parent

        s1 = wx.BoxSizer(wx.HORIZONTAL)
        self._default_directory = wx.TextCtrl(self, ID_DIRECTORY_CHANGE, parent.settings['dirname'],
                                              wx.Point(0, 0), wx.Size(350, 20))
        s1.Add((1, 1), 1, wx.EXPAND)
        s1.Add(wx.StaticText(self, -1, "Default directory"))
        s1.Add(self._default_directory)
        s1.Add((1, 1), 1, wx.EXPAND)
        s1.SetItemMinSize(1, (180, 20))

        s2 = wx.BoxSizer(wx.HORIZONTAL)
        self._default_CRAN = wx.TextCtrl(self, ID_DIRECTORY_CHANGE, parent.settings['repo'],
                                         wx.Point(0, 0), wx.Size(350, 20))
        s2.Add((1, 1), 1, wx.EXPAND)
        s2.Add(wx.StaticText(self, -1, "Default CRAN server"))
        s2.Add(self._default_CRAN)
        s2.Add((1, 1), 1, wx.EXPAND)
        s2.SetItemMinSize(1, (180, 20))

        s3 = wx.BoxSizer(wx.HORIZONTAL)
        self._r_path = wx.TextCtrl(self, ID_R_PATH, parent.settings['RDirectory'],
                                   wx.Point(0, 0), wx.Size(350, 20))
        s3.Add((1, 1), 1, wx.EXPAND)
        s3.Add(wx.StaticText(self, -1, "Rscript executable"))
        s3.Add(self._r_path)
        s3.Add((1, 1), 1, wx.EXPAND)
        s3.SetItemMinSize(1, (180, 20))

        s4 = wx.BoxSizer(wx.HORIZONTAL)
        self._build_command = wx.TextCtrl(self, ID_BUILD_COMMAND, parent.settings['buildcommand'],
                                          wx.Point(0, 0), wx.Size(350, 60), wx.TE_MULTILINE)
        s4.Add((1, 1), 1, wx.EXPAND)
        s4.Add(wx.StaticText(self, -1, "Built command\n(The braces {} denote\nthe file path placeholder.)"))
        s4.Add(self._build_command)
        s4.Add((1, 1), 1, wx.EXPAND)
        s4.SetItemMinSize(1, (180, 60))

        s5 = wx.BoxSizer(wx.HORIZONTAL)
        self._window_text = wx.TextCtrl(self, ID_BUILD_COMMAND, parent.settings['newText'],
                                        wx.Point(0, 0), wx.Size(350, 60), wx.TE_MULTILINE)
        s5.Add((1, 1), 1, wx.EXPAND)
        s5.Add(wx.StaticText(self, -1, "The default text included in all new files."))
        s5.Add(self._window_text)
        s5.Add((1, 1), 1, wx.EXPAND)
        s5.SetItemMinSize(1, (180, 60))

        grid_sizer = wx.GridSizer(cols=1)
        grid_sizer.SetHGap(5)
        grid_sizer.Add(s1)
        grid_sizer.Add(s2)
        grid_sizer.Add(s3)
        grid_sizer.Add(s4)
        grid_sizer.Add(s5)

        cont_sizer = wx.BoxSizer(wx.VERTICAL)
        cont_sizer.Add(grid_sizer, 1, wx.EXPAND | wx.ALL, 5)

        btn_sizer = wx.StdDialogButtonSizer()

        if wx.Platform != "__WXMSW__":
            btn = wx.ContextHelpButton(self)
            btn_sizer.AddButton(btn)

        btn = wx.Button(self, wx.ID_OK)
        btn.SetHelpText("The OK button completes the dialog")
        btn.SetDefault()
        btn_sizer.AddButton(btn)

        btn = wx.Button(self, wx.ID_CANCEL)
        btn.SetHelpText("The Cancel button cancels the dialog. (Cool, huh?)")
        btn_sizer.AddButton(btn)
        btn_sizer.Realize()

        cont_sizer.Add(btn_sizer, 0, wx.ALIGN_CENTER_VERTICAL | wx.ALL, 5)

        self.SetSizer(cont_sizer)
        cont_sizer.Fit(self)


# get on with the program
class MainWindow(wx.Frame):
    def __init__(self, parent=None, id=-1, title="", pos=wx.DefaultPosition,
                 size=(400, 300), style=wx.DEFAULT_FRAME_STYLE |
                                        wx.SUNKEN_BORDER |
                                        wx.CLIP_CHILDREN, filename="untitled.Rmd"):
        super(MainWindow, self).__init__(parent, id, title, pos, size, style)
        self.Bind(wx.EVT_CLOSE, self.OnClose)
        self._mgr = AuiManager()
        self._mgr.SetManagedWindow(self)

        self.font = wx.Font(11, wx.MODERN, wx.NORMAL, wx.NORMAL, False, u'Consolas')
        # self.font.SetPointSize(int) # to change the font size

        self.settingsFile = "WriteROptions"
        self.settings = {'repo': "http://cran.stat.auckland.ac.nz/",
                         'dirname': 'none',
                         'templates': 'none',
                         'lastdir': expanduser('~'),
                         'filename': 'none',
                         'newText': "WriteR",
                         'RDirectory': self.GetRDirectory(),
                         'buildcommand': '''rmarkdown::render("{}")'''}

        self.settings = self.getSettings(self.settingsFile, self.settings)

        if len(sys.argv) > 1:
            self.settings['lastdir'], self.settings['filename'] = split(realpath(sys.argv[-1]))
            self.filename = self.settings['filename']
            self.dirname = self.settings['lastdir']

            self.CreateExteriorWindowComponents()
            self.CreateInteriorWindowComponents()

            self.fileOpen(self.dirname, self.filename)
        elif self.settings['filename'] == 'none':
            self.filename = filename
            self.dirname = self.settings['lastdir']

            self.CreateExteriorWindowComponents()
            self.CreateInteriorWindowComponents()

            self.OnOpen(self)
            #  set the save flag to true if OnOpen is cancelled
        else:
            self.filename = self.settings['filename']
            self.dirname = self.settings['lastdir']

            self.CreateExteriorWindowComponents()
            self.CreateInteriorWindowComponents()

            self.fileOpen(self.dirname, self.filename)

        printing(self.settings['RDirectory'])

        self.x = 0

        # create a flag for exiting subthreads
        self.sub_flag = Event()
        self.comp_thread = None

    def CreateInteriorWindowComponents(self):
        # self._mgr.AddPane(self.CreateShellCtrl(), wx.aui.AuiPaneInfo().Name("console")
        #                   .Caption("Console").Bottom().Layer(1).Position(1).CloseButton(True).
        #                   MaximizeButton(True).MinimizeButton(True).Hide())
        self.editor = self.CreateTextCtrl(self.settings['newText'])
        self.console = self.CreateTextCtrl("")
        self.console.SetEditable(False)
        self._mgr.AddPane(self.console, AuiPaneInfo().Name("console")
                          .Caption("Console").Bottom().Layer(1).Position(1).CloseButton(True)
                          .MinimizeButton(True).Hide())
        self._mgr.AddPane(self.editor, AuiPaneInfo().Name('editor').
                          CenterPane().Hide())

        self._mgr.GetPane("console").Hide().Bottom().Layer(0).Row(0).Position(0)
        self._mgr.GetPane("editor").Show()

        self.editor.SetFocus()
        self.editor.SelectAll()

        self._mgr.Update()
        # self.control = wx.TextCtrl(self, style=wx.TE_MULTILINE)

    def CreateExteriorWindowComponents(self):
        self.CreateMenu()
        self.StatusBar()
        self.SetTitle()

    def CreateMenu(self):
        fileMenu = wx.Menu()
        for id, label, helpText, handler in \
                [(wx.ID_NEW, "New file\tCtrl+N", "Start a new file", self.OnNewFile),
                 (wx.ID_OPEN, "&Open\tCtrl+O", "Open an existing file", self.OnOpen),
                 (wx.ID_SAVE, "&Save\tCtrl+S", "Save the current file", self.OnSave),
                 (wx.ID_SAVEAS, "Save &As\tCtrl+Shift+S", "Save the file under a different name", self.OnSaveAs),
                 (None,) * 4,
                 (
                 wx.ID_EXIT, "Quit && save\tCtrl+Q", "Saves the current file and closes the program", self.OnSafeExit)]:
            if id == None:
                fileMenu.AppendSeparator()
            else:
                item = fileMenu.Append(id, label, helpText)
                self.Bind(wx.EVT_MENU, handler, item)
        menuBar = wx.MenuBar()  # create the menu bar object
        menuBar.Append(fileMenu, "&File")  # Add the fileMenu to the MenuBar

        editMenu = wx.Menu()
        for id, label, helpText, handler in \
                [(wx.ID_CUT, "Cu&t\tCtrl+X", "Cut highlighted text to clipboard", self.OnCut),
                 (wx.ID_COPY, "&Copy\tCtrl+C", "Copy highlighted text to clipboard", self.OnCopy),
                 (wx.ID_PASTE, "&Paste\tCtrl+V", "Paste text from clipboard", self.OnPaste),
                 (wx.ID_SELECTALL, "Select all\tCtrl+A", "Highlight entire text", self.OnSelectAll),
                 (wx.ID_DELETE, "&Delete", "Delete highlighted text", self.OnDelete),
                 (None,) * 4,
                 (ID_SETTINGS, 'Settings', "Setup the editor to your liking", self.OnSettings)]:
            if id == None:
                editMenu.AppendSeparator()
            else:
                item = editMenu.Append(id, label, helpText)
                self.Bind(wx.EVT_MENU, handler, item)
        menuBar.Append(editMenu, "&Edit")  # Add the editMenu to the MenuBar

        buildMenu = wx.Menu()
        for id, label, helpText, handler in \
                [
                 # (ID_TEST, "Test the console\tF6", "Runs a test in the console", self.OnTest),
                 (ID_BUILD, "Build\tF5", "Build the script", self.OnBuild)]:
            if id == None:
                buildMenu.AppendSeparator()
            else:
                item = buildMenu.Append(id, label, helpText)
                self.Bind(wx.EVT_MENU, handler, item)
        menuBar.Append(buildMenu, "Build")  # Add the editMenu to the MenuBar

        helpMenu = wx.Menu()
        for id, label, helpText, handler in \
                [(wx.ID_ABOUT, "About", "Information about this program", self.OnAbout)]:
            if id == None:
                fileMenu.AppendSeparator()
            else:
                item = helpMenu.Append(id, label, helpText)
                self.Bind(wx.EVT_MENU, handler, item)

        menuBar.Append(helpMenu, "&Help")  # Add the helpMenu to the MenuBar
        self.SetMenuBar(menuBar)  # Add the menuBar to the Frame

    def CreateShellCtrl(self):
        shell = Shell(self, -1, wx.Point(0, 0), wx.Size(150, 90),
                      wx.NO_BORDER | wx.TE_MULTILINE, InterpClass=MyInterpretor)
        shell.SetFont(self.font)
        return shell

    def CreateTextCtrl(self, text):
        text = wx.TextCtrl(self, -1, text, wx.Point(0, 0), wx.Size(150, 90),
                           wx.NO_BORDER | wx.TE_MULTILINE)
        text.SetFont(self.font)
        return text

    def SetTitle(self, *args, **kwargs):
        # MainWindow.SetTitle overrides wx.Frame.SetTitle, so we have to
        # call it using super:
        super(MainWindow, self).SetTitle("WriteR -  %s" % self.filename)

    # Helper methods:
    def defaultFileDialogOptions(self):
        return dict(message="Choose a file", defaultDir=self.dirname, wildcard="*.*")

    def askUserForFilename(self, **dialogOptions):
        dialog = wx.FileDialog(self, **dialogOptions)
        if dialog.ShowModal() == wx.ID_OK:
            userProvidedFilename = True
            self.filename = dialog.GetFilename()
            self.dirname = dialog.GetDirectory()
            self.SetTitle()  # Update the window title with the new filename
        else:
            userProvidedFilename = False
        dialog.Destroy()
        return userProvidedFilename

    # Event handlers:
    def OnAbout(self, event):
        dialog = wx.MessageDialog(self, "WriteR is a  first attempt  at developing an R Markdown editor\n"
                                        "using wxPython, developed by Jonathan Godfrey\n"
                                        "and James Curtis in 2015.\nVersion: 0.150302",
                                  "About this R Markdown Editor", wx.OK)
        dialog.ShowModal()
        dialog.Destroy()

    def OnSafeExit(self, event):
        self.OnSave(event)
        self.OnExit(event)

    def OnExit(self, event):
        self.Close()  # Close the main window.

    def OnSave(self, event):
        textfile = open(join(self.dirname, self.filename), "w")
        textfile.write(self.editor.GetValue())
        textfile.close()

    def OnOpen(self, event):
        if self.askUserForFilename(style=wx.OPEN, **self.defaultFileDialogOptions()):
            self.fileOpen(self.dirname, self.filename)

    def fileOpen(self, dirname, filename):
            textfile = open(join(dirname, filename), "r")
            self.editor.SetValue(textfile.read())
            textfile.close()

    # what?
    def OnNewFile(self, event):
        self.olddirname = self.dirname
        self.dirname = ".\\templates"
        self.OnOpen(event)
        self.dirname = self.olddirname
        if self.filename == "Blank.Rmd":
            self.editor.WriteText("% file created on " + asctime() + "\n\n")
        self.OnSaveAs(event)

    def OnSaveAs(self, event):
        if self.askUserForFilename(defaultFile=self.filename, style=wx.SAVE, **self.defaultFileDialogOptions()):
            self.OnSave(event)
            # edit menu events

    def OnCut(self, event):
        self.editor.Cut()

    def OnCopy(self, event):
        self.editor.Copy()

    def OnPaste(self, event):
        self.editor.Paste()

    def OnDelete(self, event):
        frm, to = self.editor.GetSelection()
        self.editor.Remove(frm, to)

    def OnSelectAll(self, event):
        self.editor.SelectAll()

    # view menu events
    def ToggleStatusBar(self, event):
        if self.statusbar.IsShown():
            self.statusbar.Hide()
        else:
            self.statusbar.Show()
            self.SetStatusText(SBText)

    def StatusBar(self):
        self.statusbar = self.CreateStatusBar()
        self.statusbar.SetFieldsCount(3)
        self.statusbar.SetStatusWidths([-5, -2, -1])
        self.SetStatusText(SBText)

    def StartThread(self, input_object):
        if self.sub_flag.isSet(): return
        if self.comp_thread is not None:
            self.sub_flag.set()
            while self.comp_thread.isAlive():
                sleep(1)
            self.sub_flag.clear()
            self.console.SetValue('')

        self.comp_thread = BashProcessThread(self.sub_flag, input_object, self.console.WriteText)
        self.comp_thread.start()

    def OnTest(self, event):
        self._mgr.GetPane("console").Show().Bottom().Layer(0).Row(0).Position(0)
        self._mgr.Update()

        self.StartThread(['python', '-u', 'test_out.py'])

    def OnBuild(self, event):
        self._mgr.GetPane("console").Show().Bottom().Layer(0).Row(0).Position(0)
        self._mgr.Update()

        # This allows the file to be up to date for the build
        self.OnSave(event)

        self.StartThread([self.settings['RDirectory'], "-e",
                          '''if (!is.element('rmarkdown', installed.packages()[,1])){{'''.format() +
                          '''install.packages('rmarkdown', repos="{0}")}};require(rmarkdown);'''.format(
                              self.settings['repo']) +
                          self.settings['buildcommand'].format(
                              join(self.dirname, self.filename).replace('\\', '\\\\'))])

    # format menu events
    def OnBold(self, event):
        frm, to = self.editor.GetSelection()
        self.editor.SetInsertionPoint(to)
        self.editor.WriteText("}")
        self.editor.SetInsertionPoint(frm)
        self.editor.WriteText("{\\bf ")
        self.editor.SetInsertionPoint(to + 6)

    def OnItalic(self, event):
        frm, to = self.editor.GetSelection()
        self.editor.SetInsertionPoint(to)
        self.editor.WriteText("}")
        self.editor.SetInsertionPoint(frm)
        self.editor.WriteText("{\\it ")
        self.editor.SetInsertionPoint(to + 6)

    def OnMath(self, event):
        frm, to = self.editor.GetSelection()
        self.editor.SetInsertionPoint(to)
        self.editor.WriteText("$")
        self.editor.SetInsertionPoint(frm)
        self.editor.WriteText("$")
        self.editor.SetInsertionPoint(to + 2)

    def OnSmallCaps(self, event):
        frm, to = self.editor.GetSelection()
        self.editor.SetInsertionPoint(to)
        self.editor.WriteText("}")
        self.editor.SetInsertionPoint(frm)
        self.editor.WriteText("{\\sc ")
        self.editor.SetInsertionPoint(to + 6)

    def OnCenteredText(self, event):
        frm, to = self.editor.GetSelection()
        self.editor.SetInsertionPoint(to)
        self.editor.WriteText("}")
        self.editor.SetInsertionPoint(frm)
        self.editor.WriteText("{\\centering ")
        self.editor.SetInsertionPoint(to + 13)

    def OnRightAlignedText(self, event):
        frm, to = self.editor.GetSelection()
        self.editor.SetInsertionPoint(to)
        self.editor.WriteText("}")
        self.editor.SetInsertionPoint(frm)
        self.editor.WriteText("{\\flushright ")
        self.editor.SetInsertionPoint(to + 14)

    def OnClose(self, event):
        self.settings['filename'] = self.filename
        self.settings['lastdir'] = self.dirname
        self.setSettings(self.settingsFile, self.settings)

        if event.CanVeto() and self.editor.IsModified():
            hold = wx.MessageBox("Your file has not been saved. Would you like to save your work?",
                                 "Save before exit?",
                                 wx.ICON_QUESTION | wx.YES_NO | wx.CANCEL | wx.YES_DEFAULT)
            if hold == wx.YES:
                self.OnSaveAs(event)
                self.Destroy()
            elif hold == wx.NO:
                self.Destroy()
            else:
                event.Veto()
        else:
            self.Destroy()

    def GetRDirectory(self):
        def splitter(path, interest):
            look = split(path)
            if interest in look[1]:
                return look[1]
            if len(look[0]) == 0:
                return None
            return splitter(look[0], interest)

        rscript = 'Rscript.exe'
        warn = "Cannot find {} in default install location.".format(rscript)
        version = "R-0.0.0"
        choice = None

        if "No settings file reference to settings":
            if isdir("C:\\Program Files\\R"):
                hold = "C:\\Program Files\\R"
            elif isdir("C:\\Program Files (x86)\\R"):
                hold = "C:\\Program Files (x86)\\R"
            else:
                print warn; return

            options = [join(r, rscript) for r, d, f in walk(hold) if rscript in f]

            printing('options', options)
            if len(options) > 0:
                choice = options[0]
                for op in options[1:]:
                    vv = splitter(op, 'R-')
                    if vv >= version:
                        if 'x64' in op:
                            choice = op
                            version = vv
                        elif 'i386' in op and 'x64' not in choice:
                            choice = op
                            version = vv
                        elif 'i386' not in choice and 'x64' not in choice:
                            choice = op
                            version = vv
            else:
                print warn; return
        else:
            'something to get the information out of the settings file.'

        return choice

    def GetStartPosition(self):
        self.x = self.x + 20
        x = self.x
        pt = self.ClientToScreen(wx.Point(0, 0))

        return wx.Point(pt.x + x, pt.y + x)

    def getSettings(self, filepath, settings):
        try:
            file = open(filepath, 'r')
            sets = file.read()
            file.close()
            if len(sets) > 0:
                # sets = json.loads(sets)
                sets = dcf_loads(sets)
                assert (set(settings.keys()) == set(sets.keys()))
                return sets
        except:
            pass
        # print "Settings file incorrectly formatted. 'WriteR.init' has been reset."
        return self.setSettings(filepath, settings)

    def setSettings(self, filepath, settings):
        file = open(filepath, 'w')
        # file.write(json.dumps(settings, sort_keys=True, indent=4, separators=(',', ': ')))
        file.write(dcf_dumps(settings))
        file.close()
        return settings

    def OnSettings(self, event):

        dlg = SettingsDialog(self, -1, "Sample Dialog", size=(350, 200),
                             style=wx.DEFAULT_DIALOG_STYLE)
        dlg.CenterOnScreen()

        # this does not return until the dialog is closed.
        val = dlg.ShowModal()

        if val == wx.ID_OK:
            self.settings = self.setSettings(self.settingsFile,
                                             {'repo': dlg._default_CRAN.GetValue(),
                                              'dirname': dlg._default_directory.GetValue(),
                                              'lastdir': dlg._default_directory.GetValue(),
                                              'template': dlg._default_directory.GetValue(),
                                              'filename': self.settings['filename'],
                                              'newText': dlg._window_text.GetValue(),
                                              'RDirectory': dlg._r_path.GetValue(),
                                              'buildcommand': dlg._build_command.GetValue()})

        dlg.Destroy()

    # Insert menu events
    def OnInsertEquation(self, event):
        self.editor.WriteText(" \\begin{equation} \\label{}\n\n\\end{equation}\n")

    def OnInsertChapter(self, event):
        self.editor.WriteText(" \\chapter{} \\label{}\n\n")

    def OnInsertSection(self, event):
        self.editor.WriteText(" \\section{} \\label{}\n\n")

    def OnInsertFigure(self, event):
        self.editor.WriteText(" \\begin{figure} \\label{}\n%\\includegraphics{}\n\\end{figure}\n")

    def OnItemize(self, event):
        self.editor.WriteText(" \\begin{itemize}\n\\item \n\\item \n\\end{itemize}\n")

    def OnEnumerate(self, event):
        self.editor.WriteText(" \\begin{enumerate}\n\\item \n\\item \n\\end{enumerate}\n")


# manditory lines to get program running.
if __name__ == "__main__":
    app = wx.App()
    frame = MainWindow()
    frame.Show()
    app.MainLoop()
