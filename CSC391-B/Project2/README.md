## Part 1
There are three python files that I wrote to test invariant.
Rotation.py is to test rotation invariant.
Scale.py is to test scale invariant.
Illumination.py is to test low-light illumination invariant.
All three files use the same image 'self-test.jpg' to test.

## Part 2
There are two python files.
stitch.py is the driver file which reads three images from command line input and stitches them together based on four methods 'sift', 'harris', 'brisk', 'orb'.
'harris' uses SIFT for finding descriptor.
The following is the command to run:
```
python stitch.py -f tests1.jpg -s tests2.jpg -t tests3.jpg
```
panorama.py is the file contains most functions to use for stitching.
There are also three test images called tests1.jpg, tests2.jpg, and tests3.jpg.

## Part 3
There is also one testing file called sb-test.py.
It counts the time for doing SIFT as detector and BRIEF as descriptor.
It also uses 'self-test.jpg' to test

## Report
There is also one report.pdf attached