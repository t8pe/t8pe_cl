;; This is where I'm going to put the code for displaying the actual jplayer stuff.
(defpackage :t8pe-jplayer
  (:use :cl :cl-user :hunchentoot :cl-who :parenscript))

(in-package :t8pe-jplayer)

(dolist (x '(:hunchentoot :cl-who :parenscript))      
  (ql:quickload x)) ;; Would you look at that? A lispy way to load libraries! I love it.


(defmacro default-page ((&key title script) &body body)
  `(with-html-output-to-string 
       (*standard-ouput* nil :prologue t :indent t) ;; had to use cl-who: to make it work before
     (:html :lang "en"
           (:head
	    (:meta :charset "utf-8")
	    (:title ,title)
	    (:link :type "text/css"
		   :rel "stylesheet"
		   :href "/retro.css")
	   ,(when script
		  `(:script :type "text/javascript"
			    (str ,script)))) 
           (:body
	    (:div :id "header" ; Retro games header
		  (:img :src "/logo.jpg"
			:alt "Commodore 64"
			:class "logo")
		  (:span :class "strapline"
			 "Listen to amazing streaming music here!"))
;	    (:div :id "player"
;	    ,(when song
;		   `(extract-to-jplayer-json-from-title-n ,song))) ; Ok that didn't work either.
	    ,@body)))) 



(defun start-server (port)
  (start (make-instance 'easy-acceptor :port port)))

(define-easy-handler (t8pe-jplayer :uri "/t8pe") ()
  (default-page (:title "t8pe" :song "Anu Playlist")
		 (:h1 "Welcome to the t8pe player!"))) 

(define-easy-handler (playlist-test :uri "/playlist") (name)
  (default-page (:title "T8PE")
                  (:h1 (str name))
		  (:p (str (extract-to-jplayer-json-from-title-n name))))) ; OKAAAAAAY. So I needed to put str in there.

(define-easy-handler (teste :uri "/testi") ()
  (default-page (:title "test" :script "alert('Farts!')")
                 (:h1 "Test!")
		 (:p "stuff")))

(define-easy-handler (test-that :uri "/test-that") ()
  (default-page2))




(defmacro default-page2 ((&key title) &body body)
  `(with-html-output-to-string 
       (*standard-ouput* nil :prologue t :indent t) 
     (:html :lang "en"
           (:head
	    (:meta :charset "utf-8")
	    (loop for (link . type) in '(("http://jplayer.org/latest/lib/jquery.min.js" . "text/javascript")
			     ("http://jplayer.org/latest/dist/jplayer/jquery.jplayer.min.js" . "text/javascript")
			     ("http://jplayer.org/latest/dist/add-on/jplayer.playlist.min.js" . "text/javascript"))
		 do (htm
		     (:script :type type :src link) :br)) ; This generates the javascript links
	    (loop for (link . type) in '(("http://jplayer.org/js/prettify/prettify-jPlayer.css" . "text/css")
					 ("http://jplayer.org/latest/dist/skin/pink.flag/css/jplayer.pink.flag.min.css" . "text/css")
					 ("http://jplayer.org/css/jPlayer.css" . "text/css"))
		 do (htm
		     (:script :type type :src link :rel "stylesheet"))) ; this generates the CSS links
	  ; (:title ,title) ; let's see if it works with the comma
	   (:body
	    (:script :type "text/javascript" 
		     (progn (str "jQuery(document).ready(function($) {
                                  var myPlaylist = new jPlayerPlaylist({
	                          jPlayer: \"#jquery_jplayer_N\",
	                          cssSelectorAncestor: \"#jp_container_N\"},")
			    (extract-to-jplayer-json-from-title-t "Anu Playlist") ; This bit I'm not sure about at all.
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
                              });")))
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
		       (loop for (class) in '(("previous") ("play") ("pause") ("next") ("stop") ("mute") ("unmute") ("volume-max")) ; christ this is hideous
			  do (htm (:li (:a :href "javascript:;" :class (concatenate 'string "jp-" class) :tabindex "1" (str class))))))
		  (:div :class "jp-volume-bar"
		   (:div :class "jp-volume-bar-value"))
		  (:ul :class "jp-toggles"
		       (loop for (class) in '(("full-screen") ("restore-screen") ("shuffle") ("shuffle-off") ("repeat") ("repeat-off"))
			    do (htm (:li (:a :href "javascript:;" :class (concatenate 'string "jp-" class) :tabindex "1" :title title (str class)))))) ; took out :title and concatenation
		  (:div :class "jp-playlist"
		   (:ul (:li)))
		  (:div :class "jp-no-solution"
		   (:span "Update required"))))))
	      (:p :style "margin-top:1em;"))))))))
		   
; So. It looks like I've got to re-eval BOTH THE FUCKING FUNCTIONS when testing changes. And the :title thing was being a bitch. Let's see if we can work it back in.

(with-html-output-to-string (*standard-ouput* nil :prologue t :indent t)



