create table t(id1 int, id2 int, id3 int);
create unique index idx on t(id1, id3);
INSERT INTO t VALUES(1,null,1);
INSERT INTO t VALUES(1,null,2);
INSERT INTO t VALUES(null,null,1);
INSERT INTO t VALUES(null,null,2);
SELECT * FROM t;
drop table t;

create table t(id1 int, id2 int, id3 int);
create unique index idx on t(id2, id3);
INSERT INTO t VALUES(1,null,1);
INSERT INTO t VALUES(1,null,2);
INSERT INTO t VALUES(null,null,1);
INSERT INTO t VALUES(null,null,2);
SELECT * FROM t;
drop table t;

create table t(id1 int, id2 int, id3 int);
create unique index idx on t(id1, id2);
INSERT INTO t VALUES(1,null,1);
INSERT INTO t VALUES(1,null,2);
INSERT INTO t VALUES(null,null,1);
INSERT INTO t VALUES(null,null,2);
SELECT * FROM t;
drop table t;

create table null_table6(id1 int nullable, id2 int nullable, id3 int);
create unique index idx on null_table6(id1, id3);
INSERT INTO null_table6 VALUES(1,null,1);
INSERT INTO null_table6 VALUES(1,null,2);
INSERT INTO null_table6 VALUES(null,null,1);
INSERT INTO null_table6 VALUES(null,null,2);
SELECT * FROM null_table6;
drop table null_table6;
...

create table t(id int, age int);
create unique index idx on t(id, age);
insert into t values(1,1);
insert into t values(1,1);
insert into t values(null,1);
insert into t values(null,1);
select * from t;


create table t(id int nullable, age int nullable);
create unique index idx on t(id, age);
insert into t values(1,1);
insert into t values(null,1);
insert into t values(1,1);

insert into t values(null,1);

create table null_table5(id date nullable, age int);
INSERT INTO null_table5 VALUES(1,1);
FAILURE
INSERT INTO null_table5 VALUES(null,1);
-SUCCESS
+FAILURE
INSERT INTO null_table5 VALUES(null,2);
drop table null_table5;
-SUCCESS
+FAILURE
SELECT * FROM null_table5;
1 | 1
...

INSERT INTO unique_table2 VALUES (1,2,1,1);
FAILURE
INSERT INTO unique_table2 VALUES (2,3,1,1);
-SUCCESS
+FAILURE
2. SELECT
SELECT * FROM unique_table1;
1 | 1 | 1
...


CREATE TABLE unique_table(id int, col1 int, col2 int);
INSERT INTO unique_table VALUES (1,1,1);

CREATE UNIQUE INDEX index_id on unique_table(id);
INSERT INTO unique_table VALUES (1,2,1);
drop table unique_table;

CREATE TABLE unique_table(id int, col1 int, col2 int);
INSERT INTO unique_table VALUES (1,1,1);

CREATE UNIQUE INDEX index_id on unique_table(id);
INSERT INTO unique_table VALUES (2,1,1);
CREATE UNIQUE INDEX index_id on unique_table(id);
INSERT INTO unique_table VALUES (3,2,1);
INSERT INTO unique_table VALUES (1,2,1);
show index from unique_table;
FAILURE

2. SELECT
SELECT * FROM unique_table;
1 | 1 | 1
2 | 1 | 1
3 | 2 | 1
ID | COL1 | COL2


UPDATE Update_table_3 SET t_name=(select Update_table_2.col1 from Update_table_2 where Update_table_2.id=1),col1=(select avg(Update_table_2.col1) from Update_table_2) where id=1;
SUCCESS
SELECT * FROM Update_table_3;
-1 | 1 | 1 | 2
+1 | 1 | 1065353216 | 2
2 | 2 | 2 | 2
3 | N01 | 1 | 2
ID | T_NAME | COL1 | COL2
\ No newline at end of file

create table t (id int, name char(20));
insert into t values(1,'apple');
insert into t values(2,'cherry');
insert into t values(3,'orange');
insert into t values(4,'grape');
SELECT * FROM t WHERE name NOT LIKE 'p%' AND name NOT LIKE '%e';
drop table t;
+1 | APPLE
10 | cherry
12 | strawberry
+2 | ORANGE
4 | lemon
5 | banana
+6 | GRAPE

1. MULTI INDEX OF EMPTY TABLE
CREATE TABLE multi_index(id int, col1 int, col2 float, col3 char, col4 date, col5 int, col6 int);
CREATE INDEX i_1_12 ON multi_index(col1,col2);
CREATE INDEX i_1_345 ON multi_index(col3, col4, col5);
CREATE INDEX i_1_56 ON multi_index(col5, col6);
CREATE INDEX i_1_456 ON multi_index(col4, col5, col6);
show index from multi_index;
SELECT * FROM multi_index;
ID | COL1 | COL2 | COL3 | COL4 | COL5 | COL6

2. MULTI INDEX OF NON-EMPTY TABLE
all success
CREATE TABLE multi_index2(id int, col1 int, col2 float, col3 char, col4 date, col5 int, col6 int);
INSERT INTO multi_index2 VALUES (1, 1, 11.2, 'a', '2021-01-02', 1, 1);
INSERT INTO multi_index2 VALUES (2, 1, 16.2, 'x', '2021-01-02', 1, 61);
INSERT INTO multi_index2 VALUES (3, 1, 11.6, 'h', '2023-01-02', 10, 17);
CREATE INDEX i_2_12 ON multi_index2(col1,col2);
CREATE INDEX i_2_345 ON multi_index2(col3, col4, col5);
CREATE INDEX i_2_56 ON multi_index2(col5, col6);
CREATE INDEX i_2_456 ON multi_index2(col4, col5, col6);
show index from multi_index2;
SELECT * FROM multi_index2;
drop table multi_index2;
1 | 1 | 11.2 | A | 2021-01-02 | 1 | 1
2 | 1 | 16.2 | X | 2021-01-02 | 1 | 61
3 | 1 | 11.6 | H | 2023-01-02 | 10 | 17
ID | COL1 | COL2 | COL3 | COL4 | COL5 | COL6

3. INFLUENCE OF INSERTING
all success

CREATE TABLE multi_index3(id int, col1 int, col2 float, col3 char, col4 date, col5 int, col6 int);
CREATE INDEX i_3_i1 ON multi_index3(id,col1);
INSERT INTO multi_index3 VALUES (1, 1, 11.2, 'a', '2021-01-02', 1, 1);
INSERT INTO multi_index3 VALUES (1, 1, 11.2, 'a', '2021-01-02', 1, 1);
SELECT * FROM multi_index3;
CREATE INDEX i_3_14 ON multi_index3(col1,col4);
INSERT INTO multi_index3 VALUES (2, 1, 16.2, 'x', '2021-01-02', 1, 61);
INSERT INTO multi_index3 VALUES (3, 1, 11.6, 'h', '2023-01-02', 10, 17);
INSERT INTO multi_index3 VALUES (4, 2, 12.2, 'e', '2022-01-04', 13, 10);
INSERT INTO multi_index3 VALUES (5, 3, 14.2, 'd', '2020-04-02', 12, 2);
show index from multi_index3;
SELECT * FROM multi_index3;
drop table multi_index3;

