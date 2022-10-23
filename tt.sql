-- echo basic insert

create table t_basic(id int, age int, name char, score float);
insert into t_basic values(1,1, 'a', 1.0);
insert into t_basic values(2,2, 'b', 2.0);
insert into t_basic values(4,4, 'c', 3.0);
insert into t_basic values(3,3, 'd', 4.0);
insert into t_basic values(5,5, 'e', 5.5);
insert into t_basic values(6,6, 'f', 6.6);
insert into t_basic values(7,7, 'g', 7.7);

select * from t_basic;

-- echo basic delete
delete from t_basic where id=3;
select * from t_basic;

-- echo basic select
select * from t_basic where id=1;

select * from t_basic where id>=5;

select * from t_basic where age>1 and age<3;

select * from t_basic where t_basic.id=1 and t_basic.age=1;

select * from t_basic where id=1 and age=1;

select id, age, name, score from t_basic;

select t_basic.id, t_basic.age, t_basic.name, t_basic.score from t_basic;

select t_basic.id, t_basic.age, name from t_basic;

-- echo create index
create index i_id on t_basic (id);
select * from t_basic;

-- echo initialization
CREATE TABLE date_table(id int, u_date date);
CREATE INDEX index_id on date_table(u_date);

-- echo 1. insert normal date data
INSERT INTO date_table VALUES (1,'2020-01-21');
INSERT INTO date_table VALUES (2,'2020-10-21');
INSERT INTO date_table VALUES (3,'2020-1-01');
INSERT INTO date_table VALUES (4,'2020-01-1');
INSERT INTO date_table VALUES (5,'2019-12-21');
INSERT INTO date_table VALUES (6,'2016-2-29');
INSERT INTO date_table VALUES (7,'1970-1-1');
INSERT INTO date_table VALUES (8,'2000-01-01');
INSERT INTO date_table VALUES (9,'2038-1-19');

-- echo 2. compare date data
SELECT * FROM date_table WHERE u_date>'2020-1-20';
SELECT * FROM date_table WHERE u_date<'2019-12-31';
SELECT * FROM date_table WHERE u_date='2020-1-1';

-- echo 3. delete data
DELETE FROM date_table WHERE u_date>'2012-2-29';
SELECT * FROM date_table;

-- echo 4. check invalid date data
SELECT * FROM date_table WHERE u_date='2017-2-29';
SELECT * FROM date_table WHERE u_date='2017-21-29';
SELECT * FROM date_table WHERE u_date='2017-12-32';
SELECT * FROM date_table WHERE u_date='2017-11-31';

INSERT INTO date_table VALUES (10,'2017-2-29');
INSERT INTO date_table VALUES (11,'2017-21-29');
INSERT INTO date_table VALUES (12,'2017-12-32');
INSERT INTO date_table VALUES (13,'2017-11-31');


-- echo initialization
CREATE TABLE Update_table_1(id int, t_name char, col1 int, col2 int);
CREATE INDEX index_id on Update_table_1(id);
INSERT INTO Update_table_1 VALUES (1,'N1',1,1);
INSERT INTO Update_table_1 VALUES (2,'N2',1,1);
INSERT INTO Update_table_1 VALUES (3,'N3',2,1);

-- echo 1. update a row
UPDATE Update_table_1 SET t_name='N01' WHERE id=1;
SELECT * FROM Update_table_1;

-- echo 2. update rows
UPDATE Update_table_1 SET col2=0 WHERE col1=1;
SELECT * FROM Update_table_1;

-- echo 3. update a index column
UPDATE Update_table_1 SET id=4 WHERE t_name='N3';
SELECT * FROM Update_table_1;

-- echo 4. update without conditions
UPDATE Update_table_1 SET col1=0;
SELECT * FROM Update_table_1;

-- echo 5. update with conditions
UPDATE Update_table_1 SET t_name='N02' WHERE col1=0 AND col2=0;
SELECT * FROM Update_table_1;

-- echo 6. update non-existent table
UPDATE Update_table_2 SET t_name='N01' WHERE id=1;

-- echo 7. update non-existent column
UPDATE Update_table_1 SET t_name_false='N01' WHERE id=1;

-- echo 8. update with invalid condition
UPDATE Update_table_1 SET t_name='N01' WHERE id_false=1;

-- echo 9. update in vain
UPDATE Update_table_1 SET t_name='N01' WHERE id=100;
SELECT * FROM Update_table_1;

-- echo 10. update with invalid value
UPDATE Update_table_1 SET col1='N01' WHERE id=1;

-- echo initialization
CREATE TABLE Select_meta(id int, age int);

-- echo 1. select from a non-existent table
select * from no_table;

