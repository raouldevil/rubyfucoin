require 'sinatra'
require 'json'
require 'net/http'
require_relative 'ruby_fu_coin'

blockchain = []
transactions = []
nodes = [
  'http://localhost:4567',
  'http://localhost:4568'
]

get '/create' do
  blockchain << RubyFuCoin.create_first_block

  "New blockchain created"
end

get '/add_transaction' do
  transactions << {from: params['from'], to: params['to'], amount: params['amount'].to_i}

  "Transaction added"
end

get '/mine' do
  transactions.each do |transaction|
    blockchain << RubyFuCoin.create_new_block(transaction, blockchain[-1])
  end
  transactions = []

  "All transactions mined"
end

get '/chain' do
  blockchain.to_json
end

get '/resolve' do
  nodes.each do |node|
    if node != request.base_url
      other_blockchain = JSON.parse(Net::HTTP.get(URI("#{node}/chain")))
      blockchain = other_blockchain if other_blockchain.count > blockchain.count
    end
  end
end