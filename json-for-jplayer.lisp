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
