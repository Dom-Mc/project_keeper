class ProjectsController < ApplicationController

  get '/projects' do
    erb :'projects/index'
  end

  get '/projects/new' do
    erb :'projects/new'
  end

  post '/projects' do
    @project = Project.create(params[:project])
  end

  get '/projects/:id' do
    # NOTE: create slug
  end

  get '/projects/edit' do
    erb :'projects/edit'
  end

  patch '/projects/update' do
  end


  delete '/projects/delete' do
  end

end
