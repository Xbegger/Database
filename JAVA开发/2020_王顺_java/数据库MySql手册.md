

## 数据库MySql手册



### 如何在数据库服务器中创建数据库？

```sql
create database test;
```

`Query OK, 1 row affected (0.00 sec)`

### 显示数据库服务器中所有数据库

```sql
show databases;
```

![image-20210914102038385](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104222.png)

### 登录mysql

```mysql
//-h localhost可以省略，-u：用户名 -p：密码！
mysql -h localhost -uroot -p123456
```

### 使用某个数据库

```sql
use test;
```

![image-20210914102218944](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104853.png)

### 显示数据库中的所有数据表

```sql
show tables; 
```

### 如何创建数据表

```sql
CREATE TABLE pet(
	name VARCHAR(20), 		// 字段 类型
    owner VARCHAR(20),
    species VARCHAR(20),
    sex CHAR(1),
    birth DATE,
    death DATE);
    

```

`Query OK, 0 rows affected (0.02 sec)`



### 查看数据表的具体结构

```sql
describe pet;
desc pet;
```

![image-20210914103534108](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104690.png)



### 查看数据表中的所有数据

```sql
select * from pet;
```

### 修改数据表中字段长度(column可省略)

```sql
alter table 表名 modify [column] 字段名 类型（要修改的长度）;
```

### 修改表中字段名字

```sql
alter table 表名 change [column] 旧字段名 新字段名 新数据类型;
```

### 如何向数据表中添加记录

```sql
INSERT INTO pet VALUES('Puffball','Diane','hamster','f','1999-03-30',null);
```

`Query OK, 1 row affected (0.00 sec)`

![image-20210914104012847](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104746.png)

```sql
insert into pet values('wuwei','youwei','hamster','f','1888-8-8',null); //大小写无关
```



### Mysql常用数据类型

MySQL支持多种类型，大致可以分为三类：**数值**、**日期/时间**和**字符串(字符)**类型。

1. 数值类型

![image-20210914104520609](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104949.png)

2. 日期类型

   ![image-20210914104617888](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104718.png)

3. 字符串类型

   ![image-20210914104659456](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104258.png)



```sql
insert into pet values('Fluffy','Harold','cat','f','1993-02-04',null);
insert into pet values('Claws','Gwen','cat','m','1994-03-17',null);
insert into pet values('Buffy','Harold','dog','f','1989-05-13',null);
insert into pet values('Fang','Benny','dog','m','1990-08-27',null);
insert into pet values('Bowser','Diane','dog','m','1979-08-31','1995-07-29');
insert into pet values('Chirpy','Gwen','bird','f','1998-09-11',null);
insert into pet values('Whistler','Gwen','bird',null,'1997-12-09',null);
insert into pet values('Slim','Benny','snake','m','1996-04-29',null);
insert into pet values('Puffball','Diane','hamster','f','1999-03-30',null);
```



### 删除记录

```sql
delete from pet where name='wuwei';
```

`Query OK, 1 row affected (0.00 sec)`

### 修改数据

```sql
update pet set name='旺旺财' where owner='周润发';
```

`Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0`



### 数据记录常见操作

```sql
INSERT
DELETE
UPDATE
SELECT
```



### Mysql 建表约束

> 一共有`6`种约束
>
> * <font  color='red'>主键约束</font>:唯一确定一条记录
> * <font  color='red'>自增约束</font>:数据自增
> * <font  color='red'>唯一约束</font>:只允许出现一次,被修饰的字段值不能重复
> * <font  color='red'>非空约束</font>:被修饰的字段值不能为空
> * <font  color='red'>默认约束</font>:拥有默认值
> * <font  color='red'>外键约束</font>:外键





* ==主键约束==

<font  color='purple'>能够唯一确定一张表中的一条记录</font>，通过给某一个字段添加约束（**primary key**），使得该字段**不重复且不为空**

```sql
create table user(
	id int primary key,
    name varchar(20)
);
```

创建多个主键的写法(**primary key(id,name)**)：

