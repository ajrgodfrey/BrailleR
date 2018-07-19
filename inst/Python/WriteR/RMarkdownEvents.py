import wx
import sys
from wx.py.shell import Shell
from wx.aui import AuiManager, AuiPaneInfo
from threading import Thread, Event
from subprocess import Popen, PIPE, STDOUT
from os.path import join, split, isdir, expanduser, realpath
from os import walk
from time import asctime, sleep

quiet = 'TRUE' # or 'FALSE', since these are 'R' constants

hardsettings = {'repo': "https://cloud.r-project.org",
                             'rendercommand': '''rmarkdown::render("{}",quiet={})''',
                             'renderallcommand': '''rmarkdown::render("{}", output_format="all",quiet={})''',
                             'renderslidycommand': '''rmarkdown::render("{}", output_format=slidy_presentation(),quiet={})''',
                             'renderpdfcommand': '''rmarkdown::render("{}", output_format=pdf_document(),quiet={})''',
                             'renderwordcommand': '''rmarkdown::render("{}", output_format=word_document(),quiet={})''',
                             'renderhtmlcommand': '''rmarkdown::render("{}", output_format="html_document",quiet={})''',
                             'knit2mdcommand': '''knitr::knit("{}",quiet={})''',
                             'knit2htmlcommand': '''knitr::knit2html("{}",quiet={})''',
                             'knit2pdfcommand': '''knitr::knit2pdf("{}",quiet={})'''}

def OnProcess(self, event, whichcmd):
        self._mgr.GetPane("console").Show().Bottom().Layer(0).Row(0).Position(0)
        self._mgr.Update()
        self.SetFocusConsole(False)
        self.OnSave(event) # This allows the file to be up to date for the build
        self.StartThread([self.settings['RDirectory'], "-e",
                          '''if (!is.element('rmarkdown', installed.packages()[,1])){{'''.format() +
                          '''install.packages('rmarkdown', repos="{0}")}};require(rmarkdown);'''.format(
                              hardsettings['repo']) +
                          hardsettings[whichcmd].format(
                              join(self.dirname, self.filename).replace('\\', '\\\\'),
                              quiet)])

def OnRenderNull(self, event):
    OnProcess(self, event, whichcmd='rendercommand')
def OnRenderHtml(self, event):
    OnProcess(self, event, whichcmd='renderhtmlcommand')
def OnRenderAll(self, event):
    OnProcess(self, event, whichcmd='renderallcommand')
def OnRenderWord(self, event):
    OnProcess(self, event, whichcmd='renderwordcommand')
def OnRenderPdf(self, event):
    OnProcess(self, event, whichcmd='renderpdfcommand')
def OnRenderSlidy(self, event):
    OnProcess(self, event, whichcmd='renderslidycommand')
def OnKnit2html(self, event):
    OnProcess(self, event, whichcmd='knit2htmlcommand')
def OnKnit2pdf(self, event):
    OnProcess(self, event, whichcmd='knit2pdfcommand')

def OnSelectRenderNull(self, event):
    self.Bind(wx.EVT_MENU, self.OnRenderNull, self.Render)
def OnSelectRenderHtml(self, event):
    self.Bind(wx.EVT_MENU, self.OnRenderHtml, self.Render)
def OnSelectRenderAll(self, event):
    self.Bind(wx.EVT_MENU, self.OnRenderAll, self.Render)
def OnSelectRenderWord(self, event):
    self.Bind(wx.EVT_MENU, self.OnRenderWord, self.Render)
def OnSelectRenderPdf(self, event):
    self.Bind(wx.EVT_MENU, self.OnRenderPdf, self.Render)
def OnSelectRenderSlidy(self, event):
    self.Bind(wx.EVT_MENU, self.OnRenderSlidy, self.Render)

def OnRCommand(self, event):
        frm, to = self.editor.GetSelection()
        self.editor.SetInsertionPoint(to)
        self.editor.WriteText("`")
        self.editor.SetInsertionPoint(frm)
        self.editor.WriteText("`r ")
        self.editor.SetInsertionPoint(frm + 3)

