CREATE DATABASE IF NOT EXISTS student_score;
USE student_score;

-- =============================================
-- BAGIAN 1: DDL (MEMBUAT STRUKTUR TABEL)
-- =============================================

DROP TABLE IF EXISTS career_recommendation;
DROP TABLE IF EXISTS exam_results;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS subjects;
DROP TABLE IF EXISTS majors;

-- 1. Table Majors
CREATE TABLE majors (
    id_major INT PRIMARY KEY,
    major_name VARCHAR(50) NOT NULL
);

-- 2. Table Subjects
CREATE TABLE subjects (
    id_subject INT PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL
);

-- 3. Table Students
CREATE TABLE students (
    id_student INT PRIMARY KEY AUTO_INCREMENT,
    id_major INT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    gender ENUM('male', 'female'),
    date_of_birth DATE,
    address TEXT,
    parent_name VARCHAR(100),
    parent_phone VARCHAR(20),
    FOREIGN KEY (id_major) REFERENCES majors(id_major)
);

-- 4. Table Exam Results
CREATE TABLE exam_results (
    id_result INT PRIMARY KEY AUTO_INCREMENT,
    id_student INT,
    id_subject INT,
    score INT,
    FOREIGN KEY (id_student) REFERENCES students(id_student),
    FOREIGN KEY (id_subject) REFERENCES subjects(id_subject)
);

-- 5. Table Career Recommendation
CREATE TABLE career_recommendation (
    id_recommendation INT PRIMARY KEY AUTO_INCREMENT,
    id_student INT,
    strongest_subject VARCHAR(50),
    highest_score INT,
    recommended_career VARCHAR(50),
    career_field VARCHAR(50),
    FOREIGN KEY (id_student) REFERENCES students(id_student)
);

-- =============================================
-- BAGIAN 2: DML (INPUT DATA)
-- =============================================

-- A. Insert Data Majors
INSERT INTO majors (id_major, major_name) VALUES 
(1, 'Science (IPA)'),
(2, 'Social Science (IPS)'),
(3, 'Language (Bahasa)');

-- B. Insert Data Subjects
INSERT INTO subjects (id_subject, subject_name) VALUES 
(1, 'Mathematics'),
(2, 'History'),
(3, 'Physics'),
(4, 'Chemistry'),
(5, 'Biology'),
(6, 'English'),
(7, 'Geography');