```sql
// 联合主键 只要主键值完全不重复就可以！
create table user2(
	id int,
    name varchar(20),
    password varchar(20),
    primary key(id,name)
);

insert into user2 values(1,'zhangsan', '123');
insert into user2 values(2,'zhangsan', '123'); //ok 联合主键通过
insert into user2 values(null,'zhangsan','123');//error 联合主键中任何一个字段都不能为空！
```



* ==自增约束（**auto_increment**）==

```sql
create table user3(
	id int primary key auto_increment,
    name varchar(20)
);

insert into user3(name) values("zhangsan");// ok 指定name字段 字符串用单引号 双引号皆可 id自动加
insert into user3(name) values("zhangsan");//ok 再次添加zhangsan 数据表中的id自增！
```

> 如果在创建表的时候忘记创建主键约束？add

```sql
create table user4(
	id int,
    name varchar(20)
);
alter table user4 add primary key(id); // 增加表格主键
```

![image-20210914155602678](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104818.png)



![image-20210914155613614](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104505.png)



> 删除主键约束？drop

```sql
alter table user4 drop primary key;
```

![image-20210914155915401](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104845.png)



> 修改主键约束？适用modify修改字段，添加约束！

```sql
alter table user4 modify id int primary key;
```

![image-20210914160134953](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104643.png)



* ==唯一约束==

<font color='orange'>约束修饰的字段的值不可以重复</font>

```sql
create table user5(
	id int,
    name varchar(20)
);
```

> 添加唯一约束

```sql
alter table user5 add unique(name);
```

![image-20210914160514389](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104143.png)

```sql
insert into user5 values(1,'zhangsan');
insert into user5 values(1,'zhangsan'); // error zhangsan 重复
```



> 可以在创建表的时候添加unique（）

```sql
create table user6(
	id int,
    name varchar(20),
    unique(id,name)      // 可以添加多个唯一约束  加起来不重复即可 不代表必须全部不重复！(类似联合主键)
);
insert into user6 values(1,"zhangsan"); // ok
insert into user6 values(2,"zhangsan"); // ok
insert into user6 values(1,"lisi"); 	// ok



// 或者在字段后面添加修饰！
create table user6_2(
	id int,
    name varchar(20) unique		//允许当前修饰的字段唯一约束
);

```



> 如何删除唯一约束？

```sql
alter table user6_2 drop index name;
```



> modify添加唯一约束

```sql
alter table user6_2 modify id int unique;
```

 

> 总结

1. 建表的时候添加约束
2. alter...add...
3. alter...modify....
4. alter...drop index...



* ==非空约束==

<font  color='orange'>修饰的字段不能为空</font>

```sql
create table user9(
	id int,
    name varchar(20) not null
);
```

![image-20210914161857171](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104395.png)

```sql
insert into user9 values(1,'youwei'); //ok
insert into user9(name) values('youwei'); //ok
```

![image-20210914162110800](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104516.png)

> 同样可以使用alter add、drop x 、modify



* ==默认约束==

<font  color='red'>在插入字段值时候，如果没有传入具体的值，就会使用**默认值**</font>！

```sql
create table user10(
	id int,
    name varchar(20),
    age int default 10
);
```

![image-20210914162644271](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104577.png)



```sql
insert into user10(id,name) values(1,'youwei'); //默认age为10
```

![image-20210914162801439](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104280.png)



```sql
insert into user10 values(1,'wuwei',99); 
```

![image-20210914162926215](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171104151.png)



> 同样可以使用alter系列操作！



* ==外键约束==

<font  color='orange'>涉及到两个表：父表、子表（主表、副表）</font>

```sql
create table classes(
	id int primary key,
    name varchar(20)
);

create table students(
	id int primary key,
    name varchar(20),
    class_id int,
    foreign key(class_id) references classes(id)
);
```

![image-20210914163330375](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105493.png)

```sql
insert into classes values(1,'一班');
insert into classes values(2,'二班');
insert into classes values(3,'三班');
insert into classes values(4,'四班');
```

![image-20210914163705070](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105761.png)

