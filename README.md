# Database-creation-PostgreSQL
## Project Description (Scenario):

Milllie’s Musical Emporium (MME) which is a music records company, wishes to cope with their growth and allow for more efficient stock recording, the store has decided to computerise their customer management and stock recording system. You have been tasked with developing a database application to meet their needs.

The database must be able to hold details of all customers (including their name, address, telephone number, date of birth and bank details, i.e. bank name, address, sort code and account number). Records are also kept of every transaction that takes place in any of the stores.

A stock warehouse is also kept. This makes it possible to see where any given product (including its identifier, type, name, description, cost) is currently stored. The stock warehouse also contains details of all purchases and allows stores to move stock from one store to another. This is particularly useful for those customers who wish to purchase a product that is not available in their local store.

The organisation would also like to be able to create management reports, which may, for example, show all sales at a particular store or a group of stores, between certain dates.


## Tasks to do:
1-produce a single SQL script file which can be run within PostgreSQL without error and which drops and creates your tables (correctly ensuring that any referential integrity issues can be resolved), and inserts sample data into each table.    
2- A PL/pgSQL stored procedure (and any associated code) which allows for registration of new customers.   
3- A PL/pgSQL stored procedure (and any associated code) which allows an existing customer to purchase a product. This transaction must allow the client to specify a specific product to purchase, a delivery date and time, ensuring that the delivery can only be booked if both that product and delivery slot are available.

## Table of Content (Files):
1- Entity relationship diagram and data dictionary (ERD_data_dictionary.png)     
2- database and procedures creation file (database + procedures_creation.sql)

 
