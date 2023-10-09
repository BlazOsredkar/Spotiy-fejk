class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
    if params[:search]
      @songs = Song.search(params[:search])
      @albums = Album.search(params[:search])
      @artists = User.search(params[:search])
      #@artists = Artist.search(params[:search])
      @search_results_available = (@songs.present? || @albums.present? || @artists.present?)
    else
      @search_results_available = false
    end
  end
end
