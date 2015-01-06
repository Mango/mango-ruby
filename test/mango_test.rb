require File.expand_path("../lib/mango", File.dirname(__FILE__))
require File.expand_path("test_helper", File.dirname(__FILE__))

require "cutest"
require "mocha/api"
include Mocha::API

prepare do
  Mango.api_key = '1234'
end

setup do
  Mango.mock_rest_client = mock
end

test "resource url" do
  assert_equal '/customers/', Mango::Customers.url
  assert_equal '/customers/123/', Mango::Customers.url(123)
end

test "operation retrieve" do |mock|
  mock.expects(:get).once.with('https://api.getmango.com/v1/customers/123/', {}).returns(test_response(test_customer))
  customer = Mango::Customers.retrieve 123
  assert_equal "customer_hash", customer[:uid]
end

test "operation list" do |mock|
  mock.expects(:get).once.with('https://api.getmango.com/v1/customers/', {}).returns(test_response([test_customer]))
  customers = Mango::Customers.list
  assert_equal "customer_hash", customers.first[:uid]
end

test "aditional params on get" do |mock|
  mock.expects(:get).once.with('https://api.getmango.com/v1/customers/', cardtype: 'visa').returns(test_response([test_customer]))
  customers = Mango::Customers.list cardtype: 'visa'
  assert_equal "customer_hash", customers.first[:uid]
end

test "operation create" do |mock|
  mock.expects(:post).once.with('https://api.getmango.com/v1/customers/', anything).returns(test_response(test_customer))
  customer = Mango::Customers.create customer_params
  assert_equal "customer_hash", customer[:uid]
end

test "operation update" do |mock|
  mock.expects(:patch).once.with('https://api.getmango.com/v1/customers/123/', anything).returns(test_response(test_customer))
  customer = Mango::Customers.update 123, customer_params
  assert_equal "customer_hash", customer[:uid]
end

test "operation delete" do |mock|
  mock.expects(:delete).once.with('https://api.getmango.com/v1/customers/123/').returns(test_response(test_customer))
  customer = Mango::Customers.delete 123
  assert_equal "customer_hash", customer[:uid]
end

test "exception handle" do |mock|
  mock.expects(:post).once.raises(bad_request)
  exception = assert_raise(Mango::Error) do
    Mango::Customers.create({number: "error"})
  end
  assert_equal ['4051', 'Bad Request: The request could not be understood by the server due to malformed syntax.'], exception.first
end
