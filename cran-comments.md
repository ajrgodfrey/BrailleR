
nothing else to note (I hope) except:


Any functions relying on package 'installr' (which was originally created for Windows only and listed as Suggests), only try to make use of installr::foo() within sufficient OS checking if() statements and requireNamespace().

Any use of the shell() command do so with OS conditioning and interactive mode protection

