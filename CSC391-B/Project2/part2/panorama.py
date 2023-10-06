# import the necessary packages
import numpy as np
import imutils
import cv2
class Stitcher:

    def __init__(self):
        # determine if we are using OpenCV v3.X
        self.isv3 = imutils.is_cv3(or_better=True)
    
    
        
    

    def stitch(self, images, ratio=0.75, reprojThresh=4.0, showMatches=False,num=1,detector="harris"):
        # unpack the images, then detect keypoints and extract
        # local invariant descriptors from them
        (imageB, imageA) = images
        (kpsA, featuresA) = self.detectAndDescribe(imageA,detector)
        (kpsB, featuresB) = self.detectAndDescribe(imageB,detector)
        # match features between the two images
        M = self.matchKeypoints(kpsA, kpsB, featuresA, featuresB, ratio, reprojThresh)
        # if the match is None, then there aren't enough matched
        # keypoints to create a panorama
        if M is None:
            return None
        # otherwise, apply a perspective warp to stitch the images
        # together
        (matches, H, status) = M
        img_b_h, img_b_w, _ = imageB.shape
        orig_corners_img_b = self.get_corners_as_array(img_b_h, img_b_w)
        ans = self.transform_with_homography(H, orig_corners_img_b)
        
        
        
        result = cv2.warpPerspective(imageA, H,
            (imageA.shape[1] + imageB.shape[1], imageA.shape[0]))
        
        result[0:imageB.shape[0], 0:imageB.shape[1]] = imageB
        #result = result[:,0:int(ans[1][0])]
        
        # check to see if the keypoint matches should be visualized
        if showMatches:
            vis = self.drawMatches(imageA, imageB, kpsA, kpsB, matches,
                status)
            # return a tuple of the stitched image and the
            # visualization
            return (result, vis)
        # return the stitched image
        return result


    def detectAndDescribe(self, image,detector):
        # convert the image to grayscale
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        # check to see if we are using OpenCV 3.X
        if detector == 'sift':
            sift = cv2.SIFT_create()
            (kps, features) = sift.detectAndCompute(gray,None)
        elif detector == 'brisk':
            brisk = cv2.BRISK_create()
            kps,features = brisk.detectAndCompute(gray,None)
        elif detector == 'orb':
            orb = cv2.ORB_create()
            (kps,features) = orb.detectAndCompute(gray,None)
        
        else:
            gray = np.float32(gray)
            dst = cv2.cornerHarris(gray,2,3,0.04)
            dst = cv2.dilate(dst,None)
    
            # convert coordinates to Keypoint type
            gray = cv2.normalize(gray, None, 0, 255, cv2.NORM_MINMAX).astype('uint8')
            kps = np.argwhere(dst > 0.01 * dst.max())
            kps = [cv2.KeyPoint(float(x[1]), float(x[0]), 3) for x in kps]

            # compute SIFT descriptors from corner keypoints
            sift = cv2.SIFT_create()
            _,features = sift.compute(gray,kps)
            
        kps = np.float32([kp.pt for kp in kps])
        # return a tuple of keypoints and features
        return (kps, features)


    def matchKeypoints(self, kpsA, kpsB, featuresA, featuresB,
        ratio, reprojThresh):
        # compute the raw matches and initialize the list of actual
        # matches
        matcher = cv2.DescriptorMatcher_create("BruteForce")
        rawMatches = matcher.knnMatch(featuresA, featuresB, 2)
        matches = []
        # loop over the raw matches
        for m in rawMatches:
            # ensure the distance is within a certain ratio of each
            # other (i.e. Lowe's ratio test)
            if len(m) == 2 and m[0].distance < m[1].distance * ratio:
                matches.append((m[0].trainIdx, m[0].queryIdx))
        # computing a homography requires at least 4 matches
        
        if len(matches) > 4:
            # construct the two sets of points
            ptsA = np.float32([kpsA[i] for (_, i) in matches])
            ptsB = np.float32([kpsB[i] for (i, _) in matches])
            # compute the homography between the two sets of points
            (H, status) = cv2.findHomography(ptsA, ptsB, cv2.RANSAC,
                reprojThresh)
            # return the matches along with the homograpy matrix
            # and status of each matched point
            return (matches, H, status)
        # otherwise, no homograpy could be computed
        return None


    def drawMatches(self, imageA, imageB, kpsA, kpsB, matches, status):
        # initialize the output visualization image
        (hA, wA) = imageA.shape[:2]
        (hB, wB) = imageB.shape[:2]
        vis = np.zeros((max(hA, hB), wA + wB, 3), dtype="uint8")
        vis[0:hA, 0:wA] = imageA
        vis[0:hB, wA:] = imageB
        # loop over the matches
        for ((trainIdx, queryIdx), s) in zip(matches, status):
            # only process the match if the keypoint was successfully
            # matched
            if s == 1:
                # draw the match
                ptA = (int(kpsA[queryIdx][0]), int(kpsA[queryIdx][1]))
                ptB = (int(kpsB[trainIdx][0]) + wA, int(kpsB[trainIdx][1]))
                cv2.line(vis, ptA, ptB, (0, 255, 0), 1)
        # return the visualization
        return vis
    def transform_with_homography(self,h_mat, points_array):
        """Function to transform a set of points using the given homography matrix.
        Points are normalized after transformation with the last column which represents the scale
    
        Args:
        h_mat (numpy array): of shape (3, 3) representing the homography matrix
        points_array (numpy array): of shape (n, 2) represting n set of x, y pixel coordinates that are
            to be transformed
        """
    # add column of ones so that matrix multiplication with homography matrix is possible
        ones_col = np.ones((points_array.shape[0], 1))
        points_array = np.concatenate((points_array, ones_col), axis=1)
        transformed_points = np.matmul(h_mat, points_array.T)
        epsilon = 1e-7 # very small value to use it during normalization to avoid division by zero
        transformed_points = transformed_points / (transformed_points[2,:].reshape(1,-1) + epsilon)
        transformed_points = transformed_points[0:2,:].T
        return transformed_points
    
    def get_corners_as_array(self,img_height, img_width):
    
        corners_array = np.array([[0, 0],
                            [img_width - 1, 0],
                            [img_width - 1, img_height - 1],
                            [0, img_height - 1]])
        return corners_array
    def get_crop_points_horz(self,img_a_h, transfmd_corners_img_b):
    
        # the four transformed corners of image B
        top_lft_x_hat, top_lft_y_hat = transfmd_corners_img_b[0, :]
        top_rht_x_hat, top_rht_y_hat = transfmd_corners_img_b[1, :]
        btm_rht_x_hat, btm_rht_y_hat = transfmd_corners_img_b[2, :]
        btm_lft_x_hat, btm_lft_y_hat = transfmd_corners_img_b[3, :]

    # initialize the crop points
    # since image A (on the left side) is used as pivot, x_start will always be zero
        x_start, y_start, x_end, y_end = (0, None, None, None)

        if (top_lft_y_hat > 0) and (top_lft_y_hat > top_rht_y_hat):
            y_start = top_lft_y_hat
        elif (top_rht_y_hat > 0) and (top_rht_y_hat > top_lft_y_hat):
            y_start = top_rht_y_hat
        else:
            y_start = 0
        
        if (btm_lft_y_hat < img_a_h - 1) and (btm_lft_y_hat < btm_rht_y_hat):
            y_end = btm_lft_y_hat
        elif (btm_rht_y_hat < img_a_h - 1) and (btm_rht_y_hat < btm_lft_y_hat):
            y_end = btm_rht_y_hat
        else:
            y_end = img_a_h - 1

        if (top_rht_x_hat < btm_rht_x_hat):
            x_end = top_rht_x_hat
        else:
            x_end = btm_rht_x_hat
    
        return int(x_start), int(y_start), int(x_end), int(y_end)

    def get_crop_points(self,h_mat, img_a, img_b, stitch_direc):
    
        img_a_h, img_a_w, _ = img_a.shape
        img_b_h, img_b_w, _ = img_b.shape

        orig_corners_img_b = self.get_corners_as_array(img_b_h, img_b_w)
                
        transfmd_corners_img_b = self.transform_with_homography(h_mat, orig_corners_img_b)

        if stitch_direc == 1:
            x_start, y_start, x_end, y_end = self.get_crop_points_horz(img_a_w, transfmd_corners_img_b)
        # initialize the crop points
        x_start = None
        x_end = None
        y_start = None
        y_end = None

        if stitch_direc == 1: # 1 is horizontal
            x_start, y_start, x_end, y_end = self.get_crop_points_horz(img_a_h, transfmd_corners_img_b)
        
        return x_start, y_start, x_end, y_end

    
       