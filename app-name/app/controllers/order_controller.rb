class OrderController < ApplicationController

  #create route that renders the orer form
  
  get '/orders/new' do 
    
    if logged_in? 
        erb :'/orders/new'
    else 
        @error = "Please log in or sign up!"
        erb :'users/login'
    end 
  end 

  post '/orders' do #processes our form
    if logged_in?
        @order = Order.create(address: params[:address], user_id: session[:user_id],item: params[:item], item_price: params[:item_price], total: params[:total])
       
        redirect to "/orders/#{@order.id}"
        #now it needs to go to the read route 
    
    else 
        redirect '/users/login'
    end 
    
  end 
  

  #read route 
  get '/orders/:id' do 
    @order = Order.find(params[:id])
    erb :'/orders/show'
  end 

  get '/orders' do 
    if logged_in?
        @orders = current_user.orders  #returns all the order info
        erb :'/orders/index'
    else 
        @error = "Please log in or sign up!"
        erb :'users/login'
    end 
  end 

  #update 

  get '/orders/:id/edit' do
    if logged_in? && @order.user_id == session[:user_id]
        @order = Order.find(params[:id])
        erb :'/orders/edit'
    else 
        @error = "Please log in or sign up."
        erb :'users/login'
    end 
  end 

  patch '/orders/:id' do
    if logged_in? && @order.user_id == session[:user_id]
      @order = Order.find(params[:id])
      @order.update(address: params[:address], item: params[:item], item_price: params[:item_price], total: params[:total])
    end 
    redirect "/orders/#{@order.id}"
  end

  #delete
#   get '/orders/:id' do
#     @order = Order.find(params[:id])
#     @order.destroy
#     redirect to '/orders'
#   end 

  delete '/orders/:id' do 
    @order = Order.find_by_id(params[:id])
    
    if logged_in? && @order.user_id == session[:user_id]
        @order.destroy
    end
    redirect '/orders'
    end 
  
end 