;;;;;;;;;;;;; The raw scripts from jplayer-playlist demo ;;;;;;;;;;;;;

;; I'm not certain that these aren't already in jplayer-playlist.js ;;

	// The next/previous commands

	$("#playlist-next").click(function() {
		myPlaylist.next();
	});

(ps ((@ $ "#playlist-next") click)
    (lambda ()
      ((@ myPlaylist next))))

	$("#playlist-previous").click(function() {
		myPlaylist.previous();
	});

(ps ((@ $ "#playlist-previous") click)
    (lambda ()
      ((@ myPlaylist previous))))

	// The play commands

	$("#playlist-play").click(function() {
		myPlaylist.play();
	});

	// The pause command

	$("#playlist-pause").click(function() {
		myPlaylist.pause();
	});

;;;;;;;;;;;;;;;;;;;;;;;; Translated into PS: ;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;; These are not really necessary at present ;;;;;;;;;;;;;;
// The remove commands

	$("#playlist-remove").click(function() {
		myPlaylist.remove();
	});

	$("#playlist-remove--2").click(function() {
		myPlaylist.remove(-2);
	});
	$("#playlist-remove--1").click(function() {
		myPlaylist.remove(-1);
	});
	$("#playlist-remove-0").click(function() {
		myPlaylist.remove(0);
	});
	$("#playlist-remove-1").click(function() {
		myPlaylist.remove(1);
	});
	$("#playlist-remove-2").click(function() {
		myPlaylist.remove(2);
	});

	// The shuffle commands

	$("#playlist-shuffle").click(function() {
		myPlaylist.shuffle();
	});

	$("#playlist-shuffle-false").click(function() {
		myPlaylist.shuffle(false);
	});
	$("#playlist-shuffle-true").click(function() {
		myPlaylist.shuffle(true);
	});

	// The select commands

	$("#playlist-select--2").click(function() {
		myPlaylist.select(-2);
	});
	$("#playlist-select--1").click(function() {
		myPlaylist.select(-1);
	});
	$("#playlist-select-0").click(function() {
		myPlaylist.select(0);
	});
	$("#playlist-select-1").click(function() {
		myPlaylist.select(1);
	});
	$("#playlist-select-2").click(function() {
		myPlaylist.select(2);
	});



	$("#playlist-play--2").click(function() {
		myPlaylist.play(-2);
	});
	$("#playlist-play--1").click(function() {
		myPlaylist.play(-1);
	});
	$("#playlist-play-0").click(function() {
		myPlaylist.play(0);
	});
	$("#playlist-play-1").click(function() {
		myPlaylist.play(1);
	});
	$("#playlist-play-2").click(function() {
		myPlaylist.play(2);
	});



	// Changing the playlist options

	// Option: autoPlay

	$("#playlist-option-autoPlay-true").click(function() {
		myPlaylist.option("autoPlay", true);
	});
	$("#playlist-option-autoPlay-false").click(function() {
		myPlaylist.option("autoPlay", false);
	});

	// Option: enableRemoveControls

	$("#playlist-option-enableRemoveControls-true").click(function() {
		myPlaylist.option("enableRemoveControls", true);
	});
	$("#playlist-option-enableRemoveControls-false").click(function() {
		myPlaylist.option("enableRemoveControls", false);
	});

	// Option: displayTime

	$("#playlist-option-displayTime-0").click(function() {
		myPlaylist.option("displayTime", 0);
	});
	$("#playlist-option-displayTime-fast").click(function() {
		myPlaylist.option("displayTime", "fast");
	});
	$("#playlist-option-displayTime-slow").click(function() {
		myPlaylist.option("displayTime", "slow");
	});
	$("#playlist-option-displayTime-2000").click(function() {
		myPlaylist.option("displayTime", 2000);
	});

	// Option: addTime

	$("#playlist-option-addTime-0").click(function() {
		myPlaylist.option("addTime", 0);
	});
	$("#playlist-option-addTime-fast").click(function() {
		myPlaylist.option("addTime", "fast");
	});
	$("#playlist-option-addTime-slow").click(function() {
		myPlaylist.option("addTime", "slow");
	});
	$("#playlist-option-addTime-2000").click(function() {
		myPlaylist.option("addTime", 2000);
	});

	// Option: removeTime

	$("#playlist-option-removeTime-0").click(function() {
		myPlaylist.option("removeTime", 0);
	});
	$("#playlist-option-removeTime-fast").click(function() {
		myPlaylist.option("removeTime", "fast");
	});
	$("#playlist-option-removeTime-slow").click(function() {
		myPlaylist.option("removeTime", "slow");
	});
	$("#playlist-option-removeTime-2000").click(function() {
		myPlaylist.option("removeTime", 2000);
	});

	// Option: shuffleTime

	$("#playlist-option-shuffleTime-0").click(function() {
		myPlaylist.option("shuffleTime", 0);
	});
	$("#playlist-option-shuffleTime-fast").click(function() {
		myPlaylist.option("shuffleTime", "fast");
	});
	$("#playlist-option-shuffleTime-slow").click(function() {
		myPlaylist.option("shuffleTime", "slow");
	});
	$("#playlist-option-shuffleTime-2000").click(function() {
		myPlaylist.option("shuffleTime", 2000);
	});

	// Equivalent commands

	$("#playlist-equivalent-1-a").click(function() {
		myPlaylist.add({
			title:"Your Face",
			artist:"The Stark Palace",
			mp3:"http://www.jplayer.org/audio/mp3/TSP-05-Your_face.mp3",
			oga:"http://www.jplayer.org/audio/ogg/TSP-05-Your_face.ogg",
			poster: "http://www.jplayer.org/audio/poster/The_Stark_Palace_640x360.png"
		}, true);
	});

	$("#playlist-equivalent-1-b").click(function() {
		myPlaylist.add({
			title:"Your Face",
			artist:"The Stark Palace",
			mp3:"http://www.jplayer.org/audio/mp3/TSP-05-Your_face.mp3",
			oga:"http://www.jplayer.org/audio/ogg/TSP-05-Your_face.ogg",
			poster: "http://www.jplayer.org/audio/poster/The_Stark_Palace_640x360.png"
		});
		myPlaylist.play(-1);
	});

	// AVOID COMMANDS

	$("#playlist-avoid-1").click(function() {
		myPlaylist.remove(2); // Removes the 3rd item
		myPlaylist.remove(3); // Ignored unless removeTime=0: Where it removes the 4th item, which was originally the 5th item.
	});

