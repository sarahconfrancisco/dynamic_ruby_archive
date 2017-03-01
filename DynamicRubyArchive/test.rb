require_relative "lib/db_connection.rb"
require_relative "lib/sql_object.rb"
require_relative "lib/associatable.rb"

class Student < SQLObject
end

Student.finalize!


class Teacher < SQLObject
end

Teacher.finalize!


class Course < SQLObject
end

Course.finalize!

Student.belongs_to(:course)
Course.belongs_to(:teacher)
Course.has_many(:students)
Teacher.has_many(:courses)
Teacher.has_many_through(:students, :courses, :students)
Student.has_one_through(:teacher, :course, :teacher)
