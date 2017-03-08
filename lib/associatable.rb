require_relative 'searchable'
require_relative 'belongs_to_options'
require_relative 'has_many_options'
require 'active_support/inflector'
require 'byebug'

module Associatable
  def belongs_to(name, options = {})
    self.assoc_options[name] = BelongsToOptions.new(name, options)
    define_method(name) do
      options = self.class.assoc_options[name]
      key_val = self.send(options.foreign_key)
      options.model_class.where(options.primary_key => key_val).first
    end
  end

  def has_many(name, options = {})
    self.assoc_options[name] = HasManyOptions.new(name, self.name, options)
    define_method(name) do
      options = self.class.assoc_options[name]
      key_val = self.send(options.primary_key)
      options.model_class.where(options.foreign_key => key_val)
    end
  end

  def assoc_options
    @assoc_options ||= {}
    @assoc_options
  end
  def has_one_through(name, through_name, source_name)
    self.superclass.has_through(name, through_name, source_name, "one")
  end

  def has_many_through(name, through_name, source_name)
    self.superclass.has_through(name, through_name, source_name, "many")
  end

  def has_through(name, through_name, source_name, type)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]

      t_table = through_options.table_name
      s_table = source_options.table_name

      f_key = source_options.foreign_key
      s_p_key = source_options.primary_key
      t_p_key = through_options.primary_key

      if type == "one"
        k_val = self.send(through_options.foreign_key)
        search_results = self.class.query_source_table(s_table, t_table, f_key, s_p_key, t_p_key , k_val)
        source_options.model_class.parse_all(search_results).first
      else
        k_val = self.send(through_options.primary_key)
        search_results = self.class.query_source_table(s_table, t_table, s_p_key, f_key , t_p_key , k_val)
        source_options.model_class.parse_all(search_results)
      end
    end
  end

  def query_source_table(s_table, t_table, s_p_key, f_key, t_p_key , k_val)
    DBConnection.execute(<<-SQL, k_val)
      SELECT
        #{s_table}.*
      FROM
        #{t_table}
        JOIN
          #{s_table}
          ON
          #{t_table}.#{t_p_key} = #{s_table}.#{f_key}
      WHERE
        #{t_table}.#{t_p_key} = ?
    SQL
  end
end

class SQLObject
  extend Associatable
end