-- echo 2. select from a non-existent column
select home from Select_meta;
select * from Select_meta where home='001';


-- echo initialization
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

-- echo insert data into select_tables_4 and select_tables_5
INSERT INTO Select_tables_4 VALUES (1, 2, 'a');
INSERT INTO Select_tables_4 VALUES (1, 3, 'b');
INSERT INTO Select_tables_4 VALUES (2, 2, 'c');
INSERT INTO Select_tables_4 VALUES (2, 4, 'd');
INSERT INTO Select_tables_5 VALUES (1, 10, 'g');
INSERT INTO Select_tables_5 VALUES (1, 11, 'f');
INSERT INTO Select_tables_5 VALUES (2, 12, 'c');

-- echo 1. multi-table query
SELECT * FROM Select_tables_1,Select_tables_2,Select_tables_3;
SELECT Select_tables_1.id,Select_tables_2.u_name,Select_tables_3.res FROM Select_tables_1,Select_tables_2,Select_tables_3;
Select Select_tables_1.res FROM Select_tables_1,Select_tables_2,Select_tables_3;

-- echo 2. conditional query
SELECT * FROM Select_tables_1,Select_tables_2,Select_tables_3 WHERE Select_tables_1.u_name=Select_tables_2.u_name AND Select_tables_2.u_name=Select_tables_3.u_name;
SELECT * FROM Select_tables_1,Select_tables_2,Select_tables_3 WHERE Select_tables_1.id=Select_tables_2.id AND Select_tables_3.res=35;
SELECT * FROM Select_tables_1,Select_tables_2,Select_tables_3 WHERE Select_tables_1.age<18 AND Select_tables_2.u_name='c' AND Select_tables_3.res=35 AND Select_tables_1.id=Select_tables_2.id AND Select_tables_2.id=Select_tables_3.id;
SELECT Select_tables_2.age FROM Select_tables_1,Select_tables_2 WHERE Select_tables_1.age<18 AND Select_tables_2.u_name='c' AND Select_tables_1.id=Select_tables_2.id;

-- echo 3. duplicate key query
SELECT * from Select_tables_4, Select_tables_5 where Select_tables_4.id=Select_tables_5.id;
select * from Select_tables_4, Select_tables_5 where Select_tables_4.id >= Select_tables_5.id;

-- echo 4. join empty table
CREATE TABLE Select_tables_6(id int, res int);
SELECT Select_tables_1.id,Select_tables_6.id from Select_tables_1, Select_tables_6 where Select_tables_1.id=Select_tables_6.id;


-- echo initialization
CREATE TABLE aggregation_func(id int, num int, price float, addr char, birthday date);

INSERT INTO aggregation_func VALUES (1, 18, 10.0, 'abc', '2020-01-01');
INSERT INTO aggregation_func VALUES (2, 15, 20.0, 'abc', '2010-01-11');
INSERT INTO aggregation_func VALUES (3, 12, 30.0, 'def', '2021-01-21');
INSERT INTO aggregation_func VALUES (4, 15, 30.0, 'dei', '2021-01-31');

-- echo 1. count
SELECT count(*) FROM aggregation_func;

SELECT count(num) FROM aggregation_func;

-- echo 2. min
SELECT min(num) FROM aggregation_func;

SELECT min(price) FROM aggregation_func;

SELECT min(addr) FROM aggregation_func;

-- echo 3. max
SELECT max(num) FROM aggregation_func;

SELECT max(price) FROM aggregation_func;

SELECT max(addr) FROM aggregation_func;

-- echo 4. avg
SELECT avg(num) FROM aggregation_func;

SELECT avg(price) FROM aggregation_func;

-- echo 5. error with *
SELECT min(*) FROM aggregation_func;
SELECT max(*) FROM aggregation_func;
SELECT avg(*) FROM aggregation_func;

-- echo 6. error with redundant columns
SELECT count(*,num) FROM aggregation_func;
SELECT min(num,price) FROM aggregation_func;
SELECT max(num,price) FROM aggregation_func;
SELECT avg(num,price) FROM aggregation_func;

-- echo 7. error with empty columns
SELECT count() FROM aggregation_func;
SELECT min() FROM aggregation_func;
SELECT max() FROM aggregation_func;
SELECT avg() FROM aggregation_func;

-- echo 8. error with non-existent columns
SELECT count(id2) FROM aggregation_func;
SELECT min(id2) FROM aggregation_func;
SELECT max(id2) FROM aggregation_func;
SELECT avg(id2) FROM aggregation_func;

-- echo 9. select many aggregation
SELECT min(num),max(num),avg(num) FROM aggregation_func;
