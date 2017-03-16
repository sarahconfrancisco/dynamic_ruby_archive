# Dynamic Ruby Archive

Dynamic Ruby Archive is a minimalist Object Relational Mapping library for Ruby and sqlite3. It connects ruby classes to relational sqlite3 database tables to establish a persistence layer for applications with minimal
configuration. This library provides a base class that, when subclassed, maps between the new class and an existing
table in the database. In the context of an application, these classes are
referred to as *models*. Models can be connected to other models through
*associations*.

Dynamic Ruby Archive relies on consistent naming as it uses class and
association names to establish correct mappings based on respective database table names and
foreign key columns. Although these mappings can be defined explicitly, it's
recommended to follow naming conventions.

## How to Use

### Use in Your Own Projects
- Download the project
- <tt>bundle install</tt>
- create your .sql file
- if needed remove an existing database with <tt>rm file_name.db</tt>
- To create your .db file run <tt>cat '{SQL_FILE_NAME}.sql' | sqlite3 '{DB_FILE_NAME}.db'</tt>
- run <tt>DBConnection.open('{DB_FILE_NAME}.db')</tt>

### Demo
-  Download the demo folder
- Open irb
- <tt> load 'demo.rb' </tt>
- Play with the data!

### Class Methods

  - ::first
  - ::last
  - ::table_name
  - ::all
  - ::find
  - ::where

### Instance Methods
  - #save
  - any associations
  - all column names of its associated table

### Associations
 - has_many
 - has_one
 - has_many_through
 - has_one_through
 - belongs_to

* Maps between classes and tables, attributes and columns
```ruby
  class Player < DRAObject
```
will map to a table named players and will define attribute accessors for a every column in the players table.

* Associations between objects are defined by class methods which reference foreign keys in the database.
```ruby
    belongs_to :team
```
references:
```sql
    team_id INTEGER,
    FOREIGN KEY (team_id) REFERENCES teams(id)
```
