require 'byebug'
class QuotesController < ApplicationController
    get '/quotes' do
# byebug
        redirect_if_not_logged_in
            @quotes = current_user.quotes 
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

    # get '/quotes/:id/edit' do
    #     @quote = Quote.find_by(id: params[:id])
    #     if @quote
    #         erb :edit
    #     else
    #         @errors = ["invalid quote id"]
    #         erb :failure
    #     end
    # end
    
    get '/quotes/:id/edit' do
        redirect_if_not_logged_in
        set_quote
        erb :edit
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