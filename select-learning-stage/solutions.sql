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
SELECT DISTINCT maker
FROM Product
WHERE type = 'PC'
EXCEPT
SELECT DISTINCT maker
FROM Product
WHERE type = 'Laptop';

-- exercise 9
SELECT DISTINCT maker
FROM Product JOIN
 PC ON PC.model = Product.model
WHERE speed >= 450;

-- exercise 10
SELECT DISTINCT model, price
FROM Printer
WHERE price = (SELECT MAX(price)
 FROM Printer);

-- exercise 11
SELECT AVG(speed)
FROM PC;

-- exercise 12
SELECT AVG(speed)
FROM Laptop
WHERE price > 1000;

-- exercise 13
SELECT AVG(speed)
FROM PC JOIN
 Product ON Product.model = PC.model
WHERE maker = 'A';

-- exercise 14
SELECT Ships.class, name, country
FROM Ships JOIN
 Classes ON Classes.class = Ships.class
WHERE numGuns >= 10;

-- exercise 15
SELECT hd
FROM PC
GROUP BY hd
HAVING COUNT(hd) >= 2;

-- exercise 16
SELECT DISTINCT A.model model_1, B.model model_2, A.speed speed_eq, A.ram ram_eq
FROM PC A, PC B
WHERE A.model > B.model AND A.speed = B.speed AND A.ram = B.ram;

-- exercise 17
SELECT DISTINCT Product.type, Laptop.model, Laptop.speed
FROM Laptop, Product
WHERE Laptop.speed < ALL (SELECT speed FROM PC) AND Product.type = 'Laptop';

-- exercise 18
SELECT maker, MIN(price)
FROM Product JOIN
 Printer ON Printer.model = Product.model
WHERE color = 'y';
