require 'sinatra'
require 'net/http'
require 'digest'

CALLBACK_URL = 'http://localhost:3000/donations/callback'


class ParamsHasher
  def initialize secret
    @secret = secret
  end

  def to_hash(params = {})
    return if params.empty?
    string = params.keys.sort.inject(@secret.clone) { |acc, key|
      acc << params[key].to_s
    }
    Digest::MD5.new.hexdigest(string)
  end
end

get '/vpcpay' do

  callback_params = {
      'vpc_AVSRequestCode' => 'Z',
      'vpc_AVSResultCode' => 'Unsupported',
      'vpc_AcqAVSRespCode' => 'Unsupported',
      'vpc_AcqCSCRespCode' => 'Unsupported',
      'vpc_AcqResponseCode' => '00',
      'vpc_AuthorizeId' => '349610',
      'vpc_BatchNo' => '20110127',
      'vpc_CSCResultCode' => 'Unsupported',
      'vpc_Card' => 'VC',
      'vpc_Message' => 'Approved',
      'vpc_ReceiptNo' => '102716349610',
      'vpc_TransactionNo' => '2000000062',
      'vpc_TxnResponseCode' => '0'
  }
  
  callback_params['vpc_Amount'] = params['vpc_Amount']
  callback_params['vpc_Command'] =params['vpc_Command']
  callback_params['vpc_Locale'] =params['vpc_Locale']
  callback_params['vpc_MerchTxnRef'] =params['vpc_MerchTxnRef']
  callback_params['vpc_Merchant'] =params['vpc_Merchant']
  callback_params['vpc_Version'] =params['vpc_Version']
  callback_params['vpc_OrderInfo'] =params['vpc_OrderInfo']

  String generated_hash = ParamsHasher.new("42077ACECA1D7465E70C2563730B2D7A").to_hash(callback_params)
  callback_params['vpc_SecureHash'] =generated_hash

  query_string = ""
  callback_params.each{|key,value| query_string += key + "=" + value + "&"}
  query_string.chop!

  redirect "http://localhost:3000/donations/callback?" + query_string
end
