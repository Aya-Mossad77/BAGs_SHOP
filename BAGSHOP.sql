DROP TABLE IF EXISTS Bag_Material;
DROP TABLE IF EXISTS Cust_Phone;
DROP TABLE IF EXISTS Cust_Order;
DROP TABLE IF EXISTS Bag;
DROP TABLE IF EXISTS Office;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Designer;
DROP TABLE IF EXISTS Raw_Material;

GO
GO

CREATE TABLE Designer (
    designer_id INT PRIMARY KEY,
    Fname VARCHAR(50) NOT NULL,
    Lname VARCHAR(50) NOT NULL,
    Exp INT DEFAULT 0,
    Super_id INT,
    CONSTRAINT FK_Designer_Supervisor FOREIGN KEY (Super_id) 
    REFERENCES Designer(designer_id) 
);


CREATE TABLE Office (
    office_num INT PRIMARY KEY,
    location VARCHAR(100) NOT NULL,
    designer_id INT UNIQUE, 
    CONSTRAINT FK_Office_Designer FOREIGN KEY (designer_id) 
    REFERENCES Designer(designer_id) ON DELETE SET NULL
);


CREATE TABLE Customer (
    Cust_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(150)
);


CREATE TABLE Cust_Phone (
    Cust_id INT,
    Phone VARCHAR(20),
    PRIMARY KEY (Cust_id, Phone),
    CONSTRAINT FK_Phone_Customer FOREIGN KEY (Cust_id) 
    REFERENCES Customer(Cust_id) ON DELETE CASCADE
);


CREATE TABLE Bag (
    Serial_id INT PRIMARY KEY,
    model VARCHAR(50) NOT NULL,
    Color VARCHAR(30),
    Cust_id INT,
    design_id INT,
    CONSTRAINT FK_Bag_Customer FOREIGN KEY (Cust_id) 
    REFERENCES Customer(Cust_id) ON DELETE SET NULL,
    CONSTRAINT FK_Bag_Designer FOREIGN KEY (design_id) 
    REFERENCES Designer(designer_id) ON DELETE SET NULL
);


