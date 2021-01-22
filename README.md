# ![](https://ga-dash.s3.amazonaws.com/production/assets/logo-9f88ae6c9c3871690e33280fcf557f33.png) Intro to Relational Databases

## Overview

**Relational databases** are a way of storing and retrieving data on disk (or many disks). They provide more powerful storage and retrieval capabilities than simple files and are used in banking, eCommerce, healthcare, and all kinds of web and enterprise applications. 

## Intro: What Are Databases? (15 min)

A **database** is a place where information is stored in a hard drive (or distributed across multiple hard drives) somewhere on a computer. Much as we've been creating and storing data here and there, a database represents a collection of individual pieces of data stored in a highly structured and searchable way; they represent a model of reality, which is why we call them models in MVC.

Inside a database, we carry out basic actions such as **c**reating, **r**eading, **u**pdating, and **d**eleting data (or CRUD)!

In modern web development, there are different categories of databases: relational (aka, SQL), NoSQL, key-value, and more. We're focusing on relational databases here.

SQL stands for **Structured Query Language**, and it's a language used to manage and get information from what are considered "relational" databases.

We call these databases "relational" because different models (or pieces of data) can be linked to other models — i.e., "related." Relational databases store data in a **table**; think of it like a spreadsheet. The table holds all of the data for one model, while the columns define the model's attributes; we often call columns "attributes" or "fields." A row is an instance (remember instantiation!); think of it as a unique copy of the blueprint that is our model (often called a "record").

