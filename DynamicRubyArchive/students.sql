CREATE TABLE teachers (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE courses (
  id INTEGER PRIMARY KEY,
  subject VARCHAR(255) NOT NULL,
  teacher_id INTEGER,

  FOREIGN KEY(teacher_id) REFERENCES teachers(id)
);

CREATE TABLE students (
  id INTEGER PRIMARY KEY,
  full_name VARCHAR(255) NOT NULL,
  course_id INTEGER,

  FOREIGN KEY(course_id) REFERENCES courses(id)
);


INSERT INTO
teachers (id, fname, lname)
VALUES
(1, "Devon", "Watts"),
(2, "May", "Rubens"),
(3, "Louise", "Ruggeri"),
(4, "Fred", "Fredrick"),
(5, "Retired", "Teacher");

INSERT INTO
  courses (id, subject, teacher_id)
VALUES
  (1, "Calculus", 1),
  (2, "Differential Equations", 2),
  (3, "Quantum Mechanics", 3),
  (4, "Computer Science", 4);


INSERT INTO
  students (id, full_name, course_id)
VALUES
  (1, "Jeff", 1),
  (2, "Dan", 2),
  (3, "Haskell", 3),
  (4, "Markov", 3);
