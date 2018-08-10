nothing to note (I hope) except:

- packages 'roloc' and rolocISCCNBS' now on CRAN; no more grief there.

Any functions relying on package 'installr' (which is for Windows only and listed as Suggests), only try to make use of installr::foo() within sufficient OS checking if() statements.

 



