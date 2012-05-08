get '/' do
  title 'welcome!'
  @csfr_token = String.random
  session[:token] = @csfr_token
  erb :home
end


post '/action/new' do
  unless session[:token] == params['token']
    flash[:error] = "You're a dick, or possibly you need cookies enabled"
    redirect '/'
  end

  email = params['email']
  password = params['password']
  slug = params['slug']

  unless Page.valid_slug(slug)
    flash[:error] = "That url wasn't allowed... what gives?"
    redirect '/'
  end

  @user = User.first(
    :email => email

  )
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
    :title => Page.make_title(slug),
    :slug => slug,
    :body => Page.default_body,
    :state => Page.state_names[:new],
  )
  if @user.save
    session[@page.id] = true
    redirect "/#{@page.slug}"
#    Pony.mail(
#      :to => email,
#      :from => 'noreply@pager.robmcgrail.com',
#      :subject => 'Your new Pager page!',
#      :body => "Edit url: #{slug}\nPassword: #{password}",
#      :via => :sendmail
#    )
#   Mail.defaults do
#       delivery_method :exim, :location => "/usr/sbin/exim"
#     end
#    mail = Mail.new do
#      from     'rob@aichi.com'
#      to       email
#      subject  'Here is the image you wanted'
#      body     'abc'
#    end
#    mail.deliver
  else
    flash[:error] = "Something went really wrong"
    redirect '/'
  end
end



#TODO
get '/edit/:slug/?' do
  slug = params[:slug]
  @page = Page.first(:slug => slug)
end


get '/ajax/valid-slug/:slug' do
  slug = params[:slug]
  valid = Page.valid_slug(slug)
  content_type :json
  { :valid => valid }.to_json
end

#get '/', :host_name => /^admin\./ do


get '/:slug' do
  slug = params[:slug]
  if @page = Page.first(:slug => slug)
    if session[@page.id]
      if @page.state == Page.state_names[:new]
        @show_intro = true
      else
        if (Time.now - page.modified_at) > 2880
          # reminder if they haven't edited the page for a while...
          @show_ownership = true
        end
      end
    end
    erb :'page/wrapper'
  else
    404
  end
end
