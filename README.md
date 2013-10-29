# MavlinkTest 项目记录
----
## 存在的问题

#### 参考网站
* http://www.sqlite.org/
* 

#### 未解决问题
1. 为什么要建立数据库索引（index）
2. 暂时在 googleMapViewController 中检测 app 是否第一次启动，以后要改在别的地方执行
3. 将mapView 上的 marker 提取 coordinate，放入全局的 NSArray 中，然后按下保存键后，将 coordinate 和 path 放入数据库
	

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
----
##### 关于Objective-C
- 什么是 Build 和 Version，如何设置 Xcode 项目中的 Build 和 Version
	* http://stackoverflow.com/questions/6851660/version-vs-build-in-xcode-4
	* http://blog.csdn.net/holydancer/article/details/8895699
		* CFBundleShortVersionString - Version
		* CFBundleVersion - Build
		* 以上两项数据都可以通过下列语句获取
		
			```
			NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
		    NSString *build = infoDictionary[(NSString *)kCFBundleVersionKey];
		    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
			```
----
- 如何检测第一次启动 app
	
	```
	NSString *bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];

	NSString *appFirstStartOfVersionKey = [NSString stringWithFormat:@"first_start_%@", bundleVersion];

	NSNumber *alreadyStartedOnVersion = [[NSUserDefaults standardUserDefaults] objectForKey:appFirstStartOfVersionKey];
	if(!alreadyStartedOnVersion || [alreadyStartedOnVersion boolValue] == NO) {
    	[self firstStartCode];
    	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:appFirstStartOfVersionKey];
	}
	```
	* `NSBundle`是什么意思？
	* `NSUserDefaults`是什么意思？
	
##### 关于其他

- git push >> fatal: no configured push destination
	* 参考：http://stackoverflow.com/questions/10032964/git-push-fatal-no-configured-push-destination
	
	```
	kavi-chens-MacBook-Air:MavlinkTest kavi$ git remote add origin git@github.com:kavichen/MavlinkTest.git
	kavi-chens-MacBook-Air:MavlinkTest kavi$ git push origin master
	```
---