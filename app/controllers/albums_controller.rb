class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ show edit update destroy ]

  # GET /albums or /albums.json
  def index
    @albums = Album.all
  end

  # GET /albums/1 or /albums/1.json
  def show
  end

  def update_foreign_key_references
    Song.where(album_id: @album.id).update_all(album_id: nil)
  end

  # GET /albums/new
  def new
    if current_user.is_artist
      @album = Album.new
    else
      redirect_to root_path, notice: "Only Artists can do that."
    end
  end

  # GET /albums/1/edit
  def edit
    if current_user == @album.user_id
    else
      redirect_to albums_path, notice:"Only the owner can do that."
    end
  end

  # POST /albums or /albums.json
  def create
    if current_user.is_artist
      @album = Album.new(album_params)
      if @album.save
        current_user.albums << @album  # Associates the album with the current user
        redirect_to @album, notice: 'Album was successfully created.'
      else
        render :new
      end
    else
      redirect_to root_path, notice: "Only Artists can do that."
    end
  end


  # PATCH/PUT /albums/1 or /albums/1.json
  def update
    respond_to do |format|
      if current_user == @album.user
        if @album.update(album_params)
          format.html { redirect_to album_url(@album), notice: "Album was successfully updated." }
          format.json { render :show, status: :ok, location: @album }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @album.errors, status: :unprocessable_entity }
        end
      else
        redirect_to albums_path, notice:"Only the owner can do that."
      end
    end
  end

  # DELETE /albums/1 or /albums/1.json
  def destroy
    if current_user == @album.user_id
      update_foreign_key_references
      @album.destroy

      respond_to do |format|
        format.html { redirect_to albums_url, notice: "Album was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to albums_path, notice:"Only the owner can do that."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:name, :description, :year, :user_id)
    end
end
