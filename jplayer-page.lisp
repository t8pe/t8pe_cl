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




(define-easy-handler (test-that :uri "/test-that") (playlist)
  (default-page2 (:playlist playlist)
                  (:p "stuff"))) 

(defmacro default-page2 ((&key playlist) &body body)
  `(with-html-output-to-string 
       (*standard-ouput* nil :prologue t :indent t) 
     (:html :lang "en"
           (:head
	    (:meta :charset "utf-8")
	    (loop for (link . type) in '(("http://jplayer.org/latest/lib/jquery.min.js" . "text/javascript")
			     ("http://jplayer.org/latest/dist/jplayer/jquery.jplayer.min.js" . "text/javascript")
			     ("http://jplayer.org/latest/dist/add-on/jplayer.playlist.min.js" . "text/javascript"))
		 do (htm
		     (:script :type type :src link))) ; This generates the javascript links
	    (loop for link in '("http://jplayer.org/js/prettify/prettify-jPlayer.css"
				"http://jplayer.org/latest/dist/skin/pink.flag/css/jplayer.pink.flag.min.css"
				"http://jplayer.org/css/jPlayer.css") ; not referencing the sprites
		 do (htm
		     (:link :href link :rel "stylesheet" :type "text/css")))
	  (:title (str playlist))) 
	   (:body
	    (:script :type "text/javascript" 
		     (progn (str "$(document).ready(function() {
                                  var myPlaylist = new jPlayerPlaylist({
	                          jPlayer: \"#jquery_jplayer_N\",
	                          cssSelectorAncestor: \"#jp_container_N\"},")
			    (str (playlist-to-json ,playlist))
			    (str "{ 
                              playlistOptions: { enableRemoveControls: true },
                	      swfPath: \"/js/\",
	                      solution: \"html,flash\",
	                      supplied: \"oga,mp3\",
	                      smoothPlayBar: true,
	                      keyEnabled: true,
                              audioFullScreen: true 
	                      }); });")))
(:div :id "jp_container_N" :class "jp-video jp-video-270p" :role "application"
      (:div :class "jp-type-playlist"
	    (:div :id "jquery_jplayer_N" :class "jp-jplayer")
	    (:div :class "jp-gui"
		  (:div :class "jp-video-play"
			(:button :class "jp-vide-play-icon" :role "button" :tabindex "0" "play"))
		  (:div :class "jp-interface"
			(:div :class "jp-progress"
			      (:div :class "jp-seek-bar"
				    (:div :class "jp-play-bar")))
			(:div :class "jp-current-time" :role "timer" "&nbsp;")
			(:div :class "jp-duration" :role "timer" "&nbsp;")
			(:div :class "jp-details"
			      (:div :class "jp-title" "&nbsp;"))
			(:div :class "jp-controls-holder"
			      (:div :class "jp-volume-controls"
				    (:button :class "jp-mute" :role "button" :tabindex "0" "mute")
				    (:button :class "jp-volume-max" :role "button" :tabindex "0" "max volume")
				    (:div :class "jp-volume-bar"
					  (:div :class "jp-volume-bar-value")))
			      (:div :class "jp-controls"
				    (:button :class "jp-previous" :role "button" :tabindex "0" "previous")
				    (:button :class "jp-play" :role "button" :tabindex "0" "play")
				    (:button :class "jp-stop" :role "button" :tabindex "0" "stop")
				    (:button :class "jp-next" :role "button" :tabindex "0" "next"))
			      (:div :class "jp-toggles"
				    (:button :class "jp-repeat" :role "button" :tabindex "0" "repeat")
				    (:button :class "jp-shuffle" :role "button" :tabindex "0" "shuffle")
				    (:button :class "jp-full-screen" :role "button" :tabindex "0" "full screen"))))
		  (:div :class "jp-playlist"
			(:ul (:li)))
		  (:div :class "jp-no-solution"
			(:span "Update Required")))))

,@body))))
