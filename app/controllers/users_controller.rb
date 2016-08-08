class UsersController < ApplicationController

  get '/signup' do
    redirect "/#{current_user.username}/projects" if logged_in? #!current_user.nil?
    @user = User.new
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.new(params[:user])
    if @user.save
      log_in(@user) #session[:user_id] = @user.id
      flash[:success] = "Welcome to Project Keeper. Your account has been successfully created!"
      redirect "users/#{@user.username}"
    else
      erb :'users/signup'
    end
  end

  get '/login' do
    redirect "users/#{current_user.username}" if logged_in? #!current_user.nil?
    @user = User.new
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      log_in(@user) #session[:user_id] = @user.id
      flash[:success] = "Welcome back to Project Keeper!"
      redirect "users/#{@user.username}"
    else
      flash[:danger] = "Invalid email/password combination."
      erb :'users/login'
    end
  end

  get '/logout' do
    verify_logged_in
    session.delete(:user_id)
    @current_user = nil
    # TODO: Verify flash message works correctly on logout
    flash[:success] = "You've successfully logged out. Hope to see you back soon!"
    redirect '/'
  end

  get '/users/:username' do
    verify_logged_in
    verify_correct_user
    @projects = @user.projects
    erb :'users/show'
  end

  get '/users/:username/edit' do
    verify_logged_in
    verify_correct_user
    erb :'users/edit'
  end

  patch '/users/:username' do
    verify_logged_in
    verify_correct_user
    if @user.update(params[:user])
      flash[:success] = "You've successfully edited your profile."
      redirect "/users/#{@user.username}" # TODO: change redirect location
    else
      erb :'users/edit'
    end
  end

  delete '/users/:username/delete' do
    verify_logged_in
    verify_correct_user
    @user.destroy
    # TODO: Check flash message correctly works when account is deleted
    flash[:success] = "You've successfully deleted your account. We're sorry to see you leave but you're always welcome back!"
    redirect to '/'
  end

end