```sql
insert into students values(1001,'zhangsan',1);	//ok
insert into students values(1002,'zhangsan',2);	//ok
insert into students values(1003,'zhangsan',3);	//ok
insert into students values(1004,'zhangsan',4); //ok
insert into students values(1004,'lisi',5);     //error 5没有在classes中存在（外键约束失败）
```

> 主表中classes中没有的数据值，在副表中不可以使用！
>
> 主表中的记录被副表引用，不可被删！！！

```sql
delete from classes where id=4; //error
```

ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`test`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`))



### 数据库的三大设计范式

1.第一范式

数据表中所有字段都是不可分割的原子值！

```sql
// 不满足！！！！
create table student2(
	id int primary key,
    name varchar(20),
    address varchar(40)
);

insert into student2 values(1,'zhangsan','中国浙江省杭州市江干区下沙街道杭州电子科技大学MIT501');
insert into student2 values(2,'wuwei','中国浙江省杭州市江干区下沙街道杭州电子科技大学ICDM501');
insert into student2 values(3,'youwei','中国浙江省杭州市江干区下沙街道杭州电子科技大学CCS606');
```

![image-20210914165655013](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105208.png)

**字段值还可以继续拆分的，就不满足第一范式！**下面的相对符合

```sql
// 相对满足！！！！
create table student3(
	id int primary key,
    name varchar(20),
    country varchar(30),
    privence varchar(30),
    city varchar(30),
    details varchar(30)
);

insert into student3 values(1,'zhangsan','中国','浙江省','杭州市','江干区杭州电子科技大MIT501');
insert into student3 values(2,'wuwei','中国','浙江省','杭州市','江干区杭州电子科技大ICDM501');
insert into student3 values(3,'youwei','中国','浙江省','杭州市','江干区杭州电子科技大CCS606');
```

![image-20210914170144704](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105612.png)

> 范式设计的越详细，对于某些实际操作可能更好 ，但不一定 所以针对实际应用来设计数据表！



2. 第二范式

必须是满足第一范式的前提下，要求，除主键外的每一列都必须完全依赖于主键，如果出现不完全依赖，只可能发生在联合主键的情况下。

```sql
// 不满足！！！！
create table myorder(
	product_id int,
    customer_id int,
    product_name varchar(20),
    customer_name varchar(20),
    primary key(product_id,customer_id)
);
```

> 问题？除主键以外的其他列，只依赖于主键的部分字段！
>
> 解决：拆表！

```sql
// 拆分为三个表 符合第二范式！
create table myorder(
    order_id int primary key,
	product_id int,
    customer_id int
);

create table product(
	id int primary key,
    name varchar(20)
);

create table customer(
	id int primary key,
    name varchar(20)
);
```



3.第三范式

必须满足第二范式，除开主键列的其他列之间不能有传递依赖。

```sql
create table myorder(
    order_id int primary key,
	product_id int,
    customer_id int
);

create table customer(
	id int primary key,
    name varchar(20),
    phone varchar(20)
);
```

---



### 查询练习

* 学生表

Student

```sql
学号
姓名
性别
出生年月
所在班级
create table student(
	sno varchar(20) primary key,
    sname varchar(20) not null,
    ssex varchar(10) not null,
    sbirthday datetime,
    class varchar(20)
);
```

* 课程表

Course

```sql
课程号
课程名称
教师编号

