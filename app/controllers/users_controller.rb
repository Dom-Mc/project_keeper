class UsersController < ApplicationController

  get '/signup' do
    @user = User.new
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.create(params[:user])
    redirect "/users/#{@user.id}"
  end

  get '/login' do
  end

  post '/login' do
  end

  get '/users/:id' do
    # NOTE: create slug
  end

  get '/users/edit' do
  end

  patch '/users/update' do
  end

  delete '/users/delete' do
  end

end
