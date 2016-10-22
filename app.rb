ENV['RACK_ENV'] = 'development'
require 'sinatra/base'
require_relative 'data_mapper_setup'

class Chitter < Sinatra::Base
  enable :sessions
  set :session_secret, 'big secret'

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id])
  end
end

  get '/' do
    erb :index
  end

  get '/new_user' do
    erb :sign_up
  end

  post '/new_user' do
    user = User.new(name: params[:name], user_name: params[:user_name], email: params[:email])
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
    user.save
    session[:user_id] = user.id
    redirect '/profile'
  end

  get '/profile' do

    erb :index
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end