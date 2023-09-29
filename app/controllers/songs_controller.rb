require 'mp3info'


class SongsController < ApplicationController
  before_action :set_song, only: %i[ show edit update destroy ]

  # GET /songs or /songs.json
  def index
    @songs = Song.all
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

  # GET /songs/1/edit
  def edit
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
      if @song.update(song_params)
        format.html { redirect_to song_url(@song), notice: "Song was successfully updated." }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
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
      params.require(:song).permit(:name, :description, :length, :mp3, :image, :user_id)
    end
end
