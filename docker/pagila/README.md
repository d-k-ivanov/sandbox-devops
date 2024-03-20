Pagila
======

Pagila is a port of the Sakila example database available for MySQL, which was
originally developed by Mike Hillyer of the MySQL AB documentation team. It
is intended to provide a standard schema that can be used for examples in
books, tutorials, articles, samples, etc.

Pagila works against PostgreSQL 11 and above.

All the tables, data, views, and functions have been ported; some of the
changes made were:

* Changed char(1) true/false fields to true boolean fields
* The last_update columns were set with triggers to update them
* Added foreign keys
* Removed 'DEFAULT 0' on foreign keys since it's pointless with real FK's
* Used PostgreSQL built-in fulltext searching for fulltext index.
  Removed the need for the film_text table.
* The rewards_report function was ported to a simple SRF

The schema and data for the Sakila database were made available under the BSD
license which can be found at

<http://www.opensource.org/licenses/bsd-license.php>.

The pagila database is made available under this license as well.

FULLTEXT SEARCH
---------------

Fulltext functionality is built in PostgreSQL, so parts of the schema exist
in the main schema file.

Example usage:

SELECT * FROM film WHERE fulltext @@ to_tsquery('fate&india');

PARTITIONED TABLES
------------------

The payment table is designed as a partitioned table with a 6 month timespan
for the date ranges.
If you want to take full advantage of table partitioning, you need to make
sure constraint_exclusion is turned on in your database. You can do this by
setting "constraint_exclusion = on" in your postgresql.conf, or by issuing the
command "ALTER DATABASE pagila SET constraint_exclusion = on" (substitute
pagila for your database name if installing into a database with a different
name)

INSTALL NOTE
------------

The pagila-data.sql file and the pagila-insert-data.sql both contain the same
data, the former using COPY commands, the latter using INSERT commands, so you
only need to install one of them. Both formats are provided for those who have
trouble using one version or another.

VERSION HISTORY
---------------

Version 2.1.0

* Replace varchar(n) with text (David Fetter)
* Match foreign key and primary key data type in some tables (Ganeshan Venkataraman)
* Change CREATE TABLE statement for customer table to use
    DEFAULT nextval('customer_customer_id_seq'::regclass) for customer_id
    field instead of SERIAL (Adrian Klaver).

Version 2.0

* Update schema for newer PostgreSQL versions
* Remove RULE for partitioning, add trigger support.
* Update years in sample data.
* Remove ARTICLES section from README, all links are dead.

Version 0.10.1

* Add pagila-data-insert.sql file, added articles section

Version 0.10

* Support for built-in fulltext. Add enum example

Version 0.9

* Add table partitioning example

Version 0.8

* First release of pagila

CREATE DATABASE ON [DOCKER](https://docs.docker.com/)
---------------------------

* On terminal pull the latest postgres image:

```bash
docker pull postgres:13.2
```

* Run image:

```bash
docker run --name postgres-pagila -e POSTGRES_PASSWORD=secret -d postgres:13.2
```

* Run postgres and create the database:

```bash
docker exec -it postgres-pagila psql -U postgres
```

```bash
psql (13.1 (Debian 13.1-1.pgdg100+1))
Type "help" for help.

postgres=# CREATE DATABASE pagila;
postgres-# CREATE DATABASE
postgres=\q
```

* Create all schema objetcs (tables, etc) replace ```<local-repo>``` by your local directory :

```bash
cat <local-repo>/pagila-schema.sql | docker exec -i postgres-pagila psql -U postgres -d pagila
```

* Insert all data:

```bash
cat <local-repo>/pagila-data.sql | docker exec -i postgres-pagila psql -U postgres -d pagila
```

* Done! Just use:

```bash
docker exec -it postgres-pagila psql -U postgres
```

```bash
postgres
psql (13.1 (Debian 13.1-1.pgdg100+1))
Type "help" for help.

postgres=# \c pagila
You are now connected to database "pagila" as user "postgres".
pagila=# \dt
                    List of relations
 Schema |       Name       |       Type        |  Owner
--------+------------------+-------------------+----------
 public | actor            | table             | postgres
 public | address          | table             | postgres
 public | category         | table             | postgres
 public | city             | table             | postgres
 public | country          | table             | postgres
 public | customer         | table             | postgres
 public | film             | table             | postgres
 public | film_actor       | table             | postgres
 public | film_category    | table             | postgres
 public | inventory        | table             | postgres
 public | language         | table             | postgres
 public | payment          | partitioned table | postgres
 public | payment_p2020_01 | table             | postgres
 public | payment_p2020_02 | table             | postgres
 public | payment_p2020_03 | table             | postgres
 public | payment_p2020_04 | table             | postgres
 public | payment_p2020_05 | table             | postgres
 public | payment_p2020_06 | table             | postgres
 public | rental           | table             | postgres
 public | staff            | table             | postgres
 public | store            | table             | postgres
(21 rows)

pagila=#
```

Pagila Licence
---------------

Copyright (c) Devrim Gündüz <devrim@gunduz.org>

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
