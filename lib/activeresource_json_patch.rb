require 'active_resource'

module ActiveResource
  class Base
    def encode_with_json(options={})
      case self.class.format
        when ActiveResource::Formats[:json]
          data = self.class.include_root_in_json ? {self.class.element_name => attributes} : attributes
          self.class.format.encode data
        else
          encode_without_json(options)
      end
    end

    alias_method_chain :encode, :json
  end
end
