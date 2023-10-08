const prevSongs = [];
const nextSongs = [];

// audio-player.js
$(document).ready(function () {
  // Function to load and play a song
  function loadAndPlaySong(songId, playlistId = null) {
    $.getJSON(`/songs/${songId}.json`, function (data) {
      // Get the existing audio element by its ID
      const audio = document.getElementById("audio-player");

      // Set the source for the audio element
      audio.src = data.mp3_url;

      audio.dataset.currentSongId = data.id;
      audio.dataset.currentPlaylistId = playlistId;

      // Load and play the audio
      audio.load();
      audio.play();

      // Update the currently playing song name (optional)
    });
  }

  // Trigger the audio player when a song is clicked
  $(".song-link").on("click", function (e) {
    e.preventDefault();
    const songId = $(this).data("song-id");
    const playlistId = $(this).data("playlist-id");
    console.log(songId);
    console.log(playlistId);
    loadAndPlaySong(songId, playlistId);
  });

  // Update custom controls when the audio playback status changes
  const audio = document.getElementById("audio-player");
  audio.addEventListener("play", function () {
    // Perform actions when the audio starts playing
    console.log("Audio is playing");
  });

  audio.addEventListener("pause", function () {
    // Perform actions when the audio is paused
    console.log("Audio is paused");
  });

  audio.addEventListener("ended", function () {
    playNextSong();
  });

  function playNextSong() {
    const currentSongId = audio.dataset.currentSongId;
    const currentPlaylistId = audio.dataset.currentPlaylistId;

    if (nextSongs.length > 0) {
      const nextSongId = nextSongs.pop();
      prevSongs.push(currentSongId);
      loadAndPlaySong(nextSongId);
      return;
    }

    fetch(
      `/songs/next_song?song_id=${currentSongId}&playlist_id=${currentPlaylistId}`
    ).then(
      (
        response // Fetch the next song
      ) =>
        response.json().then((data) => {
          console.log(data);
          loadAndPlaySong(data.id, currentPlaylistId);
        })
    );
  }
  function playPreviousSong() {
    if (prevSongs.length > 0) {
      const previousSongId = prevSongs.pop();
      nextSongs.push(audio.dataset.currentSongId);
      loadAndPlaySong(previousSongId);
    }
  }
});
