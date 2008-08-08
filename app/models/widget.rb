class Widget < ActiveRecord::Base
  def self.all_active
    caches (:all, :expires_in=>CACHE_TIMEOUT)
  end
  def self.caches(method, options = {})
    options = {
      :expires_in=>nil
    }.merge(options)
    # :with code lifted from err's cache_fu
    if options.keys.include?(:with) 
      with = options.delete(:with)
      cache.fetch(
        "#{self}:#{method}:#{with}".gsub(" ","_"), 
        :expires_in => options[:expires_in]
      ) { send(method, with) }
    elsif withs = options.delete(:withs)
      cache.fetch(
        "#{self}:#{method}:#{withs}".gsub(" ","_"), 
        :expires_in => options[:expires_in]
      ) { 
        send(method, *withs) 
      }
    else
      cache.fetch(
        "#{self}:#{method}", 
        :expires_in => options[:expires_in]
      ) { 
        send(method) 
      }
    end
  end
  def self.cache
    ActiveSupport::Cache.lookup_store(:mem_cache_store)
  end
end
