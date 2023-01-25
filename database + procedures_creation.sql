--Section 1: tables creation--
--1 Creating the 'customer' table and inserting values into it:--

DROP TABLE IF EXISTS customer;
CREATE TABLE customer
(customer_id SERIAL NOT NULL PRIMARY KEY,
customer_sname varchar(20) NOT NULL,
customer_fname varchar(20) NOT NULL,
address varchar(90) NOT NULL,
telephone varchar(15) NOT NULL,
birth_date date NOT NULL,
bank_name varchar(30) NOT NULL,
bank_address varchar(90) NOT NULL,
sort_code varchar(6) NOT NULL,
account_no varchar(15) NOT NULL
);



INSERT INTO customer(customer_sname,customer_fname,address,telephone,birth_date,bank_name,bank_address,sort_code,account_no) VALUES
('Ahmed', 'Husam', 'Sudan-Khartoum-Jabra 12','00249363454642','1992-09-12',
	'Bank of Sunderland','UK-England-Sunderland 12','928352','87017462719'),
('Mann', 'Jack', 'Germany-Hamburg-Strasse 34','00498282811234','1998-09-12',
	'Bank of Deutschland','DE-Hamburg-Strasse 34','759374','66492183837'),
('Reiner','Sonic', 'UK-England-Manchester 65','00249763818327','1987-02-13',
	'Eggman Bank','UK-England-Manchester 43','987123','18763629182'),
('Karl', 'Eggman', 'Norway-Oslo-Strasse 98','0011972647382','1976-08-04',
	'Eggman Bank','Norway-Oslo-Strasse 11','123876','76389124762'),
('CJ', 'Punko', 'USA-New York-Townsville 90','001987374738','2000-01-23',
	'Bank of New York','USA-New York-Townsville 11','432984','98087126471');




--2 Creating the 'product' table and inserting values into it:--

DROP TABLE IF EXISTS product;
CREATE TABLE product
(product_id SERIAL NOT NULL PRIMARY KEY,
product_name varchar(30) NOT NULL,
product_category varchar(15) NOT NULL,
product_cost decimal
);


INSERT INTO product(product_name,product_category,product_cost) VALUES
('Drum', 'Instrument', '50.00'),
('Electric Juitar','Instrument', '100.00'),
('Microphone', 'Instrument', '30.00'),
('Wireless Microphone', 'Instrument' , '50.00'),
('1001 Inventions', 'Book', '20.00');




--3 Creating the 'transactions' table and inserting values into it:--

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions
(transaction_id SERIAL NOT NULL PRIMARY KEY,
customer_id integer NOT NULL ,
product_id integer NOT NULL,
product_name varchar(30) NOT NULL,
product_category varchar(15) NOT NULL,
product_cost decimal,
payment_method varchar(20) NOT NULL,
purchase_type varchar(20),
delivery_date timestamp,
store_id integer NOT NULL,
purchase_date timestamp NOT NULL,
FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOrEIGN KEY (product_id) REFERENCES product(product_id)
);


INSERT INTO transactions(customer_id,product_id,product_name,product_category,product_cost,payment_method,purchase_type,delivery_date,store_id,purchase_date) VALUES
('1', '5','1001 Inventions', 'Book', 20.00, 'Cash','On Store', '2022-09-19 04:00 PM','1','2022-09-12'),
('2', '2','Electric Juitar','Instrument',100.00,'Cash','On Store', '2021-08-19 04:00 PM','2','2021-08-12'),
('1', '1','Drum','Instrument',50.00,'Credit Card','Online','2021-12-29 01:00 PM','3','2021-12-22'),
('3', '3','Microphone','Instrument',30.00,'Credit Card','Online','2020-12-18 02:00 PM','4','2020-12-11'),
('3', '4','Wireless Microphone','Instrument',50.00,'Credit Card','On Store','2020-05-19 11:00 AM','5','2020-05-12'),
('1', '5','1001 Inventions', 'Book',20.00, 'Credit Card','Online','2022-09-19 04:00 PM','1','2022-09-12'),
('2', '2','Electric Juitar','Instrument',100.00,'Credit Card','Online','2021-08-19 05:00 PM','2','2021-08-12'),
('5', '1','Drum','Instrument',50.00,'Credit Card','Online','2021-12-29 05:00 PM','3','2021-12-22'),
('4', '3','Microphone','Instrument',30.00,'Credit Card','Online','2020-12-18 10:00 AM','4','2020-12-11'),
('5', '4','Wireless Microphone','Instrument', 50.00,'Credit Card','Online','2020-05-19 09:00 AM','5','2020-05-12');






