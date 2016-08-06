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
      redirect "/#{@user.username}/projects/#{@project.slug}"
    else
      # TODO: Add flash message (list errors)
      erb :'projects/new'
    end
  end

  get '/:username/projects/:slug' do
    verify_logged_in
    verify_correct_user
    @project = Project.find_by_slug(params[:slug])
    erb :'projects/show'
  end

  get '/:username/projects/:slug/edit' do
    verify_logged_in
    verify_correct_user
    @project = Project.find_by_slug(params[:slug])
    erb :'projects/edit'
  end

  patch '/:username/projects/:slug' do
    verify_logged_in
    verify_correct_user
    @project = Project.find_by_slug(params[:slug])
    if @project.update(params[:project])
      # TODO: add flash message (successfully updated)
      redirect "/#{@user.username}/projects/#{@project.slug}"
    else
      # TODO: add flash message (list errors)
      erb :'users/edit'
    end
  end

  delete '/:username/projects/:slug/delete' do
    verify_logged_in
    verify_correct_user
    Project.find_by_slug(params[:slug]).destroy
    # TODO: add flash message (successfully deleted)
    redirect to "/#{@user.username}/projects"
  end

end
