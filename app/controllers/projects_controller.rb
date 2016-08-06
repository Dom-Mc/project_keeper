class ProjectsController < ApplicationController

  get '/:username/projects' do
    verify_logged_in
    verify_correct_user
    @projects = @user.projects
    erb :'projects/index'
  end

  get '/:username/projects/new' do
    verify_logged_in
    verify_correct_user
    @project = Project.new
    erb :'projects/new'
  end

  post '/:username/projects' do
    verify_logged_in
    verify_correct_user
    @project = Project.new(params[:project])
    if @project.save
      @user.projects << @project
      redirect "/#{@user.username}/projects/#{@project.id}"
    else
      # TODO: Add flash message (list errors)
      erb :'projects/new'
    end
  end

  get '/:username/projects/:id' do
    verify_logged_in
    verify_correct_user
    @project = Project.find_by(id: params[:id])
    # NOTE: create and add slug
    erb :'projects/show'
  end

# TODO: fix routes
  get '/projects/edit' do
    verify_logged_in
    verify_correct_user
    # binding.pry
    @project = Project.find_by(id: params[:id])
    erb :'projects/edit'
  end

  patch '/projects/update' do
    verify_logged_in
    verify_correct_user
    @project = Project.find_by(id: params[:id])
    if @project.update(params[:user])
      # TODO: add flash message (successfully updated)
      redirect "/#{@user.username}/projects/#{@project.id}" # TODO: change redirect location
    else
      # TODO: add flash message (list errors)
      erb :'users/edit'
    end
  end

  delete '/projects/delete' do
    verify_logged_in
    verify_correct_user
    Project.find_by(id: params[:id]).destroy
    # TODO: add flash message (successfully deleted)
    redirect to "/#{@user.username}/projects"
  end

end
