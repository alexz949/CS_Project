# import the necessary packages
import numpy as np
import imutils
import cv2
class Stitcher:

    def __init__(self):
        # determine if we are using OpenCV v3.X
        self.isv3 = imutils.is_cv3(or_better=True)
    
    def stitch(self, images, ratio=0.8, reprojThresh=4.0, showMatches=False,num=1,detector="harris",crop=True):
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
        print(ans)
        
        
        result = cv2.warpPerspective(imageA, H,
            (imageA.shape[1] + imageB.shape[1], imageA.shape[0]))
        #calculate transform H matrix to locate stitch part
        result[0:imageB.shape[0], 0:imageB.shape[1]] = imageB
        small = min(ans[1][0],ans[2][0])
        if crop:
            result = result[:,0:int(small)]
        
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
            orb = cv2.ORB_create(nfeatures=1160)
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
    # add column of ones so that matrix multiplication with homography matrix is possible
        ones_col = np.ones((points_array.shape[0], 1))
        points_array = np.concatenate((points_array, ones_col), axis=1)
        transformed_points = np.matmul(h_mat, points_array.T)
        epsilon = 1e-7
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

    def get_crop_points(self,H, imageA, imageB):
    
        imageA_h, imageA_w, _ = imageA.shape
        imageB_h, imageB_w, _ = imageB.shape

        orig_corners_img_b = self.get_corners_as_array(imageB_h, imageB_w)
                
        transfmd_corners_img_b = self.transform_with_homography(H, orig_corners_img_b)

        
        x_start, y_start, x_end, y_end = self.get_crop_points_horz(imageA_w, transfmd_corners_img_b)
        # initialize the crop points
        x_start = None
        x_end = None
        y_start = None
        y_end = None

        x_start, y_start, x_end, y_end = self.get_crop_points_horz(imageA_h, transfmd_corners_img_b)
        
        return x_start, y_start, x_end, y_end

    
       