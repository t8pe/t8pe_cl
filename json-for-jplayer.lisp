(defun extract-data-rows (resp)
  (cdr (second (second (second resp)))))

(defun extract-to-jplayer-json (resp)
  "Takes a sanitised version of the input, ie only the data rows"
  (let ((json-for-jplayer '()))
    (progn
      (mapcar (lambda (x) (unless (eq (first x) '(:TRANSACTION))
      (push (destructuring-bind (a b c d e f) (first x)
      		   (format nil "[\"title\":\"~a\", \"artist\":\"~a\", \"mp3\":\"~a\", \"oga\":\"~a\"]" b c d e)) json-for-jplayer))) resp))
      json-for-jplayer))

(defun extract-to-jplayer-json-from-title-n (title)
  "Takes a known string title of a playlist and returns a string formatted properly for jPlayer's input requirements"
  (let ((json-for-jplayer '())
	(useful-data (extract-data-rows (get-playlist-by-title title)) ))
    (progn
      (mapcar (lambda (x) (unless (eq (first x) '(:TRANSACTION))
      (push (destructuring-bind (a b c d e f) (first x)
		   (format nil "{\"title\":\"~a\", \"artist\":\"~a\", \"mp3\":\"~a\", \"oga\":\"~a\", \"poster\":\"\"}," b c d e)) json-for-jplayer))) useful-data))
      json-for-jplayer))

(defun extract-to-jplayer-json-from-title-t (title)
  "Takes a known string title of a playlist and sends to *standard-output* formatted properly for jPlayer's input requirements"
  (let ((json-for-jplayer '())
	(useful-data (extract-data-rows (get-playlist-by-title title)) ))
    (progn
      (mapcar (lambda (x) (unless (eq (first x) '(:TRANSACTION))
      (push (destructuring-bind (a b c d e f) (first x)
		   (format t "{\"title\":\"~a\", \"artist\":\"~a\", \"mp3\":\"~a\", \"oga\":\"~a\", \"poster\":\"\"}," b c d e)) json-for-jplayer))) useful-data))
      json-for-jplayer))