1 | 1 | 11.2 | A | 2021-01-02 | 1 | 1
1 | 1 | 11.2 | A | 2021-01-02 | 1 | 1
ID | COL1 | COL2 | COL3 | COL4 | COL5 | COL6

1 | 1 | 11.2 | A | 2021-01-02 | 1 | 1
1 | 1 | 11.2 | A | 2021-01-02 | 1 | 1
2 | 1 | 16.2 | X | 2021-01-02 | 1 | 61
3 | 1 | 11.6 | H | 2023-01-02 | 10 | 17
4 | 2 | 12.2 | E | 2022-01-04 | 13 | 10
5 | 3 | 14.2 | D | 2020-04-02 | 12 | 2
ID | COL1 | COL2 | COL3 | COL4 | COL5 | COL6

4. QUERY WITH INDEXS
SELECT * FROM multi_index3 WHERE id = 1;
SELECT * FROM multi_index3 WHERE col1 > 1 and col4 = '2021-01-02';
SELECT * FROM multi_index3 WHERE col1 <> 1 and col4 >= '2021-01-02';
SELECT * FROM multi_index3 WHERE col2 < 15.0 and col4 <> '2021-01-02';

1 | 1 | 11.2 | A | 2021-01-02 | 1 | 1
1 | 1 | 11.2 | A | 2021-01-02 | 1 | 1
ID | COL1 | COL2 | COL3 | COL4 | COL5 | COL6

ID | COL1 | COL2 | COL3 | COL4 | COL5 | COL6

4 | 2 | 12.2 | E | 2022-01-04 | 13 | 10
ID | COL1 | COL2 | COL3 | COL4 | COL5 | COL6

3 | 1 | 11.6 | H | 2023-01-02 | 10 | 17
4 | 2 | 12.2 | E | 2022-01-04 | 13 | 10
5 | 3 | 14.2 | D | 2020-04-02 | 12 | 2
ID | COL1 | COL2 | COL3 | COL4 | COL5 | COL6

5. INFLUENCE OF DELETING
DELETE FROM multi_index3 WHERE id = 1;
DELETE FROM multi_index3 WHERE id = 61;
SELECT * FROM multi_index3;
2 | 1 | 16.2 | X | 2021-01-02 | 1 | 61
3 | 1 | 11.6 | H | 2023-01-02 | 10 | 17
4 | 2 | 12.2 | E | 2022-01-04 | 13 | 10
5 | 3 | 14.2 | D | 2020-04-02 | 12 | 2
ID | COL1 | COL2 | COL3 | COL4 | COL5 | COL6

DELETE FROM multi_index3 WHERE col3 = 'x';
SELECT * FROM multi_index3;
3 | 1 | 11.6 | H | 2023-01-02 | 10 | 17
4 | 2 | 12.2 | E | 2022-01-04 | 13 | 10
5 | 3 | 14.2 | D | 2020-04-02 | 12 | 2
ID | COL1 | COL2 | COL3 | COL4 | COL5 | COL6

DELETE FROM multi_index3 WHERE id = 4 and col1 = 1;
DELETE FROM multi_index3 WHERE id = 90 and col1 = 13;
DELETE FROM multi_index3 WHERE id = 90 and col1 = 1;
DELETE FROM multi_index3 WHERE id = 4 and col1 = 13;
DELETE FROM multi_index3 WHERE id = 3 and col1 = 1;
DELETE FROM multi_index3 WHERE id = 3 and col1 = 1;
SELECT * FROM multi_index3;
4 | 2 | 12.2 | E | 2022-01-04 | 13 | 10
5 | 3 | 14.2 | D | 2020-04-02 | 12 | 2
ID | COL1 | COL2 | COL3 | COL4 | COL5 | COL6

INSERT INTO multi_index3 VALUES (1, 1, 11.2, 'a', '2021-01-02', 1, 1);
INSERT INTO multi_index3 VALUES (2, 1, 11.2, 'x', '2021-01-02', 1, 61);
INSERT INTO multi_index3 VALUES (3, 1, 11.2, 'h', '2023-01-02', 10, 17);
SELECT * FROM multi_index3;
1 | 1 | 11.2 | A | 2021-01-02 | 1 | 1
2 | 1 | 11.2 | X | 2021-01-02 | 1 | 61
3 | 1 | 11.2 | H | 2023-01-02 | 10 | 17
4 | 2 | 12.2 | E | 2022-01-04 | 13 | 10
5 | 3 | 14.2 | D | 2020-04-02 | 12 | 2
ID | COL1 | COL2 | COL3 | COL4 | COL5 | COL6

6. INFLUENCE OF UPDATING
UPDATE multi_index3 SET col6=49 where id=2;
UPDATE multi_index3 SET col4='1999-02-01' where id=2;
UPDATE multi_index3 SET col1=2 where id=2;
UPDATE multi_index3 SET col1=5 where col6=49;
SELECT * FROM multi_index3;
1 | 1 | 11.2 | A | 2021-01-02 | 1 | 1
2 | 5 | 11.2 | X | 1999-02-01 | 1 | 49
3 | 1 | 11.2 | H | 2023-01-02 | 10 | 17
4 | 2 | 12.2 | E | 2022-01-04 | 13 | 10
5 | 3 | 14.2 | D | 2020-04-02 | 12 | 2
ID | COL1 | COL2 | COL3 | COL4 | COL5 | COL6

7. INFLUENCE OF DROPPING TABLE
DROP table multi_index;
SUCCESS

8. ERROR
CREATE TABLE multi_index4(id int, col1 int, col2 float, col3 char, col4 date, col5 int, col6 int);

failure
CREATE INDEX i_4_i7 ON multi_index4(id,col7);
CREATE INDEX i_4_78 ON multi_index4(col7,col8);
CREATE INDEX i_4_i78 ON multi_index4(id,col7,col8);

create table t1(id int, name char(4), col int);
create table t2(id int, name char(4), col float);
insert into t1 values(1,1,1);
insert into t1 values(2,2,2);
insert into t1 values(3,3,3);
insert into t1 values(4,4,4);
insert into t2 values(4,4,4.44);
insert into t2 values(5,5,5.55);
insert into t2 values(6,6,6.66);
select * from t1;
select * from t2;
update t2 set name=(select col from t1 where id = 1), col=(select avg(col) from t1);
select * from t2;
drop table t1;
drop table t2;

SUCCESS
UPDATE Update_table_3 SET t_name=
(select Update_table_2.col1 from Update_table_2 where Update_table_2.id=1),
col1=(select avg(Update_table_2.col1) from Update_table_2)
where id=1;

SUCCESS
SELECT * FROM Update_table_3;
-1 | 1 | 1 | 2
+1 | 1 | 1065353216 | 2
2 | 2 | 2 | 2
3 | N01 | 1 | 2
ID | T_NAME | COL1 | COL2