def OnRChunk(self, event):
        frm, to = self.editor.GetSelection()
        self.editor.SetInsertionPoint(to)
        self.editor.WriteText("\n```\n\n")
        self.editor.SetInsertionPoint(frm)
        self.editor.WriteText("\n```{r }\n")
        self.editor.SetInsertionPoint(frm + 8)

def OnRGraph(self, event):
        frm, to = self.editor.GetSelection()
        self.editor.SetInsertionPoint(to)
        self.editor.WriteText("\n```\n\n")
        self.editor.SetInsertionPoint(frm)
        self.editor.WriteText("\n```{r , fig.height=5, fig.width=5, fig.cap=\"\"}\n")
        self.editor.SetInsertionPoint(frm + 8)

def OnRmdComment(self, event):
        frm, to = self.editor.GetSelection()
        self.editor.SetInsertionPoint(to)
        self.editor.WriteText(" -->\n\n")
        self.editor.SetInsertionPoint(frm)
        self.editor.WriteText("\n<!-- ")
        self.editor.SetInsertionPoint(to + 15)

def OnRPipe(self, event):
    self.editor.WriteText(" %>% ") 
def OnRLAssign(self, event):
    self.editor.WriteText(" <- ") 
def OnRRAssign(self, event):
    self.editor.WriteText(" -> ") 

STATE_NORMAL = "in text"
STATE_START_HEADER = "start header"
STATE_IN_HEADER = "in header"
STATE_END_HEADER = "end header"
STATE_START_CODEBLOCK = "start codeblock"
STATE_IN_CODEBLOCK = "in codeblock"
STATE_END_CODEBLOCK = "end codeblock"
STATE_SINGLE_LINE_LATEX = "single line latex"
STATE_START_LATEX_DOLLAR = "start latex"
STATE_IN_LATEX_DOLLAR = "in latex"
STATE_END_LATEX_DOLLAR = "end latex"
STATE_START_LATEX_BRACKET = "start  latex" # note: more spaces between words than corresponding "DOLLAR" constant
STATE_IN_LATEX_BRACKET = "in  latex" # note: more spaces between words than corresponding "DOLLAR" constant
STATE_END_LATEX_BRACKET = "end  latex" # note: more spaces between words than corresponding "DOLLAR" constant

def CurrentMarkdown(self):
    (ok, currentCol, currentRow) = self.editor.PositionToXY(self.editor.GetInsertionPoint())
    state = STATE_NORMAL 
    for i in range(0, currentRow+1):
        line = self.editor.GetLineText(i)
        if state is STATE_NORMAL or state is STATE_END_HEADER or state is STATE_END_CODEBLOCK or state is STATE_END_LATEX_DOLLAR or state is STATE_END_LATEX_BRACKET or state is STATE_SINGLE_LINE_LATEX:
           if line.startswith("---"):
              state = STATE_START_HEADER
           elif line.startswith("```"):
              state = STATE_START_CODEBLOCK
           elif line.startswith("$$") and line[2:].endswith("$$"):
              state = STATE_SINGLE_LINE_LATEX
           elif line.startswith("$$"):
              state = STATE_START_LATEX_DOLLAR
           elif line.startswith("\["):
              state = STATE_START_LATEX_BRACKET
           else:
              state = STATE_NORMAL
        elif state is STATE_START_HEADER or state is STATE_IN_HEADER:
           if line.startswith("---"):
              state = STATE_END_HEADER
           else:
              state = STATE_IN_HEADER
        elif state is STATE_START_CODEBLOCK or state is STATE_IN_CODEBLOCK:
           if line.startswith("```"):
              state = STATE_END_CODEBLOCK
           else:
              state = STATE_IN_CODEBLOCK
        elif state is STATE_START_LATEX_DOLLAR or state is STATE_IN_LATEX_DOLLAR:
           if line.startswith("$$") or line.endswith("$$"):
              state = STATE_END_LATEX_DOLLAR
           else:
              state = STATE_IN_LATEX_DOLLAR
        elif state is STATE_START_LATEX_BRACKET or state is STATE_IN_LATEX_BRACKET:
           if line.startswith("\]"):
              state = STATE_END_LATEX_BRACKET
           else:
              state = STATE_IN_LATEX_BRACKET
    return state
