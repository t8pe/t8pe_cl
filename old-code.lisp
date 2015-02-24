;;;;;;;;;;;;;;;;; Early work from jplayer-page.lisp ;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;; scratch work ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; These are just to test how the macros pass values ;;;;;;;;;;
(define-easy-handler (teste :uri "/testi") (playlist)
  (default-page3 (:playlist playlist)
		 (:p (str playlist))))

(defmacro default-page3 ((&key playlist) &body body)
  `(with-html-output-to-string
       (*standard-ouput* nil :prologue t :indent t) 
     (:html :lang "en"
           (:head
	    (:meta :charset "utf-8")
	    (:title ,playlist))
	   (:body
	    
	    (:script :type "text/javascript" 
		     (progn (str "jQuery(document).ready(function($) {
                                  var myPlaylist = new jPlayerPlaylist({
	                          jPlayer: \"#jquery_jplayer_N\",
	                          cssSelectorAncestor: \"#jp_container_N\"},")
			    
			    (str (extract-to-jplayer-json-from-title-n ,playlist) ; This bit I'm not sure about at all.
))
			    (str 
			     "{ playlistOptions: {
	                      enableRemoveControls: true
	                      },
                	      swfPath: \"/js/\",
	                      solution: \"html,flash\",
	                      supplied: \"oga,mp3\",
	                      smoothPlayBar: true,
	                      keyEnabled: true,
                              audioFullScreen: true // Allows the audio poster to go full screen via keyboard
	                      }); // end Playlist part
                              });"))
	    ,@body))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; end ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   

; So. It looks like I've got to re-eval BOTH THE FUCKING FUNCTIONS when testing changes. And the :title thing was being a bitch. Let's see if we can work it back in.

(with-html-output-to-string (*standard-ouput* nil :prologue t :indent t)

(loop for (class) in '(("full-screen") ("restore-screen") ("shuffle") ("shuffle-off") ("repeat") ("repeat-off"))
do (htm (:li (:a :href "javascript:;" :class (concatenate 'string "jp-" class) :tabindex "1" :title (str class)))))) ; why the hell is there an extra title?



jQuery(document).ready(function($) {


var myPlaylist = new jPlayerPlaylist({
				     jPlayer: \"#jquery_jplayer_N\",
				     cssSelectorAncestor: \"#jp_container_N\"},

				     (extract-to-jplayer-json-from-title-t "Anu Playlist") ; This bit I'm not sure about at all.
			    { 
playlistOptions: 
{
enableRemoveControls: true
},
swfPath: \"/js/\",
solution: \"html,flash\",
supplied: \"oga,mp3\",
smoothPlayBar: true,
keyEnabled: true,
audioFullScreen: true // Allows the audio poster to go full screen via keyboard
}); // end Playlist part
});")))

(ps ((@ ($ document) ready

(defmacro square-brackets (body)
  `(substitute #\[ #\( (substitute #\] #\) ,body))) ; A noble effort. But I need a string replacement.

(defmacro square-brackets2 (body)
  "For each item in the body list, add it to the output string, slap square brackets on it, return it"
  `(concatenate 'string "[" (mapcar #'princ ,body) "]"))

(mapcar #'princ (extract-to-jplayer-json-from-title-n "Anu Playlist"))

 ;And there we have it.


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


;;;;;;;;;;;;;;;;;;;;;;; From jplayer-page.lisp ;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;; This stuff is deprecated: ;;;;;;;;;;;;;;;;;;;;;;


	    (:div :class "entry-content"
	     (:div :id "jp_container_N"
	      (:div :id "jp_container_N" 
		    :class "jp-video jp-video-270p"
	       (:div :class "jp-type-playlist"
		(:div :id "jquery_jplayer_N"
		      :class "jp-jplayer")
		(:div :class "jp-video-play"
                 (:a :href "javascript:;"
		     :class "jp-video-play-icon"
		     :tabindex "1" 
		     (str "play")))
		(:div :class "jp-interface"
		 (:div :class "jp-progress"
		  (:div :class "jp-seek-bar"
		   (:div :class "jp-play-bar")))
		 (:div :class "jp-current-time")
		 (:div :class "jp-duration")
		 (:div :class "jp-details"
		  (:ul 
		   (:li 
		    (:span :class "jp-title"))))
		 (:div :class "jp-controls-holder"
		  (:ul :class "jp-controls"
		       (loop for (class) in '(("previous") ("play") ("pause") ("next") ("stop") ("mute") ("unmute") ("volume-max")) 
			  do (htm (:li (:a :href "javascript:;" :class (concatenate 'string "jp-" class) :tabindex "1" (str class))))))
		  (:div :class "jp-volume-bar"
			(:div :class "jp-volume-bar-value"))
		  (:ul :class "jp-toggles"
		       (loop for (class) in '(("full-screen") ("restore-screen") ("shuffle") ("shuffle-off") ("repeat") ("repeat-off"))
			  do (htm (:li (:a :href "javascript:;" :class (concatenate 'string "jp-" class) :tabindex "1" (str class)))))) ; leaving out :title as there's a CL-WHO problem with it
		  (:div :class "jp-playlist"
			(:ul (:li)))
		  (:div :class "jp-no-solution"
			(:span "Update required"))))))
	      (:p :style "margin-top:1em;"))))
	   ,@body)))