UPDATE Update_table_3 SET t_name=2,col1=2.0 WHERE id=2;
SUCCESS
UPDATE Update_table_3 SET t_name=(select Update_table_2.col1 from Update_table_2 where Update_table_2.id=1),col1=(select avg(Update_table_2.col1) from Update_table_2) where id=1;
-SUCCESS
+FAILURE
SELECT * FROM Update_table_3;
-1 | 1 | 1 | 2
+1 | N01 | 1 | 2
2 | 2 | 2 | 2
3 | N01 | 1 | 2

create table t1(id int, name char(10));
insert into t1 values(1,'test');
insert into t1 values(34, 33);
select * from t1;
update t1 set name=(select id from t1 where name='33') where id=1;
select * from t1;
drop table t1;

-- index
create table t(id int, age float, name char);
SHOW INDEX FROM t;
CREATE INDEX index_id on t(id);
SHOW INDEX FROM t;

-INDEX_TABLE_1 | 1 | INDEX_ID | 1 | ID
-TABLE | NON_UNIQUE | KEY_NAME | SEQ_IN_INDEX | COLUMN_NAME

3. like
SELECT * FROM like_table WHERE name LIKE 'c%';
-10 | cherry
-7 | coconut
-ID | NAME
+FAILED TO PARSE SQL
SELECT * FROM like_table WHERE name LIKE '%e';
-1 | apple
-11 | pineapple
...

SELECT * FROM like_table WHERE name LIKE '%e';
-1 | apple
-11 | pineapple
-2 | orange
-6 | grape
ID | NAME
SELECT * FROM like_table WHERE name LIKE '%pp%';
-1 | apple

create table t(id int, name char(8));
insert into t values (1, 'wefwef');
insert into t values (2, 'wwwws');
insert into t values (3, '313');
select * from t where name like '%f';
select * from t where name like 'w%' and name not like 'a';
select * from t
drop table t;
select * from table where name like

create table t(id int nullable, num )

3 | 3 | N3
ID | NUM | NAME
UPDATE null_table4 SET id=null where num is null;
-FAILURE
+SUCCESS
UPDATE null_table4 SET num=(SELECT null_table3.num from null_table3 where null_table3.id=1)
where id=2;
SUCCESS
SELECT * FROM null_table4;
-1 | NULL | NULL
2 | NULL | N2

create table t(id int, num int nullable);
insert into t values (1, null);
update t set id=null where num is null;
select * from t;
drop table t;

create table t(id int, num int);
insert into t values (1, null);
update t set id=null where num is null;
select * from t;
drop table t;

CREATE TABLE null_table(id int, num int nullable, price float not null, birthday date nullable);
CREATE TABLE null_table2(id int, num int nullable, price float not null, birthday date nullable);
INSERT INTO null_table VALUES (1, 18, 10.0, '2020-01-01');
INSERT INTO null_table VALUES (2, null, 20.0, '2010-01-11');
INSERT INTO null_table VALUES (3, 12, 30.0, null);
INSERT INTO null_table VALUES (4, 15, 30.0, '2021-01-31');
INSERT INTO null_table2 VALUES (1, 18, 30.0, '2021-01-31');
INSERT INTO null_table2 VALUES (2, null, 40.0, null);
SELECT null_table.num,null_table2.num,null_table.birthday FROM null_table,null_table2 where null_table.num=null_table2.num;
drop table null_table;
drop table null_table2;


CREATE TABLE null_table(id int, num int nullable, price float not null, birthday date nullable);
CREATE TABLE null_table2(id int, num int nullable, price float not null, birthday date nullable);
CREATE INDEX index_num on null_table(num);

INSERT INTO null_table VALUES (1, 18, 10.0, '2020-01-01');
INSERT INTO null_table VALUES (2, null, 20.0, '2010-01-11');
INSERT INTO null_table VALUES (3, 12, 30.0, null);
INSERT INTO null_table VALUES (4, 15, 30.0, '2021-01-31');
INSERT INTO null_table2 VALUES (1, 18, 30.0, '2021-01-31');
INSERT INTO null_table2 VALUES (2, null, 40.0, null);

INSERT INTO null_table VALUES (5, 15, null, '2021-01-31');
INSERT INTO null_table VALUES (null, 15, 30.0, '2021-01-31');

SELECT * FROM null_table;
SELECT * FROM null_table where 1 is null;
SELECT * FROM null_table where 1 is not null;
SELECT * FROM null_table where null=1;
SELECT * FROM null_table where 1=null;
SELECT * FROM null_table where 1<>null;
SELECT * FROM null_table where 1<null;
SELECT * FROM null_table where 1>null;
SELECT * FROM null_table where null is null;
SELECT * FROM null_table where null is not null;

SELECT * FROM null_table WHERE null=null;

SELECT * FROM null_table WHERE null<>null;

SELECT * FROM null_table WHERE null>null;

SELECT * FROM null_table WHERE null<null;


SELECT * FROM null_table where 'a' is null;

SELECT * FROM null_table where 'a' is not null;

SELECT * FROM null_table WHERE null='a';

SELECT * FROM null_table WHERE 'a'=null;
SELECT * FROM null_table WHERE 'a'<>null;
SELECT * FROM null_table WHERE 'a'>null;
SELECT * FROM null_table WHERE 'a'<null;


SELECT * FROM null_table where '2021-01-31' is null;
SELECT * FROM null_table where '2021-01-31' is not null;
SELECT * FROM null_table WHERE null='2021-01-31';
SELECT * FROM null_table WHERE '2021-01-31'=null;
SELECT * FROM null_table WHERE '2021-01-31'>null;
SELECT * FROM null_table WHERE '2021-01-31'<null;


SELECT * FROM null_table where birthday is not null;
SELECT * FROM null_table where birthday is null;
SELECT * FROM null_table where birthday = null;
SELECT * FROM null_table where null = birthday;
SELECT * FROM null_table where birthday <> null;
SELECT * FROM null_table where birthday > null;
SELECT * FROM null_table where birthday < null;
SELECT * FROM null_table where num is not null;
SELECT * FROM null_table where num is null;
SELECT * FROM null_table where num = null;
SELECT * FROM null_table where null = num;
SELECT * FROM null_table where num <> null;
SELECT * FROM null_table where num > null;
SELECT * FROM null_table where num < null;
SELECT null_table.num,null_table2.num,null_table.birthday FROM null_table,null_table2 where null_table.num=null_table2.num;

5. AGGREGATION
SELECT count(*) FROM null_table;
COUNT(*)
4
SELECT count(price) FROM null_table;
COUNT(PRICE)
4
SELECT count(birthday) FROM null_table;
COUNT(BIRTHDAY)
3
SELECT avg(num) FROM null_table;
AVG(NUM)
15

6. AGGREGATION WITH NULL COLUMNS
CREATE TABLE null_table3(id int, num int nullable);
SUCCESS
INSERT INTO null_table3 VALUES (1, null);
SUCCESS
INSERT INTO null_table3 VALUES (2, null);
SUCCESS
SELECT count(num) FROM null_table3;
COUNT(NUM)
0
SELECT min(num) FROM null_table3;
MIN(NUM)
NULL
SELECT max(num) FROM null_table3;
MAX(NUM)
NULL
SELECT avg(num) FROM null_table3;
AVG(NUM)
NULL

