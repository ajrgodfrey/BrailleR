import wx
import wx.stc # needed for word count and go to line

def OnGoToLine(self, event):
        (x, y) = self.editor.PositionToXY(self.editor.GetInsertionPoint())
        maxLine=self.editor.GetNumberOfLines()
        dialog = wx.NumberEntryDialog(self, caption="GoToLine", message="Go to line",prompt="Line",value=y,min=0,max=maxLine)
        if dialog.ShowModal() == wx.ID_OK:
            line=dialog.GetValue()
            line=max(0,min(self.editor.GetNumberOfLines(),line))
            self.editor.SetInsertionPoint(self.editor.XYToPosition(0, dialog.GetValue()))
        dialog.Destroy()
    
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


