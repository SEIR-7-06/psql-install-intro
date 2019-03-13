## Structured Query Language (SQL)

#### Installing Postgres


1.  Run the command `brew install postgres`
2.  Let's install using-

	3.  [Post gres app](https://postgresapp.com/)
	3.  Move the app to your `/Applications/` directory.
	4.  Now, double-click it to run it.
	5.  Select **Open Postgres** in the bottom-right corner.
			
			OR
			
	1. Run `brew tap homebrew/services` to install brew services.
	2. Then run `brew services start postgresql` to start postgres as a background service
	3. To stop postgres manually, run `brew services stop postgresql`. You can also use brew services to restart Postgres `brew services restart postgresql`


####  LIST ALL THE DATABASES!

* We've provided a cheatsheet of Postgres commands to help you out.
* First thing's first - let's run `psql postgres` on the terminal 
* Now, let'ssee if we have any databases!
* `\l` to list **all** databses OR use this query `SELECT * FROM pg_database;`

#### Creating a database

* This is pretty straigtforward!
* Let's tell Postgres to create a database with a name!
* Syntax **matters**. Close each statement with a `;`
* `CREATE DATABASE ga;`
* Run the list command to see our new database!
* To remove a database use `DROP DATABASE databasename;`

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
CREATE TABLE courses 
(id SERIAL PRIMARY KEY, name varchar(255), code varchar(200));
```

* Let's break this down...
* SERIAL PRIMARY KEY sets our Primary Key.
* We can now define the rest of our values using `attribute_name` with an associated `value_type`
* We organize them using commas to split them up.
* You can also use `\d+ tablename` to describe the table OR run query:

```sql
SELECT * FROM information_schema.COLUMNS
WHERE TABLE_NAME = 'courses';
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


#### Adding rows to a database

Check this syntax out:

```sql
INSERT INTO courses (name, code)
VALUES
('Web Developement Immersive', 'WDI');
```

* We don't need to include a Primary Key.
* Why? Remember auto-incremement?
* When we add a new row we get an automatic ID!
* We just specify the attributes to add into.
* And then we specify the **Values**!


#### Selecting rows from a database

* We can select all the rows!
* We use the **SELECT** statement!

```sql
SELECT * FROM courses;
```

* We can look for specific rows!

```sql
SELECT * FROM courses WHERE id = 1;
```

Nice, eh?

Now, let's create another table 'students' where each student can take one course at a time.

```sql
CREATE TABLE students 
(id SERIAL PRIMARY KEY, name VARCHAR(255), email VARCHAR(200), 
course_id INTEGER REFERENCES courses(id));

INSERT INTO students (name, email, course_id)
VALUES
('Jimbo', 'jimbo@ga.co', 1);

SELECT * FROM students;
```

#### Deleting rows from a database

* We use the **Delete** keyword!
* We can be specific like SELECT!

```sql
DELETE FROM courses WHERE id = 1;
```
* What do you see?
* The error 'violates foreign key' is generated when you try to delete a row that is used as a reference in another table(students).

#### Migrations

Let's think about this. Wouldn't it be nice if we just had a script that we could copy/paste all of this into? Especially when we want to let a new user try our app out or run it on a server somewhere - having a script that can create our databses and tables for us is a *huge* win!

* We need to connect to SQL
* Create our database
* Create our tables
* How would we write this?
* Each command would be line-by-line



## Relationships in Relational Databases

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




