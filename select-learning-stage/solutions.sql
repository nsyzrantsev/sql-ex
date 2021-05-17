-- exercise 1
SELECT model, speed, hd
FROM PC
WHERE price < 500;

-- exericse 2
SELECT DISTINCT maker
FROM Product
WHERE type = 'Printer'
