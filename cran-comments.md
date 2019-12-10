nothing to note (I hope) except:

- improvements to ensure use of Python 3.x
- removal of Python27 functions; some replaced by Python3 versions
- checking with RHub fails due to dependency on installr.

Any functions relying on package 'installr' (which is for Windows only and listed as Suggests), only try to make use of installr::foo() within sufficient OS checking if() statements and requireNamespace().

Any use of the shell() command do so with OS conditioning and interactive mode protection

 



