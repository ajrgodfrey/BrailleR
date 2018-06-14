import wx
def OnAbout(self, event):
        dialog = wx.MessageDialog(self, "WriteR is a  first attempt  at developing an R Markdown editor\n"
                                        "using wxPython. Development started by Jonathan Godfrey\n"
                                        "and James Curtis in 2015.\nContinued development assisted by Timothy Bilton in 2016.\nMarshall Flax started helping out in May 2018.\nSend all feedback to Jonathan Godfrey at a.j.godfrey@massey.ac.nz\nVersion: 0.160530.0 (or later)",
                                  "About this R Markdown Editor", wx.OK)
        dialog.ShowModal()
        dialog.Destroy()