// 先创建teacher表才能再创建course表
create table course(
	cno varchar(20) primary key,
    cname varchar(20) not null,
    tno varchar(20)not null,
    foreign key(tno) references teacher(tno) 
    
);
```



* 成绩表

Score

```sql
学号
课程号
成绩
create table score(
	sno varchar(20) not null,
    cno varchar(20) not null,
    degree decimal,
    foreign key(sno) references student(sno),
    foreign key(cno) references course(cno),
    primary key(sno,cno)
);
```



* 教师表

Teacher

```sql
教师编号
教师名字
教师性别
出生年月日
职称
所在部门
create table teacher(
	tno varchar(20) primary key,
    tname varchar(20) not null,
    tsex varchar(10)not null,
    tbirthday datetime,
    prof varchar(20) not null,
    depart varchar(20) not null
);
```

> 添加数据

```sql
#添加学生信息
insert into student values('101','曾华','男','1977-09-01','95033');
insert into student values('102','匡明','男','1975-10-02','95031');
insert into student values('103','王丽','女','1976-01-23','95033');
insert into student values('104','李军','男','1976-02-20','95033');
insert into student values('105','王芳','女','1975-02-10','95031');
insert into student values('106','陆君','男','1974-06-03','95031');
insert into student values('107','王尼玛','男','1976-02-20','95033');
insert into student values('108','张全蛋','女','1975-02-10','95031');
insert into student values('109','赵铁柱','男','1974-06-03','95031');
#添加教师信息
insert into teacher values('804','李诚','男','1958-12-02','副教授','计算机系');
insert into teacher values('856','张旭','男','1969-03-12','讲师','电子工程系');
insert into teacher values('825','王萍','女','1972-05-05','助教','计算机系');
insert into teacher values('831','刘冰','女','1977-08-14','助教','电子工程系');
#添加课程表
insert into course values('3-105','计算机导论','825');
insert into course values('3-245','操作系统','804');
insert into course values('6-166','数字电路','856');
insert into course values('9-888','高等数学','831');
#添加成绩表
insert into score value('103','3-105','92');
insert into score value('103','3-245','86');
insert into score value('103','6-166','85');
insert into score value('105','3-105','88');
insert into score value('105','3-245','75');
insert into score value('105','6-166','79');
insert into score value('109','3-105','76');
insert into score value('109','3-245','68');
insert into score value('109','6-166','81');
```

![image-20210915095255606](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105675.png)

```sql
select * from student;
```

![image-20210915095334002](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105862.png)

> 查询部分列

```sql
select sname, ssex,class from student;
```

![image-20210915095438547](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105488.png)

> 查询不重复的depart列（distinct）

```sql
select distinct depart from teacher;	 # 不重复的depart列
```



> 查询区间between xxx and xxx;

```sql
select * from score where degree between 60 and 68;     # 包含边界值
select * from score where degree > 60 and degree < 68;  
```



> 查询 同字段或者关系（in）

```sql
select * from score where degree in(85,86,88);	# in 关键字
```

> 查询不同字段的或者关系（or）

```sql
select * from student where class='95031' or ssex='女';
```



> 升序 降序

```sql
select * from student order by class desc; #desc降序     asc升序（默认！）
```

> 某字段升序，另一个字段降序

```sql
select * from score order by cno asc,degree desc;
```



> 统计

```sql
select count(*) from student where class='95031';
```

![image-20210915101003771](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105743.png)

> 子查询 排序

```sql
select sno,cno from score where degree=(select max(degree) from score);
#1.找到最高分
#2.找到最高分的其他字段
select sno,cno from score order by degree desc limit 0,1; # 排序 -> 0：位置 1：数量
```



> 平均值 (avg)

```sql
select * from course ;
select avg(degree) from score where cno='3-105';
select cno, avg(degree) from score group by cno;
```

![image-20210916170840030](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105124.png)

> 查询score表中至少有两名学生选修的并以3开头的课程的平均分数

```sql
# %代表统配符 可以表示任意字符！like '3%'-》3开头的模糊查询
# having count()>=2 -> 至少有2两条数据存在 类似于where但是having可以添加函数
# xxx like 'xxx'    -> 模糊查询 
select cno,avg(degree),count(*) from score group by cno having count(cno)>=2 and cno like '3%';
```

![image-20210916171516915](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105842.png)



> 查询分数大于70，小于90的sno列

```sql
select sno ,degree from score where degree > 70 and degree < 90;
select sno ,degree from score where degree between 70 and 90;    # 带边界
```

![image-20210916171849448](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105757.png)



> 查询所有学生sname、cno和degree列 (来自不同表:多表查询)

```sql
# 多表查询
select sno, sname from student;		#查询步骤1
select sno,cno ,degree from score;  #查询步骤2
=》								   #合并
select sname,cno,degree from student ,score where student.sno = score.sno;
```

![image-20210916183337408](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105496.png)



>  查询所有学生cname、sno和degree列 (来自不同表:多表查询)

```sql
select sno , cname ,degree from course,score where course.cno = score.cno;
```

![image-20210917100438356](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105289.png)



> 查询所有学生的sname、cname和degree列(三表查询)

```sql
sname -> student
cname -> course
degree -> score

