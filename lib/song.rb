class Song 
  attr_accessor :name
  attr_reader :artist
  @@all = []
  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist=(artist) if artist
    self.genre=(genre) if genre 
   end
  
  def self.all 
    @@all 
  end
  
  def self.destroy_all 
 @@all.clear
end

def save 
  @@all << self
end
  
def self.create(name)
    song = Song.new(name)
    song.save
    song
end

def artist=(artist)
   @artist = artist
   artist.add_song(self)
 end

def genre=(genre)
  @genre = genre 
  genre.songs << self unless genre.songs.include?(self)

end

def genre 
  @genre 
  end
  
def self.find_by_name(name)
 all.find {|x| x.name == name}
 end
 
def self.find_or_create_by_name(name)
  find_by_name(name) || create(name)
end

def self.new_from_filename(file)
  parts = file.split(" - ")
  artist_name, song_name, genre_name = parts[0], parts[1], parts[2].gsub(".mp3", "")

  artist = Artist.find_or_create_by_name(artist_name)
  genre = Genre.find_or_create_by_name(genre_name)

  new(song_name, artist, genre)
  end

  def self.create_from_filename(file)
    new_from_filename(file).tap{ |x| x.save }
  end

  def import
    files.each{ |x| Song.create_from_filename(x) }
  end

end