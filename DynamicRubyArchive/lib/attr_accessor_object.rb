require 'byebug'
class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      name = name.to_s
      ivar = "@" + name
      define_method(name) do
        instance_variable_get(ivar)
      end
      define_method(name + "=") do |value|
        instance_variable_set(ivar, value)
      end
    end

  end
end
