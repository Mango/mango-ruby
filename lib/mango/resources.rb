require_relative 'operations'

module Mango
  class Resource
    include Operations

    def self.url id=nil
      resource_name = self.name.split('::').last.downcase
      id ? "/#{resource_name}/#{id}/" : "/#{resource_name}/"
    end
  end

  class Customers < Resource
    public_class_method :create, :retrieve, :list, :update, :delete
  end

  class Charges < Resource
    public_class_method :create, :retrieve, :list
  end

  class Refunds < Resource
    public_class_method :create, :retrieve, :list
  end

  class Cards < Resource
    public_class_method :create, :retrieve, :list, :update, :delete
  end

  class Queue < Resource
    public_class_method :create, :retrieve, :list, :delete, :delete_all
  end

  class Installments < Resource
    public_class_method :retrieve
  end

end
