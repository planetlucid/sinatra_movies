class ApplicationController < Sinatra::Base
    
    configure do
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "password_security"
    end
    
    # get '/quotes/new' do
    #     erb :new
    # end

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

    get '/login' do
        erb :login
    end

    post '/login' do
        #Find the user with the username
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/quotes'
        else
            @errors = ["Invalid username"]
            erb :failure
        end
    end

    private    

    def user_params
        { username: params[:username], password: params[:password] }
    end
end
