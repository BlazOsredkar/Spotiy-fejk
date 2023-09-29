# app/helpers/songs_helper.rb

module SongsHelper
  def formatted_duration(seconds)
    minutes = seconds.to_i / 60
    remaining_seconds = seconds.to_i % 60
    "#{minutes}:#{format('%02d', remaining_seconds)}"
  end
end
