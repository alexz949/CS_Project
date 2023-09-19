## Part 1
The file called "equalHist" is for the section 1.
There are two functions "histEq" is my function and "cv_hist_eq" is the built-in function.
The figure "fig_histEq" is the histogram after running histEq with my function and the "fig_buiultin" is the result ran by built-in function

Both of the functions use a test image called "img_test" which has size (1706, 1278).

In historgram equalization,
The time for running "histEq" is 0.0871 sec
The time for built-in function is 0.0274 sec



The file "convolution" is for section 3.
There are also two functions one is called "conv" which is my function.
The second one is "cv_conv" which is the built-in function.


In convolution,
The time for running a 3 by 3 filter with "conv" is 2.0384 sec
The time for built-in function is 0.0264 sec

The time for running a 5 by 5 filter with "conv" is 2.0737 sec
The time for built-in function is 0.0352 sec


## Part 2
The file called "sobel_edge" is what I design my own image filter.
It basically does a edge detect filter and then do the vertical sobel filter which I believe it will make the edges more vivid.


## Part 3
The file "video_frame" is the video frame processing.
It creates two windows one is called "Original"  which is the normal case.
The other one is doing filter and other cases.
When pressing 's', it will blur the video by doing Gaussian Filter.
When pressing 'u',  it will unsharp the image by first do box filter and then do a constant = 5.
When pressing 'h', it will output the histogram equalization frame.
When pressing 'q', it will terminate the program.
