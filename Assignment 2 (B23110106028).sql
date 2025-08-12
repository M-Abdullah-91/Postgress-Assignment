CREATE DATABASE CarShowroomDB;
USE CarShowroomDB;


CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY ,
    CustomerName VARCHAR(100) NOT NULL,
    City VARCHAR(50),
    State VARCHAR(50),
    JoinDate DATE DEFAULT CURRENT_DATE
);

CREATE TABLE Cars (
    CarID SERIAL PRIMARY KEY ,
    Model VARCHAR(50) NOT NULL,
    Brand VARCHAR(50) NOT NULL,
    Year INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Color VARCHAR(30) NOT NULL,
    InventoryCount INT NOT NULL
);

CREATE TABLE Salespersons (
    SalespersonID SERIAL PRIMARY KEY ,
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(50)NOT NULL,
    HireDate DATE DEFAULT CURRENT_DATE
);

CREATE TABLE Sales (
    SaleID SERIAL PRIMARY KEY ,
    CustomerID INT NOT NULL,
    CarID INT NOT NULL,
    SaleDate DATE,
    SalePrice DECIMAL(10,2),
    SalespersonID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (CarID) REFERENCES Cars(CarID),
    FOREIGN KEY (SalespersonID) REFERENCES Salespersons(SalespersonID)
);

CREATE TABLE ServiceRecords (
    RecordID SERIAL PRIMARY KEY ,
    CarID INT,
    ServiceDate DATE DEFAULT CURRENT_DATE,
    ServiceType VARCHAR(50) NOT NULL,
    Cost DECIMAL(8,2),
    TechnicianID INT,
    FOREIGN KEY (CarID) REFERENCES Cars(CarID)
);




INSERT INTO Customers (CustomerName, City, State, JoinDate) VALUES
('John Smith', 'New York', 'NY', '2023-01-15'),
('Sarah Johnson', 'Los Angeles', 'CA', '2023-02-20'),
('Mike Brown', 'Chicago', 'IL', '2023-03-10'),
('Emily Davis', 'Houston', 'TX', '2023-04-05'),
('David Wilson', 'Phoenix', 'AZ', '2023-05-12'),
('Lisa Anderson', 'Philadelphia', 'PA', '2023-06-18'),
('Robert Taylor', 'San Antonio', 'TX', '2023-07-22'),
('Jennifer Martinez', 'San Diego', 'CA', '2023-08-14'),
('William Garcia', 'Dallas', 'TX', '2023-09-08'),
('Amanda Rodriguez', 'San Jose', 'CA', '2023-10-25');


INSERT INTO Salespersons (Name, Department, HireDate) VALUES
('Alex Thompson', 'Luxury Sales', '2022-01-10'),
('Maria Garcia', 'Economy Sales', '2022-03-15'),
('Tom Wilson', 'Luxury Sales', '2022-05-20'),
('Rachel Adams', 'SUV Sales', '2022-07-12'),
('Steve Johnson', 'Sports Cars', '2022-09-08'),
('Linda Brown', 'Economy Sales', '2023-01-22'),
('Kevin Davis', 'Luxury Sales', '2023-04-15'),
('Nancy Miller', 'SUV Sales', '2023-06-10');


INSERT INTO Cars (Model, Brand, Year, Price, Color, InventoryCount) VALUES
('Camry', 'Toyota', 2023, 28000.00, 'Silver', 15),
('Corolla', 'Toyota', 2023, 24000.00, 'White', 20),
('Civic', 'Honda', 2023, 25000.00, 'Black', 18),
('Accord', 'Honda', 2023, 32000.00, 'White', 14),
('3 Series', 'BMW', 2023, 55000.00, 'Black', 8),
('5 Series', 'BMW', 2023, 65000.00, 'Silver', 6),
('C-Class', 'Mercedes', 2023, 58000.00, 'Silver', 7),
('E-Class', 'Mercedes', 2023, 68000.00, 'Black', 5),
('A4', 'Audi', 2023, 50000.00, 'Black', 9),
('Q5', 'Audi', 2023, 55000.00, 'White', 7),
('F-150', 'Ford', 2023, 35000.00, 'Red', 20),
('Mustang', 'Ford', 2023, 45000.00, 'Yellow', 8);

INSERT INTO Sales (CustomerID, CarID, SaleDate, SalePrice, SalespersonID) VALUES
(1, 1, '2023-06-15', 27500.00, 2),
(2, 1, '2023-07-20', 28000.00, 2),
(3, 1, '2023-08-12', 27800.00, 6),
(4, 1, '2023-09-05', 27600.00, 2),
(5, 1, '2023-10-18', 27900.00, 6),
(6, 1, '2023-11-22', 28200.00, 2),
(7, 1, '2023-12-08', 27400.00, 6),
(8, 1, '2024-01-15', 28100.00, 2),
(9, 1, '2024-02-28', 27700.00, 6),
(10, 1, '2024-03-14', 28000.00, 2);


