class ProjectsController < ApplicationController

  get '/:username/projects/' do
    # binding.pry
    @user = User.find_by(username: params[:username])
    # user_authenticated?
    @projects = @user.projects
    erb :'projects/index'
  end

  get '/:username/projects/new' do
    user_authenticated?
    @project = Project.new
    erb :'projects/new'
  end

  post '/:username/projects' do
    user_authenticated?
    @project = @user.projects.build(params[:project])
    if @project.save
      flash[:success] = "Your new project was successfully created!"
      redirect "/#{@user.username}/projects/#{@project.slug}"
    else
      erb :'projects/new'
    end
  end

  get '/:username/projects/:slug' do
    user_authenticated?
    slugify(params[:slug])
    erb :'projects/show'
  end

  get '/:username/projects/:slug/edit' do
    user_authenticated?
    slugify(params[:slug])
    erb :'projects/edit'
  end

  patch '/:username/projects/:slug' do
    user_authenticated?
    slugify(params[:slug])
    if @project.update(params[:project])
      flash[:success] = "Your project was successfully updated!"
      redirect "/#{@user.username}/projects/#{@project.slug}"
    else
      erb :'projects/edit'
    end
  end

  delete '/:username/projects/:slug/delete' do
    user_authenticated?
    slugify(params[:slug]).delete
    flash[:success] = "Your project was successfully deleted."
    redirect to "/#{@user.username}/projects"
  end

end
