# MavlinkTest 项目记录
----
## 存在的问题

#### 参考网站
* http://www.sqlite.org/

#### 未解决问题
1. 为什么要建立数据库索引（index）
2. 暂时在 googleMapViewController 中检测 app 是否第一次启动，以后要改在别的地方执行
3. 自定义 marker 的UI选择（Menu）
	* https://github.com/levey/AwesomeMenu
4. 找一个侧边栏的 UI，通过滑动可以获取存入数据库的 path
	* 找一个开源的侧边栏
		* ~~https://github.com/romaonthego/REFrostedViewController~~ 
		* https://github.com/rnystrom/RNFrostedSidebar
		* https://github.com/edgecase/ecslidingviewcontroller  http://vimeo.com/35959384


#### 已解决问题
* ~~将mapView 上的 marker 提取 coordinate，放入全局的 GMSMutablePath 中，然后按下保存键后，将 coordinate 和 path 放入数据库~~
	* ~~建立 tmpPath~~
	* ~~长按 mapView 时，在该 coordinate 上建立一个新的 marke~~r
	* ~~在新建的 Marker 的 infowindow 上，显示该坐标的序号~~
	* ~~没有数据传入 tmpPath，怀疑是 get set 的问题~~
	* ~~marker = <GMSMarker: 0x1877d1f0> (null) (22.325050, 113.402804), <UIImage: 0x187839e0> // 其中有一个 null~~
	* ~~在 GMSPath 中找到特定的 marker~~
	* ~~2013-10-31 11:22:03.270 MavlinkTest[5023:70b] INSERT INTO 		coordinate(latitude,longitude)VALUES(-180.000000,-180.000000);
		2013-10-31 11:22:03.272 MavlinkTest[5023:70b] marker6 added // 最后一个点坐标错误~~

#### 问题归档
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
	
----
- 在显示 UIButton 时，没有出现自定义按钮的图片，而出现了蓝色的按钮
	* 原代码:  
	`UIButton *addPathButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];`
	* iOS7中代码：  
	`UIButton *addPathButton = [UIButton buttonWithType:UIButtonTypeCustom];`
----
- Objective - C 中的 Getter 和 Setter
	* 参考网站： http://stackoverflow.com/questions/10425827/please-explain-getter-and-setters-in-objective-c
	
----
- iPhone Simulator location
	* Simulator: ~/Library/Application Support/iPhone Simulator/
	
##### 关于其他

- git push >> fatal: no configured push destination
	* 参考：http://stackoverflow.com/questions/10032964/git-push-fatal-no-configured-push-destination
	
	```
	kavi-chens-MacBook-Air:MavlinkTest kavi$ git remote add origin git@github.com:kavichen/MavlinkTest.git
	kavi-chens-MacBook-Air:MavlinkTest kavi$ git push origin master
	```
---

- 如何加入 mavlink 到Xcode 中
	* Xcode -> File -> Add Files to "MavlinkTest" -> `~/Developer/mavlink/`这个文件夹
	* 完成
 ----
 