class ApplicationController < Sinatra::Base

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

end
