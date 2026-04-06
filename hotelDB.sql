-- =========================================
-- Hotel Management Database
-- =========================================

-- Create Database
CREATE SCHEMA hoteldb;
USE hoteldb;

-- =========================================
-- Tables
-- =========================================

-- Department Table
CREATE TABLE department (
  depID INT NOT NULL AUTO_INCREMENT,
  depName VARCHAR(150) NULL,
  PRIMARY KEY (depID)
);

-- Employee Table
CREATE TABLE employee (
  employee_id INT NOT NULL AUTO_INCREMENT,
  fName VARCHAR(45) NOT NULL,
  lName VARCHAR(45) NOT NULL,
  phone_number VARCHAR(20) NULL,
  age INT NULL,
  gender VARCHAR(45) NULL,
  email VARCHAR(45) NOT NULL,
  deptID INT NOT NULL,
  PRIMARY KEY (employee_id)
);

-- Guest Table
CREATE TABLE guest (
  guestID INT NOT NULL AUTO_INCREMENT,
  fName VARCHAR(50) NOT NULL,
  lName VARCHAR(50) NOT NULL,
  age INT NULL,
  gender VARCHAR(45) NULL,
  phoneNumber VARCHAR(20) NULL,
  isCreditCardValid BIT(1) NULL,
  PRIMARY KEY (guestID)
);

-- Room Type Table
CREATE TABLE room_type (
  roomTypeID INT NOT NULL AUTO_INCREMENT,
  smokingFriendly VARCHAR(45) NULL,
  riName VARCHAR(45) NULL,
  costK DECIMAL(8,2) NULL,
  PRIMARY KEY (roomTypeID)
);

-- Rooms Table
CREATE TABLE rooms (
  roomID INT NOT NULL AUTO_INCREMENT,
  roomType VARCHAR(45) NOT NULL,
  roomNumber INT NOT NULL,
  PRIMARY KEY (roomID)
);

-- Reservation Table
CREATE TABLE reservation (
  resID INT NOT NULL AUTO_INCREMENT,
  employeeID INT NOT NULL,
  guestID INT NOT NULL,
  totalAmount DECIMAL(8,2) NULL,
  payType VARCHAR(45) NULL,
  checkInDate DATETIME NULL,
  checkOutDate DATETIME NULL,
  PRIMARY KEY (resID)
);

-- Services Table
CREATE TABLE services (
  serID INT NOT NULL AUTO_INCREMENT,
  service_name VARCHAR(45) NULL,
  service_desc VARCHAR(500) NULL,
  cost DECIMAL(8,2) NULL,
  resID INT NOT NULL,
  depID INT NOT NULL,
  PRIMARY KEY (serID)
);

-- =========================================
-- Insert Data
-- =========================================

-- Departments
INSERT INTO department (depName) VALUES 
('Finance'),
('HR'),
('Admin'),
('Technical'),
('Sale');

-- Employees
INSERT INTO employee (fName, lName, phone_number, age, gender, email, deptID) VALUES
('Ayaan', 'Ayan', '+9663331234567', 22, 'Male', 'email1@domain.com', 1),
('Ayaan2', 'Ayan2', '+9666661987654', 32, 'Male', 'email2@domain.com', 2),
('Asmaa', 'Alayed', '+9669987456327', 35, 'Female', 'asma@domain.com', 3),
('Hamza', 'Ali', '00968746517', 42, 'Male', 'hamza@hotmail.com', 4),
('Ibrahim', 'Ahmed', '+9669632587423', 50, 'Male', 'ahmed@yahoo.com', 5);

-- Guests
INSERT INTO guest (fName, lName, age, gender, phoneNumber, isCreditCardValid) VALUES
('Ayan', 'Ahmed', 25, 'Male', '00966698745632', 1),
('Talal', 'Ali', 40, 'Male', '+96687436541', 0),
('Suleman', 'Shaikh', 29, 'Male', '0096687456321', 1),
('Ayesha', 'Noor', 25, 'Female', '+966577448855', 1),
('Amina', 'Ali', 25, 'Female', '0096687456321', 0);

-- =========================================
-- Queries
-- =========================================

-- Update
UPDATE employee 
SET phone_number = '+966541879325', age = 32 
WHERE employee_id = 3;

UPDATE guest 
SET fName = 'Khalid', age = 32 
WHERE guestID = 4;

-- Delete
DELETE FROM rooms WHERE roomID = 5;
DELETE FROM room_type WHERE roomTypeID = 4;

-- Select Queries
SELECT * FROM employee;

SELECT fName, lName 
FROM employee;

SELECT * 
FROM employee 
WHERE fname = 'ayaan2';

SELECT SUM(cost), service_name, service_desc 
FROM services 
GROUP BY service_name, service_desc;

SELECT * 
FROM guest 
HAVING age > 25;

SELECT fName, lName, age 
FROM employee 
ORDER BY fName;

SELECT * 
FROM services 
WHERE resId IN (SELECT resID FROM reservation);

SELECT employee.fName, employee.lName, employee.phone_number, employee.age,
department.depID, department.depName
FROM employee 
INNER JOIN department 
ON employee.deptID = department.depID;

SELECT * 
FROM employee 
WHERE fName LIKE '%ay%';

SELECT * 
FROM employee 
LIMIT 3;
-- Additional queries to showcase functionality

-- Count total employees in each department
SELECT d.depName, COUNT(e.employee_id) AS total_employees
FROM employee e
JOIN department d ON e.deptID = d.depID
GROUP BY d.depName;

-- List guests with valid credit cards
SELECT fName, lName, phoneNumber
FROM guest
WHERE isCreditCardValid = 1;

-- Show total revenue per reservation
SELECT resID, SUM(cost) AS services_total
FROM services
GROUP BY resID;

-- Join rooms and room types to see costs and smoking info
SELECT r.roomNumber, rt.riName, rt.smokingFriendly, rt.costK
FROM rooms r
JOIN room_type rt ON r.roomType = rt.roomTypeID;