class Theme
  include DataMapper::Resource
  property :id,               Serial
  property :name,             String, :required => true
  property :css,              Text,   :length => 0..100_000, :required => true

  timestamps :at

  has n, :pages, :required => false

  @@default_theme = 'Hello'

  def self.default
    Theme.first(:name => @@default_theme)
  end


  def self.extract_name(file)
    str = file.read
    file.rewind
    str.lines.first.chomp
  end


  def self.extract_css(file)
    str = file.read
    file.rewind
    str.lines.to_a[1..-1].join
  end
end
