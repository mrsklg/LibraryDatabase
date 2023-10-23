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

![baza](https://github.com/mrsklg/LibraryDatabase/assets/100710286/1c67f7fe-68b8-4880-9276-8df1cae29123)

## Database Structure

### Relations

#### Many-to-many

One author can write multiple books and one book can have multiple authors.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/11753508-5e22-4cbe-a7d4-53cd117a6a9b)


#### One-to-many

One book can have multiple copies, but a copy can be a copy of only one book.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/9d05033b-53d3-4623-925a-4160f6f51085)


#### Many-to-one

Multiple copies can have one publisher.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/8df00f1c-d1eb-426f-8255-6f4f138ecd84)


### Queries


#### Displaying books with their authors and genres.


Query:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/939e9ec1-1fbf-4fd0-ae9f-7c70bccc0704)


Result:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/c52cc4fe-6697-4962-98b0-b971de62930a)


#### Displaying the borrowing history after returning the book

Query:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/f20ea256-d86c-41aa-aae3-0370d68b37b3)


Result:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/ec974e92-45b6-46aa-9d96-a0b68f1f2fe4)


#### Displaying the sum of unpaid late fees of patrons


Query:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/c62805b8-e9c1-4c6b-8a70-755283e0eccb)


Result:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/543eb3c3-5688-479f-934e-bc51e46fca60)



### Triggers


#### Calculating late fee after returning a book, if needed

After the book is returned the trigger checks, whether the late fee has to be calculated. If the book was returned after the previously set return date, the trigger calculates the fee amount and inserts it into the fees table.


![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/c45c9a4b-0dc3-4f0f-bc39-f1279d8632e3)


![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/7a3c24ba-0509-40d4-a2f8-5ec997ce2b92)


#### Changing the number of borrowed books

After the patron has borrowed or returned a book, the trigger updates the patron's borrowed book count.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/529044c0-36cf-4341-8328-d7c1f8882305)


![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/7df0d36a-7e82-4e98-b766-c6cc8b72fbbf)


![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/cdc1d5dd-c0d8-435b-8410-31c6c0d5624f)



### Procedures

#### Adding an author to the book

If the book already exists, the procedure adds an author to it. Otherwise, the procedure returns an error. If the added author does not exist in the author table, they are inserted into the table.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/371305f0-e915-4a8f-8af6-22cecb31875f)


Data:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/b031588e-bab7-448f-b590-dcfe9c68a9e5)


Result:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/101cd3e9-3061-4d7a-a6c8-d16e97825a3e)



#### Adding a book

The procedure inserts a book into the book table. If the book already exists in the table, the procedure returns an error. If the obligatory data is missing, the book will not be inserted into the table.


![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/e34ece84-e900-4577-a89c-d14f4dd2373d)


Data:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/7662227b-88da-427f-9a66-bfdba081fbc3)


Result:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/e15de6dc-4bb9-4c85-8843-ddbbb1b018ce)



#### Returning a book

The procedure inserts the date of return in the table Wypozyczenie as the current date and logs the performed operation with the date in the log table.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/d76f25ef-5982-43fa-8d63-0dacc4c2202b)


Data:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/3c36e9e4-90e6-491f-a478-9a69f02b0301)


Result:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/7f180f60-ce28-4f01-8edd-86b032c6630f)


Logs table:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/59da4960-dec3-474d-a6d9-8fbaf67c5932)



### Functions

#### Counting patrons with books

The function returns the number of patrons with a given surname who have more books borrowed than the given parameter.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/533f935a-edaa-4cad-a751-d75e7ce008db)


Data:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/33a1b2bb-fee5-461f-887e-592bb49a0435)


Result:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/28c70a75-5d84-4882-9d5a-1914e947cc15)



### Transaction

The procedure enables the patron to borrow a book. Based on the book title, it finds the book and based on the patron's name and surname, it finds the patron. Inside the transaction the procedure checks the number of book's available copies and, if there are available copies, it inserts into the Wypozyczenie table the ID of the first available copy and the date and the patron's ID. It also updates the logs table.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/2ce15ae1-d742-4322-8a64-485953dad662)
![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/eef96a96-78eb-4624-a6c0-9a83a401765c)


Data:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/6cd3608a-b483-4fd0-947a-7a0d24d891ca)


Result:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/8c532ffc-964e-4ad7-8c01-34ea5395aad5)


Logs table:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/4e7b4eff-bbb3-4950-b116-a6507bca75ca)


### Partitioning

The partitioning of the logs table.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/566891c3-bbdb-4620-a084-2f47c83c53ba)


Partitioning - EXPLAIN command:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/2d489705-9510-4753-b21a-00998a033789)



### Versioning

The versioning of the book table.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/28cff2d1-604f-45fe-bbae-1279c1f952f5)


The example of versioning in the book table:

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/6aa50bef-f9f6-44d3-b1f3-14312e1bb93b)



### Events

#### Event creating a new partition

The event creates a new partition in the logs table every year.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/a1c46e91-3d42-412a-8ff8-c9967066acba)



#### Event deleting data from the Wypozyczenie table

The event deletes from the Wypozyczenie table records, where the year has passed since the return date. The event executes every day.

![image](https://github.com/mrsklg/LibraryDatabase/assets/100710286/01e81416-32e7-4827-b8b8-d565a7ccb7ae)

