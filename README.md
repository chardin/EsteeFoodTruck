# FoodTruck

FoodTruck is a system of objects for retrieving and processing food truck data.  It is intended to support multiple storage engines, and implements a flatfile storage as a default.

## Desired characteristics of a solution

The problem statement reads, in part:

>We build systems engineered to run in production. Given this, please organize, design, test, deploy, and document your solution as if you were going to put it into production.

I decided that the main priority was to devise a clean, object-oriented solution.  It would be best if the solution were extensible, so that one could add capabilities to it in the future.  Most of all, I didn't want to have to undo a lot of work in order to extend the system.

It occurred to me that a system like this would probably need to be migrated to a different data store, possibly a relational database.  I decided to implement a system wiuth different storage mechanisms.  This also makes it possible to use multiple sotrage classes using the same business logic classes.

I decided to fetch the database remotely and store it.  This makews it easy to ensure that the database is in a consistent state even if the data source changes.  It is easy enough to fetch that data remotely, and to avoid losing data if a fetch fails.

## Tradeoffs

- Food truck data are stored in memory.  If the database gets too large for that, it may be best to pull the data from the flatfile and store it using some other mechanism, such as a relational database.
- The current database has effectively one, non-normalized table.  The system can accommodate many such tables, and can be used to generate normalized representations of the data.
- Given more time, I would probably have implemented more functionality, and maybe some code or infrastructure to exercise this framework.

## The code itself

The solution is coded in OO Perl.  The code is in the `lib/` directory.  The `db/` directory contains the CSV database for the food trucks.  Unit tests are in the `t/` subdirectory.