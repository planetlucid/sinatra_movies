# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# gem "rails"
gem 'activerecord', require: 'active_record'
gem 'sinatra-activerecord', require: 'sinatra/activerecord'
gem 'sqlite3'
gem 'rake'
gem 'bcrypt'

group :test, :development do
  gem 'pry'
  gem 'byebug'
  gem 'rubocop'
end