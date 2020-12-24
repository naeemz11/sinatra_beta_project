class UserController < ApplicationController

    get '/users/signup' do  #users is from the users db
        erb :'/users/signup'

    end 

    post '/users/signup' do #takes user's info from the signup page
        #params[:username]
        #params[:password]
        if params[:username] == "" || params[:password] == ""
            redirect 'users/signup'
        else 
            @user = User.create(username: params[:username], password: params[:password])
            session[:user_id] = @user.id
       
            redirect "/users/#{@user.id}"
        end 
    
    end 

    get '/users/login' do 
        #if the user is logged in, redirect to home page. Else show them the home page
        if logged_in?
            @user = User.find(session[:user_id])
            redirect "/users/#{@user.id}"
        else
            erb :'/users/login'
        end 
    end 

    post '/users/login' do 
        #find user if user exists and if exists
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password]) #exists, set the session and redirect to homepage
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        #authenticate password
        else 
        #not valid. rediect to login
            redirect '/users/login'
        end 
         
    end 

    
    get '/users/logout' do 
        session.clear
        redirect '/'
    end 


    get '/users/:id' do #showpage: renders data based on id
        @user = User.find(params[:id])
        
        erb :'/users/welcome'
    
    end 



    post '/users/logout' do
        session.clear
        redirect '/'
    end


end 