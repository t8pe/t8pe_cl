(ql:quickload :hunchentoot)                           
(ql:quickload :drakma)                                
(ql:quickload :babel)                                 
(ql:quickload :cl-json)
                               
;; Should probably put those (require) things in there.                               

(defun decode-neo4j-json-output (json)               
               (cl-json:decode-json-from-string (babel:octets-to-string json)))       

(setf *test-query* "{\"query\" : \"MATCH (s:Song) WHERE s.artist='Ben' RETURN s.name\"}")                                                   
(setf *neo* "http://127.0.0.1:7474/db/data/cypher")   
(setf *neo-trans* "http://localhost:7474/db/data/transaction/") 
(setf *acc-format* "application/json; charset=UTF-8")    
(setf *json* "application/json")    
(setf poop "commander poop")

;;;;;;;;;;;;;;;;;;;;; INFORMATION SCHEMA - NEO4J ;;;;;;;;;;;;;;;;;;;;;
                 
;; load csv with headers from "file:///Users/BenDeschamps/Documents/PROGRAMMING/t8pe/moredata.csv" as csvline
;; merge (s:Song {title:csvline.Title, album:csvline.Album, track:csvline.TrackNumber, mp3: coalesce(csvline.mp3, "No MP3"}) 
;; merge (a:Artist {name:csvline.Artist})
;; merge (s)-[:BY]->(a)
;;
;; In other words: a Song is ({title, album*, track, mp3, oga*, poster*}) -[:BY]-> Artist ({name}), -[:IN]-> Playlist ({title})

(defun cypher-query (body)
  "This allows the execution of arbitrary Cypher statements, so body must be a properly formatted Cypher query."
  (decode-neo4j-json-output 
   (drakma:http-request *neo-trans* 
			:method :post 
			:accept *acc-format* 
			:content-type *json* 
			:content (format nil "{\"statements\" : [ {\"statement\" : \"~a\"} ]}" body))))  


(defun get-playlist-by-title (title)
  (cypher-query (format nil "match (s:Song)-[:IN]->(p:Playlist {title:'~a'}) return s.title, s.artist, s.mp3, s.oga, s.poster;" title)))

(defun get-song-by-title (title)
 "Be careful as Songs are of course case sensitive"
  (cypher-query (format nil "MATCH (s:Song) WHERE s.title='~a' return s.title, s.artist, s.mp3, s.oga, s.poster;" title)))

(defun get-song-by-title-artist (title artist)
  "Be careful with this one as it assumes Noun Case for both artist and title."
  (cypher-query (format nil "MATCH (s:Song {title:'~a', artist:'~a'}) return s.title, s.artist, s.mp3, s.oga, s.poster;" title artist)))
