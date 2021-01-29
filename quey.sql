
-- TO RUN THIS FILE IN TERMINAL
-- psql -f <filename> -d ga

-- TO SEE ALL TABLES ON DATABASE
-- \dt

-- TO SEE THE COLUMNS ON A TABLE
-- \d <table name>

-- TO QUIT POSTGRES
-- \q

-- DELETE THE DATABASE IF IT EXISTS
-- DROP DATABASE IF EXISTS ga;

-- CREATE ga Database
-- CREATE DATABASE ga;

-- CREATE COURSE TABLE
-- CREATE TABLE course
-- (id SERIAL PRIMARY KEY, name VARCHAR(255), code VARCHAR(200));


-- CREATE NEW COURSE ON COURSE TABLE
-- INSERT INTO course (name, code)
-- VALUES ('Web Development Immersive', 'WDI');


-- GET ALL RECORDS FROM COURSE TABLE
-- SELECT * FROM course;

-- CREATE ANOTHER NEW COURSE ON COURSE TABLE
-- INSERT INTO course (name, code)
-- VALUES ('Data Science', 'DSI');

-- SELECT ONE RECORD FROM COURSE TABLE BY ID
-- SELECT * FROM course WHERE id = 2;


-- SELECT ONE RECORD FROM COURSE TABLE BY NAME
-- SELECT * FROM course WHERE name = 'Web Development Immersive';

-- UPDATE ONE RECORD BY ID
-- UPDATE course
-- SET name = 'Software Engineering Immersive', code = 'SEI'
-- WHERE id = 1;

-- DELETE ONE RECORD FROM COURSE TABLE BY ID
-- DELETE FROM course WHERE id = 2;


-- GET ALL RECORDS FROM COURSE TABLE
-- SELECT * FROM course;

-------------------------------- MANY TO MANY RELATIONSHIP

-- DROP ALL TABLES
-- DROP DATABASE ga;

-- DROP (clear all records) COURSE TABLE
-- DROP TABLE course;

-- CREATE THE COURSE TABLE --

-- CREATE TABLE course
-- (id SERIAL PRIMARY KEY, name VARCHAR(255), code VARCHAR(5));

-- INSERT INTO course (name, code)
-- VALUES ('Software Engineering Immersive', 'SEI');

-- SELECT * FROM course;


-- CREATE THE STUDENT TABLE --
-- CREATE TABLE student
-- (id SERIAL PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), course_id INTEGER REFERENCES course(id));

-- INSERT A NEW STUDENT
-- INSERT INTO student (name, email, course_id)
-- VALUES ('Sarah Doe', 'sdoe@gmail.com', 1);

-- INSERT INTO student (name, email, course_id)
-- VALUES ('John Doe', 'jdoe@gmail.com', 1);

-- SELECT * FROM course;

-- SELECT * FROM student;

-- SELECT * FROM student WHERE course_id = 1;

-- CREATE TABLE student_courses
-- (id SERIAL PRIMARY KEY, student_id INTEGER REFERENCES student(id), course_id INTEGER REFERENCES course(id));

-- INSERT INTO student_courses
-- (student_id, course_id)
-- VALUES (1, 1);

-- SELECT * FROM student_courses;


-- NOT EQUAL
-- SELECT * FROM student WHERE name <> 'Sarah Doe';

-- ORDER BY
-- SELECT * FROM student ORDER BY name;


-- SELECT COLUMNS FROM TABLE
-- SELECT name, id FROM student;

SELECT name AS full_name FROM student;



-- ALTER TABLE product ADD COLUMN description VARCHAR(255);
-- ALTER TABLE product DROP COLUMN description;
-- ALTER TABLE product RENAME TO products;
