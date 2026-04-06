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
-- ================================================
-- Extra queries to expand SQL file for GitHub
-- ================================================

-- 1. Count total employees in each department
SELECT d.depName, COUNT(e.employee_id) AS total_employees
FROM employee e
JOIN department d ON e.deptID = d.depID
GROUP BY d.depName;

-- 2. List guests with valid credit cards
SELECT fName, lName, phoneNumber
FROM guest
WHERE isCreditCardValid = 1;

-- 3. Show total revenue per reservation
SELECT resID, SUM(cost) AS services_total
FROM services
GROUP BY resID;

-- 4. Rooms with type, smoking info, and cost
SELECT r.roomNumber, rt.riName, rt.smokingFriendly, rt.costK
FROM rooms r
JOIN room_type rt ON r.roomType = rt.roomTypeID;

-- 5. Employees over 30 years old
SELECT fName, lName, age
FROM employee
WHERE age > 30
ORDER BY age DESC;

-- 6. Guests older than 25 with their reservation count
SELECT g.fName, g.lName, COUNT(r.resID) AS reservations_count
FROM guest g
LEFT JOIN reservation r ON g.guestID = r.guestID
GROUP BY g.guestID, g.fName, g.lName
HAVING COUNT(r.resID) > 0;

-- 7. Average cost of services per department
SELECT depID, AVG(cost) AS avg_service_cost
FROM services
GROUP BY depID;

-- 8. Total revenue per department
SELECT depID, SUM(cost) AS total_service_revenue
FROM services
GROUP BY depID;

-- 9. Employees with their department names
SELECT e.fName, e.lName, d.depName
FROM employee e
JOIN department d ON e.deptID = d.depID
ORDER BY d.depName;

-- 10. Reservations with totalAmount greater than 100
SELECT resID, totalAmount, payType, checkInDate, checkOutDate
FROM reservation
WHERE totalAmount > 100
ORDER BY totalAmount DESC;

-- 11. Guests who have stayed multiple times
SELECT g.fName, g.lName, COUNT(r.resID) AS stay_count
FROM guest g
JOIN reservation r ON g.guestID = r.guestID
GROUP BY g.guestID, g.fName, g.lName
HAVING COUNT(r.resID) > 1;

-- 12. Rooms that are not booked yet
SELECT r.roomNumber, r.roomType
FROM rooms r
WHERE r.roomID NOT IN (SELECT DISTINCT resID FROM reservation);

-- 13. List services with their department names
SELECT s.service_name, s.cost, d.depName
FROM services s
JOIN department d ON s.depID = d.depID
ORDER BY s.cost DESC;

-- 14. Guests who stayed in July 2023
SELECT g.fName, g.lName, r.checkInDate, r.checkOutDate
FROM guest g
JOIN reservation r ON g.guestID = r.guestID
WHERE MONTH(r.checkInDate) = 7 AND YEAR(r.checkInDate) = 2023;

-- 15. Most expensive service per department
SELECT depID, service_name, MAX(cost) AS max_cost
FROM services
GROUP BY depID, service_name;

-- 16. Employees with email addresses ending with 'domain.com'
SELECT fName, lName, email
FROM employee
WHERE email LIKE '%domain.com';

-- 17. Count of guests by gender
SELECT gender, COUNT(*) AS total
FROM guest
GROUP BY gender;

-- 18. Room count by room type
SELECT roomType, COUNT(*) AS total_rooms
FROM rooms
GROUP BY roomType;

-- 19. Reservations with payment type 'Cash'
SELECT *
FROM reservation
WHERE payType = 'Cash';

-- 20. Guests with invalid credit cards
SELECT fName, lName, phoneNumber
FROM guest
WHERE isCreditCardValid = 0;
-- ================================================
-- Advanced Queries to Expand SQL for GitHub
-- ================================================

-- 21. Guests who spent more than the average totalAmount
SELECT g.fName, g.lName, r.totalAmount
FROM guest g
JOIN reservation r ON g.guestID = r.guestID
WHERE r.totalAmount > (SELECT AVG(totalAmount) FROM reservation);

-- 22. Employee with the most reservations handled
SELECT e.fName, e.lName, COUNT(r.resID) AS reservations_handled
FROM employee e
JOIN reservation r ON e.employeeID = r.employeeID
GROUP BY e.employeeID, e.fName, e.lName
ORDER BY reservations_handled DESC
LIMIT 1;