;;;;;;;;;;;;;;;;;;;;;; THE HTML FOR COMPARISON ;;;;;;;;;;;;;;;;;;;;;;;

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
					
		<div class="jp-playlist">
			<ul>
				<!-- The method Playlist.displayPlaylist() uses this unordered list -->
				<li></li>
			</ul>
		</div>
		<div class="jp-no-solution">
			<span>Update Required</span>
			To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
		</div>
	</div>
</div>



<div id="jp_container_N" class="jp-video jp-video-270p" role="application" aria-label="media player">
	<div class="jp-type-playlist">
		<div id="jquery_jplayer_N" class="jp-jplayer"></div>
		<div class="jp-gui">
			<div class="jp-video-play">
				<button class="jp-video-play-icon" role="button" tabindex="0">play</button>
			</div>
			<div class="jp-interface">
				<div class="jp-progress">
					<div class="jp-seek-bar">
						<div class="jp-play-bar"></div>
					</div>
				</div>
				<div class="jp-current-time" role="timer" aria-label="time">&nbsp;</div>
				<div class="jp-duration" role="timer" aria-label="duration">&nbsp;</div>
				<div class="jp-details">
					<div class="jp-title" aria-label="title">&nbsp;</div>
				</div>
				<div class="jp-controls-holder">
					<div class="jp-volume-controls">
						<button class="jp-mute" role="button" tabindex="0">mute</button>
						<button class="jp-volume-max" role="button" tabindex="0">max volume</button>
	<div class="jp-volume-bar">
							<div class="jp-volume-bar-value"></div>
						</div>
					</div>
					<div class="jp-controls">
						<button class="jp-previous" role="button" tabindex="0">previous</button>
						<button class="jp-play" role="button" tabindex="0">play</button>
						<button class="jp-stop" role="button" tabindex="0">stop</button>
						<button class="jp-next" role="button" tabindex="0">next</button>
					</div>
					<div class="jp-toggles">
						<button class="jp-repeat" role="button" tabindex="0">repeat</button>
						<button class="jp-shuffle" role="button" tabindex="0">shuffle</button>
						<button class="jp-full-screen" role="button" tabindex="0">full screen</button>
					</div>
				</div>
			</div>
		</div>