--4 Creating the 'store' table and inserting values into it:--

DROP TABLE IF EXISTS store;
CREATE TABLE store
(store_id SERIAL NOT NULL PRIMARY KEY,
store_name varchar(30) NOT NULL,
store_city varchar(15) NOT NULL,
store_address varchar(50) NOT NULL,
telephone varchar(15) NOT NULL,
latitude decimal NOT NULL,
longitude decimal NOT NULL
);


INSERT INTO store(store_name,store_city,store_address,telephone,latitude,longitude) VALUES
('MME Khartoum', 'Khartoum', 'Jabra Street 19', '1726916', -123.1235 , 12.456),
('MME Portsudan', 'Portsudan', 'Hambu Steet 87', '1772638',-192.8723,82.987),
('MME Dongola', 'Dongola' , 'Coco Street 11', '1798620',-119.8723,73.987),
('MME Kasala', 'Kasala', 'Uchiha Street 13', '1773071',-101.8723,92.987);



--5 Creating the 'warehouse_item' table and inserting values into it:--

DROP TABLE IF EXISTS warehouse_item;
CREATE TABLE warehouse_item
(warehouse_id varchar(3) NOT NULL,
store_id integer NOT NULL,
product_id integer NOT NULL,
product_qty integer NOT NULL,
PRIMARY KEY (warehouse_id,product_id),
FOREIGN KEY (product_id) REFERENCES product(product_id),
FOREIGN KEY (store_id) REFERENCES store(store_id)
);


INSERT INTO warehouse_item VALUES
('1','1','1', 7000),
('1','1','2',2000),
('1','1','3', 3000),
('1','1','4', 2000),
('1','1','5', 3500),
('2','2','1', 7000),
('2','2','2',2000),
('2','2','3', 3000),
('2','2','4', 2000),
('2','2','5', 3500),
('3','3','1', 7000),
('3','3','2',2000),
('3','3','3', 3000),
('3','3','4', 2000),
('3','3','5', 3500),
('4','4','1', 7000),
('4','4','2',2000),
('4','4','3', 3000),
('4','4','4', 2000),
('4','4','5', 3500);


--Section 2: Stored procedures creations--
--1 A PL/pgSQL stored procedure  which allows for registration of new customers--

CREATE OR REPLACE PROCEDURE new_customer (sname customer.customer_sname%TYPE,fname customer.customer_fname%TYPE,
addr customer.address%TYPE,tele customer.telephone%TYPE,birth customer.birth_date%TYPE,bankename customer.bank_name%TYPE,
bankaddress customer.bank_address%TYPE,sortcode customer.sort_code%TYPE,accountno customer.account_no%TYPE)
LANGUAGE 'plpgsql'
AS
$BODY$
BEGIN
INSERT INTO customer(customer_sname,customer_fname,address,telephone,birth_date,bank_name,bank_address,sort_code,account_no)
 VALUES (sname, fname,addr,tele, birth, bankename, bankaddress, sortcode, accountno);
END;
$BODY$

--Trigger function that checks if the customer already exists, if yes insert is aborted, else the insert takes place--
CREATE OR REPLACE FUNCTION insert_error() RETURNS TRIGGER
LANGUAGE 'plpgsql'
AS 
$BODY$
BEGIN

--Checking if the customer already exists in the customer table--
IF EXISTS (SELECT * from customer where customer_sname = new.customer_sname  and customer_fname = new.customer_fname and address = new.address and telephone = new.telephone 
and birth_date = new.birth_date and bank_name = new.bank_name and bank_address = new.bank_address and sort_code = new.sort_code and account_no = new.account_no)
THEN RAISE NOTICE 'The customer you are trying to insert already exists!.';
RETURN NULL;

