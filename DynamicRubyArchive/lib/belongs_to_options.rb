require 'active_support/inflector'
require_relative 'assoc_options'

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    defaults = {
      foreign_key: (name.to_s + "_id").to_sym,
      :class_name => name.to_s.camelcase,
      primary_key: :id
    }
    defaults.keys.each do |key|
      self.send("#{key}=", options[key] || defaults[key])
    end

  end
end
