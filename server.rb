require 'sinatra'
require 'csv'



get "/articles" do
  articles = CSV.read('all_articles.csv')
  erb :articles, locals: {articles: articles}
end

get "/articles/new" do
  erb :new
end

post "/articles" do

  article_group = [params['title'],params['url'],params['description']]
  CSV.open('all_articles.csv', 'a') do |file|
    file.puts(article_group)
  end
  redirect "/articles"
end




set :views, File.join(File.dirname(__FILE__), "views")
set :public_folder, File.join(File.dirname(__FILE__), "public")
