import os

import cv2
import numpy

#function to read image
def read_images(path, image_size):
    names = []
    training_images, training_labels = [], []
    label = 0
    for dirname, subdirnames, filenames in os.walk(path):
        for subdirname in subdirnames:
            names.append(subdirname)
            subject_path = os.path.join(dirname, subdirname)
            for filename in os.listdir(subject_path):
                img = cv2.imread(os.path.join(subject_path, filename),
                                 cv2.IMREAD_GRAYSCALE)
                if img is None:
                    # The file cannot be loaded as an image.
                    # Skip it.
                    continue
                img = cv2.resize(img, image_size)
                training_images.append(img)
                training_labels.append(label)
            label += 1
    training_images = numpy.asarray(training_images, numpy.uint8)
    training_labels = numpy.asarray(training_labels, numpy.int32)
    return names, training_images, training_labels

#find the training images path
path_to_training_images = '../data/at'
training_image_size = (200, 200)
names, training_images, training_labels = read_images(
    path_to_training_images, training_image_size)

#use Eigen face model to train the data
model = cv2.face.EigenFaceRecognizer_create(80)
model.train(training_images, training_labels)


#Find faces using Haar Classifier
face_cascade = cv2.CascadeClassifier(
    f'{cv2.data.haarcascades}haarcascade_frontalface_default.xml')

#face detect
frame = cv2.imread('ten.jpg')
faces = face_cascade.detectMultiScale(frame, 1.15, 5)
for (x, y, w, h) in faces:
    cv2.rectangle(frame, (x, y), (x+w, y+h), (255, 0, 0), 2)
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    roi_gray = gray[x:x+w, y:y+h]
    if roi_gray.size == 0:
        # The ROI is empty. Maybe the face is at the image edge.
        # Skip it.
        continue
    #label the face with name and confidence(distance)
    roi_gray = cv2.resize(roi_gray, training_image_size)
    label, confidence = model.predict(roi_gray)
    #Setup threshold by distance
    if(confidence < 11000):
        text = '%s, confidence=%.2f' % (names[label], confidence)
    else:
        text = 'unknown'
    print(confidence)
    cv2.putText(frame, text, (x, y - 20),
                        cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 0, 0), 2)
cv2.imshow('Face Recognition', frame)
cv2.waitKey(0)
