require 'active_support/inflector'

class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.singularize.constantize
  end

  def table_name
    model_class.table_name
  end
end
