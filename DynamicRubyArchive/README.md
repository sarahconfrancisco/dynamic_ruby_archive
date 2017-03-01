= Dynamic Ruby Archive -- Object-relational mapping in Rails

Dynamic Ruby Archive connects ruby classes to relational sqlite3 database tables
to establish a persistence layer for applications that needs minimal
configuration (with correct naming - more on that later). The library provides
a base class that, when subclassed, maps between the new class and an existing
table in the database. In the context of an application, these classes are
referred to as *models*. Models can be connected to other models through
*associations*.

Dynamic Ruby Archive relies on consistent naming as it uses class and
association names to establish mappings between respective database tables and
foreign key columns. Although these mappings can be defined explicitly, it's
recommended to follow naming conventions.

* Maps between classes and tables, attributes and columns

class Student < SQLObject
end

will map to a table named students which might look like:

  CREATE TABLE students (
    id INTEGER PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
  );

and will define attribute accessors for a Student object's full_name.

* Associations between objects are defined by class methods

  class Professor < SQLObject
    has_many :courses
    has_one :office
    has_many_through :students, :courses, :students
    belongs_to :college
  end
