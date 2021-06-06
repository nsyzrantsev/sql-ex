## Short database description "Computer firm":

The database scheme consists of four tables:
* Product(maker, model, type)
* PC(code, model, speed, ram, hd, cd, price)
* Laptop(code, model, speed, ram, hd, screen, price)
* Printer(code, model, color, type, price)

The Product table contains data on the maker, model number, and type of product ('PC', 'Laptop', or 'Printer'). It is assumed that model numbers in the Product table are unique for all makers and product types. Each personal computer in the PC table is unambiguously identified by a unique code, and is additionally characterized by its model (foreign key referring to the Product table), processor speed (in MHz) – speed field, RAM capacity (in Mb) - ram, hard disk drive capacity (in Gb) – hd, CD-ROM speed (e.g, '4x') - cd, and its price. The Laptop table is similar to the PC table, except that instead of the CD-ROM speed, it contains the screen size (in inches) – screen. For each printer model in the Printer table, its output type (‘y’ for color and ‘n’ for monochrome) – color field, printing technology ('Laser', 'Jet', or 'Matrix') – type, and price are specified.

## Short database description "Ships":

The database of naval ships that took part in World War II is under consideration. The database consists of the following relations:
* Classes(class, type, country, numGuns, bore, displacement)
* Ships(name, class, launched)
* Battles(name, date)
* Outcomes(ship, battle, result)

Ships in classes all have the same general design. A class is normally assigned either the name of the first ship built according to the corresponding design, or a name that is different from any ship name in the database. The ship whose name is assigned to a class is called a lead ship.
The Classes relation includes the name of the class, type (can be either bb for a battle ship, or bc for a battle cruiser), country the ship was built in, the number of main guns, gun caliber (bore diameter in inches), and displacement (weight in tons). The Ships relation holds information about the ship name, the name of its corresponding class, and the year the ship was launched. The Battles relation contains names and dates of battles the ships participated in, and the Outcomes relation - the battle result for a given ship (may be sunk, damaged, or OK, the last value meaning the ship survived the battle unharmed).
Notes: 1) The Outcomes relation may contain ships not present in the Ships relation. 2) A ship sunk can’t participate in later battles. 3) For historical reasons, lead ships are referred to as head ships in many exercises.4) A ship found in the Outcomes table but not in the Ships table is still considered in the database. This is true even if it is sunk.

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
SELECT DISTINCT maker
FROM Product
WHERE type = 'PC'
EXCEPT
SELECT DISTINCT maker
FROM Product
WHERE type = 'Laptop';
```
[Code](solutions.sql#L48)

### Exercise 9

Find the makers of PCs with a processor speed of 450 MHz or more. Result set: maker.

### Solution

```sql
SELECT DISTINCT maker
FROM Product JOIN
 PC ON PC.model = Product.model
WHERE speed >= 450;
```
[Code](solutions.sql#L57)

### Exercise 10

Find the printer models having the highest price. Result set: model, price.

### Solution

```sql
SELECT DISTINCT model, price
FROM Printer
WHERE price = (SELECT MAX(price)
 FROM Printer);
```
[Code](solutions.sql#L63)

### Exercise 11

Find out the average speed of PCs.

### Solution

```sql
SELECT AVG(speed)
FROM PC;
```
[Code](solutions.sql#L69)

### Exercise 12

Find out the average speed of the laptops priced over $1000.

### Solution

```sql
SELECT AVG(speed)
FROM Laptop
WHERE price > 1000;
```
[Code](solutions.sql#L73)

### Exercise 13

Find out the average speed of the PCs produced by maker A.

### Solution

```sql
SELECT AVG(speed)
FROM PC JOIN
 Product ON Product.model = PC.model
WHERE maker = 'A';
```
[Code](solutions.sql#L78)

### Exercise 14

For the ships in the Ships table that have at least 10 guns, get the class, name, and country.

### Solution

```sql
SELECT Ships.class, name, country
FROM Ships JOIN
 Classes ON Classes.class = Ships.class
WHERE numGuns >= 10;
```
[Code](solutions.sql#L84)

### Exercise 15

Get hard drive capacities that are identical for two or more PCs.
Result set: hd.

### Solution

```sql
ELECT hd
FROM PC
GROUP BY hd
HAVING COUNT(hd) >= 2;
```
[Code](solutions.sql#L90)

### Exercise 16

Get pairs of PC models with identical speeds and the same RAM capacity. Each resulting pair should be displayed only once, i.e. (i, j) but not (j, i).
Result set: model with the bigger number, model with the smaller number, speed, and RAM.

### Solution

```sql
SELECT DISTINCT A.model model_1, B.model model_2, A.speed speed_eq, A.ram ram_eq
FROM PC A, PC B 
WHERE A.model > B.model AND A.speed = B.speed AND A.ram = B.ram;
```
[Code](solutions.sql#L96)

### Exercise 17

Get the laptop models that have a speed smaller than the speed of any PC.
Result set: type, model, speed.

### Solutions

```sql
SELECT DISTINCT Product.type, Laptop.model, Laptop.speed
FROM Laptop, Product
WHERE Laptop.speed < ALL (SELECT speed FROM PC) AND Product.type = 'Laptop';
```
[Code](solutions.sql#L101)

### Exercise 18

Find the makers of the cheapest color printers.
Result set: maker, price.

### Solutions

```sql

```
