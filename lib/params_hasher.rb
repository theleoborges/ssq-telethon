require 'digest'

class ParamsHasher
  def to_hash(params = {})
    return if params.empty?
    secret = params.delete(:secret).clone
    string = params.keys.sort.inject(secret) { |acc, key|
      acc << params[key].to_s
    }
    Digest::MD5.new.hexdigest(string)
  end
end