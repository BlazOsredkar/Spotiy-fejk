require 'mp3info'


class SongsController < ApplicationController
  before_action :set_song, only: %i[ show edit update destroy ]


  def add_to_playlist
    @song = Song.find(params[:id])
    @playlists = Playlist.where(user_id: current_user.id)
  end

  def create_playlist_song
    @song = Song.find(params[:id])
    selected_playlist_ids = Array(params[:song][:playlist_ids]).reject(&:empty?)
    
    if selected_playlist_ids.empty?
      redirect_to add_to_playlist_song_path(@song), alert: 'Please select at least one playlist.'
    else
      selected_playlist_ids.each do |playlist_id|
        playlist = Playlist.find(playlist_id)
        position = playlist.songs.count + 1
        playlist.playlist_songs.create(song: @song, position: position)
      end
    
      redirect_to @song, notice: 'Song added to playlist(s) successfully.'
    end
  end

  # GET /songs or /songs.json
  def index
    if params[:search]
      @songs = Song.search(params[:search])
    else
      @songs = Song.all
    end
  end

  # GET /songs/1 or /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    #check if the current user 
    #add the current_user to the song
    if current_user.is_artist
      @song = Song.new(user_id: current_user.id)
    else
      redirect_to root_path, notice:"Only Artists can do that."
    end
  end

  def next_song
    if @playlist = Playlist.find(params[:playlist_id]) rescue nil
      @song = @playlist.songs.find(params[:song_id]) rescue nil
      @next_song = @playlist.songs.find_by('playlists_songs.position > ?', @song.playlist_songs.find_by(playlist: @playlist).position) rescue nil if @song
      unless @next_song
        @next_song = @playlist.songs_by_position.first
      end
    else
      @song = Song.find(params[:song_id]) rescue nil
      @next_song = Song.where.not(id: @song.id).sample
    end
    render json: @next_song
  end

  # GET /songs/1/edit
  def edit
    if current_user == @song.user
    else
      redirect_to songs_path, notice:"Only the owner can do that."
    end
  end

  # POST /songs or /songs.json
  def create
    @song = Song.new(song_params)


    if params[:song][:mp3].present?
      mp3_file = params[:song][:mp3].tempfile
      Mp3Info.open(mp3_file) do |mp3info|
        @song.length = mp3info.length
      end
    end

    respond_to do |format|
      if @song.save
        format.html { redirect_to song_url(@song), notice: "Song was successfully created." }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1 or /songs/1.json
  def update
    respond_to do |format|
      if current_user == @song.user
        if @song.update(song_params)
          format.html { redirect_to song_url(@song), notice: "Song was successfully updated." }
          format.json { render :show, status: :ok, location: @song }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @song.errors, status: :unprocessable_entity }
        end
      else
        redirect_to root_path, notice:"Only Song creator can do that."
      end
    end
  end

  # DELETE /songs/1 or /songs/1.json
  def destroy
    respond_to do |format|
      if current_user == @song.user
        @song.destroy
        format.html { redirect_to songs_url, notice: "Song was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to song_url, alert: "Only the owner can do that." }
        format.json { render json: { error: "Unauthorized" }, status: :unauthorized }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.require(:song).permit(:name, :description, :length, :mp3, :image, :user_id, :album_id)
    end
end
