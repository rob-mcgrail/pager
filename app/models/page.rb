class Page
  include DataMapper::Resource

  property :id,               Serial
  property :path,             String,   :length => 3..200, :unique => true, :required => true
  property :password,         String
  property :state,            String
  property :css,              Text,     :length => 0..100_000, :required => true
  property :body,             Text,     :length => 0..100_000, :required => true

  timestamps :at

  belongs_to :user, :required => false
  belongs_to :theme


  def self.default_body
    'This is initial body content. It should act as a tutorial...' # get this from a template file... / db
  end


  def self.valid_path?(path)
    # to come
    true
  end


  def self.state
    {:new => 0}
  end


  def theme_synced?
    if self.theme
      global_css = self.theme.css
      local_css = self.css
      if local_css == global_css
        true
      else
        false
      end
    else
      false
    end
  end
end
