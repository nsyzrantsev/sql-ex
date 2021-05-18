## Short database description "Computer firm":

The database scheme consists of four tables:
* Product(maker, model, type)
* PC(code, model, speed, ram, hd, cd, price)
* Laptop(code, model, speed, ram, hd, screen, price)
* Printer(code, model, color, type, price)

The Product table contains data on the maker, model number, and type of product ('PC', 'Laptop', or 'Printer'). It is assumed that model numbers in the Product table are unique for all makers and product types. Each personal computer in the PC table is unambiguously identified by a unique code, and is additionally characterized by its model (foreign key referring to the Product table), processor speed (in MHz) – speed field, RAM capacity (in Mb) - ram, hard disk drive capacity (in Gb) – hd, CD-ROM speed (e.g, '4x') - cd, and its price. The Laptop table is similar to the PC table, except that instead of the CD-ROM speed, it contains the screen size (in inches) – screen. For each printer model in the Printer table, its output type (‘y’ for color and ‘n’ for monochrome) – color field, printing technology ('Laser', 'Jet', or 'Matrix') – type, and price are specified.

### Exercise 1

Find the model number, speed and hard drive capacity for all the PCs with prices below $500.
Result set: model, speed, hd.

### Solution

```sql
SELECT model, speed, hd
FROM PC
WHERE price < 500;
```
[Code](solutions.sql#L1)

### Exercise 2

List all printer makers. Result set: maker.

### Solution

```sql
SELECT maker
FROM Product
WHERE type = 'Printer';
```
[Code](solutions.sql#L6)

### Exercise 3

Find the model number, RAM and screen size of the laptops with prices over $1000.

### Solution

```sql
SELECT model, ram, screen
FROM Laptop
WHERE price > 1000;
```
[Code](solutions.sql#L11)

### Exercise 4

Find all records from the Printer table containing data about color printers.

### Solution

```sql
SELECT *
FROM Printer
WHERE color = 'y';
```
[Code](solutions.sql#L15)

### Exercise 5

Find the model number, speed and hard drive capacity of PCs cheaper than $600 having a 12x or a 24x CD drive.

### Solution

```sql
SELECT model, speed, hd
FROM PC
WHERE (cd = '12x' OR cd = '24x') AND price < 600;
```
[Code](solutions.sql#L21)

### Exercise 6

For each maker producing laptops with a hard drive capacity of 10 Gb or higher, find the speed of such laptops. Result set: maker, speed.

### Solution

```sql
SELECT DISTINCT maker, speed
FROM Laptop JOIN
 Product ON Product.model = Laptop.model
WHERE hd >= 10;
```
[Code](solutions.sql#L26)

### Exercise 7

Get the models and prices for all commercially available products (of any type) produced by maker B.

### Solution

```sql
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
```
[Code](solutions.sql#L32)

### Exercise 8

Find the makers producing PCs but not laptops.

### Solution

```sql

```
