class User
  include DataMapper::Resource

  property :id,               Serial
  property :email,            String,   :format => :email_address

  timestamps :at

  has n, :pages, :required => false
end
