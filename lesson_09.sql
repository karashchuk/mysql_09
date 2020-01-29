-- Практическое задание по теме “Транзакции, переменные, представления”
-- 1.	В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
create database sample;
use sample;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

START TRANSACTION;
insert into sample.users 
	select * from shop.users where id = 1;
commit;

-- 2.	Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.
create view w_products as 
	select 
		p.name as prod_name,
		c.name as cat_name
	from shop.products p
	left join shop.catalogs c on p.catalog_id = c.id;

select * from w_products;

-- 3.	по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
-- Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
CREATE TABLE tests (
  id SERIAL PRIMARY KEY,
  something VARCHAR(32),
  created_at DATE);
  
insert into tests (something, created_at) values
	('s1','2018-08-01'),
	('s2','2016-08-04'),
	('s3','2018-08-16'), 
	('s4','2018-08-17');
	
CREATE TABLE august (
  monthday DATE);
  
insert into august values 
	('2018-08-01'), ('2018-08-02'), ('2018-08-03'), ('2018-08-04'), ('2018-08-05'),('2018-08-06'),('2018-08-07'),
	('2018-08-08'), ('2018-08-09'),	('2018-08-10'),	('2018-08-11'),	('2018-08-12'),	('2018-08-13'),	('2018-08-14'),
	('2018-08-15'),	('2018-08-16'),	('2018-08-17'),	('2018-08-18'),	('2018-08-19'),	('2018-08-20'),	('2018-08-21'),
	('2018-08-22'),	('2018-08-23'),	('2018-08-24'),	('2018-08-25'),	('2018-08-26'),	('2018-08-27'),	('2018-08-28'),
	('2018-08-29'),	('2018-08-30'),	('2018-08-31');

select monthday, if (created_at is not null,1,0) as 'is' 
from august
left join tests on monthday = created_at
order by monthday ;

-- 4.	(по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей
DROP TABLE if EXISTS newrows;
CREATE TABLE newrows (
  id SERIAL PRIMARY KEY,
  created_at DATE);
INSERT INTO newrows SELECT NULL, monthday FROM august; 

WITH top5 AS
 (SELECT created_at FROM newrows ORDER BY created_at DESC LIMIT 5)
delete FROM newrows WHERE created_at not IN (SELECT * FROM top5);

-- Практическое задание по теме “Администрирование MySQL” (эта тема изучается по вашему желанию)
-- 1.	Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.
create user shop_read IDENTIFIED BY '123456';
GRANT SELECT ON shop.* TO shop_read;

create user shop IDENTIFIED BY '123456';
GRANT ALL ON shop.* TO shop;
GRANT GRANT OPTION ON shop.* TO shop;

-- 2.	(по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, имя пользователя и его пароль. 
-- Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. Создайте пользователя user_read, который бы не имел доступа к таблице accounts, 
-- однако, мог бы извлекать записи из представления username.
use sample;
create table accounts (
  id SERIAL PRIMARY KEY,
  `name` VARCHAR(32),
  `password` VARCHAR(32)
);

insert into accounts values 
(null, 'user1', '123456'),
(null, 'user2', '456789');

create view username as select id,name from accounts;
select * from username;

create user user_read IDENTIFIED BY '123456';
GRANT SELECT ON sample.username TO user_read;

-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- 1.	Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DELIMITER //
DROP FUNCTION IF EXISTS hello;
CREATE function hello()
RETURNS VARCHAR(16) DETERMINISTIC 
BEGIN
  DECLARE timenow TIME;
  SET timenow = DATE_FORMAT(NOW(), "%H:%i:%s");
	IF (timenow <= '06:00:00') THEN
  		RETURN 'Доброй ночи!';
	ELSEIF  (timenow <= '12:00:00') THEN
	  	RETURN 'Доброе утро!';
	ELSEIF  (timenow <= '18:00:00') THEN
	  	RETURN 'Добрый день!';
	ELSE 
	  	RETURN 'Добрый вечер!';
	END IF;
END//

-- 2.	В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. 
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.
DELIMITER //
DROP TRIGGER if EXISTS check_product_insert //
CREATE TRIGGER check_product_insert BEFORE insert ON products
FOR EACH ROW BEGIN
  IF (NEW.name is NULL) AND (NEW.description is NULL) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Должно быть как минимум либо название либо описание';
  END IF;
END//

DROP TRIGGER if EXISTS check_product_update //
CREATE TRIGGER check_product_update BEFORE update ON products
FOR EACH ROW BEGIN
  IF (NEW.name is NULL) AND (NEW.description is NULL) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Должно быть как минимум либо название либо описание';
  END IF;
END//

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  (null, null, 9890.00, 1);
  
-- 3.	(по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.

DELIMITER //
DROP FUNCTION IF EXISTS FIBONACCI;
CREATE function FIBONACCI(num INT)
RETURNS INT UNSIGNED DETERMINISTIC 
BEGIN
  DECLARE n,f1,f2,f INT UNSIGNED;
  SET f1 = 0;
  SET f2 = 1;
  SET n = 2;
	IF (num <=1) THEN
  		RETURN num;
	ELSE
		while n <= num DO
		set f = f1 + f2;
		SET f1 = f2;
		SET f2 = f;
		SET n = n + 1;
		END while;
	  	RETURN f;
	END IF;
END//

