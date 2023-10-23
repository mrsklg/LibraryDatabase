# LibraryDatabase

## Contents
- [Overview](#overview)
- [Entity Relationship Diagram](#erd)
- [Database Structure](#database-structure)
  - [Relations](#relations)
  - [Queries](#queries)
  - [Triggers](#triggers)
  - [Procedures](#procedures)
  - [Functions](#functions)
  - [Transaction](#transaction)
  - [Partitioning](#partitioning)
  - [Versioning](#versioning)
  - [Events](#events)

## Overview

The project involved designing a comprehensive database for a library management solution, incorporating triggers, procedures, and functions. The goal was to create an efficient and organized system for managing books, patrons, and circulation activities. The database schema was carefully designed, ensuring normalized tables and establishing relationships between entities. Triggers were implemented to enforce data integrity and automate certain actions, while procedures and functions were utilized to streamline complex operations.

## ERD
![baza](https://github.com/mrsklg/LibraryDatabase/assets/100710286/0c197379-7fb8-43eb-8979-ebb059aa3857)

## Database Structure

### Relations

#### Many-to-many

One author can write multiple books and one book can have multiple authors.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/7f2f3f4e-d622-4b46-a953-2f2fbbeccc23)

#### One-to-many

One book can have multiple copies, but a copy can be a copy of only one book.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/521390b3-7121-48c1-abd6-ef71607ce7c0)

#### Many-to-one

Multiple copies can have one publisher.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/e0981b15-0036-4560-b7cb-551eedb11abf)

### Queries


#### Displaying books with their authors and genres.


Query:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/d3edba85-740d-4903-b4e8-7498a207f192)

Result:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/3df60b99-d076-474a-a917-eeb354110b45)

#### Displaying the borrowing history after returning the book

Query:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/2ed38e90-28f8-4ff1-91bb-6c053f6375df)

Result:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/9e034997-5f45-4940-b060-b523216ad053)

#### Displaying the sum of unpaid late fees of patrons


Query:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/11631ba9-728d-4d9c-a018-b3c8ea21ad29)

Result:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/ffee09be-5a46-4637-b1e9-616ca6e663f2)


### Triggers


#### Calculating late fee after returning a book, if needed

After the book is returned the trigger checks, whether the late fee has to be calculated. If the book was returned after the previously set return date, the trigger calculates the fee amount and inserts it into the fees table.


![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/640d9485-c73c-4928-b9d4-b3a92fa72d24)

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/43de2b91-8e00-48d7-8bd7-3496c2ced469)

#### Changing the number of borrowed books

After the patron has borrowed or returned a book, the trigger updates the patron's borrowed book count.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/45165888-41e9-4242-bf27-760d57ea55f8)

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/6491b30d-ffc7-4828-9f63-32768e2a50ff)

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/e575a36c-599c-467c-8c97-d2b9e9d2934e)


### Procedures

#### Adding an author to the book

If the book already exists, the procedure adds an author to it. Otherwise, the procedure returns an error. If the added author does not exist in the author table, they are inserted into the table.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/553eb342-4a9e-4f8a-aefe-41581e6937c4)

Data:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/b5a09892-bd3d-46b9-abbf-c9db281de874)

Result:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/bcdea613-9447-4945-8ba9-0da8aeabf281)


#### Adding a book

The procedure inserts a book into the book table. If the book already exists in the table, the procedure returns an error. If the obligatory data is missing, the book will not be inserted into the table.


![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/ec839cb8-9ae1-4bf1-bc24-b0ced924dc5e)

Data:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/e9d1d675-0165-44e2-9f27-3390b599b904)

Result:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/5383aafc-e22e-4d40-9960-b0b34ce0ccc9)


#### Returning a book

The procedure inserts the date of return in the table Wypozyczenie as the current date and logs the performed operation with the date in the log table.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/7135a6fd-b087-43c1-9a0d-b548d44d5f0f)

Data:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/28c2ebc0-6e6a-4f24-a3aa-6b796803a55e)

Result:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/24d5a511-fb74-444c-baa5-876f06f7e068)

Logs table:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/42e35ff1-f6ce-4824-94d2-4af7eefbc32c)


### Functions

#### Counting patrons with books

The function returns the number of patrons with a given surname who have more books borrowed than the given parameter.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/53fb132f-225e-45ab-bb85-77e1b36cf88b)

Data:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/963e5a5a-f0d6-4056-99cf-9ef487db8338)

Result:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/985b574d-d9cd-4aec-8726-d2137b852c69)


### Transaction

The procedure enables the patron to borrow a book. Based on the book title, it finds the book and based on the patron's name and surname, it finds the patron. Inside the transaction the procedure checks the number of book's available copies and, if there are available copies, it inserts into the Wypozyczenie table the ID of the first available copy and the date and the patron's ID. It also updates the logs table.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/0f93bc2f-af78-463d-849c-3ee335eec9f4)
![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/e2b0c5e2-edf3-4f82-9043-a48174eb12d1)

Data:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/974a7988-338e-4953-af0b-03a094dd5a17)

Result:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/b3d0645a-3b85-4fe7-9b7e-d5a4a10c2021)

Logs table:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/c4d2eac2-35b4-490b-9a4d-73b6b7b19d86)

### Partitioning

The partitioning of the logs table.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/2c7b05e9-0d4a-4994-9d78-a58c00e9152a)

Partitioning - EXPLAIN command:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/23831ebb-87e7-426e-a2ff-065b49d61654)


### Versioning

The versioning of the book table.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/7cd78840-c572-4164-b9a1-8493e18f05f7)

The example of versioning in the book table:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/cb5cec4b-f0a9-48df-a48c-987f04604b95)


### Events

#### Event creating a new partition

The event creates a new partition in the logs table every year.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/66ba9a42-93b0-458e-a145-1b190f9c3dbd)


#### Event deleting data from the Wypozyczenie table

The event deletes from the Wypozyczenie table records, where the year has passed since the return date. The event executes every day.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/a65f8545-6460-4633-b983-4fdb9cea02af)
