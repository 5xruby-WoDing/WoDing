module Newebpay
  class Mpg
    attr_accessor :info

    def initialize(params)
      @key = ENV['MPG_KEY']
      @iv = ENV['MPG_IV']
      @merchant_id = ENV['MPG_ID']
      @info = {}  
      set_info(params)
    end


    def form_info
      {
        MerchantID: @merchant_id,
        TradeInfo: trade_info,
        TradeSha: trade_sha,
        Version: "2.0"
      }
    end

    private

    def url_encoded_query_string
      URI.encode_www_form(info)
    end

    def trade_info
      aes_encode(url_encoded_query_string)
    end

    def aes_encode(string)
      cipher = OpenSSL::Cipher::AES256.new(:CBC)
      cipher.encrypt
      cipher.key = @key
      cipher.iv = @iv
      cipher.padding = 0
      padding_data = add_padding(string)
      encrypted = cipher.update(padding_data) + cipher.final
      encrypted.unpack('H*').first
    end

    def add_padding(data, block_size = 32)
      pad = block_size - (data.length % block_size)
      data + (pad.chr * pad)
    end

    def trade_sha
      sha256_encode(@key, @iv, trade_info)
    end
  
    def sha256_encode(key, iv, trade_info)
      encode_string = "HashKey=#{key}&#{trade_info}&HashIV=#{iv}"
      Digest::SHA256.hexdigest(encode_string).upcase
    end

    def set_info(reservation)  
      info[:MerchantID] = @merchant_id
      info[:MerchantOrderNo] = reservation.serial
      info[:Amt] = reservation.seat.deposit
      info[:ItemDesc] = "訂位類型為#{reservation.seat.kind}、容納人數為#{reservation.seat.capacity}" 
      info[:Email] = reservation.email
      info[:TimeStamp] = Time.now.to_i 
      info[:RespondType] = "JSON"
      info[:Version] = "2.0"
      info[:LoginType] = 0 
      info[:CREDIT] =  1,
      info[:VACC] = 1
      info[:ReturnURL] = "https://bd0e-2401-e180-88b1-450-d09a-3264-8cf-1f66.jp.ngrok.io/reservations/#{reservation.serial}/information"
      # info[:NotifyURL] = "http://localhost:3000/"     
    end

  end
end