--Checking if any of the inserted values is null or spaces value--
ELSIF ((new.customer_sname IS NULL  or nullif(trim(new.customer_sname ), '') is NULL)  or  (new.customer_fname IS NULL or nullif(trim(new.customer_fname ), '') is NULL) or
 (new.address IS NULL or nullif(trim(new.address), '') is NULL) or  (new.telephone IS NULL or nullif(trim(new.telephone ), '') is NULL)
or (new.birth_date IS NULL) or  (new.bank_name IS NULL or nullif(trim(new.bank_name ), '') is NULL) or
  (new.bank_address IS NULL or nullif(trim(new.bank_address ), '') is NULL) or  (new.sort_code IS NULL or nullif(trim(new.sort_code ), '') is NULL) or
    (new.account_no IS NULL or TRIM(new.account_no) IS NULL))
THEN RAISE NOTICE 'Null and empty values are not allowed!';
RETURN NULL;

--Successful insertion displays a message--
ELSE RAISE NOTICE 'A new customer has been successfully inserted into the customer table!';
RETURN new;
END IF;
END;
$BODY$

--Creating the trigger before insert on table customer--
DROP TRIGGER IF EXISTS check_insert on customer;
CREATE TRIGGER check_insert
BEFORE INSERT ON customer
FOR EACH ROW
EXECUTE PROCEDURE insert_error();



--testing the stored procesdure with valid customer details' input leading to successful registeration of a new customer:--
CALL new_customer('Crash', 'Bandicoot', 'Wumba-Khartoum-Jabra 12','0024936334342','1992-08-04',
	'Bank of Cortex','Wumba-England-Sunderland 12','923452','87017862719')

--testing the stored procedure with input that prevents insertion when the customer already exists:--
CALL new_customer('Ahmed', 'Husam', 'Sudan-Khartoum-Jabra 12','00249363454642','1992-09-12',
	'Bank of Sunderland','UK-England-Sunderland 12','928352','87017462719')

--testing the stored procedure with spaces value that prevents insertion:--
CALL new_customer('', 'Husam', 'Sudan-Khartoum-Jabra 12','00249363454642','1992-09-12',
	'Bank of Sunderland','UK-England-Sunderland 12','928352','87017462719')














--2 A PL/pgSQL stored procedure which allows an existing customer to purchase a product:--


CREATE OR REPLACE PROCEDURE product_purchase (custid customer.customer_id%TYPE, storename store.store_name%TYPE, pname product.product_name%TYPE, paymeth transactions.payment_method%TYPE, delivery transactions.delivery_date%TYPE)
LANGUAGE 'plpgsql'
AS
$BODY$
DECLARE 
--customer related variables--
customerid customer.customer_id%TYPE;
id_count integer;

--product related variables--
productid product.product_id%TYPE;
productname product.product_name%TYPE;
pcat product.product_category%TYPE;
pcost product.product_cost%TYPE;
pqty warehouse_item.product_qty%TYPE;

--other variables--
storeid store.store_id%TYPE;
storen store.store_name%TYPE;
wareid warehouse_item.warehouse_id%TYPE;
purchasedate transactions.purchase_date%TYPE := Now();

BEGIN
--Fetching the customer id to add this information to the transaction--
SELECT customer_id INTO customerid FROM customer where customer_id = custid;

--Fetching the count of customer ids in the customer table--
SELECT count(customer_id) INTO id_count FROM customer;

--Fetching the product, store and warehouse details to add to the transaction--
SELECT product.product_id, product_name,product_category,product_cost,product_qty, store.store_id,store_name, warehouse_id INTO productid, productname, pcat, pcost, pqty, storeid,storen, wareid from store JOIN warehouse_item
ON store.store_id = warehouse_item.store_id JOIN product
ON product.product_id = warehouse_item.product_id
WHERE store_name = storename and product_name = pname;

