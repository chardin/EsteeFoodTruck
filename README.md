# FoodTruck

FoodTruck is a system of objects for retrieving and processing food
truck data.  It is intended to support multiple storage engines, and
implements a flatfile storage as a default.

## Tradeoffs

- Food truck data are stored in memory.  If the database gets too large for that, it may be best to pull the data from the flatfile and store it using some other mechanism, such as a relational database.
- The current database has effectively one, non-normalized table.  The system can accommodate many such tables, and can be used to generate normalized representations of the data.