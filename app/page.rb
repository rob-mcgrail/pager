class Page
  include DataMapper::Resource

  property :id,               Serial
  property :title,            String,   :length => 3..500, :required => true
  property :slug,             String,   :length => 3..500, :unique => true, :required => true
  property :created_at,       DateTime
  property :updated_at,       DateTime
  property :password,         String

  property :body,             Text,     :length => 0..100_000, :required => true

  belongs_to :user, :required => true

  def self.default_title
    'I need a title!'
  end


  def self.default_body
    'A tutorial of how to use the site would go here'
  end


  def self.generate_slug
    str = String.random
    if self.first(:slug => str)
      self.generate_slug
    else
      str
    end
  end
end