select sname,cname,degree from student , course ,score 
where student.sno = score.sno
and course.cno = score.cno;
```

![image-20210917195814382](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105578.png)

> 取别名

```sql
select sname,cname,degree,student.sno as stu_sno,score.sno,course.cno as cou_cno,score.cno from student,course,score where student.sno = score.sno and course.cno = score.cno;
```

![image-20210919100152538](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105174.png)



> 查询95031班学生每门课的平均分

```sql
#select sno from student where class = '95031';寻找学号
#select * from score where sno in (select sno from student where class = '95031');
select cno,avg(degree) from score where sno in (select sno from student where class='95031')group by cno;
```

![image-20210919100602058](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105979.png)

![image-20210919100736794](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105388.png)



> 查询选修3-105课程的成绩高于109号同学3-105成绩的所有同学的记录

```sql
#select degree from score where sno= '109' and cno ='3-105';
select * from score where degree > (select degree from score where sno ='109' and cno='3-105') and cno='3-105';
```

![image-20210919101303147](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105160.png)



> 查询成绩高于学号为109、课程号为3-105的成绩的所有记录

```sql
#select * from score where sno=109 and cno='3-105';
select * from score where degree>(select degree from score where sno=109 and cno='3-105');
```

![image-20210919101738644](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105991.png)



> 查询学号为108、101的同学同年出生的所有学生的sno、sname、sbirthday列

```sql
#select * from student where sno in(108,101);

#select year(sbirthday) from student where sno in(108,101);#取出生年月的年份用year（xxx）

select sno,sname,sbirthday from student where year(sbirthday) in (select year(sbirthday) from student where sno in(108,101));
```

> 查询张旭教师任课的学生成绩

```sql
select tno from teacher where tname='张旭';

select * from score where cno=(select cno from course where tno=(select tno from teacher where tname='张旭'));
```

![image-20210919103007277](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171105364.png)



> 查询选修某课程的同学人数多于5人的教师姓名

```sql
# 添加数据
insert into score value('101','3-105','90');
insert into score value('102','3-105','91');
insert into score value('104','3-105','89');


select tname from teacher where tno=(select tno from course where cno=(select cno from score group by cno having count(*)>5));
```

![image-20210919160125525](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171106696.png)



> 查询95033 班95031班全体学生的记录

```sql
insert into student values('110','张飞','男','1974-06-03','95038');
select * from student where class in('95031','95033');
```



> 查询存在有85分以上成绩的cno

```sql
select cno from score where degree>85;
```



> 查询出''计算机系''教室所教课程的成绩表

```sql
#select * from teacher where depart='计算机系';
#select * from course where tno in(select tno from teacher where depart='计算机系');
select * from score where cno in(select cno from course where tno in(select tno from teacher where depart='计算机系'));
```

![image-20210919161041596](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171106374.png)



> (union 联合)查询”计算机“系与电子工程系不同职称的教师的tname和prof

```sql
select * from teacher where depart="计算机系" and prof not in(select prof from teacher where depart="电子工程系") union select * from teacher where depart="电子工程系" and prof not in(select prof from teacher where depart="计算机系");
```

![image-20210919162550868](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171106227.png)





> (any)查询选修编号为“3-105”课程且成绩至少高于选修编号为“3-245”同学的cno、sno和degree并按degree从高到低次序排序

```sql
select * from score where cno="3-105" and degree>any(select degree from score where cno='3-245')order by degree desc;# 大于最小即可！
```

![image-20210919163104867](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171106072.png)



> (all)查询选修编号为“3-105”且成绩高于选修编号为“3-245”课程的同学的cno、sno和degree

```sql
select * from score where cno="3-105" and degree>all(select degree from score where cno='3-245')order by degree desc;# all 大于所有项
```

![image-20210919163318963](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171106893.png)



> (union 并  as 别名)查询所有教师和同学的name、sex、birthday

```sql
select tname as name,tsex as sex,tbirthday as birthday from teacher
union
select sname,ssex,sbirthday from student;#此行数据库会根据第一行列名默认将第二行一一对应
```

![image-20210919163711657](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171106573.png)



> 查询所有 女 教师和 女 同学的name、sex 和 birthday

```sql
select tname as name,tsex as sex,tbirthday as birthday from teacher where tsex="女"
union
select sname,ssex,sbirthday from student where ssex = "女";
```

![image-20210919164009512](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171106855.png)



> 查询成绩比该课程平均成绩低的同学的成绩表

``` sql
#select cno,avg(degree) from score group by cno;

