source :rubygems

gem "sinatra"
gem "sinatra-flash"
gem "sinatra-subdomain"

gem "dm-core", ">=1.2"
gem "dm-do-adapter", ">=1.2"
gem "dm-timestamps", ">=1.2"
gem "dm-validations", ">=1.2"
gem "dm-migrations", ">=1.2"

gem "erubis"
gem "redcarpet"
gem "warden"
gem "bcrypt-ruby", :require => "bcrypt"
gem "trollop"
gem "json"
gem "pony"

group :dev do
  gem "mongrel", :platforms => :mri_18
  gem "puma"
  gem "dm-sqlite-adapter", ">=1.2"
end

group :production do
  gem "dm-mysql-adapter"
end

group :test do
  gem "minitest", :platforms => :mri_18
  gem "minitest-colorize"
  gem "webmock"
  gem "dm-sweatshop"
end
