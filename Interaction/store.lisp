(cl:in-package #:lispos-interaction)

(defparameter *admin*
  (let ((result (make-instance 'person
                  :name "Admin")))
    (reinitialize-instance result :author result)
    result))

(defparameter *people*
  (vector *admin*
          (make-instance 'person :author *admin* :name "Bill")
          (make-instance 'person :author *admin* :name "Jane")
          (make-instance 'person :author *admin* :name "Jack")
          (make-instance 'person :author *admin* :name "Susan")
          (make-instance 'person :author *admin* :name "Joe")
          (make-instance 'person :author *admin* :name "Anne")
          (make-instance 'person :author *admin* :name "John")
          (make-instance 'person :author *admin* :name "Sue")))
            
(defun random-person ()
  (aref *people* (random (length *people*))))

(defun random-text ()
  (loop with result = (make-string 10000)
        for i from 0 below 10000
        for newline-p = (< (random 1.0) 0.05)
        do (setf (char result i)
                 (if newline-p #\Newline (code-char (+ 97 (random 26)))))
        finally (return result)))
        
(defun random-text-document ()
  (make-instance 'text-document
    :author (random-person)
    :contents (random-text)))

(defun random-music ()
  (make-instance 'music
    :author (random-person)
    :composer (random-person)
    :performer (random-person)))

(defparameter *store*
  (append (loop repeat 1000
                collect (cond ((< (random 1.0) 0.4) (random-text-document))
                              (t  (random-music))))
          (coerce *people* 'list)))
