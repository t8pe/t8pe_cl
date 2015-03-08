# t8pe 

So far t8pe is a minimal web app. It doesn't yet handle most of the fancy stuff like adding playlists, user management... we're getting there. 
**  t8pe/lisp serves files, makes player, takes care of money, record
keeping. Everything else is in BuddyPress. **

##t8pe todo

- login system
- a way to use search results
- build-playlist page
- catch exceptions properly in json-for-jplayer.lisp
- write 404 pages
- unfuck my git setup
- iframes

## DATA MODEL: 
###Song:
- Copyright owner
- songwriter
- [:BY] -> Artist
- [:IN] -> playlist
- plays information
- lyrics
- more info / writeups (link)

###Playlist: 
- Title
- [:OWNED_BY] -> User/Artist
- more info / writeups (link)

###Artist: UNIQUE
- name
- plays information (aggregate)
- payment stuff?
- BuddyPress Foreign Key
- more info / writeups (link)

###User: UNIQUE
- Username
- BuddyPress Foreign Key

##FURTHER THOUGHTS 
###Trouble:
- collaboration (percentages?)
- multiple artists
- remixes
- non-unique names -> politics of choosing the correct name? Help with
claiming names?

###Blog-level customizability:
- visual (CSS)
- favicon

###Curation:
- artist-controlled curation split

###API:
- whaaaaaa?

## BUDDYPRESS MODEL:

##PAYMENT STUFF:
- does payment happen through BP or through NEO?


