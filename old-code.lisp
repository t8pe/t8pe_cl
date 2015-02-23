
;;;;;;;;;;;;;;; Early work from json-for-jplayer.lisp ;;;;;;;;;;;;;;;;

;;----- This is what the final format has to be: ---------;;
{
"title":"Great Day For Up",
"artist":"2",
"mp3":"http://BenDeschamps.com/MP3S/Great_Day_For_Up.mp3",
"oga":"",
"poster":""
},{
"title":"Separate Sunrises","artist":"2","mp3":"http://BenDeschamps.com/MP3S/Separate_Sunrises.mp3","oga":"","poster":""
},{
"title":"Tangerine Bream","artist":"2","mp3":"http://BenDeschamps.com/MP3S/Tangerine_Bream.mp3","oga":"http://jplayer.org/audio/ogg/Miaow-07-Bubble.ogg","poster":""}

;;----- This is what we currently get back: --------------;;
((:COMMIT . "http://localhost:7474/db/data/transaction/29/commit")
 (:RESULTS
  ((:COLUMNS "s.name" "s.mp3")
   (:DATA 
    ((:ROW "The La Song" "la.mp3")) 
    ((:ROW "Tangerine Bream" "TB.mp3"))
    ((:ROW "Fairytale" "Fairytale.mp3")) 
    ((:ROW "Medusa" "Medusa.mp3"))
    ((:ROW "Sir Gawain And The Green Knight" "GGK.mp3")))))
 (:TRANSACTION (:EXPIRES . "Sat, 07 Feb 2015 22:35:57 +0000")) (:ERRORS))

(setf resp '((:COMMIT . "http://localhost:7474/db/data/transaction/29/commit")
 (:RESULTS
  ((:COLUMNS "s.name" "s.mp3")
   (:DATA ((:ROW "The La Song" "la.mp3")) ((:ROW "Tangerine Bream" "TB.mp3"))
    ((:ROW "Fairytale" "Fairytale.mp3")) ((:ROW "Medusa" "Medusa.mp3"))
    ((:ROW "Sir Gawain And The Green Knight" "GGK.mp3")))))
 (:TRANSACTION (:EXPIRES . "Sat, 07 Feb 2015 22:35:57 +0000")) (:ERRORS)))

;; (cdr (second (second (second resp)))) gives a list of just the response rows

(setf rows (cdr (second (second (second resp)))))

;;-------------This is what I want:---------------;;

(defmacro extract-to-jplayer-json (resp)
  (...))
-> json in jplayer format.

;; Or:
(while rows (resp) ;; resp from get-playlist- etc
       (transform-row-to-json row))

;; test condition: (eq (car row) (:TRANSACTION)) - WHICH ACTUALLY WORKS!

;; So I can recursively call transform-row-to-json and have it push onto a list of some type.

(defun extract-to-jplayer-json (resp)
  (let ((json-for-jplayer '()))
;; need to get past the opening rows first
  (if (not (eq (car resp) '(:TRANSACTION)))
	   (push (destructuring-bind (a b c d e f) (caar resp)
		   (format nil "[\"title\":\"~a\", \"artist\":\"~a\", \"mp3\":\"~a\", \"oga\":\"~a\"]" b c d e)) json-for-jplayer)
	   json-for-jplayer (cdr resp)))) ;; need to properly select the next bit of the resp
;; Oh if this actually worked on rose, I'd exceed recursion. Doh.
;; Changed from t to nil in the format and at least it put *something* in the output. Which is a start.


;; Some futzing: ;;
(setf rose (extract-data-rows (get-playlist-by-title "Anu Playlist")))

(destructuring-bind (a b c d e f) (car (second rose))
	   (list :title b :artist c :mp3 d :oga e))
-> (:TITLE "Tangerine Bream" :ARTIST "Ben" :MP3 "TB.mp3" :OGA "TB.ogg")

(destructuring-bind (a b c d e f) (car (second rose))
	   (list "title" b "artist" c "mp3" d "oga" e))

;; This may be the place where a macro is necessary. 
;; Or it might make a lot of sense to set it up as a CLOS object.

;; So this does it with a destructuring-bind, for a single row; it's ugly as shit and has warnings aplenty, but there you go.?/
(destructuring-bind (a b c d e f) (car (second rose))
(format t "[\"title\":\"~a\", \"artist\":\"~a\", \"mp3\":\"~a\", \"oga\":\"~a\"]" b c d e))
;; And now that it's format t rather than format nil, it outputs perfectly. I think.
;; So this works on (car (second rose)) - 




(defun extract-to-jplayer-json-from-title (title) ;; trying to get the right data in
  (let ((json-for-jplayer '()))
    (progn
      (mapcar (lambda (x) (if (not (eq (car x) '(:TRANSACTION)))
      (push (destructuring-bind (a b c d e f) (car x)
		   (format t "{\"title\":\"~a\", \"artist\":\"~a\", \"mp3\":\"~a\", \"oga\":\"~a\", \"poster\":\"\"}," b c d e)) json-for-jplayer))) (extract-data-rows (get-playlist-by-title title))))
      json-for-jplayer))

(defun extract-to-jplayer-json (resp)
  (let ((json-for-jplayer '()))
    (progn
      (mapcar (lambda (x) (if (not (eq (car x) '(:TRANSACTION)))
      (push (destructuring-bind (a b c d e f) (car x)
      		   (format nil "[\"title\":\"~a\", \"artist\":\"~a\", \"mp3\":\"~a\", \"oga\":\"~a\"]" b c d e)) json-for-jplayer))) resp))
      json-for-jplayer))

(defun extract-to-jplayer-json-from-title2 (title)
  (let ((json-for-jplayer '())
	(useful-data (extract-data-rows (get-playlist-by-title title)) ))
    (progn
      (mapcar (lambda (x) (unless (eq (first x) '(:TRANSACTION))
      (push (destructuring-bind (b c d e f) (cdr (first x)) ;; Doesn't seem to gain anything.
		   (format t "{\"title\":\"~a\", \"artist\":\"~a\", \"mp3\":\"~a\", \"oga\":\"~a\", \"poster\":\"\"}," b c d e)) json-for-jplayer))) useful-data)) ;; I'm absolutely certain that this could be prettier.
      json-for-jplayer)) 


;;;;;;;;;;;;;;;;;;;;;; From neo4j-wrapper.lisp ;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;; STUFF I WANT TO SEE: ;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun write-playlist (lst)
  (...))

(defun delete-playlist (lst)
  (...))

;;;;;;;;;;;;;;;;;;;;;;;;;;;; working on: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun query3 (body)
  "This allows the execution of arbitrary Cypher statements, so body must be a properly formatted Cypher query."
  (babel:octets-to-string 
   (drakma:http-request *neo-trans* 
			:method :post 
			:accept *acc-format* 
			:content-type *json* 
			:content (format nil "{\"statements\" : [ {\"statement\" : \"~a\"} ]}" body)))) 

(defun get-playlist-by-title-1 (title)
  (query3 (format nil "match (s:Song)-[:IN]->(p:Playlist {title:'~:(~a~)'}) return s.name, s.artist, s.mp3, s.oga, s.poster;" title)))
;; Interesting. The output between these two is different - it's actually pure JSON for the latter one, at least in terms of its brackets etc. But it's not correctly formatted JSON, so I'm not sure it's that helpful!
