# MavlinkTest 项目记录
----
## 存在的问题

#### 参考网站
* http://www.sqlite.org/
* 

#### 未解决问题
1. 为什么要建立数据库索引（index）
2. 如何检测第一次启动 app


#### 已解决问题
##### 关于数据库
----
- 在 sqlite3 中，integer 和 int 类型之间的却别
	* 参考：http://stackoverflow.com/questions/7337882/sqlite-and-integer-types-int-integer-bigint
	* 在 sqlite3中，INTEGER 是一个 dynamic typing，可以用来代表许多类型，参考之下链接（其他类型也是相同情况）
	* http://www.sqlite.org/datatype3.html	
----
- primary key如何 auto increment
  
	```
	CREATE TABLE t1 coordinate IF NOT EXISTS coordinate
	(
  	id INTEGER PRIMARY KEY AUTOINCREMENT,
  	latitude REAL NOT NULL,
  	longitude REAL NOT NULL
	)
	```
----
- sqlite3 中的 insert语句 

	```
	sqlite> INSERT INTO Books(Id, Title, Author, ISBN)
   	...> VALUES(1, 'War and Peace', 'Leo Tolstoy', '978-0345472403');
	```
---
##### 关于 app
