CREATE DATABASE ManisTermProjectDB;
GO

USE ManisTermProjectDB;

/* Create Tables */
/* State Fees Table */
CREATE TABLE STATEFEES
(
    [State] NVARCHAR(2) NOT NULL,
    Tax FLOAT(10) DEFAULT(0.00),
    ShippingCharges FLOAT(5) DEFAULT(6.00),

    /* Table Constraints */
    CONSTRINAT StateFeesPK PRIMARY KEY([State])
)

/* Customer Table */
CREATE TABLE CUSTOMER
(
    CustomerID INT NOT NULL,
    FirstName NVARCHAR(20) NOT NULL,
    LastName NVARCHAR(20) NOT NULL,
    CustomerAddress NVARCHAR(20) NOT NULL,
    City NVARCHAR(20) NOT NULL,
    [State] NVARCHAR(2) NOT NULL,
    Zip INT NOT NULL,

    /* Table Constraints */
    CONSTRAINT CustomerPK PRIMARY KEY(CustomerID),
    CONSTRAINT CustomerStateFK FOREIGN KEY([State]) REFERENCES STATEFEES([State])
)

/* Inventory Table */
CREATE TABLE INVENTORY
(
    ItemID INT NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    Category NVARCHAR(100) NULL,
    QuantityOnHand INT NOT NULL,
    UnitPricing FLOAT(10) NOT NULL,

    /* Table Constraints */
    CONSTRAINT InventoryPK PRIMARY KEY(ItemID)
)

/* Supplier Table */
CREATE TABLE SUPPLIER
(
    SupplierID INT NOT NULL

    /* Table Constraints */
    CONSTRAINT SupplierPK PRIMARY KEY(SupplierID)
)

/* Supplier Phone Table */
CREATE TABLE SUPPLIERPHONE
(
    PhoneID INT NOT NULL,
    SupplierID INT NOT NULL,
    PhoneNumber NCARCHAR(20) NOT NULL,
    PhoneType NVARCHAR(20) NULL,

    /* Table Constraints */
    CONSTRAINT SupplierPhonePK PRIMARY KEY(PhoneID, SupplierID),
    CONSTRAINT SupplierPhoneFK FOREIGN KEY(SupplierID) REFERENCES Supplier(SupplierID)
)

/* Order Table */
CREATE TABLE [ORDER]
(
    OrderID INT NOT NULL,
    CustomerID INT NOT NULL,
    [Date] DATE NOT NULL,
    PaymentInfo NVARCHAR(20) NOT NULL,
    ShippingStatus NVARCHAR(20) NOT NULL,

    /* Table Constraints */
    CONSTRAINT OrderPK PRIMARY KEY(OrderID),
    CONSTRAINT OrderCustomerFK FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
	    ON DELETE NO ACTION ON UPDATE NO ACTION
)

/* Order Detail Table */
CREATE TABLE ORDERDETAIL
(
    OrderID INT NOT NULL,
    ItemID INT NOT NULL,
    UnitPrice FLOAT(20) NOT NULL,
    Quantity INT NOT NULL,

    /* Table Constraints */
    CONSTRAINT OrderDetailPK PRIMARY KEY(OrderID, ItemID),
    CONSTRAINT OrderDetailOrderFK FOREIGN KEY(OrderID) REFERENCES [Order](OrderID)
	    ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT OrderDetailInventoryFK FOREIGN KEY(ItemID) REFERENCES Inventory(ItemID)
		ON DELETE NO ACTION ON UPDATE NO ACTION
)

/* Warehouse Table */
CREATE TABLE WAREHOUSE
(
    ItemID INT NOT NULL,
    SupplierID INT NOT NULL,
    QuantityOnHand INT NOT NULL,

    /* Table Constraints */
    CONSTRAINT WareHousePK PRIMARY KEY(ItemID, SupplierID),
    CONSTRAINT WareHouseInventoryFK FOREIGN KEY(ItemID) REFERENCES Inventory(ItemID)
	    ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT WareHouseSupplierFK FOREIGN KEY(SupplierID) REFERENCES Supplier(SupplierID)
        ON DELETE NO ACTION ON UPDATE NO ACTION       
)

/* Populate Tables With Data */
/* State Fees Table */
INSERT INTO STATEFEES
    ([State], Tax, ShippingCharges)

