Responses to feedback from manual inspection by Gregor on behalf of CRAN:

- I appreciate feedback, but the assistance must take note of the intended purpose of the packatge. The suggestion "You write information messages to the console that cannot be easily suppressed." is correct, but this is totally the point of the package. These messages appear in the session window or in a user's output files, no matter what the workflow. Suppression is highly undesirable. The existing `GoSighted()` function turns off many messages. There is a mixture of untranslatable implied print() and translatable message() functionality. Users want feedback in languages other than English which suggests use of message(), while the current development team can only manage English.
- Almost all commented out code in examples has been removed. This removed the usefulness and therefore the existence of some examples.
- Exceptions to the removal of commented code exist where the example is intended to illustrate the incorrect use of the function and then its correct usage. See for example, OneFactor.Rd
- checked that all Rd files have a \value section. Needed to write WhichFile() function to do this.
- GetExampleText.Rd has cat() in its example because this is how it would be implemented in practice. Not updated.
- removed rm() from examples
- One primary purpose of the BrailleR package is to return plain text when other R functionality does not. This is critical for access by blind users. Requesting that this practice be discontinued invalidates much of what the package delivers for blind users. For example, the WTF.Rd now has an entry \value{Text describing what BrailleR was able to detect in the graphics window.}
- sample code in template files is not used in package examples. I understand the suggestion to save original graphical parameters, but this is not necessary in general use of R markdown where most of these samples are used because R chunks do not retain altered graphical parameters from one chunk to the next.


nothing else to note (I hope) except:


Any functions relying on package 'installr' (which was originally created for Windows only and listed as Suggests), only try to make use of installr::foo() within sufficient OS checking if() statements and requireNamespace().

Any use of the shell() command do so with OS conditioning and interactive mode protection

failures on Devian (discovered on upload to CRAN via pre-testing) relate to files and folders not being cleaned out after creation in examples.
I now explicitly change directory to a temporary folder using tempdir() and revert back to the original folder at the end of each example

 



