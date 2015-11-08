# Require all gems in Gemfile :-)
require 'bundler'
Bundler.require

# Models is in another file because it doesn't belong here
require_relative 'models'

# Sessions are basically going to make my life not a living hell hopefully
enable :sessions

helpers do
	def login?
    if session[:user].nil?
      return false
    else
      return true
    end
  end

  def username
    return session[:username]
  end
end

# Get index page
get '/'  do
	slim :index
end

get '/dashboard' do
	slim :dashboard
end

# Get Sign up Page
get '/signup' do
	slim :signup
end

# Get Login Page
get '/login' do
	slim :login
end

# Get dashboard
get '/dashboard' do
	@username = session[:username]
	slim :dashboard
end

# Get create new network page
get '/create' do
	slim :create
end

# Get all networks ordered
get '/browse' do
	@networks = Network.all(:order => :created_at.desc)
	slim :browse
end

post '/signup' do
	@user = User.new(params[:user])
	if @user.save
		redirect '/dashboard'
	else
		redirect '/signup'
	end
end

# Get user profile
get '/u/:user' do
	@user = User.get(user)
	if @user
		slim :user
	else
		slim :error
	end
end

# Post create new network
post '/create' do
	@network = Network.new(params[:network])
	if @network.save
		redirect '/browse'
	else
		redirect '/create'
	end
end

get '/users' do
	@users = User.all
	slim :users
end

get '/search' do
	slim :search
end

# Get network via unique ID
get '/network' do
	slim :network
end

get '/logout' do
	session[:user] = nil
	redirect '/'
end

post '/login' do
	# FUCK EVERYTHING i hat etime crunch
	redirect '/dashboard'
end
