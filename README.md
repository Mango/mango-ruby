Mango
=====

Ruby wrapper for Mango API


## Description

API to interact with Mango
https://getmango.com/


## Installation

As usual, you can install it using rubygems.

```
$ gem build mango-ruby.gemspec
```

```
$ gem install ./mango-ruby-0.0.1.gem
```

Note: We'll be uploading the gem to [RubyGems](https://rubygems.org) in the next couple of days.


## Usage

```
require 'mango-ruby'

Mango.api_key = ENV['MANGO_SECRET_KEY']

params = {
  email: "johndoe@example.com",
  name: "John Doe"
}

begin
  customer = Mango::Customers.create params
rescue Mango::Error => e
  e.each {|code, message| ... }
end
```

You can set a global API_KEY (`Mango.api_key`) or override it on each request


## API

All the requests go through:
```
Mango.request(method, url, api_key=nil, params={}, headers={})
```

But you can use CRUD methods on `Mango::Cards`, `Mango::Customers`...
```
def create params={}, api_key=nil
def list params={}, api_key=nil
def retrieve uid, params={}, api_key=nil
def delete uid, params={}, api_key=nil
def update uid, params={}, api_key=nil
```

So this two are equivalent:
```
customer = Mango::Customers.create params
customer = Mango.request :post, '/customers/', api_key, params
```

This are the operations available for each resource:

|Resource|list|create|retrieve|update|delete|delete_all|
|--------|:--:|:----:|:------:|:----:|:----:|:--------:|
|Cards         | x | x | x | x | x |   |
|Charges       | x | x | x |   |   |   |
|Customers     | x | x | x | x | x |   |
|Installments  | x |   |   |   |   |   |
|Queue         | x | x | x |   | x | x |
|Refunds       | x | x | x |   |   |   |
