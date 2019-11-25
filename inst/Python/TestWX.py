import wx
app = wx.App(False)
frame = wx.Frame(None, wx.ID_ANY, "It looks like the WX module is available. Close this window and start WriteR")
frame.Show(True)
app.MainLoop()
