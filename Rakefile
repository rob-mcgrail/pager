require 'rake'

task :default => [:test]

env = ENV["env"] || "development"


task :test do
  require './app'
  env = "test"
  set :environment, :test
  load './settings.rb'
  puts "\nDestructively updating:\n"
  puts settings.db
  DataMapper.auto_migrate!
  Bundler.require(:test)
  Rake::Task["themes"].invoke
  require './test/mocks/factory'
  require 'minitest/autorun'
  Dir['./test/test_*.rb'].each {|file| require file }
end


namespace :db do
  require './app'
  set :environment, env.to_sym
  load './settings.rb'

  task :update do
    puts "\nNon-destructively updating:\n"
    puts settings.db
    DataMapper.auto_upgrade!
  end

  task :migrate do
    puts "\nDestructively update #{env} database? Y/N\n"
    if $stdin.gets.chomp.downcase == 'y'
      puts "\nDestructively updating:\n"
      puts settings.db
      DataMapper.auto_migrate!
      Rake::Task["themes"].invoke
    end
  end
end


task :themes do
  require './app'
  set :environment, env.to_sym
  load './settings.rb'
  puts "\nDestructively loading themes...\n\n"
  @themes = Theme.all
  @themes.each do |theme|
    unless theme.destroy
      raise "Failed to destroy theme #{theme.id} #{theme.name}"
    end
  end
  Dir['./assets/themes/*.css'].each do |path|
    theme = File.new(path)
    name = 'Hello'#Theme.extract_name(theme)
    css = Theme.extract_css(theme)
    @theme = Theme.new(
      :name => name,
      :css => css,
    )
    unless @theme.save
      raise "Failed to save theme #{@theme.id} #{@theme.name}"
    end
  end
end


task :server do
  system("bundle exec rackup -p 8000 -s puma")
end


task :install do
  system("bundle install")
  Rake::Task["test"].invoke
  Rake::Task["db:migrate"].invoke
end
