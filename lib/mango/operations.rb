module Mango
  module Operations
    module ClassMethods

      private

      def create params={}, api_key=nil
        Mango.request :post, url, api_key, params
      end

      def list params={}, api_key=nil
        Mango.request :get, url, api_key, params
      end

      def retrieve uid, params={}, api_key=nil
        require_uid uid
        Mango.request :get, url(uid), api_key, params
      end

      def update uid, params={}, api_key=nil
        require_uid uid
        Mango.request :patch, url(uid), api_key, params
      end

      def delete uid, params={}, api_key=nil
        require_uid uid
        Mango.request :delete, url(uid), api_key, params
      end

      def delete_all params={}, api_key=nil
        Mango.request :delete, url, api_key, params
      end

      def require_uid uid
        raise Error.new('UID is required') if uid.nil? || uid == ''
      end

    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end