/*

1 | 18 | 10 | 2020-01-01
2 | NULL | 20 | 2010-01-11
3 | 12 | 30 | NULL
4 | 15 | 30 | 2021-01-31
ID | NUM | PRICE | BIRTHDAY

ID | NUM | PRICE | BIRTHDAY

1 | 18 | 10 | 2020-01-01
2 | NULL | 20 | 2010-01-11
3 | 12 | 30 | NULL
4 | 15 | 30 | 2021-01-31
ID | NUM | PRICE | BIRTHDAY

ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY

1 | 18 | 10 | 2020-01-01
2 | NULL | 20 | 2010-01-11
3 | 12 | 30 | NULL
4 | 15 | 30 | 2021-01-31
ID | NUM | PRICE | BIRTHDAY


ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY

1 | 18 | 10 | 2020-01-01
2 | NULL | 20 | 2010-01-11
3 | 12 | 30 | NULL
4 | 15 | 30 | 2021-01-31
ID | NUM | PRICE | BIRTHDAY

ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY

1 | 18 | 10 | 2020-01-01
2 | NULL | 20 | 2010-01-11
3 | 12 | 30 | NULL
4 | 15 | 30 | 2021-01-31
ID | NUM | PRICE | BIRTHDAY

ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY


1 | 18 | 10 | 2020-01-01
2 | NULL | 20 | 2010-01-11
4 | 15 | 30 | 2021-01-31
ID | NUM | PRICE | BIRTHDAY

3 | 12 | 30 | NULL
ID | NUM | PRICE | BIRTHDAY

ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY

1 | 18 | 10 | 2020-01-01
3 | 12 | 30 | NULL
4 | 15 | 30 | 2021-01-31
ID | NUM | PRICE | BIRTHDAY

2 | NULL | 20 | 2010-01-11
ID | NUM | PRICE | BIRTHDAY

ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY
ID | NUM | PRICE | BIRTHDAY

18 | 18 | 2020-01-01
NULL_TABLE.NUM | NULL_TABLE2.NUM | NULL_TABLE.BIRTHDAY


*/

FAILURE
7. UPDATE WITH INVALID CONDITION
UPDATE Update_table_2 SET t_name='N4',col1=1 where col3=1;
-FAILURE
-8. UPDATE IN VAIN
-UPDATE Update_table_3 SET t_name='N1',col1=1 where col1=100;
-SUCCESS
-SELECT * FROM Update_table_3;
-1 | N01 | 1 | 2
-2 | N01 | 1 | 2



create table t1(id int, col float, name char);
insert into t1 values(1,1,'2');
insert into t1 values(2,9.72,'tes');
update t1 set id=1.4,name='A32' where id=1;
update t1 set col=1,coll='wefwe' where id=1;
update t1 set col=1,name='1' where coll=1;
update t1 set id=(select avg(col) from t1) where id =1;
select * from t1;
drop table t1;
update t1 set

create table t2(id int, col float, name char);

insert into t1 values(1,1);
insert into t2 values(1,2);
select * from t1,t2;
update t1 set id=3,col=3 where id=1;
update t1 set ild=3,col=3 where id=1;
update t1 set id=3,cokl=3 where id=1;
update t1 set id=3,col=3 where idd=1;
update t1 set id='12',col=1.33 where id=3;
select * from t1;
update t1 set id=1.44, col='13' where id=12;
select * from t1;
update t1 set col=(select col from t2 where t2.id=1) where t1.id=2;
select * from t1,t2;
update t2 set id=1,col=1 where id=1;
select * from t1,t2;
update t1 set col=(select id from t2 where id=1), id=(select id from t2 where id=1) where id=2;
select * from t1;
drop table t1;
drop table t2;


FAILURE
7. UPDATE WITH INVALID CONDITION
UPDATE Update_table_2 SET t_name='N4',col1=1 where col3=1;
-FAILURE

2. MIN
SELECT min(num) FROM aggregation_func;
-MIN(NUM)
-12
+FAILURE
SELECT min(price) FROM aggregation_func;
-MIN(PRICE)
-10
+FAILURE
...

FAILURE
2. SELECT
SELECT * FROM null_table;
-1 | 18 | 10 | 2020-01-01
-2 | NULL | 20 | 2010-01-11
-3 | 12 | 30 | NULL
-4 | 15 | 30 | 2021-01-31
-ID | NUM | PRICE | BIRTHDAY
-3. SELECT WITH CONSTANT
-SELECT * FROM null_table where 1 is null;
...


create table t1 (id int, num1 int);
create table t2 (id int, num2 int);
create table t3 (id int, num3 int);
create table t4 (id int, num4 int);
create table t5 (id int, num5 int);
create table t6 (id int, num6 int);
insert into t1 values (1,1);
insert into t2 values (1,1);
insert into t3 values (1,1);
insert into t4 values (1,1);
insert into t5 values (2,100);
insert into t6 values (2,1);
select * from t1 inner join t2 on t1.id=t2.id inner join t3 on t1.id=t3.id inner join t4 on t3.id=t4.id and t4.num4 <= 5 inner join t5 on 1=1 inner join t6 on t5.id=t6.id where t3.num3 <10 and t5.num5>90;
drop table t1;
drop table t2;
drop table t3;
drop table t4;
drop table t5;
drop table t6;
select * from t1
              inner join t2 on t1.id=t2.id
              inner join t3 on t1.id=t3.id
              inner join t4 on t3.id=t4.id and t4.num4 <= 5
              inner join t5 on 1=1
              inner join t6 on t5.id=t6.id
where t3.num3 <10 and t5.num5>90;


1 | A | 18 | 5
JOIN_TABLE_1.ID | JOIN_TABLE_1.NAME | JOIN_TABLE_2.AGE | JOIN_TABLE_3.LEVEL
Select * from join_table_1 inner join join_table_2 on join_table_1.id=join_table_2.id and join_table_2.age>15;
-1 | A | 1 | 18
-JOIN_TABLE_1.ID | JOIN_TABLE_1.NAME | JOIN_TABLE_2.ID | JOIN_TABLE_2.AGE
+FAILED TO PARSE SQL
Select * from join_table_1 inner join join_table_2 on join_table_1.id=join_table_2.id and join_table_2.age>15 where join_table_1.name='b';
-JOIN_TABLE_1.ID | JOIN_TABLE_1.NAME | JOIN_TABLE_2.ID | JOIN_TABLE_2.AGE
+FAILED TO PARSE SQL
Select * from join_table_1 inner join join_table_2 on join_table_1.id=join_table_2.id and join_table_2.age>15 inner join join_table_3 on join_table_1.id=join_table_2.id and join_table_3.level>=5;

create table t1(id int, age float, addr char(4));
create table t2(id int, age float, addr char(4));
create table t3(id int, age float, addr char(4));
insert into t1 values (1,3,'434');
insert into t2 values (2,6,'aa');
insert into t2 values (1,-1.9,'aa');
insert into t3 values (3,9,'zz');
insert into t3 values (2,1,'zz');
insert into t3 values ('1',7,'zz');
select * from t1,t2,t3;
select * from t1 inner join t2 on t1.id<=t2.id and t1.age> t2.age;
select t1.id, t2.id,t3.id from t1 inner join t2 on t1.id=t2.id inner join t3 on t1.id=t3.id;
select * from t1 inner join t3 on t1.id=t3.id, t2 inner join t3 on t2.id=t3.id;
select * from t1,t2,t3;
drop table t1;
drop table t2;
drop table t3;


