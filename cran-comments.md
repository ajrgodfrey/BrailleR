nothing to note (I hope) except:

- improvements to ensure use of Python 3.x
- removal of Python27 functions; some replaced by Python3 versions
- checking with RHub fails due to dependency on installr.

Any functions relying on package 'installr' (which is for Windows only and listed as Suggests), only try to make use of installr::foo() within sufficient OS checking if() statements and requireNamespace().

Any use of the shell() command do so with OS conditioning and interactive mode protection

failures on Devian (discovered on upload to CRAN via pre-testing) relate to files and folders not being cleaned out after creation in examples.
I now explicitly change directory to a temporary folder using tempdir() and revert back to the original folder at the end of each example

 