INSERT INTO ServiceRecords (CarID, ServiceDate, ServiceType, Cost, TechnicianID) VALUES
(1, '2023-07-01', 'Oil Change', 75.00, 101),
(2, '2023-07-15', 'Oil Change', 80.00, 102),
(4, '2023-07-10', 'Brake Service', 280.00, 101),
(8, '2023-08-05', 'Brake Service', 320.00, 102),
(9, '2023-09-10', 'Brake Service', 295.00, 103),
(12, '2023-12-10', 'Engine Repair', 1100.00, 105),
(6, '2023-09-25', 'Transmission Repair', 1800.00, 106),
(11, '2023-08-25', 'Tire Replacement', 380.00, 103),
(5, '2023-09-20', 'Tire Replacement', 420.00, 103);

-- Find the total number of customers in the database
SELECT COUNT(*) AS TotalCustomers FROM Customers;

-- Calculate the average sale price of all car sales
SELECT AVG(SalePrice) AS AverageSalePrice FROM Sales;

-- Find the most expensive car ever sold
SELECT MAX(SalePrice) AS MostExpensiveCarSold FROM Sales;

-- Determine the total inventory count of all cars in the showroom
SELECT SUM(InventoryCount) AS TotalInventoryCount FROM Cars;

-- Find the earliest and most recent sale dates
SELECT 
    MIN(SaleDate) AS EarliestSaleDate,
    MAX(SaleDate) AS MostRecentSaleDate
FROM Sales;

-- PART 2:

-- Group cars by brand and count how many models each brand has
SELECT 
    Brand,
    COUNT(DISTINCT Model) AS ModelCount
FROM Cars
GROUP BY Brand
ORDER BY ModelCount DESC;

-- Calculate the total sales amount for each salesperson
SELECT 
    s.SalespersonID,
    sp.Name AS SalespersonName,
    SUM(s.SalePrice) AS TotalSalesAmount
FROM Sales s
JOIN Salespersons sp ON s.SalespersonID = sp.SalespersonID
GROUP BY s.SalespersonID, sp.Name
ORDER BY TotalSalesAmount DESC;

-- Find the average sale price for each car model
SELECT 
    c.Model,
    c.Brand,
    AVG(s.SalePrice) AS AverageSalePrice
FROM Sales s
JOIN Cars c ON s.CarID = c.CarID
GROUP BY c.Model, c.Brand
ORDER BY AverageSalePrice DESC;

-- For each service type, find the average service cost
SELECT 
    ServiceType,
    AVG(Cost) AS AverageServiceCost
FROM ServiceRecords
GROUP BY ServiceType
ORDER BY AverageServiceCost DESC;

-- Find the count of cars by brand and color combination
SELECT 
    Brand,
    Color,
    COUNT(*) AS CarCount
FROM Cars
GROUP BY Brand, Color
ORDER BY Brand, Color;

-- PART 3: 

-- Identify brands that offer more than five different car models
SELECT 
    Brand,
    COUNT(DISTINCT Model) AS ModelCount
FROM Cars
GROUP BY Brand
HAVING COUNT(DISTINCT Model) > 5
ORDER BY ModelCount DESC;

-- List car models that have been sold more than 10 times
SELECT 
    c.Brand,
    c.Model,
    COUNT(s.SaleID) AS SalesCount
FROM Sales s
JOIN Cars c ON s.CarID = c.CarID
GROUP BY c.Brand, c.Model
HAVING COUNT(s.SaleID) > 10
ORDER BY SalesCount DESC;

-- Find salespersons whose average sale price is greater than 50,000
SELECT 
    sp.SalespersonID,
    sp.Name AS SalespersonName,
    AVG(s.SalePrice) AS AverageSalePrice
FROM Sales s
JOIN Salespersons sp ON s.SalespersonID = sp.SalespersonID
GROUP BY sp.SalespersonID, sp.Name
HAVING AVG(s.SalePrice) > 50000
ORDER BY AverageSalePrice DESC;

-- Identify months that had more than 20 sales
SELECT 
    EXTRACT(YEAR FROM SaleDate ) AS "SaleYear",
    EXTRACT(MONTH FROM SaleDate) AS "SaleMonth",
    TO_CHAR(SaleDate, 'Month') AS "MonthName",
    COUNT(*) AS "SalesCount"
FROM sales
GROUP BY "SaleYear", "SaleMonth", "MonthName"
HAVING COUNT(*) > 20
ORDER BY "SaleYear", "SaleMonth";



-- Find service types where the average cost is greater than 500
SELECT 
    ServiceType,
    AVG(Cost) AS AverageServiceCost,
    COUNT(*) AS ServiceCount
FROM ServiceRecords
GROUP BY ServiceType
HAVING AVG(Cost) > 500
ORDER BY AverageServiceCost DESC;