select * from score a where degree < (select avg(degree) from score b where a.cno = b.cno);
```

![image-20210919164456756](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171106425.png)



> 查询所有任课教师的Tname和Depart(课程表中安排了课程)

```sql
select tname,depart from teacher where tno in (select tno from course);
```

![image-20210919164822695](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171106468.png)



> 查询至少有两名男生的班号

```sql
select class from student where ssex="男" group by class having count(*)>1;
```

![image-20210919165109471](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171106699.png)



> 查询student表中不姓王的同学记录(模糊查询)

```sql
select * from student where sname not like '王%';
```



> 查询student表中每个学生的姓名和年龄

```sql
#当前年份减去出生年份
#select year(now());
select sname , year(now())-year(sbirthday) as '年龄' from student;
```

![image-20210919165556233](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171106242.png)



> 查询student表中最大最小的sbirthday日期值（max,min）

```sql
select max(sbirthday) as '最大值' , min(sbirthday) as '最小值' from student ;
```

![image-20210920101917720](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171106678.png)



> 以班号和年龄从大到小的顺序查询student表中的全部记录

```sql
select * from student order by class desc,sbirthday;
```



> 查询男教师及其所上的课程

```sql
select * from course where tno in(select tno from teacher where tsex='男');
```

![image-20210920102414195](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171106451.png)



> 查询最高分同学的sno、cno和degree列

```sql
select * from score where degree=(select max(degree) from score);
```



> 查询和李军同性别的所有同学的sname

```sql
select sname from student where ssex=(select ssex from student where sname = '李军');
```

![image-20210920102755502](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171106279.png)



> 查询和李军同性别并同班的同学sname

```sql
select sname from student where ssex=(select ssex from student where sname = '李军')
and class=(select class from student where sname='李军');
```



> 查询所有选修 计算机导论课程的 男同学的成绩表

```sql
select * from score 
where cno=(select cno from course where cname='计算机导论')
and sno in (select sno from student where ssex = '男');
```

![image-20210920103257648](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171106875.png)



### 假设建立了一个grade表

```sql
create table grade(
	low int(3),
    upp int(3),
    grade char(1)
);

insert into grade values(90,100,'A');
insert into grade values(80,89,'B');
insert into grade values(70,79,'C');
insert into grade values(60,69,'D');
insert into grade values(0,59,'E');
```

> 先查询所有同学的sno、cno和grade列

```sql
select sno,cno,grade from score ,grade where degree between low and upp;
```

![image-20210920103754290](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171106904.png)





### sql的四种链接查询

内连接

> inner join 或者 join

外连接

> 左连接 left join 或者 left outer join
>
> 右链接 right join 或者 right outer join
>
> 完全外连接 full join 或者full outer join





0. 创建一个数据库

```sql
create database testJoin;
```



1. 创建person表

```sql
create table person(
	id int,
    name varchar(20),
    cardId int
);
insert into person values(1,'张三',1);
insert into person values(2,'李四',3);
insert into person values(3,'王五',6);
```

![image-20210920105227997](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171107064.png)

2. 创建card表

```sql
create table card(
	id int,
    name varchar(20)
);
insert into card values(1,'饭卡');
insert into card values(2,'建行卡');
insert into card values(3,'农行卡');
insert into card values(4,'工商卡');
insert into card values(5,'邮政卡');
```

![image-20210920104725133](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171107684.png)



-- 没有创建外键

> inner join 查询

```sql
#cardId 与 id 一一对应且相等
#有一条数据对应id为6，在另一张表中没有找到 因此没有显示!
#内联查询就是将两个表中有关系的数据（某字段相等）全查询出来！！！
select * from person inner join card on person.cardId=card.id;
select * from person join card on person.cardId=card.id;# ok
```

![image-20210920105242739](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171107199.png)



> left join(左外连接)

```sql
#on 类似于where
#会把左边表中所有数据取出来，而右边表中的数据，如果有相等的，就显示出来，如果没有就会补NULL
select * from person left join card on person.cardId=card.id;
select * from person left outer join card on person.cardId=card.id;
```

![image-20210920105711133](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171107039.png)



> right join(右外连接)

```sql
# 右外连接，会把右边表里面的所有数据取出来，而左边表中的数据如果有相等的，就显示出来，如果没有就补NULL
select * from person right join card on person.cardId=card.id;
select * from person right outer join card on person.cardId=card.id;# ok
```

![image-20210920111114265](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171107419.png)



> full join(全外链接)

```sql
# mysql 不支持full join连接
select * from person right join card on person.cardId=card.id;# error