create table t1(id int, col int);
create table t2(id int, col int);
insert into t1 values(2,1);
insert into t1 values(1,1);
insert into t2 values(1,2);
select * from t1,t2;
update t1 set id=3,col=3 where id=1;
select * from t1,t2;
update t1 set col=(select col from t2 where t2.id=1) where t1.id=2;
select * from t1,t2;
update t2 set id=1,col=1 where id=1;
select * from t1,t2;
update t1 set col=(select id from t2 where id=1), id=(select id from t2 where id=1) where id=2;
select * from t1;
drop table t1;
drop table t2;

-- null
-- insert null -> nullable
-- insert null -> non-nullable
-- update null -> nullable
-- update null -> non-nullable
create table t(id int nullable, age int);
insert into t values (null,2);
insert into t values (1,4);
select avg(id) from t;
select * from t;
select * from t where id=null;
drop table t;

create table t(id int, num int nullable, birthday date nullable);
create index i_num on t(num);
insert into t values(1, 2, '2020-01-01');
insert into t values(1, null, null);
insert into t values(1, null, '2020-02-02');
insert into t values(null, 1, '2020-01-02'),(2,null,null);
update t set id=null where id = 1;
select * from t;
select * from t where id is null;
select * from t where id is not null;
select * from t where num is null;
select * from t where num > null;
select * from t where num <> null;
select * from t where 1=null;
select * from t where 'a'=null;
select * from t where null = null;
select count(*) from t;
select count(num) from t;
select avg(num) from t;


create table t(id1 nullable, id2 nullable);
create unique index id1_id2 on t(id1,id2); insert into t values(1,null);
insert into t values(1,null);-- 允许 insert into t values(2,2);
insert into t values(2,2);-- 不允许


-- update t set id=null, num=null where id =1;
-- select * from t where null is null;
-- select * from t where '2020-01-31' is null;
-- order by, need null
create table t(id int);
insert into t values (1);
insert into t values (2);
insert into t values (3);
insert into t values (null);
select * from t order by id asc;
drop table t;

create table t(addr char(10));
insert into t values ('wefw');
insert into t values ('1');
insert into t values ('2');
insert into t values ('3');
select avg(addr) from t;
drop table t;

INSERT INTO Typecast_table_4 VALUES(1,1,1);
SUCCESS
SELECT * FROM Typecast_table_4 WHERE 'a'<1;
-1 | 1 | 1
-ID | NAME | AGE
-SELECT * FROM Typecast_table_4 WHERE '1a'>0;
-1 | 1 | 1
-ID | NAME | AGE
-SELECT * FROM Typecast_table_4 WHERE '1a'>0.5;
-1 | 1 | 1

3 | 15 | ABC | 3
11. SELECT SINGLE AND AGGREGATION
SELECT id,avg(num),addr FROM aggregation_func;
-FAILURE
+ID | ADDR | AVG(NUM)
+1 | ABC | 15
SELECT max(id),min(num),birthday FROM aggregation_func;
-FAILURE
+BIRTHDAY | MIN(NUM) | MAX(ID)
+2020-01-01 | 12 | 4


select avg(t_basic_2.score) from t_basic_2;

create table t_basic_2(id int, age int, name char, score float);
insert into t_basic_2 values(1,1, 'a', 1.0);
insert into t_basic_2 values(2,2, 'b', 2.0);
insert into t_basic_2 values(4,4, 'c', 3.0);
insert into t_basic_2 values(3,3, 'd', 4.0);
insert into t_basic_2 values(5,5, 'e', 5.5);
insert into t_basic_2 values(6,6, 'f', 6.6);
insert into t_basic_2 values(7,7, 'g', 7.7);
select * from t_basic_2;
select id, avg(id) from t_basic_2;
select avg(id),count(*),max(id),min(id) from t_basic_2;
select avg(t_basic_2.score),count(*),max(age),min(score) from t_basic_2;
select avg(3),count(1) from t_basic_2;
select avg(3.4),max(1.1),min(-1.1) from t_basic_2;
select max(3.456),min(age),avg(t_basic_2.age) from t_basic_2;
select count(4),max(name) from t_basic_2;
select count(*,id) from t_basic_2;
select count() from t_basic_2;
select count(b) from t_basic_2;
create table t_basic_3(id int, age int, name char, score float);
select avg(id),max(age),min(name),count(score) from t_basic_3;
select sum(id), sum(1.2), sum(t_basic_2.score) from t_basic_2;
drop table t_basic_2;
drop table t_basic_3;

INSERT INTO aggregation_func VALUES (5, 18, 10.0, '1abc', '2022-01-01');
SUCCESS
SELECT avg(addr) from aggregation_func;
-AVG(ADDR)
-0.2
\ No newline at end of file
+FAILURE
create table t(i1 int, i2 int, i3 int, i4 int, i5 date);
insert into t values(5,18,10.0, '1', '2022-01-01');
insert into t values(1,3,2,5, '1993-12-04');
select avg(i1) from t;
select avg(i2) from t;
select avg(i3) from t;
select avg(i4) from t;
select avg(i5) from t;
drop table t;

create table t(a char);
insert into t values ('ww');
insert into t values ('1');
insert into t values ('2.5');
insert into t values ('ww');
select avg(a) from t;
drop table t;

/*
SUCCESS
SUCCESS
SUCCESS
SUCCESS
SUCCESS
SUCCESS
SUCCESS
SUCCESS
id | age | name | score
1 | 1 | a | 1
2 | 2 | b | 2
4 | 4 | c | 3
3 | 3 | d | 4
5 | 5 | e | 5.5
6 | 6 | f | 6.6
7 | 7 | g | 7.7
avg(id) | count(*) | max(id) | min(id)
4 | 7 | 7 | 1
avg(t_basic_2.score) | count(*) | max(age) | min(score)
4.26 | 7 | 7 | 1
avg(3) | count(1)
3 | 7
avg(3.4) | max(1.1) | min(-1.1)
3.4 | 1.1 | -1.1
max(3.456) | min(age) | avg(t_basic_2.age)
3.46 | 1 | 4
count(4) | max(name)
7 | g
FAILURE
FAILURE
FAILURE
SUCCESS
avg(id) | max(age) | min(name) | count(score)
SUCCESS
SUCCESS

*/
drop table t;
create table t(id int);
insert into t values (1),(2),(3);
select avg(id) from t;
drop table t;

create table t(id int);
insert into t values(null);
insert into t values(null);
insert into t values(null);
select count(*) from t;
select count(id) from t;
drop table t;

create table t(id int nullable, age float nullable, addr char nullable, d date nullable);
insert into t values (null, null, null, null);
select * from t;
select count(*) from t;
select count(id) from t;
select min(id) from t;
select max(id) from t;
select avg(id) from t;
select sum(id) from t;
drop table t;

