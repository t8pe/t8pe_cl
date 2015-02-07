(ql:quickload :hunchentoot)                           
(ql:quickload :drakma)                                
(ql:quickload :babel)                                 
(ql:quickload :cl-json)
                               
;; Should probably put those (require) things in there.                               

(defun decode-neo4j-json-output (json)               
               (cl-json:decode-json-from-string (babel:octets-to-string json)))       

(setf *test-query* "{\"query\" : \"MATCH (s:Song) WHERE s.artist='Ben' RETURN s.name\"}")                                                   
(setf *neo* "http://localhost:7474/db/data/cypher")   
(setf *neo-trans* "http://localhost:7474/db/data/transaction/") 
(setf *acc-format* "application/json; charset=UTF-8")    
(setf *json* "application/json")    
(setf poop "commander poop")
                 
(defun query1 (type prop term ret)
  (decode-neo4j-json-output 
   (drakma:http-request *neo-trans* 
			:method :post 
			:accept *acc-format* 
			:content-type *json* 
			:content (format nil "{\"statements\" : [ {\"statement\" : \"MATCH (s:~@(~a~)) WHERE s.~(~:a~)='~@(~a~)' RETURN s.~(~:a~)\"} ]}" type prop term ret))))           
;; query1 allows a very specific format of request.

(defun query2 (body)
  (decode-neo4j-json-output 
   (drakma:http-request *neo-trans* 
			:method :post 
			:accept *acc-format* 
			:content-type *json* 
			:content (format nil "{\"statements\" : [ {\"statement\" : \"~a\"} ]}" body))))  
;; query2 allows arbitrary execution of Cypher statements from lisp. I call that a win.

(defun get-playlist (title)
  (query2 (format nil "match (s:Song)-[:IN]->(p:Playlist {title:'~:(~a~)'}) return s.name, s.mp3;" title)))

;; Each of the "query" defuns has the exact same stuff from decode... to "statement" so I'm sure there's some way to abstract that.
;;--------------------------------------------;;                                      ;; STUFF I WANT TO SEE:

(defun get-playlist-by-owner (owner)
  (query2 (format nil "match (s:Song)-[:IN]->(p:Playlist {owner:'~:(~a~)'}) return s.name, s.mp3;" owner))) ;; Since the Playlists don't have Owners yet this one hasn't been tested.

(defun get-song-by-title (title)
  (...))

(defun get-song-by-title-artist (title artist)
  (...))


(defun write-playlist (lst)
  (...))

(defun delete-playlist (lst)
  (...))
