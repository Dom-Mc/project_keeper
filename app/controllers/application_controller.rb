require 'rack-flash'
require 'date'
class ApplicationController < Sinatra::Base

  #:sweep => true will set stale flash entries to be cleared regardless if they've been accessed
  use Rack::Flash, :sweep => true

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "project_me_secret"
  end

  get '/' do
    @user = current_user
    erb :home
  end

  helpers do

    def log_in(user)
      session[:user_id] = user.id
    end

    def logged_in?
      !current_user.nil?
    end

    def current_user
      if (user_id = session[:user_id])
        #prevents multiple calls to the database
        @current_user ||= User.find_by(id: session[:user_id])
      end
    end

    def correct_user?
      if (@user = User.find_by(username: params[:username]))
        redirect "users/#{@current_user.username}" unless @user == current_user
        true
      else
        false
      end
    end

    def user_authenticated?
      if !logged_in?
        flash[:danger] = "Please login"
        redirect '/login'
        false
      else
        correct_user?
      end
    end

    def slugify(slug)
      if @project ||= Project.find_by_slug(slug)
        @slug ||= @project.slug
        @project
      else
        flash[:danger] = "Ooops looks like an error occurred."
        redirect "/#{@current_user.username}/projects" # TODO: change to @current_user.username
      end
    end

    def truncate(text, max_length)
      text.length > max_length ? "#{text[0...max_length]}..." : text
    end

    def convert_date(date)
      date.strftime("%b %d %Y") unless date.nil?
    end

    def current_year
      Time.now.year
    end

    def projects_show_page?
      request.path == "/#{@current_user.username}/projects/#{@slug}"
    end

    def users_show_page?
      request.path == "/users/#{@current_user.username}"
    end

  end
end
