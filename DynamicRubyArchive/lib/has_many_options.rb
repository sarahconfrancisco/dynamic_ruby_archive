require 'active_support/inflector'

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    defaults = {
      foreign_key: "#{(self_class_name.to_s.underscore + "_id")}".to_sym,
      :class_name => name.to_s.singularize.camelcase,
      primary_key: :id
    }
    defaults.keys.each do |key|
      self.send("#{key}"=, options[key] || defaults[key])
    end
  end
end
