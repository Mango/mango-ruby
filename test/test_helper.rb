module Mango
  @mock_rest_client = nil

  def self.mock_rest_client=(mock_client)
    @mock_rest_client = mock_client
  end

  def self.execute_request(options)
    case options[:method]
    when :get
      @mock_rest_client.get options[:url]
    when :post
      @mock_rest_client.post options[:url], options[:payload]
    when :patch
      @mock_rest_client.patch options[:url], options[:payload]
    when :delete
      @mock_rest_client.delete options[:url]
    end
  end
end

Response = Struct.new :body, :code

def test_response body, code=200
  Response.new JSON.generate(body), code
end

def test_customer(params={})
  {
    uid: "customer_hash",
    name: "John Doe",
    email: "johndoe@example.com",
    live: false,
    meta: "",
    default_card: "card_id",
    cards: [{
      exp_year: 2020,
      cardtype: "visa",
      exp_month: 1,
      uid: "card_id",
      last4: "0010"
    }],
    created_at: "2014-11-26 04:53:36",
    updated_at: "2014-11-26 04:53:36"
  }.merge(params)
end

def customer_params
  {
    email: "johndoe@email.com",
    name: "John Doe"
  }
end

def bad_request
  json = {
    "errors" => [{
      "4051" => "Bad Request: The request could not be understood by the server due to malformed syntax."
    }]
  }
  RestClient::Exception.new(test_response(json, 404), 400)
end