-- 23. Departments with total revenue from services
SELECT d.depName, SUM(s.cost) AS department_revenue
FROM department d
JOIN services s ON d.depID = s.depID
GROUP BY d.depID, d.depName
HAVING SUM(s.cost) > 100;

-- 24. Rooms and total number of guests who stayed in them
SELECT r.roomNumber, COUNT(rsv.resID) AS guests_count
FROM rooms r
LEFT JOIN reservation rsv ON r.roomID = rsv.resID
GROUP BY r.roomID, r.roomNumber;

-- 25. Top 3 most expensive services
SELECT service_name, cost
FROM services
ORDER BY cost DESC
LIMIT 3;

-- 26. Guests who stayed multiple times in the same month
SELECT g.fName, g.lName, MONTH(r.checkInDate) AS month, COUNT(r.resID) AS stays
FROM guest g
JOIN reservation r ON g.guestID = r.guestID
GROUP BY g.guestID, MONTH(r.checkInDate)
HAVING COUNT(r.resID) > 1;

-- 27. Average age of employees per department
SELECT d.depName, AVG(e.age) AS avg_age
FROM employee e
JOIN department d ON e.deptID = d.depID
GROUP BY d.depID, d.depName;

-- 28. Guests with longest stay (checkOutDate - checkInDate)
SELECT g.fName, g.lName, DATEDIFF(day, r.checkInDate, r.checkOutDate) AS stay_duration
FROM guest g
JOIN reservation r ON g.guestID = r.guestID
ORDER BY stay_duration DESC
LIMIT 5;

-- 29. Services linked to guests via reservations
SELECT g.fName, g.lName, s.service_name, s.cost
FROM guest g
JOIN reservation r ON g.guestID = r.guestID
JOIN services s ON s.resID = r.resID
ORDER BY g.lName, s.cost DESC;

-- 30. Rooms not assigned in any reservation
SELECT r.roomNumber, rt.riName
FROM rooms r
JOIN room_type rt ON r.roomType = rt.roomTypeID
WHERE r.roomID NOT IN (SELECT resID FROM reservation);

-- 31. Departments with highest average service cost
SELECT depID, AVG(cost) AS avg_cost
FROM services
GROUP BY depID
ORDER BY avg_cost DESC
LIMIT 1;

-- 32. Guests whose first name starts with 'A' and stayed more than once
SELECT g.fName, g.lName, COUNT(r.resID) AS total_stays
FROM guest g
JOIN reservation r ON g.guestID = r.guestID
WHERE g.fName LIKE 'A%'
GROUP BY g.guestID, g.fName, g.lName
HAVING COUNT(r.resID) > 1;

-- 33. Total revenue grouped by payment type
SELECT payType, SUM(totalAmount) AS total_revenue
FROM reservation
GROUP BY payType;

-- 34. Services costing more than average service
SELECT service_name, cost
FROM services
WHERE cost > (SELECT AVG(cost) FROM services);

-- 35. Guests and the total number of services they used
SELECT g.fName, g.lName, COUNT(s.serID) AS total_services
FROM guest g
JOIN reservation r ON g.guestID = r.guestID
JOIN services s ON s.resID = r.resID
GROUP BY g.guestID, g.fName, g.lName
ORDER BY total_services DESC;

-- 36. Departments with most services provided
SELECT d.depName, COUNT(s.serID) AS service_count
FROM department d
JOIN services s ON d.depID = s.depID
GROUP BY d.depID, d.depName
ORDER BY service_count DESC;

-- 37. Guests and their longest service cost
SELECT g.fName, g.lName, MAX(s.cost) AS max_service_cost
FROM guest g
JOIN reservation r ON g.guestID = r.guestID
JOIN services s ON s.resID = r.resID
GROUP BY g.guestID, g.fName, g.lName;

-- 38. Employees with youngest and oldest age per department
SELECT depID, MIN(age) AS youngest, MAX(age) AS oldest
FROM employee
GROUP BY depID;

-- 39. Total revenue per guest from services
SELECT g.fName, g.lName, SUM(s.cost) AS total_spent
FROM guest g
JOIN reservation r ON g.guestID = r.guestID
JOIN services s ON s.resID = r.resID
GROUP BY g.guestID, g.fName, g.lName;

-- 40. Guests who stayed in multiple rooms
SELECT g.fName, g.lName, COUNT(DISTINCT r.roomID) AS room_count
FROM guest g
JOIN reservation r ON g.guestID = r.guestID
GROUP BY g.guestID, g.fName, g.lName
HAVING COUNT(DISTINCT r.roomID) > 1;