require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
  end

  get '/' do
    erb :welcome
  end 

  helpers do 

    def logged_in? #returns a ture or false value
      !!session[:user_id]
    end 

    def current_user
      User.find_by(:id => session[:user_id] )
    end 

  end 



end