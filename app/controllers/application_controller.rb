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
    "Hello World!!!!"
  end

  private

    def log_in(user)
      session[:user_id] = user.id
    end

    def current_user
      if (user_id = session[:user_id])
        #prevents multiple calls to the database
        @current_user ||= User.find_by(id: session[:user_id])
      end
    end

    def verify_correct_user
      @user = User.find_by(username: params[:username])
      redirect "/#{@current_user.username}/projects" unless @user == current_user
    end

    def logged_in?
      !current_user.nil? #!!session[:user_id]
    end

    def verify_logged_in
      unless logged_in?
        # TODO: flash message (please login)
        redirect '/login'
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
  

end