-- C. Insert Data Students (Total 30 Data)
INSERT INTO students (id_student, id_major, full_name, email, phone_number, gender, date_of_birth, address, parent_name, parent_phone) VALUES 
-- Data Lama (1-10)
(1, 3, 'Paul Casey', 'paul.casey.1@gslingacademy.com', '08153406981', 'male', '2005-08-14', 'Jl. Merdeka No. 10, Jakarta', 'Mr./Mrs. Casey', '08529348123'),
(2, 2, 'Danielle Sandoval', 'danielle.sandoval.2@gslingacademy.com', '08340192843', 'female', '2006-02-20', 'Jl. Sudirman No. 45, Bandung', 'Mr./Mrs. Sandoval', '08129384756'),
(3, 1, 'Tina Andrews', 'tina.andrews.3@gslingacademy.com', '08928374651', 'female', '2005-11-05', 'Jl. Diponegoro No. 12, Surabaya', 'Mr./Mrs. Andrews', '08567891234'),
(4, 1, 'Tara Clark', 'tara.clark.4@gslingacademy.com', '08213456789', 'female', '2007-05-12', 'Jl. Gajah Mada No. 88, Yogyakarta', 'Mr./Mrs. Clark', '08134567890'),
(5, 3, 'Anthony Campos', 'anthony.campos.5@gslingacademy.com', '08781234567', 'male', '2006-09-30', 'Jl. Thamrin No. 5, Semarang', 'Mr./Mrs. Campos', '08198765432'),
(6, 2, 'Kelly Wade', 'kelly.wade.6@gslingacademy.com', '08571234987', 'female', '2005-04-18', 'Jl. Ahmad Yani No. 23, Medan', 'Mr./Mrs. Wade', '08219876543'),
(7, 1, 'Anthony Smith', 'anthony.smith.7@gslingacademy.com', '08965432109', 'male', '2007-01-25', 'Jl. Gatot Subroto No. 67, Makassar', 'Mr./Mrs. Smith', '08312345678'),
(8, 2, 'George Short', 'george.short.8@gslingacademy.com', '08123456789', 'male', '2006-12-10', 'Jl. Asia Afrika No. 9, Bali', 'Mr./Mrs. Short', '08523456789'),
(9, 3, 'Stanley Gutierrez', 'stanley.gutierrez.9@gslingacademy.com', '08234567891', 'male', '2005-07-07', 'Jl. Pahlawan No. 33, Malang', 'Mr./Mrs. Gutierrez', '08134567891'),
(10, 1, 'Audrey Simpson', 'audrey.simpson.10@gslingacademy.com', '08776543210', 'female', '2006-03-15', 'Jl. Imam Bonjol No. 11, Solo', 'Mr./Mrs. Simpson', '08987654321'),
-- Data Baru (11-30)
(11, 2, 'Gabrielle White', 'gabrielle.white.11@gslingacademy.com', '08361729384', 'female', '2006-05-14', 'Jl. Sudirman No. 120, Makassar', 'Parent of White', '08983274623'),
(12, 1, 'Clinton Randolph', 'clinton.randolph.12@gslingacademy.com', '08173648291', 'male', '2005-09-02', 'Jl. Gatot Subroto No. 45, Bandung', 'Parent of Randolph', '08765432189'),
(13, 3, 'Patricia Gomez', 'patricia.gomez.13@gslingacademy.com', '08283746519', 'female', '2006-11-20', 'Jl. Ahmad Yani No. 88, Semarang', 'Parent of Gomez', '08129837465'),
(14, 1, 'Pamela Jackson', 'pamela.jackson.14@gslingacademy.com', '08928374612', 'female', '2005-04-10', 'Jl. Pahlawan No. 10, Medan', 'Parent of Jackson', '08213456789'),
(15, 2, 'Laura Jackson', 'laura.jackson.15@gslingacademy.com', '08564738291', 'female', '2006-01-25', 'Jl. Merdeka No. 55, Yogyakarta', 'Parent of Jackson', '08345678901'),
(16, 3, 'Roger Wiley', 'roger.wiley.16@gslingacademy.com', '08129384756', 'male', '2005-07-18', 'Jl. Sudirman No. 33, Jakarta', 'Parent of Wiley', '08456789012'),
(17, 1, 'Vicki Thompson', 'vicki.thompson.17@gslingacademy.com', '08765432109', 'female', '2006-10-05', 'Jl. Gatot Subroto No. 99, Surabaya', 'Parent of Thompson', '08567890123'),
(18, 2, 'Maxwell Davidson', 'maxwell.davidson.18@gslingacademy.com', '08213456780', 'male', '2005-03-12', 'Jl. Ahmad Yani No. 14, Bandung', 'Parent of Davidson', '08678901234'),
(19, 3, 'Jonathan Werner', 'jonathan.werner.19@gslingacademy.com', '08987654321', 'male', '2006-08-30', 'Jl. Pahlawan No. 77, Makassar', 'Parent of Werner', '08789012345'),
(20, 1, 'Angela Rios', 'angela.rios.20@gslingacademy.com', '08543210987', 'female', '2005-12-15', 'Jl. Merdeka No. 22, Semarang', 'Parent of Rios', '08890123456'),
(21, 2, 'Tim Nichols', 'tim.nichols.21@gslingacademy.com', '08112233445', 'male', '2006-06-01', 'Jl. Sudirman No. 60, Medan', 'Parent of Nichols', '08901234567'),
(22, 3, 'Kyle Willis', 'kyle.willis.22@gslingacademy.com', '08667788990', 'male', '2005-02-28', 'Jl. Gatot Subroto No. 5, Jakarta', 'Parent of Willis', '08112345678'),
(23, 1, 'Shannon Simpson', 'shannon.simpson.23@gslingacademy.com', '08334455667', 'female', '2006-09-10', 'Jl. Ahmad Yani No. 101, Surabaya', 'Parent of Simpson', '08223456789'),
(24, 2, 'Sean Griffin', 'sean.griffin.24@gslingacademy.com', '08889990001', 'male', '2005-05-20', 'Jl. Pahlawan No. 44, Yogyakarta', 'Parent of Griffin', '08334567890'),
(25, 3, 'Cassandra West', 'cassandra.west.25@gslingacademy.com', '08556677889', 'female', '2006-11-05', 'Jl. Merdeka No. 12, Bandung', 'Parent of West', '08445678901'),
(26, 1, 'Patricia Chavez', 'patricia.chavez.26@gslingacademy.com', '08223344556', 'female', '2005-01-15', 'Jl. Sudirman No. 89, Makassar', 'Parent of Chavez', '08556789012'),
(27, 2, 'Jason Williams', 'jason.williams.27@gslingacademy.com', '08778899001', 'male', '2006-07-25', 'Jl. Gatot Subroto No. 30, Semarang', 'Parent of Williams', '08667890123'),
(28, 3, 'Peter Gibbs', 'peter.gibbs.28@gslingacademy.com', '08990011223', 'male', '2005-10-10', 'Jl. Ahmad Yani No. 65, Medan', 'Parent of Gibbs', '08778901234'),
(29, 1, 'Jeffrey Blanchard', 'jeffrey.blanchard.29@gslingacademy.com', '08445566778', 'male', '2006-04-02', 'Jl. Pahlawan No. 9, Jakarta', 'Parent of Blanchard', '08889012345'),
(30, 2, 'Carol Hill', 'carol.hill.30@gslingacademy.com', '08112233446', 'female', '2005-08-18', 'Jl. Merdeka No. 70, Surabaya', 'Parent of Hill', '08990123456');

