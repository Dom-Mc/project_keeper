class UsersController < ApplicationController

  get '/signup' do
    redirect "/#{current_user.username}" if logged_in?
    @user = User.new
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.new(params[:user])
    if @user.save
      log_in(@user)
      flash[:success] = "Welcome to Project Keeper. Let's get started!"
      redirect "/#{@user.username}"
    else
      erb :'users/signup'
    end
  end

  get '/login' do
    redirect "/#{current_user.username}" if logged_in?
    @user = User.new
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      log_in(@user)
      flash[:success] = "Welcome back to Project Keeper!"
      redirect "/#{@user.username}"
    else
      flash[:danger] = "Invalid username and/or password."
      erb :'users/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      @current_user = nil
      flash[:success] = "You have successfully logged out. We hope to see you back soon!"
    end
    redirect '/'
  end

  get '/:username' do
    user_authenticated?
    @projects = @user.projects.take(3)
    erb :'users/show'
  end

  get '/:username/edit' do
    user_authenticated?
    erb :'users/edit'
  end

  patch '/:username' do
    user_authenticated?
    if @user.update(params[:user])
      flash[:success] = "Your profile has successfully been updated!"
      redirect "/#{@user.username}"
    else
      erb :'users/edit'
    end
  end

  delete '/:username/delete' do
    user_authenticated?
    @user.delete
    flash[:success] = "You have successfully deleted your account. We're sorry to see you leave but you're always welcome back!"
    redirect to '/'
  end

end
