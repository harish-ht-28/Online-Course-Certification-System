CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100), email VARCHAR(100) UNIQUE, password VARCHAR(100)
);

CREATE TABLE instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100), email VARCHAR(100) UNIQUE, password VARCHAR(100)
);

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY, title VARCHAR(255), description TEXT, instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY, student_id INT, course_id INT, status ENUM('In Progress', 'Completed'),
    FOREIGN KEY (student_id) REFERENCES students(student_id), FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE certifications (
    certificate_id INT AUTO_INCREMENT PRIMARY KEY, student_id INT, course_id INT, issue_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id), FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO students (name, email, password) VALUES ('Alice Johnson', 'alice@example.com', 'password123');
INSERT INTO instructors (name, email, password) VALUES ('Dr. Smith', 'smith@example.com', 'securepass');
INSERT INTO courses (title, description, instructor_id) VALUES ('SQL for Beginners', 'Learn SQL from scratch.', 1);
INSERT INTO enrollments (student_id, course_id, status) VALUES (1, 1, 'In Progress');

UPDATE enrollments SET status = 'Completed' WHERE student_id = 1 AND course_id = 1;
INSERT INTO certifications (student_id, course_id) 
SELECT student_id, course_id FROM enrollments WHERE student_id = 1 AND course_id = 1 AND status = 'Completed';

SELECT s.name AS Student, c.title AS Course, cert.issue_date AS Certificate_Issued_On 
FROM certifications cert
JOIN students s ON cert.student_id = s.student_id
JOIN courses c ON cert.course_id = c.course_id;
