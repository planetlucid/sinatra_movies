require 'byebug'
class QuotesController < ApplicationController
    get '/quotes' do
# byebug
        redirect_if_not_logged_in
            @quotes = current_user.quotes
            @current_user = current_user 
            erb :index
        # else
        #     redirect '/login'
        # end
    end

    get '/quotes/new' do
        erb :new
    end

    post '/quotes' do
        redirect_if_not_logged_in
        quote = Quote.new(quote_params)
        if quote.save
            redirect '/quotes'
        else
            @errors = [params.to_s]
            erb :failure
        end
    end 

  
    
    get '/quotes/:id/edit' do
        redirect_if_not_logged_in
        set_quote
    
        #abstract into helper methods so I dont havae to type it every time.
        @quote = Quote.find_by_id(params[:id])
        if @quote.user_id == current_user
            erb :edit
        else
            "You're not the owner of this post."
            redirect to '/quotes'
        end
    end

    patch '/quotes/:id' do
        redirect_if_not_logged_in
        set_quote
        if @quote.update(quote_params)
            redirect '/quotes'
        else
            @errors = ['could not update']
            erb :failures
        end
    end

    delete '/quotes/:id' do
        set_quote
        @quote.destroy
        redirect '/quotes'
    end

    #helper for how to authorize correct user
    #model.user_id = current_user.user_id

    private 

    def quote_params
        { author: params[:author], body: params[:body], user: current_user}
    end

    def set_quote
        @quote = Quote.find_by(id: params[:id])
        unless @quote
            @errors = ['invalid quote id']
            redirect '/'
        end
    end
end