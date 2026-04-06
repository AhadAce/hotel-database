# Hotel Database Management System

---

## Overview

This project is a **hotel database management system** designed to handle employees, guests, rooms, reservations, and hotel services efficiently.

We noticed that many small and medium-sized hotels struggle with organizing and managing their operational data, such as reservations, room types, and service billing. This led us to create a structured **SQL database** that provides a solid foundation for hotel management applications.

---

## Problem Statement

Managing hotel data manually or with unstructured systems often results in:

- Inaccurate guest records  
- Conflicting room reservations  
- Difficulty tracking services and payments  
- Inefficient reporting on employees, departments, and revenue  

---

## Solution

Our **Hotel Database** solves these problems by providing:

- Structured tables for employees, guests, rooms, room types, services, and reservations  
- Relationships between tables to enforce data integrity  
- Sample data for testing common operations  
- A foundation for building a full hotel management application  

---

## Features

- Employee and department management  
- Guest records management with credit card validation  
- Room and room type tracking  
- Reservation system linking guests, employees, and rooms  
- Service management with cost tracking  
- Sample queries for reporting and analytics  

---

## Database Structure

The main tables in the database are:

- `employee` – stores employee information  
- `department` – stores hotel departments  
- `guest` – stores guest information and credit card validity  
- `rooms` – tracks room numbers and types  
- `room_type` – defines room characteristics and cost  
- `reservation` – links employees and guests with reservation details  
- `services` – tracks hotel services provided per reservation  

---

## Sample Queries

Some example queries included in the database:

- Retrieve all employees or guests  
- Aggregate service costs  
- Filter employees or guests by age  
- Join tables to get employee and department details  
- Search using patterns (`LIKE`)  

---

## Tech Stack

**Database:** Microsoft SQL Server (T-SQL)  
**File Type:** `.sql`  

---

## Author

Ahad Abuyabis

---
