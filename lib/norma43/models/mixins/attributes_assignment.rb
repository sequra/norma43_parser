# frozen_string_literal: true

module Norma43
  module Models
    module Mixins
      module AttributesAssignment
        EMPTY_ATTRIBUTES = {}.freeze

        def attributes=(new_attributes)
          Hash(new_attributes).each do |attr_name, attr_value|
            attr_writer_method_name = "#{attr_name}=".to_sym
            next unless public_methods(false).include?(attr_writer_method_name)

            public_send(attr_writer_method_name, attr_value)
          end
        end

        def attributes
          instance_variables.map { |ivar_name|
            attr_reader_method_name = ivar_name.to_s.delete_prefix("@").to_sym
            next unless public_methods(false).include?(attr_reader_method_name)

            attr_value = public_send(attr_reader_method_name)

            [attr_reader_method_name, attr_value]
          }.compact.to_h
        end
        alias_method :to_hash, :attributes # Implicit coercion for `Hash(model)`
        alias_method :to_h,    :attributes # Explicit coercion
      end
    end
  end
end
