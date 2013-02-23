require "mixlevpixle/version"

module Mixlevpixle

  class Store

    def load(key, obj)
      robj = get(key) || obj
      robj.define_singleton_method :mixle_key do
        key
      end
      store_object = self
      robj.define_singleton_method :mixle do
        store_object.save(mixle_key, self)
      end
      robj
    end

    def save(key, obj)
      class <<obj
         remove_method :mixle
         remove_method :mixle_key
      end
      set(key, obj)
    end

  end

  class DalliStore < Store

    require 'dalli'

    def initialize(namespace, host = 'localhost', port = 11211)
      @namespace = namespace.dup
      @dalli_client = Dalli::Client.new("#{host}:#{port}")
    end

    def set(key, value)
      @dalli_client.set(@namespace + '::' + key, value)
    end

    def get(key)
      @dalli_client.get(@namespace + '::' + key)
    end

    def delete(key)
      @dalli_client.delete(@namespace + '::' + key)
    end

  end
end
