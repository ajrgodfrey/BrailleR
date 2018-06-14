from wx.aui import AuiManager, AuiPaneInfo

class MyConsole:
    def __init__(self, parent):
        self.console = parent.CreateTextCtrl("")
        self.console.SetEditable(True)
        self.parent = parent
        parent._mgr.AddPane(self.console, AuiPaneInfo().Name("console")
                          .Caption("Console").Bottom().Layer(1).Position(1).CloseButton(True)
                          .MinimizeButton(True))
        # parent._mgr.GetPane("console").Bottom().Layer(0).Row(0).Position(0)
        self.console.SetValue('')
        self.console.write('Render output goes here')

    def Reset(self):
        self.console.SetValue('')

    def write(self, text):
        self.console.write(text)

    def CreateWriteText(self, text):
        self.console.write(text)

    def SetFocus(self):
        self.console.SetFocus()

    def DoneFunc(self, retcode):
        self.console.write("Done {}".format(retcode))
        self.parent.SetFocusConsole(True)