# 利用union来实现全连接
select * from person left join card on person.cardId=card.id
union
select * from person right join card on person.cardId=card.id;
```

![image-20210920111628923](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171107804.png)



<img src="https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171107806.png" alt="image-20210920111704200"  />



---



### MySQL事务

> 事务是一个最小的不可分割的工作单元，事务能够保证一个业务的完整性



MySQL中是默认开启事务的

```sql
#自动提交 代表事务开启！！！
select @@autocommit;
#默认事务开启作用：当我们去执行一个sql语句的时候，效果会立即体现出来，切不能回滚！
```

![image-20210920112316425](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171107978.png)

```sql
create database bank;
#use bank;
create table user(
	id int primary key,
    name varchar(20),
    money int
);
insert into user values(1,'a',1000);
insert into user values(2,'b',1000);

#事务回滚：撤销sql语句的执行效果！但是上面的insert语句已经提交了（autocommit=1）所以该数据不能回滚！
rollback;

#设置mysql自动提交为false,关闭！
set autocommit=0;
#设置完false后 提交数据需要使用commit！
insert into xxxxx;
commit;
```

--自动提交：@@autocommit=1

--手动提交：commit；

--事务回滚：rollback；



> 事务提供了一个可以反悔的机会



--手动开启一个事务（两种方式）：

* begin；
* start transaction;

```sql
update user set money=money-100 where name='a';
update user set money=money+100 where name='b';
#开始事务回滚
rollback;#失败，没有效果！！因为开启了自动提交
```

![image-20210920140259892](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171107889.png)



```sql
#手动开启事务
begin;#start transaction;类似
update user set money=money-100 where name='a';
update user set money=money+100 where name='b';
#回滚数据 成功！
rollback;
select * from user;
#事务开启之后 一旦commit就不可以回滚，事务已经结束了
commit;
rollback;#失败！
```

![image-20210920140259892](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171107300.png)



#### 事务的四大特征

> * A  原子性：事务是最小的单位，不可分隔。
> * C  一致性：同一事务中的sql语句，必须同时成功或者同时失败（a，b转账示例）
> * I   隔离性：事务1 和 事务2 之间是具有隔离性。
> * D  持久性：事务一旦结束（commit,rollback），就不可以反悔。

事务开启：

1. 修改默认提交 set autocommit=0；
2. begin
3. start  transaction



事务提交：

commit；



事务手动回滚：

rollback；



事务的隔离性：

> * read uncommitted;	读未提交
> * read committed;         读已提交
> * repeatable read;         可重复读（MySQL默认隔离级别）
> * serializable;                  串行化

***



1. read uncommitted：

> 如果有事务a和事务b，a对数据进行操作，在操作的过程中，**事务没有被提交**，但是b可以看见a操作的结果。

```sql
# bank - user表
insert into user values(3,'小明',1000);
insert into user values(4,'淘宝店',1000);
```

![image-20210920141823090](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171107555.png)

--如何查看数据库的隔离级别？

```sql
#MySql8.0：
select @@global.transaction_isolation;#系统级别
select @@transaction_isolation;		  #会话级别

