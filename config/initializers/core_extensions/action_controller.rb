module ActionController
  class Request
    # never match any incomming etag
    def etag_matches?(etag)
      false
    end
  end

  class Response
    # fake rails that our response already has an etag set and so none is generated automatically
    def etag?
      true
    end
  end
end