-- D. Insert Exam Results (Nilai Ujian)
INSERT INTO exam_results (id_student, id_subject, score) VALUES 
-- Nilai Paul Casey (ID 1)
(1, 1, 73), (1, 2, 81), (1, 3, 93), (1, 4, 97), (1, 5, 63), (1, 6, 80), (1, 7, 87),
-- Nilai Danielle Sandoval (ID 2)
(2, 1, 90), (2, 2, 86), (2, 3, 96), (2, 4, 100), (2, 5, 90), (2, 6, 88), (2, 7, 90),
-- Nilai Tina Andrews (ID 3)
(3, 1, 81), (3, 2, 97), (3, 3, 95), (3, 4, 96), (3, 5, 65), (3, 6, 77), (3, 7, 94),
-- Nilai Tara Clark (ID 4)
(4, 1, 71), (4, 2, 74), (4, 3, 88), (4, 4, 80), (4, 5, 89), (4, 6, 63), (4, 7, 86),
-- Nilai Anthony Campos (ID 5)
(5, 1, 84), (5, 2, 77), (5, 3, 65), (5, 4, 65), (5, 5, 80), (5, 6, 74), (5, 7, 76),
-- Nilai Kelly Wade (ID 6)
(6, 1, 93), (6, 2, 100), (6, 3, 67), (6, 4, 78), (6, 5, 72), (6, 6, 80), (6, 7, 84),
-- Nilai Anthony Smith (ID 7)
(7, 1, 99), (7, 2, 96), (7, 3, 97), (7, 4, 73), (7, 5, 88), (7, 6, 76), (7, 7, 64),
-- Nilai George Short (ID 8)
(8, 1, 95), (8, 2, 95), (8, 3, 82), (8, 4, 63), (8, 5, 84), (8, 6, 70), (8, 7, 85),
-- Nilai Stanley Gutierrez (ID 9)
(9, 1, 94), (9, 2, 68), (9, 3, 94), (9, 4, 85), (9, 5, 81), (9, 6, 74), (9, 7, 72),
-- Nilai Audrey Simpson (ID 10)
(10, 1, 98), (10, 2, 69), (10, 3, 88), (10, 4, 71), (10, 5, 67), (10, 6, 71), (10, 7, 73),
-- Nilai Data Baru (11-30)
(11, 1, 65), (11, 2, 60), (11, 3, 97), (11, 4, 94), (11, 5, 71), (11, 6, 81), (11, 7, 66),
(12, 1, 80), (12, 2, 61), (12, 3, 100), (12, 4, 65), (12, 5, 87), (12, 6, 64), (12, 7, 61),
(13, 1, 94), (13, 2, 59), (13, 3, 69), (13, 4, 67), (13, 5, 89), (13, 6, 65), (13, 7, 73),
(14, 1, 66), (14, 2, 94), (14, 3, 86), (14, 4, 100), (14, 5, 57), (14, 6, 90), (14, 7, 63),
(15, 1, 96), (15, 2, 90), (15, 3, 86), (15, 4, 92), (15, 5, 92), (15, 6, 95), (15, 7, 87),
(16, 1, 94), (16, 2, 50), (16, 3, 78), (16, 4, 64), (16, 5, 79), (16, 6, 74), (16, 7, 84),
(17, 1, 92), (17, 2, 64), (17, 3, 93), (17, 4, 91), (17, 5, 80), (17, 6, 89), (17, 7, 72),
(18, 1, 86), (18, 2, 83), (18, 3, 85), (18, 4, 79), (18, 5, 93), (18, 6, 76), (18, 7, 77),
(19, 1, 92), (19, 2, 87), (19, 3, 92), (19, 4, 99), (19, 5, 97), (19, 6, 87), (19, 7, 86),
(20, 1, 99), (20, 2, 65), (20, 3, 98), (20, 4, 75), (20, 5, 66), (20, 6, 72), (20, 7, 100),
(21, 1, 100), (21, 2, 90), (21, 3, 72), (21, 4, 98), (21, 5, 73), (21, 6, 97), (21, 7, 72),
(22, 1, 57), (22, 2, 55), (22, 3, 78), (22, 4, 94), (22, 5, 83), (22, 6, 88), (22, 7, 88),
(23, 1, 89), (23, 2, 72), (23, 3, 68), (23, 4, 72), (23, 5, 71), (23, 6, 54), (23, 7, 90),
(24, 1, 50), (24, 2, 76), (24, 3, 81), (24, 4, 55), (24, 5, 56), (24, 6, 80), (24, 7, 79),
(25, 1, 87), (25, 2, 91), (25, 3, 90), (25, 4, 88), (25, 5, 95), (25, 6, 88), (25, 7, 93),
(26, 1, 92), (26, 2, 86), (26, 3, 87), (26, 4, 81), (26, 5, 93), (26, 6, 90), (26, 7, 99),
(27, 1, 100), (27, 2, 77), (27, 3, 80), (27, 4, 94), (27, 5, 63), (27, 6, 90), (27, 7, 90),
(28, 1, 64), (28, 2, 75), (28, 3, 93), (28, 4, 79), (28, 5, 81), (28, 6, 96), (28, 7, 85),
(29, 1, 79), (29, 2, 65), (29, 3, 99), (29, 4, 71), (29, 5, 76), (29, 6, 77), (29, 7, 83),
(30, 1, 82), (30, 2, 100), (30, 3, 61), (30, 4, 97), (30, 5, 30), (30, 6, 74), (30, 7, 73);

