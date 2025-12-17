This package was archived due to one of its depndencies also being archived. When the dependency was fixed, BrailleR remained archived. I had hoped to find time to do more than fix the dependency, but alas...


So, i think there is nothing to note (I hope) except:

* package ExtraFonts has been removed from dependencies. All functions making use of that package have been overwritten by functions which post a message to inform users of the changes.
* NOTE re run time for examples. I get these sporadically. If pain persists, I will need to remove the examples. CRAN servers and Win-builder seem to have adequate grunt to avoid this issue.
* Any functions relying on package 'installr' (which was originally created for Windows only and listed as Suggests), only try to make use of installr::foo() within sufficient OS checking if() statements and requireNamespace().
* Any use of the shell() command do so with OS conditioning and interactive mode protection
