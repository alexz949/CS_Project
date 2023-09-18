import cv2
import filters
from managers import WindowManager, CaptureManager

class Cameo(object):

    def __init__(self):
        self._windowManager = WindowManager('Cameo',
                                            self.onKeypress)
        self._captureManager = CaptureManager(
            cv2.VideoCapture(0), self._windowManager, True)
        self._smooth = False
        self._unsharp = False
        self._histeq = False
        self._edgedetect = False
        self._filter = filters.UnsharpFilter()
        self._vfilter = filters.SmoothFilter()
        self._histogramEQ = filters.HistEq()


    def run(self):
        """Run the main loop."""
        self._windowManager.createWindow()
        while self._windowManager.isWindowCreated:
            self._captureManager.enterFrame()
            frame = self._captureManager.frame

            if frame is not None:
                #filters.strokeEdges(frame, frame)
                if self._smooth:
                    self._vfilter.apply(frame,frame)
                elif self._unsharp:
                    self._filter.apply(frame,frame)
                elif self._histeq:
                    self._histogramEQ.apply(frame,frame)
                

            self._captureManager.exitFrame()
            self._windowManager.processEvents()

    def onKeypress(self, keycode):
        """Handle a keypress.

        space  -> Take a screenshot.
        tab    -> Start/stop recording a screencast.
        escape -> Quit.

        """
        if keycode == 32: # space
            self._captureManager.writeImage('screenshot.png')
        elif keycode == 9: # tab
            if not self._captureManager.isWritingVideo:
                self._captureManager.startWritingVideo(
                    'screencast.avi')
            else:
                self._captureManager.stopWritingVideo()
        elif keycode == 27: # escape
            self._windowManager.destroyWindow()
        elif keycode == 115: # s
            self._smooth = \
                not self._smooth
        elif keycode == 104: # h
            self._histeq = \
                not self._histeq
        elif keycode == 117: # u
            self._unsharp = \
                not self._unsharp
        elif keycode == 101: # e
            self._edgedetect = \
                not self._edgedetect


class CameoDouble(Cameo):
    def __init__(self):
        Cameo.__init__(self)
        self._windowManager2 = WindowManager('Cameo2')
        self._captureManager2 = CaptureManager(
            cv2.VideoCapture(1), self._windowManager2, True)


    def run(self):
        """Run the main loop."""
        self._windowManager.createWindow()
        self._windowManager2.createWindow()
        while self._windowManager.isWindowCreated:
            self._captureManager.enterFrame()
            self._captureManager2.enterFrame()
            

            frame2 = self._captureManager2.frame
            frame = self._captureManager.frame

            if frame is not None:
                if frame2 is not None:
                #filters.strokeEdges(frame, frame)
                    """
                    if self._smooth:
                        self._vfilter.apply(frame,frame)
                    elif self._unsharp:
                        self._filter.apply(frame,frame)
                    elif self._histeq:
                        self._histogramEQ.apply(frame,frame)
                    """
            
            self._captureManager2.exitFrame()
            self._captureManager.exitFrame()
            self._windowManager.processEvents()


if __name__=="__main__":
    #Cameo().run()
    CameoDouble().run()
