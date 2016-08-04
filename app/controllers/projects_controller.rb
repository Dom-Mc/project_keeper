class ProjectsController < ApplicationController

  get '/:username/projects' do
    @user = User.find_by_username(params[:username])
    if @user.id == session[:user_id]
      @projects = @user.projects
      erb :'projects/index'
    else
      redirect '/'
    end
  end

  get '/:username/projects/new' do
    @user = User.find_by_username(params[:username])
    if @user.id == session[:user_id]
      @project = Project.new
      erb :'projects/new'
    else
      redirect '/'
    end
  end

  post '/:username/projects' do
    @user = User.find_by_username(params[:username])
    if @user.id == session[:user_id]
      @project = Project.create(params[:project])
      @user.projects << @project
      redirect "/#{@user.username}/projects/#{@project.id}"
    else
      erb :'projects/new'
    end
  end

  get '/:username/projects/:id' do
    @user = User.find_by_username(params[:username])
    if @user.id == session[:user_id]
      @project = Project.find_by_id(params[:id])
      # NOTE: create slug
      erb :'projects/show'
    else
      redirect '/'
    end
  end

  get '/projects/edit' do
    erb :'projects/edit'
  end

  patch '/projects/update' do
  end


  delete '/projects/delete' do
  end

end
