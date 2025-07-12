CREATE TABLE Customers (
	customer_id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	email VARCHAR(150) UNIQUE NOT NULL,
	region VARCHAR(50) NOT NULL,
	signup_date DATE NOT NULL
);

CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0)
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(50) DEFAULT 'Completed',
    total_amount NUMERIC(10,2) NOT NULL CHECK (total_amount >= 0),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
    payment_method VARCHAR(50) NOT NULL,
    status VARCHAR(50) DEFAULT 'Successful',
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Returns (
    return_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    return_date DATE NOT NULL,
    reason VARCHAR(255),
    amount_refunded NUMERIC(10,2) NOT NULL CHECK (amount_refunded >= 0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL,
    region VARCHAR(50)
);
----------------------
INSERT INTO Customers (name, email, region, signup_date) VALUES
('Chinedu Okafor', 'chinedu.okafor@gmail.com', 'Lagos', '2022-01-15'),
('Aisha Bello', 'aisha.bello@yahoo.com', 'Abuja', '2022-03-22'),
('Emeka Nwosu', 'emeka.nwosu@gmail.com', 'Port Harcourt', '2022-06-18'),
('Yetunde Adebayo', 'yetunde.adebayo@yahoo.com', 'Ibadan', '2022-09-05'),
('Fatima Yusuf', 'fatima.yusuf@gmail.com', 'Kaduna', '2023-01-11'),
('Babatunde Ade', 'babatunde.ade@gmail.com', 'Lagos', '2023-03-25'),
('Ngozi Umeh', 'ngozi.umeh@gmail.com', 'Enugu', '2023-04-08'),
('Usman Lawal', 'usman.lawal@gmail.com', 'Abuja', '2023-05-12'),
('Olumide Ogunleye', 'olumide.ogunleye@gmail.com', 'Ibadan', '2023-06-30'),
('Halima Musa', 'halima.musa@gmail.com', 'Kano', '2023-07-04');

INSERT INTO Products (name, category, price, stock_quantity) VALUES
('Infinix Hot 30', 'Electronics', 125000, 150),
('Samsung Galaxy A14', 'Electronics', 185000, 120),
('Tecno Spark 10', 'Electronics', 105000, 200),
('Omo Detergent 2kg', 'Household', 4500, 500),
('Dangote Spaghetti 500g', 'Groceries', 500, 800),
('Golden Penny Semovita 5kg', 'Groceries', 4200, 300),
('Haier Thermocool Freezer', 'Home Appliances', 320000, 50),
('HP Laptop 14"', 'Computers', 280000, 70),
('Mouka Foam Mattress', 'Home & Living', 95000, 90),
('Nokia 3310', 'Electronics', 18000, 250);

INSERT INTO Orders (customer_id, order_date, status, total_amount) VALUES
(1, '2023-04-01', 'Completed', 125000),
(2, '2023-04-03', 'Completed', 4500),
(3, '2023-04-05', 'Completed', 280000),
(4, '2023-04-06', 'Completed', 500),
(5, '2023-04-07', 'Completed', 105000),
(6, '2023-04-08', 'Completed', 4200),
(7, '2023-04-10', 'Completed', 320000),
(8, '2023-04-11', 'Completed', 185000),
(9, '2023-04-12', 'Completed', 95000),
(10, '2023-04-15', 'Completed', 18000);


INSERT INTO Order_Items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 125000),
(2, 4, 1, 4500),
(3, 8, 1, 280000),
(4, 5, 1, 500),
(5, 3, 1, 105000),
(6, 6, 1, 4200),
(7, 7, 1, 320000),
(8, 2, 1, 185000),
(9, 9, 1, 95000),
(10, 10, 1, 18000);


INSERT INTO Payments (order_id, payment_date, amount, payment_method, status) VALUES
(1, '2023-04-01', 125000, 'Bank Transfer', 'Successful'),
(2, '2023-04-03', 4500, 'Card', 'Successful'),
(3, '2023-04-05', 280000, 'Bank Transfer', 'Successful'),
(4, '2023-04-06', 500, 'USSD', 'Successful'),
(5, '2023-04-07', 105000, 'Card', 'Successful'),
(6, '2023-04-08', 4200, 'Bank Transfer', 'Successful'),
(7, '2023-04-10', 320000, 'Bank Transfer', 'Successful'),
(8, '2023-04-11', 185000, 'Card', 'Successful'),
(9, '2023-04-12', 95000, 'USSD', 'Successful'),
(10, '2023-04-15', 18000, 'Bank Transfer', 'Successful');

INSERT INTO Returns (order_id, return_date, reason, amount_refunded) VALUES
(2, '2023-04-10', 'Damaged item', 4500),
(5, '2023-04-15', 'Wrong item sent', 105000),
(9, '2023-04-20', 'Customer changed mind', 95000);

INSERT INTO Employees (name, role, region) VALUES
('Ifeanyi Chukwu', 'Support Agent', 'Lagos'),
('Aminat Salami', 'Support Agent', 'Abuja'),
('Emmanuel Ojo', 'Operations Manager', 'Lagos'),
('Mary Okon', 'Support Agent', 'Port Harcourt'),
('Ibrahim Abdullahi', 'Support Agent', 'Kano'),
('Tosin Adeola', 'Customer Success Manager', 'Ibadan'),
('Adaeze Okeke', 'Support Agent', 'Enugu'),
('Samuel Eze', 'Logistics Manager', 'Lagos'),
('Fatimah Ahmed', 'Support Agent', 'Kaduna'),
('Kingsley Nwachukwu', 'Finance Analyst', 'Abuja');