VALUES
    ('AL', DEFAULT, DEFAULT),
    ('AK', DEFAULT, 8.00),
    ('AZ', DEFAULT, DEFAULT),
    ('AR', DEFAULT, DEFAULT),
    ('CA', 8.25, DEFAULT),
    ('CO', DEFAULT, DEFAULT),
    ('CT', DEFAULT, DEFAULT),
    ('DE', DEFAULT, DEFAULT),
    ('FL', DEFAULT, DEFAULT),
    ('GA', DEFAULT, DEFAULT),
    ('HI', DEFAULT, 8.00),
    ('ID', DEFAULT, DEFAULT),
    ('IL', DEFAULT, DEFAULT),
    ('IN', DEFAULT, DEFAULT),
    ('IA', DEFAULT, DEFAULT),
    ('KS', DEFAULT, DEFAULT),
    ('KY', DEFAULT, DEFAULT),
    ('LA', DEFAULT, 4.00),
    ('ME', DEFAULT, DEFAULT),
    ('MD', DEFAULT, DEFAULT),
    ('MA', DEFAULT, DEFAULT),
    ('MI', DEFAULT, DEFAULT),
    ('MN', DEFAULT, DEFAULT),
    ('MS', DEFAULT, DEFAULT),
    ('MO', DEFAULT, DEFAULT),
    ('MT', DEFAULT, DEFAULT),
    ('NE', DEFAULT, DEFAULT),
    ('NV', DEFAULT, DEFAULT),
    ('NH', DEFAULT, DEFAULT),
    ('NJ', DEFAULT, DEFAULT),
    ('NM', DEFAULT, 4.00),
    ('NY', DEFAULT, DEFAULT),
    ('NC', DEFAULT, DEFAULT),
    ('ND', DEFAULT, DEFAULT),
    ('OH', DEFAULT, DEFAULT),
    ('OK', DEFAULT, 4.00),
    ('OR', DEFAULT, DEFAULT),
    ('PA', DEFAULT, DEFAULT),
    ('RI', DEFAULT, DEFAULT),
    ('SC', DEFAULT, DEFAULT),
    ('SD', DEFAULT, DEFAULT),
    ('TN', DEFAULT, DEFAULT),
    ('TX', 6.25, 4.00),
    ('UT', DEFAULT, DEFAULT),
    ('VT', DEFAULT, DEFAULT),
    ('VA', DEFAULT, DEFAULT),
    ('WA', DEFAULT, DEFAULT),
    ('WV', DEFAULT, DEFAULT),
    ('WI', DEFAULT, DEFAULT),
    ('WY', DEFAULT, DEFAULT)

/* Customer Data */
INSERT INTO CUSTOMER
    (CustomerID, FirstName, LastName, CustomerAddress, City, [State], zip)

VALUES
    (1, 'John', 'Smith', '123 Some Street', 'Killeen', 'TX', 76543),
    (2, 'Jane', 'Doe', '456 Another Street', 'Los Angeles', 'CA', 98765),
    (3, 'Adam', 'Robins', '321 Your Street', 'New York City', 'NY', 10001),
    (4, 'Alice', 'Fisher', '654 MadeUp Street', 'Denver', 'CO', 80014),
    (5, 'Bob', 'Hansen', '9987 This Street', 'Anchorage', 'AK', 99501),
    (6, 'Betty', 'White', '135 Lovely Lane', 'Oklahoma City', 'OK', 73008),
    (7, 'Daniel', 'Day-Lewis', '975 Another Ave.', 'Santa Fe', 'NM', 87501),
    (8, 'Debbie', 'Robinson', '357 My Lane', 'New Orleans', 'LA', 70032),
    (9, 'Eric', 'Clapton', '284 Some Ave.', 'Seattle', 'WA', 98101),
    (10, 'Emily', 'Ross', '672 Great Ave.', 'Pittsburgh', 'PA', 15106)

/* Inventory Data */
INSERT INTO INVENTORY
    (ItemID, [Description], Category, QuantityOnHand,UnitPricing)

VALUES
    (1, 'Dish Soap', 'Sanitation', 100, 2.99),
    (2, 'Desk', 'Home/Furniture', 999, 99.99),
    (3, 'Dog Food', 'Pet Supplies', 888, 29.99),
    (4, 'Lawn Chair', 'Home/Lawn', 777, 24.99),
    (5, 'Hat', 'Clothing', 666, 19.99),
    (6, 'Coffee Table', 'Home/Furniture', 555, 149.99),
    (7, 'Electric Guitar', 'Music/Instruments', 444, 149.99),
    (8, 'Phone Case', 'Phone Accessories', 333, 14.99),
    (9, 'Coffee Maker', 'Home/ Kitchen', 222, 24.99),
    (10, 'Laptop', 'Electronics', 111, 499.99)

/* Supplier Data */
INSERT INTO SUPPLIER
    (SupplierID)

VALUES
    (1001),
    (1002),
    (1003),
    (1004),
    (1005),
    (1006)

/* Supplier Phone Data */
INSERT INTO SUPPLIERPHONE
    (SupplierID, PhoneID, PhoneNumber, PhoneType)

VALUES
    (1001, 1, '(254) 555-1234', 'Sales'),
    (1001, 2, '(254) 555-2345', 'Shipping'),
    (1001, 3, '(254) 555-3456', 'Billing'),
    (1002, 4, '(720) 555-1234', 'Sales'),
    (1002, 5, '(720) 555-2345', 'Shipping'),
    (1003, 6, '(562) 555-1234', 'Sales'),
    (1004, 7, '(413) 555-1234', 'Sales'),
    (1004, 8, '(413) 555-2345', 'Shipping'),
    (1005, 9, '(776) 555-1234', 'Sales'),
    (1006, 10, '(812) 555-1234', 'Sales')

/* Order Data */
INSERT INTO [ORDER]
    (OrderID, CustomerID, [Date], PaymentInfo, ShippingStatus)