CREATE TABLE aggregation_func(id int, num int, price float, addr char, birthday date);
INSERT INTO aggregation_func VALUES (1, 18, 10.0, 'abc', '2020-01-01');
INSERT INTO aggregation_func VALUES (2, 15, 20.0, 'abc', '2010-01-11');
INSERT INTO aggregation_func VALUES (3, 12, 30.0, 'def', '2021-01-21');
INSERT INTO aggregation_func VALUES (4, 15, 30.0, 'dei', '2021-01-31');
SELECT count(*) FROM aggregation_func;
SELECT count(num) FROM aggregation_func;
SELECT min(num) FROM aggregation_func;
SELECT min(price) FROM aggregation_func;
SELECT min(addr) FROM aggregation_func;
SELECT max(num) FROM aggregation_func;
SELECT max(price) FROM aggregation_func;
SELECT max(addr) FROM aggregation_func;
SELECT avg(num) FROM aggregation_func;
SELECT avg(price) FROM aggregation_func;

SELECT min(*) FROM aggregation_func;
SELECT max(*) FROM aggregation_func;
SELECT avg(*) FROM aggregation_func;
SELECT count(*,num) FROM aggregation_func;
SELECT min(num,price) FROM aggregation_func;
SELECT max(num,price) FROM aggregation_func;
SELECT avg(num,price) FROM aggregation_func;
SELECT count() FROM aggregation_func;
SELECT min() FROM aggregation_func;
SELECT max() FROM aggregation_func;
SELECT avg() FROM aggregation_func;
SELECT count(id2) FROM aggregation_func;
SELECT min(id2) FROM aggregation_func;
SELECT max(id2) FROM aggregation_func;
SELECT avg(id2) FROM aggregation_func;

SELECT min(num),max(num),avg(num) FROM aggregation_func;
drop table aggregation_func;

/*

COUNT(*)
4

COUNT(NUM)
4

MIN(NUM)
12

MIN(PRICE)
10

MIN(ADDR)
ABC

MAX(NUM)
18

MAX(PRICE)
30

MAX(ADDR)
DEI

AVG(NUM)
15

AVG(PRICE)
22.5

FAILURE
FAILURE
FAILURE
FAILURE
FAILURE
FAILURE
FAILURE
FAILURE
FAILURE
FAILURE
FAILURE
FAILURE
FAILURE
FAILURE
FAILURE

MIN(NUM) | MAX(NUM) | AVG(NUM)
12 | 18 | 15





*/




-- aggregation
select count(*,id) from t;
select count() from t;
select count(not_exists_col) from t;

create table t(id int, name char(4), age float);
insert into t values(1.9,'3.5',11.5);
insert into t values(0,1.5,11.5);
insert into t values(0,2.5,9.5);
select * from t;
drop table t;

INSERT INTO Typecast_table_2 VALUES(1.9,'3.5',11.5);
SUCCESS
SELECT * FROM Typecast_table_2;
-0 | 1.5 | 9.5
-1 | 2.5 | 10.5
+0 | 1.50 | 9.5
+1 | 2.50 | 10.5
2 | 3.5 | 11.5
ID | NAME | AGE
SELECT * FROM Typecast_table_2 WHERE age<=10;


-- inserts
CREATE TABLE insert_table(id int, t_name char(4), col1 int, col2 int);
INSERT INTO insert_table VALUES (1,'N1',1,1);
INSERT INTO insert_table VALUES (2,'N2',1,1),(3,'N3',2,1);
INSERT INTO insert_table VALUES (4,'N4',1,1),(1,1,1);
INSERT INTO insert_table VALUES (4,'N4',1,1),(1,1,1,1);
select * from insert_table;
drop table insert_table;
/*
SUCCESS
SUCCESS
SUCCESS
FAILURE
FAILURE
SELECT * FROM insert_table;
1 | N1 | 1 | 1
2 | N2 | 1 | 1
3 | N3 | 2 | 1
ID | T_NAME | COL1 | COL2

*/

3 | 3 | 3
ID | NAME | AGE
SELECT * FROM Typecast_table_3 WHERE id<'1.5a';
-1 | 1 | 1
ID | NAME | AGE
SELECT * FROM Typecast_table_3 WHERE id>='3a';
3 | 3 | 3


--typecast
create table t(id int, name char(4), age float);
insert into t values(1.9,'3.5',11.5);
insert into t values(0,1.5,11.5);
insert into t values(0,2.5,9.5);
insert into t values(23.3244, '4AA', 'wefwof');
insert into t values('3ewA', 1.324, 4);
select * from t;
select * from t where id < '1';
select * from t where 'a'<1;
drop table t;

create table t(id int);
insert into t values('2');
select * from t;
update t set id=1.1;
update t set id='33';
select * from t where id='3';
create table t(id int, name char, year float);
insert into t values('2', 1, 1);
insert into t values(1.4, 1.5, '3.3');
select * from t;
select * from t where id < '1.5a';
select * from t where id='1a';
select * from t where id='a';
select * from t where id>='1a';
select * from t where id<'1.5a';
drop table t;

create table t1(id int, name char(4), age float);
insert into t1 values(0,'C',0);
insert into t1 values(1,'A',11.5);
insert into t1 values(2,'B',11.5);
insert into t1 values(3,'1C',10.5);
SELECT * FROM t1 WHERE name>=1;
drop table t1;

--selects
CREATE TABLE Select_tables_1(id int, age int, u_name char);
CREATE TABLE Select_tables_2(id int, age int, u_name char);
CREATE TABLE Select_tables_3(id int, res int, u_name char);
CREATE TABLE Select_tables_4(id int, age int, u_name char);
CREATE TABLE Select_tables_5(id int, res int, u_name char);

INSERT INTO Select_tables_1 VALUES (1,18,'a');
INSERT INTO Select_tables_1 VALUES (2,15,'b');
INSERT INTO Select_tables_2 VALUES (1,20,'a');
INSERT INTO Select_tables_2 VALUES (2,21,'c');
INSERT INTO Select_tables_3 VALUES (1,35,'a');
INSERT INTO Select_tables_3 VALUES (2,37,'a');
INSERT INTO Select_tables_4 VALUES (1, 2, 'a');
INSERT INTO Select_tables_4 VALUES (1, 3, 'b');
INSERT INTO Select_tables_4 VALUES (2, 2, 'c');
INSERT INTO Select_tables_4 VALUES (2, 4, 'd');
INSERT INTO Select_tables_5 VALUES (1, 10, 'g');
INSERT INTO Select_tables_5 VALUES (1, 11, 'f');
INSERT INTO Select_tables_5 VALUES (2, 12, 'c');

