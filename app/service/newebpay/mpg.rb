module Newebpay
  class Mpg
    def initialize(params)


        @key = ENV['MPG_KEY']
        @iv = ENV['MPG_IV']
        @merchant_id = ENV['MPG_ID']
        @info = {}  # 使用 attr_accessor 讓 info 方便存取
        set_info(params)
    end

    def test
      p "tet"
    end
  end
end