--Input validation--
--Validation for invalid customer id--
IF customerid IS NULL THEN RAISE NOTICE 'The customer id you entered is invalid, please register yourself, valid ids range from 1 to %.', id_count;
END IF;
--Validation for invalid store name--
IF storen IS NULL THEN RAISE NOTICE 'The store you are looking for does not exist,Please view our store table for available stores.';
END IF;
--Validation for invalid product name--
IF productname IS NULL THEN RAISE NOTICE 'The product you are looking for does not exist; Or its possible you entered an invalid store. Please view our product and store tables for available stores and products.';
END IF;
--Validation for invalid payment method--
IF paymeth NOT LIKE 'Cash' and paymeth NOT LIKE 'Credit Card' THEN RAISE NOTICE 'Please specify the appropriate payment method, either Cash or Credit Card.';
END IF;
--Validation for invalid delivery date --
IF delivery IS NULL or CAST(delivery as date) <= CAST(purchasedate as date) THEN RAISE NOTICE 'Please specifiy a delivery date in the format YYYY-MM-DD that is at least 1 day after purchase date and a delivery time between 09:00 AM and 05:00 PM, purchase date is: %.', purchasedate;
END IF;
--Validation for invalid delivery time--
IF CAST(delivery as time) > '05:00 PM' or CAST(delivery as time) < '09:00 AM' THEN RAISE NOTICE 'The delivery time you entered % is outside of our working hours, our working hours are from 09:00 AM til 05:00 PM!', CAST(delivery as time);
END IF;
--Validation for insuffient stock--
IF pqty = 0 THEN RAISE NOTICE 'Sorry! We are currently out of stuck for this product!';
END IF;
--Finalizing the product purchase with a final validation before--
IF delivery >= (purchasedate + INTERVAL '1 day') and (CAST(delivery as time) BETWEEN '05:00 PM' and '09:00 AM') and customerid IS NOT NULL and delivery is NOT NULL and storen IS NOT NULL and productname IS NOT NULL and (paymeth LIKE 'Cash' or paymeth LIKE 'Credit Card')
 THEN RAISE NOTICE 'The product % is available. You booked the date: % for delivery, Thank you for choosing MME.', pname, delivery;

--Updating the product quantity in the warehouse after a successful purchase has been made--
UPDATE warehouse_item SET product_qty = product_qty - 1 WHERE warehouse_id = wareid and product_id = productid;
RAISE NOTICE 'The quantity of product % at the warehouse with the id % has been updated.',pname,wareid;

--Inserting the transaction into the transactions table--
INSERT INTO transactions(customer_id,product_id,product_name,product_category,product_cost,payment_method,purchase_type,delivery_date,store_id,purchase_date)
 VALUES (customerid,productid,pname,pcat,pcost,paymeth,'Online',delivery,storeid,purchasedate);
RAISE NOTICE 'A new record has been inserted to the transactions table!';
END IF;

END;
$BODY$


--testing the stored procesdure with valid input:--
CALL product_purchase(1, 'MME Kasala', 'Drum', 'Cash' , '2022-12-31 11:00 AM')

--Testing for different invalid inputs:--

--testing the stored procedure with invalid customer id:--
CALL product_purchase(100, 'MME Kasala', 'Drum', 'Cash' , '2022-12-31 11:00 AM')
--testing the stored procedure with invalid store name:--
CALL product_purchase(1, 'MME Sudan', 'Drum', 'Cash' , '2022-12-31 11:00 AM')
--testing the stored procedure with invalid product name:--
CALL product_purchase(1, 'MME Kasala', 'Car', 'Cash' , '2022-12-31 11:00 AM')
--testing the stored procedure with invalid payment method:--
CALL product_purchase(1, 'MME Kasala', 'Drum', 'Loan' , '2022-12-31 11:00 AM')
--testing the stored procedure with invalid delivery date:--
CALL product_purchase(1, 'MME Kasala', 'Drum', 'Cash' , '2022-09-30 11:00 AM')
--testing the stored procedure with invalid delivery time:--
CALL product_purchase(1, 'MME Kasala', 'Drum', 'Cash' , '2022-12-31 01:00 AM')
--testing the stored procedure without specifying a delivery time:--
CALL product_purchase(1, 'MME Kasala', 'Drum', 'Cash' , '2022-12-31')

--testing the stored procedure with all invalid inputs combined:--
CALL product_purchase(100, 'MME Sudan', 'Car', 'Loan' , '2022-10-11 01:00 AM')
