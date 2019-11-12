nothing to note (I hope) except:

- improvements to ensure use of Python 3.x

Any functions relying on package 'installr' (which is for Windows only and listed as Suggests), only try to make use of installr::foo() within sufficient OS checking if() statements.

 



