class ApplicationController < Sinatra::Base
    
    configure do
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "password_security"
      end
    
    get '/' do
        "<h1>Hello, World</h1>"
    end

    get '/failure' do
        @errors = ["Error message 1", "Error message 2"]
        erb :failure
    end

    get '/signup' do
        erb :signup
      end
    
      post '/signup' do
        user = User.new(user_params)
        if user.save
          redirect '/'
        else
          @errors = ["Signup failed"]
          erb :failure
        end
    end

    def user_params
        { username: params[:username], password: params[:password] }
    end
end
