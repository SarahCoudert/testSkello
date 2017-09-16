require 'json'
require "sinatra"
require "sinatra/reloader" if development?
require_relative "database"

get "/" do
  @database = DB
  erb :index
end

get "/article/:id" do
  @votes = get_votes_by_id(params[:id])
  @post = DB[params[:id].to_i]
  @comments = COMMENTS[params[:id].to_i]
  erb :article
end

post "/upvote/:article/:comment" do
  votes = get_all_votes()
  article_id = params[:article].to_i
  comment_id = params[:comment].to_i
  votes[article_id][comment_id] = (votes[article_id][comment_id].to_i) + 1
  j = Hash.new
  j["comments_votes"] = votes
  save_new_votes(j)
  200
end

post "/downvote/:article/:comment" do
  votes = get_all_votes()
  article_id = params[:article].to_i
  comment_id = params[:comment].to_i
  votes[article_id][comment_id] = (votes[article_id][comment_id].to_i) - 1
  j = Hash.new
  j["comments_votes"] = votes
  save_new_votes(j)
  200
end

def get_votes_by_id(id)
  file = File.read("votes.json")
  json = JSON.parse(file)
  return json["comments_votes"][id.to_i]
end

def get_all_votes()
  file = File.read("votes.json")
  json = JSON.parse(file)
  return json["comments_votes"]
end

def save_new_votes(votes)
  new_json = votes.to_json
  File.write("votes.json", new_json)
end