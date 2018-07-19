
def OnMathSquareBrack(self, event):
        frm, to = self.editor.GetSelection()
        self.editor.SetInsertionPoint(to)
        self.editor.WriteText("\\right] ")
        self.editor.SetInsertionPoint(frm)
        self.editor.WriteText(" \\left[")
        self.editor.SetInsertionPoint(to + 15)

def OnMathCurlyBrack(self, event):
        frm, to = self.editor.GetSelection()
        self.editor.SetInsertionPoint(to)
        self.editor.WriteText("\\right} ")
        self.editor.SetInsertionPoint(frm)
        self.editor.WriteText(" \\left{")
        self.editor.SetInsertionPoint(to + 15)


def OnMathRoundBrack(self, event):
        frm, to = self.editor.GetSelection()
        self.editor.SetInsertionPoint(to)
        self.editor.WriteText("\\right) ")
        self.editor.SetInsertionPoint(frm)
        self.editor.WriteText(" \\left(")
        self.editor.SetInsertionPoint(to + 15)


def OnSymbol_infinity(self, event):
        self.editor.WriteText("\\infty{}") 
def OnSymbol_plusminus(self, event):
        self.editor.WriteText(" \\pm ") 
def OnSymbol_minusplus(self, event):
        self.editor.WriteText(" \\mp ") 
def OnSymbol_geq(self, event):
        self.editor.WriteText(" \\geq ") 
def OnSymbol_leq(self, event):
        self.editor.WriteText(" \\leq ") 
def OnSymbol_neq(self, event):
        self.editor.WriteText(" \\ne ") 

def OnSymbol_times(self, event):
        self.editor.WriteText("\\times{}") 
def OnSymbol_partial(self, event):
        self.editor.WriteText("\\partial{}") 
def OnSymbol_LeftParen(self, event):
        self.editor.WriteText("\\left(") 
def OnSymbol_RightParen(self, event):
        self.editor.WriteText("\\right) ") 
def OnSymbol_LeftSquare(self, event):
        self.editor.WriteText("\\left[") 
def OnSymbol_RightSquare(self, event):
        self.editor.WriteText("\\right] ") 
def OnSymbol_LeftCurly(self, event):
        self.editor.WriteText("\\left\\{") 
def OnSymbol_RightCurly(self, event):
        self.editor.WriteText("\\right\\} ")

def OnAbsVal(self, event):
    frm, to = self.editor.GetSelection()
    self.editor.SetInsertionPoint(to)
    self.editor.WriteText("\\right| ")
    self.editor.SetInsertionPoint(frm)
    self.editor.WriteText(" \\left|")
    self.editor.SetInsertionPoint(frm + 3)


def OnMathBar(self, event):
        self.editor.WriteText(" \\bar{} ") 


def OnSquareRoot(self, event):
        self.editor.WriteText("\\sqrt{}") 
def OnFraction(self, event):
        self.editor.WriteText("\\frac{ num }{ den }") 
def OnSummation(self, event):
        self.editor.WriteText("\\sum_{ lower }^{ upper }{ what }") 
def Onintegral(self, event):
        self.editor.WriteText("\\int_{ lower }^{ upper }{ what }") 
def OnProduct(self, event):
        self.editor.WriteText("\\prod_{ lower }^{ upper }{ what }") 
def OnLimit(self, event):
        self.editor.WriteText("\\lim_{ what \\to where }{is}") 
def OnDoubleSummation(self, event):
        self.editor.WriteText("\\sum_{ lower }^{ upper }{\\sum_{ lower }^{ upper }{ what }}") 
def OnDoubleIntegral(self, event):
        self.editor.WriteText("\\int_{ lower }^{ upper }{\\int_{ lower }^{ upper }{ what }}") 

def OnGreek_alpha(self, event):
        self.editor.WriteText("\\alpha{}") 
def OnGreek_beta(self, event):
        self.editor.WriteText("\\beta{}") 
def OnGreek_gamma(self, event):
        self.editor.WriteText("\\gamma{}") 
def OnGreek_delta(self, event):
        self.editor.WriteText("\\delta{}") 
def OnGreek_epsilon(self, event):
        self.editor.WriteText("\\epsilon{}") 
def OnGreek_varepsilon(self, event):
        self.editor.WriteText("\\varepsilon{}") 
def OnGreek_zeta(self, event):
        self.editor.WriteText("\\zeta{}") 
def OnGreek_eta(self, event):
        self.editor.WriteText("\\eta{}") 
def OnGreek_theta(self, event):
        self.editor.WriteText("\\theta{}") 
def OnGreek_vartheta(self, event):
        self.editor.WriteText("\\vartheta{}") 
def OnGreek_iota(self, event):
        self.editor.WriteText("\\iota{}") 
def OnGreek_kappa(self, event):
        self.editor.WriteText("\\kappa{}") 
def OnGreek_lambda(self, event):
        self.editor.WriteText("\\lambda{}") 
def OnGreek_mu(self, event):
        self.editor.WriteText("\\mu{}") 
def OnGreek_nu(self, event):
        self.editor.WriteText("\\nu{}") 
def OnGreek_xi(self, event):
        self.editor.WriteText("\\xi{}") 
def OnGreek_omicron(self, event):
        self.editor.WriteText("\\omicron{}") 
def OnGreek_pi(self, event):
        self.editor.WriteText("\\pi{}") 
def OnGreek_rho(self, event):
        self.editor.WriteText("\\rho{}") 
def OnGreek_sigma(self, event):
        self.editor.WriteText("\\sigma{}") 
def OnGreek_tau(self, event):
        self.editor.WriteText("\\tau{}") 
def OnGreek_upsilon(self, event):
        self.editor.WriteText("\\upsilon{}") 
def OnGreek_phi(self, event):
        self.editor.WriteText("\\phi{}") 
def OnGreek_chi(self, event):
        self.editor.WriteText("\\chi{}") 
def OnGreek_psi(self, event):
        self.editor.WriteText("\\psi{}") 
def OnGreek_omega(self, event):
        self.editor.WriteText("\\omega{}")

