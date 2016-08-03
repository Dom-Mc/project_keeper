class UsersController < ApplicationController

  get '/signup' do
    if session[:user_id]
      redirect "/projects"
    else
      @user = User.new
      erb :'users/signup'
    end
  end

  post '/signup' do
    # TODO: Add validations to User model
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect "/projects"
    else
      erb :'users/signup'
    end
  end

  get '/login' do
    if session[:user_id]
      redirect "/projects"
    else
      @user = User.new
      erb :'users/login'
    end
  end

  post '/login' do
    # TODO: Add validations to User model
    @user = User.find_by_username(params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect '/projects'
    else
      erb :'users/login'
    end
  end

  get '/logout' do
    session.clear if session[:user_id]
    redirect '/login'
  end

  get '/users/:id' do
    # NOTE: create slug
    if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      erb :'users/show'
    else
      redirect "/login"
    end
  end

  get '/users/edit' do

  end

  patch '/users/update' do

  end

  delete '/users/delete' do
  end

end