-- E. Insert Career Recommendation (Data Otomatis)
INSERT INTO career_recommendation (id_student, strongest_subject, highest_score, recommended_career, career_field) VALUES 
(1, 'Chemistry', 97, 'Chemist', 'Science'),
(2, 'Chemistry', 100, 'Chemist', 'Science'),
(3, 'History', 97, 'Historian', 'Humanities'),
(4, 'Biology', 89, 'Doctor', 'Healthcare'),
(5, 'Mathematics', 84, 'Data Scientist', 'Technology'),
(6, 'History', 100, 'Historian', 'Humanities'),
(7, 'Mathematics', 99, 'Data Scientist', 'Technology'),
(8, 'Mathematics', 95, 'Data Scientist', 'Technology'),
(9, 'Mathematics', 94, 'Data Scientist', 'Technology'),
(10, 'Mathematics', 98, 'Data Scientist', 'Technology'),
(11, 'Physics', 97, 'Physicist', 'Science'),
(12, 'Physics', 100, 'Physicist', 'Science'),
(13, 'Mathematics', 94, 'Data Scientist', 'Technology'),
(14, 'Chemistry', 100, 'Chemist', 'Science'),
(15, 'Mathematics', 96, 'Data Scientist', 'Technology'),
(16, 'Mathematics', 94, 'Data Scientist', 'Technology'),
(17, 'Physics', 93, 'Physicist', 'Science'),
(18, 'Biology', 93, 'Doctor', 'Healthcare'),
(19, 'Chemistry', 99, 'Chemist', 'Science'),
(20, 'Geography', 100, 'Geologist', 'Science'),
(21, 'Mathematics', 100, 'Data Scientist', 'Technology'),
(22, 'Chemistry', 94, 'Chemist', 'Science'),
(23, 'Geography', 90, 'Geologist', 'Science'),
(24, 'Physics', 81, 'Physicist', 'Science'),
(25, 'Biology', 95, 'Doctor', 'Healthcare'),
(26, 'Geography', 99, 'Geologist', 'Science'),
(27, 'Mathematics', 100, 'Data Scientist', 'Technology'),
(28, 'English', 96, 'Translator', 'Language'),
(29, 'Physics', 99, 'Physicist', 'Science'),
(30, 'History', 100, 'Historian', 'Humanities');