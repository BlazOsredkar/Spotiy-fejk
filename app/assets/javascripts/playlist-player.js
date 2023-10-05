$(document).ready(function () {
  let playlist = [];
  let currentSongIndex = 0;

  function loadAndPlaySong(songId) {
    $.getJSON(`/songs/${songId}.json`, function (data) {
      const audio = document.getElementById("audio-player");
      audio.src = data.mp3_url;
      audio.load();
      audio.play();
    });
  }

  function loadPlaylist(playlistId) {
    $.getJSON(`/playlists/${playlistId}.json`, function (data) {
      playlist = data.songs;
      currentSongIndex = 0;
      loadAndPlaySong(playlist[currentSongIndex].id);
    });
  }

  function playNextSong() {
    if (currentSongIndex < playlist.length - 1) {
      currentSongIndex++;
      loadAndPlaySong(playlist[currentSongIndex].id);
    }
  }

  function playPreviousSong() {
    if (currentSongIndex > 0) {
      currentSongIndex--;
      loadAndPlaySong(playlist[currentSongIndex].id);
    }
  }

  // Button click event for next song
  $("#next-btn").on("click", function (e) {
    e.preventDefault();
    playNextSong();
  });

  // Button click event for previous song
  $("#prev-btn").on("click", function (e) {
    e.preventDefault();
    playPreviousSong();
  });

  // Load playlist when a playlist is clicked
  $(".playlist-link").on("click", function (e) {
    e.preventDefault();
    const playlistId = $(this).data("playlist-id");
    loadPlaylist(playlistId);
  });
});
