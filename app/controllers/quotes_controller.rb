class QuotesController < ApplicationController
    get '/quotes/new' do
        erb :new
    end

    post '/quotes' do
        quote = Quote.new(quote_params)
        if quote.save
            redirect '/'
        else
            @errors = [params.to_s]
            erb :failure
        end
    end 

    private

    def quote_params
        {author: params[:author], body: params[:body]}

    end
end