![relational db](https://cloud.githubusercontent.com/assets/25366/8589355/2646c588-25ca-11e5-9f2d-3d3afe8b7817.png)


## Code Along: Structured Query Language (SQL)

#### Installing Postgres v12.x (Mac)

1. Run the command `brew install postgres`	
2. Run `brew tap homebrew/services` to install brew services.
3. Then run `brew services start postgresql` to start postgres as a background service
4. To stop postgres manually, run `brew services stop postgresql`. You can also use brew services to restart Postgres `brew services restart postgresql`

#### Installing Postgres v12.x for nonMac
1. **Ubuntu** [Steps here](https://www.postgresql.org/download/linux/ubuntu/) 
2. **Windows** [Installer here](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)

---

####  List All Databases

* We've provided a cheatsheet of Postgres commands to help you out.
* First thing's first - let's run `psql postgres` on the terminal 
* Now, let'ssee if we have any databases!
* `\l` to list **all** databses OR use this query `SELECT * FROM pg_database;`

#### Creating a database

* This is pretty straigtforward!
* Let's tell Postgres to create a database with a name!
* Syntax **matters**. Close each statement with a `;`
* Create a database one of two ways:
	- From the command line: `createdb database_name`
	- In the `psql` shell: `CREATE DATABASE database_name;`
* Let's create a database called `ga` from inside the `psql` shell: `CREATE DATABASE ga;`
* Run the list command to see our new database!
* To remove a database use one of two ways:
	- From the command line: `dropdb database_name`
	- In the `psql` shell: `DROP DATABASE database_name;`

#### Connecting to your database

* Time to connect to our database.
* We can do that with the following syntax:
* `\c databasename`
* In our case, `\c ga`
* We can't do anything inside of our DB until we connect to it.

####  Creating tables in a Database

* We specify to `CREATE TABLE name_of_table();`
* We pass in attribute names inside of the parenthases.

```sql
CREATE TABLE course 
(id SERIAL PRIMARY KEY, name varchar(255), code varchar(200));
```

* Let's break this down...
* SERIAL PRIMARY KEY sets our Primary Key.
* We can now define the rest of our values using `attribute_name` with an associated `value_type`
* We organize them using commas to split them up.
* You can also use `\d+ tablename` to describe the table OR run query:

```sql
SELECT * FROM information_schema.COLUMNS
WHERE TABLE_NAME = 'course';
```

#### Listing tables in a database

* To see a list of all tables in a database...
* Run the following command 
		`\dt` 
		OR run this query 
```sql
SELECT
*
FROM
pg_catalog.pg_tables
WHERE
schemaname != 'pg_catalog'
AND schemaname != 'information_schema';
```

#### Adding rows to a table

Check this syntax out:

```sql
INSERT INTO course (name, code)
VALUES
('Web Developement Immersive', 'WDI');
```

* We don't need to include a Primary Key.
* Why? Remember auto-incremement?
* When we add a new row we get an automatic ID!
* We just specify the attributes to add into.
* And then we specify the **Values**!


#### Selecting rows from a table

* We can select all the rows!
* We use the **SELECT** statement!

```sql
SELECT * FROM course;
```

* We can look for specific rows!

```sql
SELECT * FROM course WHERE id = 1;
```

#### Updating row in a table

* If `WHERE` clause is not given update will update all the records in the table

```sql
UPDATE course
SET code = 'SEI', name='Software Engineering Immersive' 
WHERE id = 1;
```
* Run `Select` query again to see the updated row.

#### Deleting row from a table

* We can delete specific rows from our table using **WHERE** clause

```sql
DELETE FROM course where id = 1;
```

Nice, eh?

### Independent Practice
Take 10 minutes to practice writing queries for Creating, Reading, Updating, Deleting (CRUD) data in the `course` table.

Here are some ideas of courses to create, along with their codes:

* User Experience Design Immersive, UXDI
* Data Science Immersive, DSI
* Python, Py
* JavaScript, JS
* MongoDB, MDB
* Structured Query Language, SQL


## Relationships in Relational Databases

### One to One
- Not frequently used, but important to know it's an option.
- Imagine that a `library` table ```has_one``` location and a location ```belongs_to``` a specific library. This allows us to perform a lookup based solely on location and see the connected library.
- Oftentimes in situations like this, you can make the location an attribute of the library. But, when a location has, for example, multiple fields (`address 1`, `address 2`, `state`, `zip`, etc.), it might make sense to create another table for addresses and set up a ```has_one``` relationship.

![](https://www.tech-recipes.com/wp-content/uploads/2015/09/One-To-Many_Relationship_SQL_Server.png)

### One to many

![](https://www.ntu.edu.sg/home/ehchua/programming/sql/images/ManyToOne.png)

One to many relationships in SQL Databases work pretty much just like **referenced** relationships. **There are NO embedded relationships in relational databses.** 

You simply put the ID of the "one" resource in the "many" as shown above. This is called a **foreign key**, because it is the key, or ID, of an item in a different table. 

### Many to Many

We didn't cover this in MongoDB because NoSQL databases are much better at storing complex data, than storing structured data with complex relationships. 

Lets dig in. 

Let's think about a high school situation where students have many classrooms and classrooms have many students. 

How do we do this? We **could** attempt to use the above (wrong) way and put ALL of the student IDs associated with each classroom in each row of the classroom table, AND ALL of the classroom IDs associated with each student in each row on the student table. 

But then we are again putting arbitrary amounts of columns in our tables and the end result is not pretty. 

![](https://media.giphy.com/media/N9sfGVpuo4p56/giphy.gif)

Fortunately the eggheads of computer science yesteryear have come up with a beautiful, elegant solution: The join table. 

#### The Join Table!

![](https://media.giphy.com/media/jDiUeDQpIkGIM/giphy.gif)

![](https://smehrozalam.files.wordpress.com/2010/06/erd-many-to-many-2.jpg)

We use a join table! It's a table with the ID's of BOTH, thus connecting our data across databases! YAY!!!!

A join table might be JUST a join table, meaning it might have nothing but the two IDs, or it might represent something too! 

For example, the join table above represents a real thing: **enrollment**! Enrollment might have some of it's own properties, like start and stop dates. Other times, the join table might not really represent anything that has a real life analogy, and it might not need to hold any data besides the ID's. 

### Code Along

We will just see a simple example of how relationships are implemented in SQL database. Django will do a lot of heavy lifting for us so we don't have to know the query in detail.

Let's create another table `student` where each student can take one course at a time, but a course can have many students. So this is an example of one-to-many relationship between `course` and `student`.

```sql
CREATE TABLE student 
(id SERIAL PRIMARY KEY, name VARCHAR(255), email VARCHAR(200), 
course_id INTEGER REFERENCES course(id));

INSERT INTO student (name, email, course_id)
VALUES
('Jimbo', 'jimbo@ga.co', 1);

SELECT * FROM student;
```

#### Foreign Key Constraint

* Try to now delete the course where course id is 1

```sql
DELETE FROM course WHERE id = 1;
```
* What do you see?
* The error 'violates foreign key' is generated when you try to delete a row that is used as a reference in another table(student).



## ACID Transactions

Let's first take a look at a real world [example](https://www.youtube.com/embed/H59Y4sZ6eb4?start=0&end=58)

- What do you think was the problem here? 
- How do you think that can be resolved? 

This is where ACID transactions come in. ACID is a series of principles that should be followed whenever you modify a database. The goal in using these principles is to maintain a stable, consistent database, both before and after whatever operation you're performing.

These properties are the reason why all banking, healthcare, financial companies use relational databases OR a database compliant with these properties.

### But What is a Transaction?

Let's learn from the same [master](https://www.youtube.com/embed/H59Y4sZ6eb4?start=59&end=106).

A transaction is a single unit of work that modifies a database. It might be several individual actions, but think of them as a unit, all working on the same task. 

Let's take another example. This time we will talk about banking. Say, 1st of every month your salary of $1000 is credited to your account. You the big saver sends half of that money into your savings account. After logging into your account, as soon as you initiate the transfer what all do you think will happen in the server. Assuming your initial balance was 0 in both the accounts.

-  Read $1000 from Checking
-  Deduct $500 from $1000
-  Update balance to $500
-  Read $0 balance from Savings
-  Add $500 to $0
-  Update balance to $500

These 6 steps to transfer money between your two accounts is ONE TRANSACTION.

### So, What's ACID

![](https://media.giphy.com/media/l3vR0BOPKtgPE1tgk/giphy.gif)

Great. Now let's break down that acronym: **ACID**.

**Atomicity**: Transactions are all or nothing; they go all in. There's no cutting corners with transactions. However you want to put it, *atomicity* just means that all parts of a transaction take place at once and run to completion, or it doesn't happen at all.
 
In the above example, either all the 6 steps will happen to transfer money from 1 account to another or none will occur. Even if 1 step fails, the entire transaction will be rolled back. That means Checking will continue to have $1000 as balance and Savings will have 0. 

**Consistency**: The database should be consistent before and after the transaction happens; kind of like how energy can neither be created nor destroyed, it just changes forms. If you're moving or removing something in a database, it has to go *somewhere*. This principle is pretty stringent: If the transaction can't be fully completed at that time, everything will roll back to the original version.

In the above example, what if the adding $500 to Savings account failed. Without rolling back the entire transaction you now have inconsistent data. You are actually out of 500 dollars and there is no way to recover your hard earned money. Imagine that!

**Isolation**: Transactions must be able to occur independently, without interference, while still maintaining the ultimate goal of *consistency* in the database. What's more, transactions must be able to happen concurrently while still keeping things consistent.

In the above example, if while making the transfer you also decide to withdraw $600 from your Checking account. Depending on the step your previous transaction is in you can get two very different and dangerous results. You may end up overdrawing your account, which is very very bad. Hence, transactions must take place in isolation and changes should be visible only after they have been made to the main memory.

**Durability:** Once a transaction is complete, it doesn't just say "See ya!" and ride off into the sunset. Any changes made must be permanently stored in the database's memory. And, if something goes wrong, the record of the transaction still exists and is always accessible in the database.

So just for review,

![](https://media.geeksforgeeks.org/wp-content/cdn-uploads/20191121102921/ACID-Properties.jpg)
[source](https://www.geeksforgeeks.org/acid-properties-in-dbms/)

### Exercise: Make It Real

We know what ACID is all about. Now, it's time to bring it into real life!

We've listed a few real-world scenarios depicting database transactions that happen all the time. With a partner, review them and think through:

- With which ACID principle(s) is the scenario dealing?
- Assuming the DB is ACID compliant, what should happen?
- What would happen if the DB was **not** ACID compliant? What could go wrong in this transaction?

**Meet the Scenarios**

- **Scenario 1**: You and your brother are both trying to buy the same 12-pack of Pamplemousse La Croix from Amazon at the same time. There are 10 packs available; your brother wants five and you want six.
- **Scenario 2**: You're trying to buy tickets from Ticketmaster to see Taylor Swift's new tour. The tickets go on sale at 12 p.m., and you're ready to purchase as soon as the clock strikes noon. After being stuck in the digital waiting room for some time, you’re finally able to add those tickets to your cart, make the purchase, and get your confirmation. All of a sudden, the site goes down (probably overrun with ravenous T Swift fans).
- **Scenario 3**: You send a five-page document to the printer. While it's working on Page 3, the printer runs out of toner.




