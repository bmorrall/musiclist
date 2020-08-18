# frozen_string_literal: true

# Adds years to albums, based off the album description
#
# Usage:
# rails runner bin/extract_years.rb


require "content_utils"

albums_with_descriptions = Album.where("description like ?", "%released%").where(year: nil)

albums_with_descriptions.find_each do |album|
  year = ContentUtils.extract_year(album.description)

  puts format("%d: %s [%s]", album.id, album.title, year)
  if year.blank?
    puts album.description.split("\n").reject { |line| line !~ /released/ }.join("\n")
  else
    album.update(year: year)
  end
end
