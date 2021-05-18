-- exercise 1
SELECT model, speed, hd
FROM PC
WHERE price < 500;

-- exericse 2
SELECT DISTINCT maker
FROM Product
WHERE type = 'Printer'

-- exercise 3
SELECT model, ram, screen
FROM Laptop
WHERE price > 1000;

-- exercise 4
SELECT *
FROM Printer
WHERE color = 'y';

-- exercise 5
SELECT model, speed, hd
FROM PC
WHERE (cd = '12x' OR cd = '24x') AND price < 600;

-- exercise 6
SELECT DISTINCT maker, speed
FROM Laptop JOIN
 Product ON Product.model = Laptop.model
WHERE hd >= 10;

-- exercise 7
SELECT DISTINCT Product.model, price
FROM Product JOIN
 PC ON PC.model = Product.model
WHERE maker = 'B'
UNION
SELECT DISTINCT Product.model, price
FROM Product JOIN
 Laptop ON Laptop.model = Product.model
WHERE maker = 'B'
UNION
SELECT DISTINCT Product.model, price
FROM Product JOIN
 Printer ON Printer.model = Product.model
WHERE maker = 'B';

-- exercise 8
SELECT maker, model, type
FROM Product;