VALUES
    (1, 2, '1 Jan 2021', 'Paid', 'Shipped'),
    (2, 4, '2 Jan 2021', 'Pending', 'Not-Shipped'),
    (3, 6, '3 Jan 2021', 'Paid', 'Pending-Shipment'),
    (4, 8, '4 Jan 2021', 'Pending', 'Not-Shipped'),
    (5, 10, '5 Jan 2021', 'Paid', 'Shipped'),
    (6, 2, '6 Feb 2021', 'Pending', 'Not-Shipped'),
    (7, 4, '7 Feb 2021', 'Paid', 'Pending-Shipment'),
    (8, 6, '8 Feb 2021', 'Pending', 'Not-Shipped'),
    (9, 8, '9 Feb 2021', 'Paid', 'Shipped'),
    (10, 9, '10 Feb 2021', 'Pending', 'Not-Shipped')

/* Warehouse Data */
INSERT INTO WAREHOUSE
    (ItemID, SupplierID, QuantityOnHand)

VALUES
    (1, 1001, 100),
    (2, 1001, 999),
    (3, 1001, 888),
    (4, 1002, 777),
    (5, 1002, 666),
    (6, 1003, 555),
    (7, 1004, 444),
    (8, 1004, 333),
    (9, 1005, 222),
    (10, 1006, 111)

/* Order Detail Data */
INSERT INTO ORDERDETAIL
    (OrderID, ItemID, UnitPrice, Quantity)

VALUES
    (1, 10, 499.99, 1),
    (2, 9, 24.99, 1),
    (3, 8, 14.99, 1),
    (4, 7, 149.99, 1),
    (5, 6, 149.99, 1),
    (6, 5, 19.99, 2),
    (7, 4, 49.99, 4),
    (8, 3, 29.99, 1),
    (9, 2, 99.99, 1),
    (10, 1, 2.99, 3)
GO

/* Queries & Views */
/* QUERY #1: "Get Extended Price */
CREATE FUNCTION GetExtendedPrice(@Order INT, @LineItem INT)

    /* Returns Monetary Value */
    RETURNS MONEY AS
        BEGIN
            DECLARE @answer MONEY
	        SELECT @answer = (UnitPrice * Quantity)
            FROM ORDERDETAIL 
                WHERE OrderID = @Order AND ItemID = @LineItem
	        RETURN @Answer;
        END
GO

/* Run Query */
SELECT dbo.GetExtendedPrice(7, 4) FROM OrderDetail;
GO

/* QUERY #2: Get Customer Activity */
CREATE FUNCTION GetCustomerActivityByID (@ID INT)
RETURNS TABLE AS
    RETURN

    SELECT CustomerID,[Date], PaymentInfo, ShippingStatus
    FROM [ORDER] 
        JOIN ORDERDETAIL 
            ON ORDERDETAIL.OrderID = [ORDER].OrderID
                WHERE CustomerID = @ID
GO

/* Run Query */
SELECT * FROM GetCustomerActivityByID(2);
GO

/* QUERY #3: Calculate Total Cost */
CREATE FUNCTION TotalCost (@ID INT)
RETURNS TABLE AS
    RETURN

    SELECT c.CustomerID, c.[State], UnitPrice, Quantity, s.Tax, s.ShippingCharges, (((UnitPrice * Quantity) * (Tax / 100)) + (UnitPrice * Quantity) + (ShippingCharges)) AS OrderTotal
    FROM CUSTOMER AS C

        /* Join Tables */
        JOIN [ORDER] AS O
            ON c.CustomerID = O.CustomerID

        JOIN ORDERDETAIL AS ord
            ON o.OrderID = ord.OrderID

        JOIN STATEFEES AS S
            ON C.[State] = s.[State]
                WHERE @ID = O.OrderID;
GO

/* QUERY #4: Calculate Sales by Month */
CREATE FUNCTION SalesByMonth ()
RETURNS TABLE AS
    RETURN

    SELECT O.OrderID, CustomerID,[Date],ItemID, UnitPrice, Quantity 
    FROM [ORDER] AS O
        JOIN OrderDetail AS ORD
            ON ORD.OrderID = O.orderID;
GO

/* Run Query */
SELECT * FROM SalesByMonth();
GO

/* QUERY #5: View Sales by Category*/
CREATE View SalesByCategory AS

    SELECT DISTINCT Category, Inventory.ItemID, UnitPricing, OrderID, Quantity, (UnitPricing * Quantity) AS total
    FROM INVENTORY 
        INNER JOIN ORDERDETAIL
            ON INVENTORY.ItemID = ORDERDETAIL.ItemID;
GO

/* Run Query */
SELECT * FROM SalesByCategory;
GO

 /* Drop Order, If Needed */
	/* 
	Drop function GetExtendedPrice;
	Drop function SalesByMonth;
	Drop table WareHouse;
	Drop table OrderDetail;
	Drop table [Order];
	Drop table StateFees;
	Drop table SupplierPhone;
	Drop table Inventory;
	Drop table Customer;
	Drop table Supplier; 
	*/