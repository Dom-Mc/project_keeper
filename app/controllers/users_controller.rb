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
    # binding.pry
    # TODO: Add validations to User model
    @user = User.new(params[:user])
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

  get '/users/:username' do
    @user = User.find_by_username(params[:username])
    if @user.id == session[:user_id]
      @user = User.find_by(id: session[:user_id])
      @projects = @user.projects
      erb :'users/show'
    else
      redirect "/login"
    end
  end

  get '/users/:username/edit' do
    @user = User.find_by_username(params[:username])
    if @user.id == session[:user_id]
      erb :'users/edit'
    else
      redirect "/"
    end
  end

  patch '/users/:username' do
    @user = User.find_by_username(params[:username])
    if @user.update(params[:user])
      redirect "/users/#{@user.username}"
    else
      erb :'users/edit'
    end
  end

  delete '/users/:username/delete' do
    User.find_by_username(params[:username]).delete
    redirect to '/'
  end

end
