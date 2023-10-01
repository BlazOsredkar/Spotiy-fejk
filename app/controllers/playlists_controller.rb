class PlaylistsController < ApplicationController
  before_action :set_playlist, only: %i[ show edit update destroy ]

  # GET /playlists or /playlists.json
  def index
    @playlists = Playlist.where(user_id: current_user.id)
  end

  # GET /playlists/1 or /playlists/1.json
  def show
  end

  # GET /playlists/new
  def new
    @playlist = Playlist.new
  end

  # GET /playlists/1/edit
  def edit
  end

  # POST /playlists or /playlists.json
  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user_id = current_user.id
    if @playlist.save
      redirect_to @playlist, notice: 'Playlist was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /playlists/1 or /playlists/1.json
  def update
    respond_to do |format|
      if @playlist.update(playlist_params)
        format.html { redirect_to playlist_url(@playlist), notice: "Playlist was successfully updated." }
        format.json { render :show, status: :ok, location: @playlist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1 or /playlists/1.json
  def destroy
    @playlist.destroy

    respond_to do |format|
      format.html { redirect_to playlists_url, notice: "Playlist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def remove_from_playlist
    @playlist = Playlist.find(params[:playlist_id])
    @song = Song.find(params[:song_id])

    # Find the position of the song being removed
    position_to_remove = @playlist.playlist_songs.find_by(song_id: @song.id).position

    # Remove the song from the playlist
    @playlist.songs.delete(@song)

    # Update the positions of the remaining songs
    @playlist.songs.where('playlists_songs.position > ?', position_to_remove).each do |song|
      current_position = song.playlist_songs.find_by(playlist: @playlist).position
      song.playlist_songs.find_by(playlist: @playlist).update(position: current_position - 1)
    end

    redirect_to playlist_path(@playlist), notice: 'Song removed from playlist successfully.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def playlist_params
      params.require(:playlist).permit(:name, :cover_image, :privacy)
    end
end
