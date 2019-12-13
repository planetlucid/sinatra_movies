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
        "<h1>Hello, #{current_user} </h1>"
        redirect '/quotes'
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
            session[:user_id] = user.id
            redirect '/quotes'
        else
            @errors = ["Signup failed"]
            erb :failure
        end
    end

    get '/login' do
        erb :login
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

    get '/account' do
        erb :account
    end

    #helper for how to authorize correct user
    #model.user_id = current_user.user_id

    helpers do
        # def logged_in?
        #     !!session[:user_id]
        # end

        def logged_in?
            !!current_user
        end

        def redirect_if_not_logged_in
            unless logged_in?
                redirect '/login'
            end
        end
        
        # def current_user
        #     User.find(session[:user_id])
        # end

        def current_user
            @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
        end
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

    get '/account' do
        @current_user = User.find_by_id(session[:user_id])
        if @current_user
            erb :account
        else
            erb :failure
        end
    end

    private    

    def user_params
        { username: params[:username], password: params[:password] }
    end
end
