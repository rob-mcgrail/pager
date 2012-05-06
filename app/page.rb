class Page
  include DataMapper::Resource

  property :id,               Serial
  property :title,            String,   :length => 3..500, :required => true
  property :slug,             String,   :length => 3..500, :unique => true, :required => true
  property :password,         String
  property :state,            String
  property :body,             Text,     :length => 0..100_000, :required => true

  timestamps :at

  belongs_to :user, :required => true

  def self.make_title(slug)
    slug.gsub(/[-|_]/i, ' ').downcase
  end


  def self.default_body
    'This is initial body content. It should act as a tutorial...' # get this from a template file... / db
  end


  def self.valid_slug(slug)
    reserved = ['action', 'ajax', 'about', 'edit'].include? slug
    if reserved || Page.first(:slug => slug)
      nil
    else
      true
    end
  end


  def self.state_names
    {:new => 'new'}
  end
end
