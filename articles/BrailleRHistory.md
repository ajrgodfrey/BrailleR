# History of the BrailleR package

I am one of only two blind people in the world today who gained
full-time employment as lecturers of statistics, that is, teaching
statistics classes and doing research in theoretical matters as against
applying statistical techniques. For years, I tried to keep my blindness
separate from my research but I took some opportunities that came my way
and heeded the advice of some colleagues to put more energy into
improving the ability of blind students around the world to have greater
access to statistics courses and statistical understanding. This
document shows you a bit more insight into how I (with the help of some
useful collaborations) got the BrailleR package to where it is now.

## My background

My adult life has been centred around Massey University, initially as an
extramural student and then studying on campus. I have undergraduate
degrees in Finance and Operations Research, a Master’s degree in
Operations Research and a PhD in Statistics. I was a Graduate Assistant
from 1998 to 2002, and then Assistant Lecturer from January 2003 to June
2004 when I became a Lecturer in Statistics. I was promoted to Senior
Lecturer in late 2014.

While I don’t find it important, I do get asked about the condition that
caused my blindness. It is Retinitis Pigmentosa. I do have some light
perception, and can make use of it in familiar surroundings for
orientation but it has no value to me for reading anything at all. I
chose to work with screen reading software when I started university and
obtained my first computer because my residual vision at the time was
limiting my reading speed. I have therefore operated a computer as a
totally blind user throughout my adult life.

I did not learn braille until after I completed my PhD. This might seem
strange, but there was very little material in a suitable digital format
for me to read throughout my student life. Things have changed and I now
spend a lot more time reading material and doing programming where the
accuracy of braille is absolutely necessary. Braille has now become a
very important part of my working life and I have a braille display
connected to my computer most of the time.

## getting started

I used to keep my research interests separate from my blindness, but I
was regularly called upon to discuss how a blind person could study and
teach Statistics by many people within New Zealand and occasionally from
overseas. In 2009, I attended the Workshop on E-Inclusion in Mathematics
and Science (WEIMS09) where I met other people interested in improving
the success rates of blind students in the mathematical sciences. My
paper was about accessibility of statistics courses, but I did point out
the usefulness of R in preference to other tools I had used to that
point in time (Godfrey 2009).

I discovered that there is room for me to take a leading role in the
development of ideas that can help other blind people learn about
statistical concepts. I have been invited to all six Summer University
events run by the organizers of the International Conference on
Computers Helping People (ICCHP), but have been unable to attend twice
due to the high cost of transporting me to Europe. I have delivered an
introductory workshop on using R at four of these events Godfrey
(2016b).

Having observed the attendees at the 2011 Summer University as they came
to grips with R, I knew there was more I could do to help them and other
blind students. I started work on the BrailleR package (Godfrey 2018) in
the second half of 2011 and first proposed it could work for blind users
at the Digitisation and E-Inclusion in Mathematics and Science (DEIMS12)
workshop held in Tokyo during February 2012 (Godfrey 2012b).

I wasn’t to know the value of another talk I gave at DEIMS12 for another
two years; this second talk and associated conference paper focused on
how I was using Sweave to create accessible statistical reports for me
and more beautifully formatted ones for my statistical consulting
clients. (Godfrey 2012a). I now know that the groundwork I had done
contributed to my desire to present my workflow as a workshop at the
5^(th) Summer University in 2014 (Godfrey 2014d). It also stood me in
good stead for the work that followed in the way the package developed
in late 2014 and early 2015.

## The starting point example

The basic graph that has been used for almost every presentation of the
BrailleR package is a histogram. There is a more detailed example, but
the following commands create a set of numbers that can be kept for
further processing once the graph has been created. It is the
re-processing of these numbers that leads to the text description that
follows.

``` r
library(BrailleR)
```

    ## The BrailleR.View,  option is set to FALSE.

    ## 
    ## Attaching package: 'BrailleR'

    ## The following objects are masked from 'package:graphics':
    ## 
    ##     boxplot, hist

    ## The following object is masked from 'package:utils':
    ## 
    ##     history

    ## The following objects are masked from 'package:base':
    ## 
    ##     grep, gsub

``` r
x=rnorm(1000)
VI(hist(x))
```

![A histogram of 1000 random values from a normal
distribution](BrailleRHistory_files/figure-html/hist-1.png)

