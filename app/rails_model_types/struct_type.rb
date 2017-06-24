# frozen_string_literal: true
class StructType < ActiveModel::Type::Value
  def cast(value)
    case value
    when String
      value = JSON.parse(value) rescue {}
    when Hash
    when ActionController::Parameters
      value = value.to_h
    else
      return value
    end
    class_struct.new(value)
  end

  def serialize(value)
    value = cast(value)
    reg = value.class.attributes_registry
    hash = {}
    value.attributes.each do |key, v|
      hash[key] = if reg.has_key?(key.to_s)
        ActiveModel::Type.lookup(*reg[key.to_s]).serialize(v)
      else
        v
      end
    end
    hash.as_json.to_json
  end

  def class_struct
    raise NotImplementedError, 'should be implemented in subclasses'
  end

  def changed_in_place?(raw_old_value, new_value)
    new_value.changed?
  end
end