SELECT * FROM Select_tables_1,Select_tables_2,Select_tables_3;
SELECT Select_tables_1.id,Select_tables_2.u_name,Select_tables_3.res FROM Select_tables_1,Select_tables_2,Select_tables_3;
Select Select_tables_1.res FROM Select_tables_1,Select_tables_2,Select_tables_3;
SELECT * FROM Select_tables_1,Select_tables_2,Select_tables_3 WHERE Select_tables_1.u_name=Select_tables_2.u_name AND Select_tables_2.u_name=Select_tables_3.u_name;
SELECT * FROM Select_tables_1,Select_tables_2,Select_tables_3 WHERE Select_tables_1.id=Select_tables_2.id AND Select_tables_3.res=35;
SELECT * FROM Select_tables_1,Select_tables_2,Select_tables_3 WHERE Select_tables_1.age<18 AND Select_tables_2.u_name='c' AND Select_tables_3.res=35 AND Select_tables_1.id=Select_tables_2.id AND Select_tables_2.id=Select_tables_3.id;
SELECT Select_tables_2.age FROM Select_tables_1,Select_tables_2 WHERE Select_tables_1.age<18 AND Select_tables_2.u_name='c' AND Select_tables_1.id=Select_tables_2.id;
SELECT * from Select_tables_4, Select_tables_5 where Select_tables_4.id=Select_tables_5.id;
select * from Select_tables_4, Select_tables_5 where Select_tables_4.id >= Select_tables_5.id;
CREATE TABLE Select_tables_6(id int, res int);

SELECT Select_tables_1.id,Select_tables_6.id from Select_tables_1, Select_tables_6 where Select_tables_1.id=Select_tables_6.id;

drop table Select_tables_1;
drop table Select_tables_2;
drop table Select_tables_3;
drop table Select_tables_4;
drop table Select_tables_5;
drop table Select_tables_6;

/*
1 | 18 | A | 1 | 20 | A | 1 | 35 | A
1 | 18 | A | 1 | 20 | A | 2 | 37 | A
1 | 18 | A | 2 | 21 | C | 1 | 35 | A
1 | 18 | A | 2 | 21 | C | 2 | 37 | A
2 | 15 | B | 1 | 20 | A | 1 | 35 | A
2 | 15 | B | 1 | 20 | A | 2 | 37 | A
2 | 15 | B | 2 | 21 | C | 1 | 35 | A
2 | 15 | B | 2 | 21 | C | 2 | 37 | A
SELECT_TABLES_1.ID | SELECT_TABLES_1.AGE | SELECT_TABLES_1.U_NAME | SELECT_TABLES_2.ID | SELECT_TABLES_2.AGE | SELECT_TABLES_2.U_NAME | SELECT_TABLES_3.ID | SELECT_TABLES_3.RES | SELECT_TABLES_3.U_NAME

1 | A | 35
1 | A | 37
1 | C | 35
1 | C | 37
2 | A | 35
2 | A | 37
2 | C | 35
2 | C | 37
SELECT_TABLES_1.ID | SELECT_TABLES_2.U_NAME | SELECT_TABLES_3.RES

FAILURE

1 | 18 | A | 1 | 20 | A | 1 | 35 | A
1 | 18 | A | 1 | 20 | A | 2 | 37 | A
SELECT_TABLES_1.ID | SELECT_TABLES_1.AGE | SELECT_TABLES_1.U_NAME | SELECT_TABLES_2.ID | SELECT_TABLES_2.AGE | SELECT_TABLES_2.U_NAME | SELECT_TABLES_3.ID | SELECT_TABLES_3.RES | SELECT_TABLES_3.U_NAME

\

1 | 18 | A | 1 | 20 | A | 1 | 35 | A
2 | 15 | B | 2 | 21 | C | 1 | 35 | A
SELECT_TABLES_1.ID | SELECT_TABLES_1.AGE | SELECT_TABLES_1.U_NAME | SELECT_TABLES_2.ID | SELECT_TABLES_2.AGE | SELECT_TABLES_2.U_NAME | SELECT_TABLES_3.ID | SELECT_TABLES_3.RES | SELECT_TABLES_3.U_NAME

21
SELECT_TABLES_2.AGE

1 | 2 | A | 1 | 10 | G
1 | 2 | A | 1 | 11 | F
1 | 3 | B | 1 | 10 | G
1 | 3 | B | 1 | 11 | F
2 | 2 | C | 2 | 12 | C
2 | 4 | D | 2 | 12 | C
SELECT_TABLES_4.ID | SELECT_TABLES_4.AGE | SELECT_TABLES_4.U_NAME | SELECT_TABLES_5.ID | SELECT_TABLES_5.RES | SELECT_TABLES_5.U_NAME

1 | 2 | A | 1 | 10 | G
1 | 2 | A | 1 | 11 | F
1 | 3 | B | 1 | 10 | G
1 | 3 | B | 1 | 11 | F
2 | 2 | C | 1 | 10 | G
2 | 2 | C | 1 | 11 | F
2 | 2 | C | 2 | 12 | C
2 | 4 | D | 1 | 10 | G
2 | 4 | D | 1 | 11 | F
2 | 4 | D | 2 | 12 | C
SELECT_TABLES_4.ID | SELECT_TABLES_4.AGE | SELECT_TABLES_4.U_NAME | SELECT_TABLES_5.ID | SELECT_TABLES_5.RES | SELECT_TABLES_5.U_NAME

SUCCESS

SELECT_TABLES_1.ID | SELECT_TABLES_6.ID

*/
CREATE TABLE date_table(id int, u_date date);
CREATE INDEX index_id on date_table(u_date);

INSERT INTO date_table VALUES (1,'2020-01-21');
DELETE FROM date_table WHERE u_date>'2012-2-29';
drop table date_table;

CREATE TABLE date_table(id int, u_date date);
INSERT INTO date_table VALUES (1,'2020-01-21');
--date
CREATE TABLE date_table(id int, u_date date);
CREATE INDEX index_id on date_table(u_date);

INSERT INTO date_table VALUES (1,'2020-01-21');
INSERT INTO date_table VALUES (2,'2020-10-21');
INSERT INTO date_table VALUES (3,'2020-1-01');
INSERT INTO date_table VALUES (4,'2020-01-1');
INSERT INTO date_table VALUES (5,'2019-12-21');
INSERT INTO date_table VALUES (6,'2016-2-29');
INSERT INTO date_table VALUES (7,'1970-1-1');
INSERT INTO date_table VALUES (8,'2000-01-01');
INSERT INTO date_table VALUES (9,'2038-1-19');

SELECT * FROM date_table WHERE u_date>'2020-1-20';
SELECT * FROM date_table WHERE u_date<'2019-12-31';
SELECT * FROM date_table WHERE u_date='2020-1-1';

DELETE FROM date_table WHERE u_date>'2012-2-29';
SELECT * FROM date_table;
\

SELECT * FROM date_table WHERE u_date='2017-2-29';
SELECT * FROM date_table WHERE u_date='2017-21-29';
SELECT * FROM date_table WHERE u_date='2017-12-32';
SELECT * FROM date_table WHERE u_date='2017-11-31';

INSERT INTO date_table VALUES (10,'2017-2-29');
INSERT INTO date_table VALUES (11,'2017-21-29');
INSERT INTO date_table VALUES (12,'2017-12-32');
INSERT INTO date_table VALUES (13,'2017-11-31');
drop table date_table;

