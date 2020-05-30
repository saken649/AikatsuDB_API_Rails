# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

[
  # master tables
  ::Group,
  ::Singer,
  ::Character,
  ::Production,
  ::Creator,
  ::Album,
  ::AlbumTrack,
  ::Series, # Song が依存
  ::Song,
  ::Aitube, # Song に依存
  # relation tables
  ::SongSinger,
  ::CharacterSinger,
  ::SongCharacter,
  ::SongCreator,
  ::SongAlbum
].each do |target|
  table_name = target.to_s.underscore.pluralize
  CSV.foreach(Rails.root.join("db/test_seed/#{table_name}_test.csv"), headers: true) do |row|
    target.create(row.to_h)
  end
  puts "seed: #{table_name}"
end