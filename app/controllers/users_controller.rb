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
      # TODO: add flash message (success)
      redirect "users/#{@user.username}"
    else
      # TODO: add flash message (failure)
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
      # TODO: add flash message (success)
      redirect "users/#{@user.username}"
    else
      # TODO: add flash message (unsuccessful login)
      erb :'users/login'
    end
  end

  get '/logout' do
    verify_logged_in
    session.delete(:user_id)
    @current_user = nil
    # TODO: add flash message (successful logout)
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
      # TODO: add flash message (successfully updated)
      redirect "/users/#{@user.username}" # TODO: change redirect location
    else
      # TODO: add flash message (list errors)
      erb :'users/edit'
    end
  end

  delete '/users/:username/delete' do
    verify_logged_in
    verify_correct_user
    @user.destroy #@user.delete
    # TODO: add flash message (successfully deleted account)
    redirect to '/'
  end

end
