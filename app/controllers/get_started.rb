helpers do
  def validate_csfr_token(token)
    unless session[:token] == token
      flash[:error] = "You're a dick, or possibly you need cookies enabled"
      redirect '/'
    end
  end
end


get '/' do
  pages = Page.all
  title 'welcome to pager!'
  @csfr_token = String.random
  session[:token] = @csfr_token
  erb :'home/index'
end


post '/action/new' do
  validate_csfr_token params['token']

  password = params['password']
  path = params['path']

  unless Page.valid_path?(path)
    flash[:error] = "That url wasn't allowed... what gives?"
    redirect '/'
  end
  @page = Page.new(
    :password => BCrypt::Password.create(password),
    :path => path,
    :css => Theme.default.css,
    :body => Page.default_body,
    :state => Page.state[:new],
    :theme => Theme.default,
  )

  if @page.save
    session[@page.id] = true
    redirect "/#{@page.path}" # where?
    # send mail
  else
    flash[:error] = "Something went really wrong"
    redirect '/'
  end
end


get '/ajax/valid-path/?' do
  path = params[:path]
  valid = Page.valid_path(path)
  content_type :json
  { :valid => valid }.to_json
end
