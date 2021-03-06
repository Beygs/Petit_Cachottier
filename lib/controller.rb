# frozen_string_literal: true

require 'gossip'
require 'comment'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params[:gossip_author], params[:gossip_content]).save
    redirect '/'
  end

  get '/gossips/:id' do
    erb :show, locals: { gossip: Gossip.find(params[:id].to_i), gossip_id: params[:id], comments: Comment.all(params[:id]) }
  end

  get '/gossips/:id/edit/' do
    erb :edit_gossip, locals: { gossip_id: params[:id] }
  end

  post '/gossips/:id/edit/' do
    edited_gossip = Gossip.new(params[:gossip_author], params[:gossip_content])
    Gossip.edit_gossip(params[:id].to_i, edited_gossip)
    redirect '/'
  end

  post '/gossips/:id/comment/' do
    Comment.new(params[:comment_author], params[:comment_content]).save(params[:id])
    redirect "/gossips/#{params[:id]}"
  end
end

