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
  "This allows the execution of arbitrary Cypher statements, so body must be a properly formatted Cypher query."
  (decode-neo4j-json-output 
   (drakma:http-request *neo-trans* 
			:method :post 
			:accept *acc-format* 
			:content-type *json* 
			:content (format nil "{\"statements\" : [ {\"statement\" : \"~a\"} ]}" body))))  


(defun get-playlist-by-title (title)
  (query2 (format nil "match (s:Song)-[:IN]->(p:Playlist {title:'~:(~a~)'}) return s.name, s.artist, s.mp3, s.oga, s.poster;" title)))

(defun get-playlist-by-owner (owner)
  "Since the Playlists don't have Owners yet this one hasn't been tested."
  (query2 (format nil "match (s:Song)-[:IN]->(p:Playlist {owner:'~:(~a~)'}) return s.name, s.artist, s.mp3, s.oga, s.poster;" owner)))

(defun get-song-by-title (title)
  (query2 (format nil "MATCH (s:Song) WHERE s.name='~:(~a~)' return s.name, s.artist, s.mp3, s.oga, s.poster;" title)))

(defun get-song-by-title-artist (title artist)
  "Be careful with this one as it assumes Noun Case for both artist and title."
  (query2 (format nil "MATCH (s:Song {name:'~:(~a~)', artist:'~:(~a~)'}) return s.name, s.artist, s.mp3, s.oga, s.poster;" title artist)))

;;;;;;;;;;;;;;;;;;;;;;;; STUFF I WANT TO SEE: ;;;;;;;;;;;;;;;;;;;;;;;;


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