A histogram of 1000 random values from a normal distribution

    ## This is a histogram, with the title: with the title: Histogram of x
    ## "x" is marked on the x-axis.
    ## Tick marks for the x-axis are at: -3, -2, -1, 0, 1, 2, and 3 
    ## There are a total of 1000 elements for this variable.
    ## Tick marks for the y-axis are at: 0, 50, 100, and 150 
    ## It has 12 bins with equal widths, starting at -3 and ending at 3 .
    ## The mids and counts for the bins are:
    ## mid = -2.75  count = 4 
    ## mid = -2.25  count = 18 
    ## mid = -1.75  count = 45 
    ## mid = -1.25  count = 86 
    ## mid = -0.75  count = 162 
    ## mid = -0.25  count = 180 
    ## mid = 0.25  count = 188 
    ## mid = 0.75  count = 151 
    ## mid = 1.25  count = 102 
    ## mid = 1.75  count = 39 
    ## mid = 2.25  count = 19 
    ## mid = 2.75  count = 6

This first example showed me what was possible if only I could get a few
things sorted out. All histograms are created by a function that stores
the results (both numeric and text details) and called the stored set of
numbers a “histogram”. The main issue is that storing the set of details
is not consistent in R, nor is the fact that the stored object gets
given a “class” to tell me what type of object it is. This problem
haunted me for quite some time because I was talking to the wrong people
about the problem; it was time to find people that held the solution
instead of talking to the people that would benefit if a solution was
found.

## Exposure of the BrailleR package outside the blind community

It was obvious to me that getting the word out to the masses about the
usefulness of R for blind students and professionals was crucial. I
started to compile my notes built up from various posts made to email
groups and individuals over the years, as well as the lessons I learned
from attendance at the 2^(nd) Summer University event. This led to the
eventual publication of my findings in (Godfrey 2013b). I know that this
was a worthwhile task because it was read by teachers of blind students
who were already using R for their courses. One such person tested R and
a screen reader and managed to find a solution to a problem posed in
Godfrey (2013b) which led to an addendum (Godfrey and Erhardt 2014).

I presented some of my work via a poster (Godfrey 2013c) at the NZ
Statistical Association conference in Hamilton during November 2013.
This ‘poster’ presentation was developed as a multimedia presentation so
that the audience could observe video footage, handle tactile images and
be able to talk with me about the BrailleR Project. The plan to get
talking with people instead of talking at them worked and I started a
really useful collaboration with Paul Murrell from the University of
Auckland. His major contributions didn’t feature in the BrailleR package
for some time, but we’re making some really nice progress. Paul is an
expert in graphics, especially their creation and manipulation in R. Our
discussions about graphics has yielded a few titbits for my own work
that have been tested for the package. We’ve been working on how to make
scalable vector graphics that can be augmented to offer blind users
greater interactivity and therefore hopefully greater understanding (see
Godfrey and Murrell 2016).

## Review of statistical software

I have been asked about the use of R in preference to other statistical
software by many blind students, their support staff, and their
teachers. Eventually I joined forces with the only other blind lecturer
of statistics (Theodor Loots, University of Pretoria) to compare the
most commonly used statistical software for its accessibility (Godfrey
and Loots 2014). I summarised this paper at the 5^(th) Summer University
event (Godfrey 2014a), and offered a similar presentation at the 6^(th)
Summer University event (Godfrey 2016a) with a few updates.

## Attendance at UseR conferences

On my way to the 5^(th) Summer University event, I managed to attend the
principal conference for R users (UseR!2014) in Los Angeles where I
presented my findings (Godfrey 2014c). Perhaps the most valuable outcome
of this conference was the ability to attend a tutorial on use of the
knitr package and then talk to its author, Yihui Xie. I’d already seen
the knitr package before attending UseR!2014 and implemented it for some
of my teaching material by updating the Sweave documents already in use.
The real value came in realising what I could probably do if I used R
markdown to do a few things I had found very hard using the Sweave way
of working. More specifically, generating an R markdown file (Rmd) from
an R script was much easier than generating a Sweave file (Rnw). Writing
the convenience functions for the package started to look very
achievable at this point, and so work began. I dug out some old work
that wasn’t fit for sharing and converted it to the markdown way of
working. There has been sufficient progress in the BrailleR Project that
I presented it at UseR!2015 (Godfrey 2015). In 2016, I presented the
associated work on writing R markdown documents for blind users could be
done, and how blind authors might also therefore write their own
documents (Godfrey and Bilton 2016).

## The ongoing work

The introduction of R markdown to the BrailleR package made a huge
difference. I’ve been able to write enough example code that once I
found a friendly postgraduate student (Timothy Bilton) to put some time
into it, we’ve managed to add more convenience functionality. Timothy
has improved some of my earlier work and tried a few things of his own.
This has left me with the time to add increased functionality for
helping blind users get into markdown for themselves.

One of my irritations of working with markdown is that everyone else
seems to write markdown and check their findings using RStudio, which
remains inaccessible for me and other screen reader users. I took an old
experiment where I wrote an accessible text editor in wxPython, and with
the help of a postgraduate student from Computer Science (James Curtis)
we’ve modified it to process Rmd files. This is now beyond experimental
but there is still more to do on making this application truly useful
(Godfrey and Curtis 2016).

