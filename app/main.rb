get '/?' do
  title 'welcome!'
  @csfr_token = String.random
  session[:token] = @csfr_token
  erb :home
end


post '/new' do
  unless session[:token] == params['token']
    flash[:error] = "You're a dick, or possibly you need cookies enabled"
    redirect '/'
  end

  email = params['email']
  password = params['password']

  @user = User.first(:email => email)

  unless @user
    @user = User.new(
      :email => email
    )
    unless @user.save
      flash[:error] = "Something went really wrong"
      redirect '/'
    end
  end

  @page = @user.pages.new(
    :password => BCrypt::Password.create(password),
    :title => Page.default_title,
    :slug => Page.generate_slug,
    :body => Page.default_body,
  )
  if @user.save
    redirect "/pages/edit/#{@page.slug}"
  else
    flash[:error] = "Something went really wrong"
    redirect '/'
  end
end
