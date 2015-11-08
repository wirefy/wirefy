# Require all gems in Gemfile :-)
require 'bundler'
Bundler.require

require_relative 'models'

# Get index page
get '/'  do
	slim :index
end

get '/dashboard' do
	slim :dashboard
end

# Get Sign up Page
get '/signup' do
	# Criteria
	# - username
	# - first name
	# - email
	# - password
	# ------------
	# Also criteria from /create
	slim :signup
end

# Get Login Page
get '/login' do
	slim :login
end

# Get create new network page
get '/create' do
	authorize!('/login')
	# Criteria
	# - SSID
	# - network password
	# - location "in english"
	# - location via HTML5 Geolocation
	# - notes(?)
	slim :create
end

# Get all networks ordered
get '/networks' do
	authorize!('/login')
	content_type :json

	@networks = Network.all(:order => :created_at.desc)
	@networks.to_json
end

post '/dashboard' do
	"kill me"
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
post '/create/:id' do
	network = Network.new(id)

	if network.save
		redirect '/networks'
	else
		redirect '/create/network'
	end
end

# Get network via unique ID
get '/n/:id' do
	authorize!('/login')
	@network = Network.get(id)
	if @network
		slim :network
	else
		slim :error
	end
end