## Acknowledgements

Contributions to the BrailleR Project are welcome from anyone who has an
interest. I will acknowledge assistance in chronological order of the
contributions I have received thus far.

Greg Snow was the first person to assist when he gave me copies of the
original R code and help files for the R2txt functions that were part of
his TeachingDemos package (Snow 2010).

The Lions clubs of Karlsruhe supported my attendance at the 3^(rd)
Summer University event in 2013. This gave me the first opportunity to
put the package in front of an audience that I hope will gain from the
package’s existence.

I’ve already mentioned the following contributors above:Paul Murrell,
Yihui Xie, Timothy Bilton, and James Curtis. In December 2016, I was
visiting Donal Fitzpatrick at Dublin City University and we were joined
by Volker Sorge for a few days. Volker’s work in creating an accessible
tool for exploration of chemical molecules is now being broadened into
statistical graphs.

I also need to acknowledge the value of attending the Summer University
events. I gain so much from my interactions with the students who
attend, the other workshop leaders who gave me feedback, and the other
professionals who assist blind students in their own countries.

## References

Godfrey, A. Jonathan R. 2009. “Are Statistics Courses Accessible?” In
*Proceedings of the Workshop on e-Inclusion in Mathematics and Science
2009*, 72–80. Fukuoka, Japan.

———. 2011. “R.” Telc, The Czech Republic.

———. 2012a. “Putting It All Together — a Blind Person’s Perspective on
Document Preparation.” In *Proceedings of Digitization and e-Inclusion
in Mathematics and Science*, edited by Katsuhito Yamaguchi and Masakazu
Suzuki, 135–41. Tokyo, Japan.

———. 2012b. “The BrailleR Project.” In *Proceedings of Digitization and
e-Inclusion in Mathematics and Science*, edited by Katsuhito Yamaguchi
and Masakazu Suzuki, 89–95. Tokyo, Japan.

———. 2013a. “Using R: The Most Accessible Statistical Software for Blind
Students.” Bad Herrenalb, Germany.

———. 2013b. “Statistical Software from a Blind Person’s Perspective: R
Is the Best, but We Can Make It Better.” *The R Journal* 5 (1): 73–79.
<https://journal.r-project.org/archive/2013-1/godfrey.pdf>.

———. 2013c. “Blindness in a Visual Discipline.” University of Waikato,
Hamilton.

———. 2014a. “A Review of Statistical Software for Blind Students.”
Paris, France.

———. 2014b. “Introduction to R: The Most Accessible Statistical Software
for Blind Students.” Paris, France.

———. 2014c. “Practical Use of R by Blind People.” University of
California, Los Angeles.

———. 2014d. “R and LaTeX — a Powerful Combination for Assignment
Preparation.” Paris, France.

———. 2015. “While My Base R Gently Weeps.” Aalborg, Denmark.

———. 2016a. “A Review of Statistical Software for Blind Students.” Linz,
Austria.

———. 2016b. “Introduction to R: The Most Accessible Statistical Software
for Blind Students.” Linz, Austria.

———. 2018. *BrailleR: Improved Access for Blind Users*. Massey
University. <https://CRAN.R-project.org/package=BrailleR>.

Godfrey, A. Jonathan R., and Timothy P. Bilton. 2016. “R Markdown:
Lifesaver or Death Trap?” Stanford University, California.

Godfrey, A. Jonathan R., and James M. P. Curtis. 2016. “Simple Authoring
of Statistical Analyses by and for Blind People.” In *Proceedings of the
International Workshop on Digitization and e-Inclusion in Mathematics
and Science 2016*, edited by Katsuhito Yamaguchi and Masakazu Suzuki,
47–54. Kanegawa, Japan.
<https://workshop.sciaccess.net/DEIMS2016/index.html>.

Godfrey, A. Jonathan R., and Robert Erhardt. 2014. “Addendum to
“Statistical Software from a Blind Person’s Perspective".” *The R
Journal* 6 (1): 182.
<https://journal.r-project.org/archive/2014-1/godfrey-erhardt.pdf>.

Godfrey, A. Jonathan R., and M. Theodor Loots. 2014. “Statistical
Software (R, SAS, SPSS, and Minitab) for Blind Students and
Practitioners.” *Journal of Statistical Software, Software Reviews* 58
(1): 1–25. <https://www.jstatsoft.org/v58/s01>.

Godfrey, A. Jonathan R., and Paul Murrell. 2016. “Statistical Graphs
Made Tactile.” In *Proceedings of the International Workshop on
Digitization and e-Inclusion in Mathematics and Science 2016*, edited by
Katsuhito Yamaguchi and Masakazu Suzuki, 69–74. Kanegawa, Japan.

Snow, Greg. 2010. *TeachingDemos: Demonstrations for Teaching and
Learning*.
