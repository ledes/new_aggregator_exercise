require 'sinatra'
require 'csv'
require 'pry'

@double_url=false

get "/articles" do
  articles = CSV.read('all_articles.csv')
  erb :articles, locals: {articles: articles}
end

get "/articles/new" do
  articles = CSV.read('all_articles.csv')
  erb :new, locals: {articles: articles}
end

get "/articles/error" do
  erb :error
end

 post "/articles" do
   articles = CSV.read('all_articles.csv')
   article_group = [params['title'],params['url'],params['description']]
     articles.each do |array|
       if array.include?(article_group[1])
         @double_url = true
       end
     end
     if @double_url == true
       redirect "/articles/error"
     else
      CSV.open('all_articles.csv', 'a') do |file|
       file.puts(article_group)
   end
     redirect "/articles/new"
   end
 end





set :views, File.join(File.dirname(__FILE__), "views")
set :public_folder, File.join(File.dirname(__FILE__), "public")
