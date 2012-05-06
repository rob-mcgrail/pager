get '/?' do
  title 'home'
  flash[:success] = '<strong>Everything</strong> is fine.'
  erb "<h1>hello</h1>"
end