CREATE TABLE Raw_Material (
    mat_Code INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE Bag_Material (
    Serial_id INT, 
    mat_Code INT,
    PRIMARY KEY (Serial_id, mat_Code),
    CONSTRAINT FK_BagMaterial_Bag FOREIGN KEY (Serial_id) 
    REFERENCES Bag(Serial_id) ON DELETE CASCADE,
    CONSTRAINT FK_BagMaterial_Material FOREIGN KEY (mat_Code) 
    REFERENCES Raw_Material(mat_Code) ON DELETE CASCADE
);


CREATE TABLE Cust_Order (
    Cust_id INT,
    order_num INT,
    date DATE NOT NULL,
    PRIMARY KEY (Cust_id, order_num), 
    CONSTRAINT FK_Order_Customer FOREIGN KEY (Cust_id) 
    REFERENCES Customer(Cust_id) ON DELETE CASCADE
);





USE BagsSHop;
GO

SELECT * FROM Designer 
WHERE Exp > 3;
GO

SELECT office_num, location FROM Office 
WHERE location LIKE 'Floor 1%';
GO

SELECT * FROM Bag 
WHERE Color IN ('Black', 'Red');
GO

SELECT designer_id, Fname, Lname FROM Designer 
WHERE Fname LIKE 'A%' OR Fname LIKE 'S%';
GO

SELECT * FROM Customer 
WHERE address IS NOT NULL 
ORDER BY name ASC;
GO

SELECT Serial_id, model FROM Bag 
WHERE Cust_id IS NULL;
GO

SELECT MIN(date) AS First_Order, MAX(date) AS Latest_Order FROM Cust_Order;
GO

SELECT COUNT(Serial_id) AS Total_Bags FROM Bag;
GO

SELECT order_num, Cust_id, date FROM Cust_Order 
WHERE date BETWEEN '2026-05-10' AND '2026-05-16';
GO

SELECT DISTINCT name FROM Raw_Material;
GO

SELECT design_id, COUNT(Serial_id) AS Bags_Designed FROM Bag 
WHERE design_id IS NOT NULL
GROUP BY design_id;
GO

SELECT Cust_id, COUNT(order_num) AS Total_Orders FROM Cust_Order
GROUP BY Cust_id
HAVING COUNT(order_num) > 1;
GO

SELECT office_num, location FROM Office 
WHERE designer_id IN (SELECT designer_id FROM Designer WHERE Exp < 4);
GO

SELECT D.Fname, D.Lname, O.office_num, O.location
FROM Designer D
INNER JOIN Office O ON D.designer_id = O.designer_id;
GO

SELECT D.Fname, D.Lname, O.office_num 
FROM Designer D
LEFT JOIN Office O ON D.designer_id = O.designer_id;
GO

SELECT C.name AS Customer_Name, B.model AS Bag_Model, D.Fname AS Designer_Name
FROM Bag B
INNER JOIN Customer C ON B.Cust_id = C.Cust_id
INNER JOIN Designer D ON B.design_id = D.designer_id;
GO

SELECT Emp.Fname AS Employee_Name, Super.Fname AS Supervisor_Name
FROM Designer Emp
INNER JOIN Designer Super ON Emp.Super_id = Super.designer_id;
GO

UPDATE Designer 
SET Exp = 3 
WHERE Fname = 'Omar';
GO

UPDATE Bag 
SET Color = 'Dark Black' 
WHERE model = 'Classic Tote';
GO

DELETE FROM Cust_Phone 
WHERE Phone = '01298765432';
GO





SELECT * FROM Designer 
WHERE Exp > 3;

SELECT office_num, location FROM Office 
WHERE location LIKE 'Floor 1%';

SELECT * FROM Bag 
WHERE Color IN ('Black', 'Red');

SELECT designer_id, Fname, Lname FROM Designer 
WHERE Fname LIKE 'A%' OR Fname LIKE 'S%';

SELECT * FROM Customer 
WHERE address IS NOT NULL 
ORDER BY name ASC;

SELECT Serial_id, model FROM Bag 
WHERE Cust_id IS NULL;

SELECT MIN(date) AS First_Order, MAX(date) AS Latest_Order FROM Cust_Order;

SELECT COUNT(Serial_id) AS Total_Bags FROM Bag;

SELECT order_num, Cust_id, date FROM Cust_Order 
WHERE date BETWEEN '2026-05-10' AND '2026-05-16';

SELECT DISTINCT name FROM Raw_Material;

SELECT design_id, COUNT(Serial_id) AS Bags_Designed FROM Bag 
WHERE design_id IS NOT NULL
GROUP BY design_id;

SELECT Super_id, COUNT(designer_id) AS Number_Of_Employees FROM Designer
WHERE Super_id IS NOT NULL
GROUP BY Super_id;

SELECT Cust_id, COUNT(order_num) AS Total_Orders FROM Cust_Order
GROUP BY Cust_id
HAVING COUNT(order_num) > 1;

SELECT * FROM Designer 
WHERE Exp > (SELECT AVG(Exp) FROM Designer);

SELECT name FROM Customer 
WHERE Cust_id IN (SELECT Cust_id FROM Bag WHERE Color = 'Red');

SELECT office_num, location FROM Office 
WHERE designer_id IN (SELECT designer_id FROM Designer WHERE Exp < 4);

SELECT D.Fname, D.Lname, O.office_num, O.location
FROM Designer D
INNER JOIN Office O ON D.designer_id = O.designer_id;

SELECT D.Fname, D.Lname, O.office_num 
FROM Designer D
LEFT JOIN Office O ON D.designer_id = O.designer_id;

SELECT C.name AS Customer_Name, B.model AS Bag_Model, D.Fname AS Designer_Name
FROM Bag B
INNER JOIN Customer C ON B.Cust_id = C.Cust_id
INNER JOIN Designer D ON B.design_id = D.designer_id;

SELECT Emp.Fname AS Employee_Name, Super.Fname AS Supervisor_Name
FROM Designer Emp
INNER JOIN Designer Super ON Emp.Super_id = Super.designer_id;

INSERT INTO Raw_Material (mat_Code, name) 
VALUES (305, 'Silver Buckle');

UPDATE Designer 
SET Exp = 3 
WHERE Fname = 'Omar';

UPDATE Bag 
SET Color = 'Dark Black' 
WHERE model = 'Classic Tote';

DELETE FROM Cust_Phone 
WHERE Phone = '01298765432';

DELETE FROM Raw_Material 
WHERE mat_Code = 305;