/*
1 | 2020-01-21
2 | 2020-10-21
9 | 2038-01-19
ID | U_DATE

5 | 2019-12-21
6 | 2016-02-29
7 | 1970-01-01
8 | 2000-01-01
ID | U_DATE

3 | 2020-01-01
4 | 2020-01-01
ID | U_DATE

DELETE
SUCCESS

7 | 1970-01-01
8 | 2000-01-01
ID | U_DATE
*/

--update

CREATE TABLE t(id int, t_name char(4), col1 int, col2 int);
CREATE INDEX index_id on t(id);
INSERT INTO t VALUES (1,'N1',1,1);
INSERT INTO t VALUES (2,'N2',1,1);
INSERT INTO t VALUES (3,'N3',2,1);
UPDATE t SET t_name='N01' WHERE id=1;
SELECT * FROM t;
UPDATE t SET col2=0 WHERE col1=1;
SELECT * FROM t;
UPDATE t SET id=4 WHERE t_name='N3';
SELECT * FROM t;
UPDATE t SET col1=0;
SELECT * FROM t;
UPDATE t SET t_name='N02' WHERE col1=0 AND col2=0;
SELECT * FROM t;
UPDATE Update_table_2 SET t_name='N01', id=1 WHERE id=1;
UPDATE t SET t_name_false='N01', id=13 WHERE id=1;
UPDATE t SET t_name='N01', www='3' WHERE id_false=1;
UPDATE t SET t_name='N01', id=199 WHERE id=100;
SELECT * FROM t;
UPDATE t SET col1='N01' WHERE id=1;
SELECT * FROM t;
drop table t;
/*
SUCCESS
SUCCESS
SUCCESS
SUCCESS
SUCCESS

SUCCESS
1 | N01 | 1 | 1
2 | N2 | 1 | 1
3 | N3 | 2 | 1
ID | T_NAME | COL1 | COL2

SUCCESS
1 | N01 | 1 | 0
2 | N2 | 1 | 0
3 | N3 | 2 | 1
ID | T_NAME | COL1 | COL2

SUCCESS
1 | N01 | 1 | 0
2 | N2 | 1 | 0
4 | N3 | 2 | 1
ID | T_NAME | COL1 | COL2

SUCCESS
1 | N01 | 0 | 0
2 | N2 | 0 | 0
4 | N3 | 0 | 1
ID | T_NAME | COL1 | COL2

SUCCESS
1 | N02 | 0 | 0
2 | N02 | 0 | 0
4 | N3 | 0 | 1
ID | T_NAME | COL1 | COL2

FAILURE
FAILURE
FAILURE

SUCCESS
SELECT * FROM Update_table_1;
1 | N02 | 0 | 0
2 | N02 | 0 | 0
4 | N3 | 0 | 1
ID | T_NAME | COL1 | COL2


FAILURE
*/

-- drop table
-- -- echo 1. Drop empty table
CREATE TABLE Drop_table_1(id int, t_name char);
DROP TABLE Drop_table_1;
CREATE TABLE Drop_table_2(id int, t_name char);
INSERT INTO Drop_table_2 VALUES (1,'OB');
DROP TABLE Drop_table_2;
CREATE TABLE Drop_table_3(id int, t_name char);
INSERT INTO Drop_table_3 VALUES (1,'OB');
DROP TABLE Drop_table_3;
INSERT INTO Drop_table_3 VALUES (1,'OB');
SELECT * FROM Drop_table_3;
DELETE FROM Drop_table_3 WHERE id = 3;
CREATE TABLE Drop_table_3(id int, t_name char);
CREATE TABLE Drop_table_4(id int, t_name char);
DROP TABLE Drop_table_4;
DROP TABLE Drop_table_4;
DROP TABLE Drop_table_4_1;
CREATE TABLE Drop_table_5(id int, t_name char);
DROP TABLE Drop_table_5;
CREATE TABLE Drop_table_5(id int, t_name char);
SELECT * FROM Drop_table_5;
CREATE TABLE Drop_table_6(id int, t_name char);
CREATE INDEX index_id on Drop_table_6(id);
INSERT INTO Drop_table_6 VALUES (1,'OB');
DROP TABLE Drop_table_6;
SELECT * FROM Drop_table_6;


-- meta

create table t(id int, age int);
delete from t where id=1;
delete from t where age=3;
drop table t;
insert into t values(1,1);
insert into t values(2,2);
select *, * from t1;
select *,id from t1;
select *,age from t1;
select *,age,id,age,id,* from t1;

-- basic

create table t_basic(id int, age int, name char, score float);
insert into t_basic values(1,1, 'a', 1.0);
insert into t_basic values(2,2, 'b', 2.0);
insert into t_basic values(4,4, 'c', 3.0);
insert into t_basic values(3,3, 'd', 4.0);
insert into t_basic values(5,5, 'e', 5.5);
insert into t_basic values(6,6, 'f', 6.6);
insert into t_basic values(7,7, 'g', 7.7);
select * from t_basic;
delete from t_basic where id<3;
select * from t_basic;
select * from t_basic where id=1;
select * from t_basic where id>=5;
select * from t_basic where age>1 and age<3;
select * from t_basic where t_basic.id=1 and t_basic.age=1;
select * from t_basic where id=1 and age=1;
select id, age, name, score from t_basic;
select t_basic.id, t_basic.age, t_basic.name, t_basic.score from t_basic;
select t_basic.id, t_basic.age, name from t_basic;
create index i_id on t_basic (id);
select * from t_basic;
drop table t_basic;

/*
1 | 1 | A | 1
2 | 2 | B | 2
3 | 3 | D | 4
4 | 4 | C | 3
5 | 5 | E | 5.5
6 | 6 | F | 6.6
7 | 7 | G | 7.7
ID | AGE | NAME | SCORE

1 | 1 | A | 1
2 | 2 | B | 2
4 | 4 | C | 3
5 | 5 | E | 5.5
6 | 6 | F | 6.6
7 | 7 | G | 7.7
ID | AGE | NAME | SCORE

ID | AGE | NAME | SCORE
1 | 1 | A | 1

5 | 5 | E | 5.5
6 | 6 | F | 6.6
7 | 7 | G | 7.7
ID | AGE | NAME | SCORE

ID | AGE | NAME | SCORE
2 | 2 | B | 2

ID | AGE | NAME | SCORE
1 | 1 | A | 1

ID | AGE | NAME | SCORE
1 | 1 | A | 1


1 | 1 | A | 1
2 | 2 | B | 2
4 | 4 | C | 3
5 | 5 | E | 5.5
6 | 6 | F | 6.6
7 | 7 | G | 7.7
ID | AGE | NAME | SCORE

1 | 1 | A | 1
2 | 2 | B | 2
4 | 4 | C | 3
5 | 5 | E | 5.5
6 | 6 | F | 6.6
7 | 7 | G | 7.7
ID | AGE | NAME | SCORE

1 | 1 | A
2 | 2 | B
4 | 4 | C
5 | 5 | E
6 | 6 | F
7 | 7 | G
ID | AGE | NAME

1 | 1 | A | 1
2 | 2 | B | 2
4 | 4 | C | 3
5 | 5 | E | 5.5
6 | 6 | F | 6.6
7 | 7 | G | 7.7
ID | AGE | NAME | SCORE


*/
