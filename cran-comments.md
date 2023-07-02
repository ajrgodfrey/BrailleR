
nothing to note (I hope) except:


- NOTE re run time for examples. I get these sporadically. If pain persists, I will need to remove the examples.

- Any functions relying on package 'installr' (which was originally created for Windows only and listed as Suggests), only try to make use of installr::foo() within sufficient OS checking if() statements and requireNamespace().

- Any use of the shell() command do so with OS conditioning and interactive mode protection

