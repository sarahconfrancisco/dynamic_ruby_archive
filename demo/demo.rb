require_relative "../lib/db_connection.rb"
require_relative "../lib/dra_object.rb"
require_relative "../lib/associatable.rb"

DB_FILE = "sports.db"
SQL_FILE = 'sports.sql'

class Owner < DRAObject
  has_one :team
  has_many_through :players, :team, :players

  finalize!
end

class Team < DRAObject
  belongs_to :owner
  has_many :players

  finalize!
end

class Player < DRAObject
  belongs_to :team
  has_one_through :boss, :team, :owner
  finalize!
end