#MySql5.x：
select @@global.tx_isolation;
select @@tx_isolation;
```

![image-20210920142042988](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171107394.png)



--如何修改数据库的隔离级别？

```sql
set global transaction isolation level read uncommitted;
set session transaction isolation level read uncommitted;#当前会话
```

![image-20210920142436257](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171107072.png)



--转账：小明在淘宝店买鞋子：800元

```sql
#小明->成都
#淘宝店->广州
start transaction;
update user set money=money-800 where name='小明';
update user set money=money+800 where name='淘宝店';
#广州的淘宝店（另一个终端开启数据库）查询是否收到汇款，消费1800
#小明 rollback；
```

![image-20210920143710229](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171107661.png)![image-20210920143727581](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171108621.png)



--如果两个不同的地方，都在进行操作，事务a开启之后，它的数据可以被其他事物读取到。

--这样就会出现**脏读（一个事务读到了另一个事务没有提交的数据）**

---



2. read committed;

```sql
set global transaction isolation level read committed;
select @@global.transaction_isolation;
```

![image-20210920144602193](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171108253.png)

```sql
#bank 数据库 user表

#小张：银行的会计
start transaction;
select * from user;
--#小张上厕所
--#小王（另一个终端开启数据库）：
start transaction;
insert into user values(5,'c',100);
commit;
#小张回来！！！
select avg(money) from user;
#money的平均值变少了！！！
```

![image-20210920144736008](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171108449.png)![image-20210920145019613](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171108207.png)![image-20210920145204915](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171108574.png)



--虽然只能读到另外一个事务提交的数据，但是还会出现问题，就是读取同一个表的数据，发现前后不一致（小张先查询所有数据，后查询平均值，发现平均值不是取自于第一次查询的结果！）

--不可重复读现象read conmmitte



---



3. repeatable read 可以重复读; 

```sql
set global transaction isolation level repeatable read;
select @@global.transaction_isolation;
```

![image-20210920145809408](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171108802.png)

```sql
select * from user;
#张全蛋-成都
start transaction;
#王尼玛(另一个开启数据库的终端)-北京
start transaction;
#张
insert into user values(6,'d',1000);
commit;
select * from user;#查看到d数据存在
#王
select * from user;#并未查看到d数据的存在
insert into user values(6,'d',1000);#插入数据失败，提示id=6存在！
```

![image-20210920145930956](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171108317.png)![image-20210920150517470](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171108548.png)![image-20210920150414890](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171108813.png)



![image-20210920150543958](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171108889.png)

--幻读：事务a和事务b同时操作一张表，事务a提交的数据，也不能被事务b读到，就造成幻读。

---



4. serializable;

```sql
set global transaction isolation level serializable;#串行化
select @@global.transaction_isolation;
```

![image-20210920150853891](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171108591.png)

```sql
select * from user;
#张全蛋-成都
start transaction;
#王尼玛(另一个开启数据库的终端)-北京
start transaction;
#张
insert into user values(7,'赵铁柱',1000);
commit;
select * from user;#查看到赵铁柱数据存在
#王
select * from user;#查看到赵铁柱数据的存在
#张
start transaction;
insert into user values(8,'王小花',1000);#操作被卡住
```

![image-20210920151024894](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171109629.png)张初始查询



![image-20210920151149103](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171109257.png)张的查询



![image-20210920151240208](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171109718.png)王的查询



![image-20210920151447044](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171109344.png)语句被卡住！！！（只有王选择commit，张才能插入)

![image-20210920151544295](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171109068.png)王 选择commit；

![image-20210920151601273](https://gitee.com/ICDM_ws/pic-bed/raw/master/all/202111171109625.png)张 插入成功！



--当user表被另外一个事务操作的时候 ，其他事务里面的写操作，是不可以进行的。

--进入排队状态（串行化），直到王 那边事务结束之后，张 的写入操作才会执行。

--在没有等待超时的情况下

---



> 性能：read-uncommitted > read committed > repeatable read > serializable
>
> **隔离级别越高，性能越差。** 
>
> MySQL 默认隔离级别是repeatable read



































































