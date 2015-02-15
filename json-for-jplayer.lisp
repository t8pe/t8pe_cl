(defun extract-data-rows (resp)
  (cdr (second (second (second resp)))))


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
   (:DATA ((:ROW "The La Song" "la.mp3")) ((:ROW "Tangerine Bream" "TB.mp3"))
    ((:ROW "Fairytale" "Fairytale.mp3")) ((:ROW "Medusa" "Medusa.mp3"))
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

;; Some futzing: ;;
(setf rose (extract-data-rows (get-playlist-by-title "Anu Playlist")))

(destructuring-bind (a b c d e f) (car (second rose))
	   (list :title b :artist c :mp3 d :oga e))
-> (:TITLE "Tangerine Bream" :ARTIST "Ben" :MP3 "TB.mp3" :OGA "TB.ogg")

(destructuring-bind (a b c d e f) (car (second rose))
	   (list "title" b "artist" c "mp3" d "oga" e))

;; This may be the place where a macro is necessary. 
;; Or it might make a lot of sense to set it up as a CLOS object.

;; So this does it with a destructuring-bind, for a single row; it's ugly as shit and has warnings aplenty, but there you go.
(destructuring-bind (a b c d e f) (car (second rose))
(format nil "[\"title\" : \"~a\" \"artist\" : \"~a\" \"mp3\" : \"~a\" \"oga\" : \"~a\"]" b c d e))
