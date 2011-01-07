require 'digest'

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