class QuotesController < ApplicationController
    get '/quotes/new' do
        erb :new
    end
end