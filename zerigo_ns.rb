# Copyright 2010 Zerigo, Inc.  See MIT-LICENSE for license information.
# Visit http://www.zerigo.com/docs/managed-dns for updates and documentation.

require 'activeresource-ext'

module Zerigo
  module NS
  
    class Base < ActiveResource::Base
      self.site='http://ns.zerigo.com/api/1.1/'
      self.user = 'test@example.com'
      self.password = 'ca01ffae311a7854ea366b05cd02bd50'
      self.timeout = 5 # timeout after 5 seconds
      
      
      # fix load() so that it no longer clobbers @prefix_options
      # also fix bug exposed by reload() where attributes is effectively parsed twice, causing the first line to raise an exception the 2nd time
      def load(attributes)
        raise ArgumentError, "expected an attributes Hash, got #{attributes.inspect}" unless attributes.is_a?(Hash)
        new_prefix_options, attributes = split_options(attributes)
        @prefix_options.merge!(new_prefix_options)
        attributes.each do |key, value|
          @attributes[key.to_s] =
            case value
              when Array
                if value.all?{|v2| v2.kind_of?(ActiveResource::Base)}
                  value.dup rescue value
                else
                  resource = find_or_create_resource_for_collection(key)
                  value.map { |attrs| attrs.is_a?(String) ? attrs.dup : resource.new(attrs) }
                end
              when Hash
                resource = find_or_create_resource_for(key)
                resource.new(value)
              else
                value.dup rescue value
            end
        end
        self
      end
      
      # fix save() because ARes 2.3 is failing on content-type matching and thus not reporting any error messages
      def save
        save_without_validation
        true
      rescue ActiveResource::ResourceInvalid => error
        case error.response['Content-Type']
        when /application\/xml/
          errors.from_xml(error.response.body)
        when /application\/json/
          errors.from_json(error.response.body)
        end
        false
      end
      
    end

  
    class Zone < Base
    end
  
    class Host < Base
    end

  end
end
