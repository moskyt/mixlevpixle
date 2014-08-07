require "mixlevpixle/version"

module Mixlevpixle

  class Store
    
    TIMESTAMP_SUFFIX = '::timestamps'

    def load(key, obj, *timestamps)
      store_status = nil
      store_error = nil
      if robj = get(key)
        if timestamps.empty?
          #ok
        else
          saved_timestamps = get(key + TIMESTAMP_SUFFIX)
          if saved_timestamps and timestamps.size == saved_timestamps.size
            if (0...timestamps.size).all?{|i| timestamps[i] <= saved_timestamps[i]}
              #ok
            else
              store_status = :expired
            end
          else
            store_status = :timestamp_mismatch
            store_error = "#{saved_timestamps.inspect} < #{timestamps.inspect}"
          end
        end
      else
        store_status = :not_found
      end

      if store_status
        robj = obj 
      else
        store_status = :ok
      end
      
      robj.define_singleton_method :mixle_key do
        key
      end
      robj.define_singleton_method :mixle_status do
        store_status
      end
      robj.define_singleton_method :mixle_error do
        store_error
      end
      store_object = self
      robj.define_singleton_method :mixle do
        store_object.set(mixle_key + TIMESTAMP_SUFFIX, timestamps)
        store_object.save(mixle_key, self)
      end
      robj
    end

    def save(key, obj)
      class <<obj
         remove_method :mixle
         remove_method :mixle_key
         remove_method :mixle_status
         remove_method :mixle_error
      end
      set(key, obj)
    end

  end

  class DalliStore < Store

    require 'dalli'

    def initialize(namespace, options = {})
      host = options.delete(:host) || 'localhost'
      port = options.delete(:port) || 11211
      @namespace = namespace.dup
      @dalli_client = Dalli::Client.new("#{host}:#{port}", options)
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
