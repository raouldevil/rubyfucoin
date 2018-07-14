require 'openssl'

class RubyFuCoin

  class << self
    def create_first_block
      coin_hash = {
        from: "N/A",
        to: "N/A",
        amount: 0,
        index: 0,
        previous_hash: 0
      }
      current_hash, nonce = mine(coin_hash)
      coin_hash.merge(
        current_hash: current_hash,
        nonce: nonce
      )
    end

    def create_new_block(from, to, amount, previous_block)
      coin_hash = {
        from: from,
        to: to,
        amount: amount,
        index: previous_block[:index],
        previous_hash: previous_block[:current_hash]
      }
      current_hash, nonce = mine(coin_hash)
      coin_hash.merge(
        current_hash: current_hash,
        nonce: nonce
      )
    end

    def mine(data, difficulty = "000")
      nonce = 0
      hashed_data = nil
      loop do
        hashed_data = hash_with_nonce(data, nonce)
        puts "FINISHED!!" if hashed_data[0..2] == difficulty
        break if hashed_data[0..2] == difficulty
        nonce += 1
      end
      return hashed_data, nonce
    end

    def hash_with_nonce(data, nonce)
      Digest::SHA256.hexdigest("#{data[:sender]}-#{data[:receiver]}-#{data[:amount]}-#{data[:index]}-#{nonce}")
    end
  end
  # require_relative 'lib/ruby_fu_coin'
  # b0 = RubyFuCoin.create_first_block
  # RubyFuCoin.create_new_block("mike", "john", 100, b0)

end
