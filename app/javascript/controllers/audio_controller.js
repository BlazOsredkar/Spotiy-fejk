// app/javascript/controllers/audio_controller.js

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["audioPlayer", "songName", "songAuthor"];

  initialize() {
    this.prevSongs = [];
    this.nextSongs = [];
  }

  connect() {
    this.audioPlayerTarget.addEventListener(
      "ended",
      this.playNextSong.bind(this)
    );
  }

  loadAndPlaySong(songId, playlistId = null) {
    fetch(`/songs/${songId}.json`)
      .then((response) => response.json())
      .then((data) => {
        this.audioPlayerTarget.src = data.mp3_url;
        this.audioPlayerTarget.dataset.currentSongId = data.id;
        this.audioPlayerTarget.dataset.currentPlaylistId = playlistId;
        this.audioPlayerTarget.load();
        this.audioPlayerTarget.play();
        this.songNameTarget.innerText = data.name;
        this.songNameTarget.href = `/songs/${data.id}`;
        this.songAuthorTarget.innerText = data.user_full_name;
        this.songAuthorTarget.href = `/artists/${data.user_id}`;
      });
  }

  playPreviousSong(event) {
    event.preventDefault();
    if (this.prevSongs.length > 0) {
      const previousSongId = this.prevSongs.pop();
      this.nextSongs.push(this.audioPlayerTarget.dataset.currentSongId);
      this.loadAndPlaySong(previousSongId);
    }
  }

  playNextSong(event) {
    event.preventDefault();
    const currentSongId = this.audioPlayerTarget.dataset.currentSongId;
    const currentPlaylistId = this.audioPlayerTarget.dataset.currentPlaylistId;
    this.prevSongs.push(currentSongId);

    if (this.nextSongs.length > 0) {
      const nextSongId = this.nextSongs.pop();
      this.loadAndPlaySong(nextSongId);
    } else {
      fetch(
        `/songs/next_song?song_id=${currentSongId}&playlist_id=${currentPlaylistId}`
      )
        .then((response) => response.json())
        .then((data) => {
          this.loadAndPlaySong(data.id, currentPlaylistId);
        });
    }
  }

  playSong(event) {
    event.preventDefault();
    const songId = event.target.dataset.songId;
    const playlistId = event.target.dataset.playlistId;
    console.log(songId, playlistId, event.target.dataset);
    this.loadAndPlaySong(songId, playlistId);
  }
}
