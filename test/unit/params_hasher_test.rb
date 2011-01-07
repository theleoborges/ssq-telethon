require 'test_helper'
require 'params_hasher'

class ParamsHasherTest < ActiveSupport::TestCase
  test "should generate the parameters hash" do
    params = {
      :secret =>  "SHH",
      :access_code =>  "123", 
      :transaction_ref =>  "345", 
      :merchant =>  "us", 
      :order_info =>  "whatever", 
      :amount =>  "100", 
      :callback_url =>  "www.yeah.com"
    }
    hasher = ParamsHasher.new
    assert_equal hasher.to_hash(params), "f17849de3586adee448f052a91fbbce8" #SHH123100www.yeah.comuswhatever345
  end
end