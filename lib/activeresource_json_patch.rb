require 'active_resource'

module ActiveResource
  class Base
    self.include_root_in_json = false

    def to_json(options={})
      super({ :root => self.class.element_name }.merge(options))
    end

    def encode_with_json(options={})
      case self.class.format
        when ActiveResource::Formats[:json]
          self.class.format.encode self.class.element_name => attributes
        else
          encode_without_json(options)
      end
    end

    alias_method_chain :encode, :json
  end
end
