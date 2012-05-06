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
end
