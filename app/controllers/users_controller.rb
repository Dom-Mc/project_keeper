class UsersController < ApplicationController

  get '/signup' do
    redirect "/#{current_user.username}/projects" if logged_in?
    @user = User.new
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.new(params[:user])
    if @user.save
      log_in(@user)
      flash[:success] = "Welcome to Project Keeper. Let's get started!"
      redirect "users/#{@user.username}"
    else
      erb :'users/signup'
    end
  end

  get '/login' do
    redirect "users/#{current_user.username}" if logged_in?
    @user = User.new
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      log_in(@user)
      flash[:success] = "Welcome back to Project Keeper!"
      redirect "users/#{@user.username}"
    else
      flash[:danger] = "Invalid email/password combination."
      erb :'users/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      @current_user = nil
      flash[:success] = "You've successfully logged out. Hope to see you back soon!"
    end
    redirect '/'
  end

  get '/users/:username' do
    user_authenticated?
    @projects = @user.projects.take(3)
    erb :'users/show'
  end

  get '/users/:username/edit' do
    user_authenticated?
    erb :'users/edit'
  end

  patch '/users/:username' do
    user_authenticated?
    if @user.update(params[:user])
      flash[:success] = "You've successfully edited your profile."
      redirect "/users/#{@user.username}"
    else
      erb :'users/edit'
    end
  end

  delete '/users/:username/delete' do
    user_authenticated?
    @user.destroy
    flash[:success] = "You've successfully deleted your account. We're sorry to see you leave but you're always welcome back!"
    redirect to '/'
  end

end
