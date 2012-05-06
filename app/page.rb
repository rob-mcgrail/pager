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

  def self.make_title(slug)
    slug.gsub(/[-|_]/i, ' ').downcase
  end


  def self.default_body
    'A tutorial of how to use the site would go here' # get this from a template file... / db
  end


  def self.valid_slug(slug)
    blacklist = ['action', 'ajax', 'about']
    if Page.first(:slug => slug) || blaclist.include? slug
      nil
    else
      true
    end
  end
end
