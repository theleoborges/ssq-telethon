require 'digest'

class ParamsHasher
  def self.to_hash(params = {})
    return if params.empty?
    secret = params.delete(:secret)
    string = params.keys.sort.inject(secret) { |acc, key|
      acc << params[key]
    }
    Digest::MD5.new.hexdigest(string)
  end
end