USE master;

GO


CREATE DATABASE bankim;

GO

USE bankim;


---טבלת בנקים
create table bank(
        BankID INT  CONSTRAINT BANK_ID_PK PRIMARY KEY,
        BankName VARCHAR (15) NOT NULL,
        City VARCHAR (20),
        Address VARCHAR (30),
);

INSERT INTO bank
VALUES (10,'Leumi','Tel Aviv',NULL),
       (11,'Discont','Jerusalem',NULL),
	   (12,'Hapoalim','Tel Aviv',NULL),
	   (20,'Mizrahi','Jerusalem','Ben Yehuda 63'),
	   (31,'BenLeumi','Beer Sheva','Izchak ben tzcvi')


---טבלת סניפים
CREATE TABLE branch
       (SnifId INT primary key,
        SnifName VARCHAR (20) NOT NULL,
        Address VARCHAR (30) ,
        City VARCHAR (20),
        BankId INT references bank(bankId),
);


---סניפי בנק לאומי
INSERT INTO branch
VALUES (858,'Holon','Sokolov 45','Holon',10),
       (811,'Asakim','Montifiori 31','Tel Aviv',10),
	   (851,'Ramat Gan','Bialik 22','Ramat Gan',10),
	   (801,'Yafo','Sderot Yerushalaim 75','Jerusalem',10),
	   (999,'Eilat','Sderot Hatmarim 34','Eilat',10)


---סניפי בנק דיסקונט
INSERT INTO branch
VALUES (76,'Merkaz Hacarmel','Sderot Hanasi 124','Haifa',11),
       (10,'Rashi','Yehuda 27','Tel Aviv',11),
	   (159,'Mercaz Jerusalem','Yafo 103','Jerusalem',11),
	   (162,'Talpiot','Kanion Lev Talpiot','Jerusalem',11),
	   (4,'Ashdod Sity','Hertzel 1','Ashdod',11)


---סניפי בנק הפועלים
INSERT INTO branch
VALUES (638,'Holon Vaizman','Vaizman 46','Holon',12),
       (772,'Linkoln','Derech Menachem Begin 37','Tel Aviv',12),
	   (646,'Gadera','Habiluim 6','Gadera',12),
	   (782,'Rechaviya','Aza 38','Jerusalem',12),
	   (650,'Ashkelon','Herzel 28','Ashkelon',12)



---סניפי בנק מזרחי
INSERT INTO branch
VALUES (567,'Beit Shemesh','Igal Alon 6','Beit Shemesh',20),
       (449,'Karmel','Sderot Hanasi 137','Haifa',20),
	   (856,'Pisgat Zeev','Sderot Moshe Dayan 166','Jerusalem',20),
	   (447,'Nesher','Derech Bar Yehuda 63','Nesher',20),
	   (446,'Kiryat Yam','Sderot Jerusalem 3','Kiryat Yam',20)


---סניפי בנק בינלאומי
INSERT INTO branch
VALUES (3,'Eilat','Sderot Hatmarim 11','Eilat',31),
       (39,'Bat Yam','Yoseftal 92','Bat Yam',31),
	   (2,'Tveriya','Kikar Rabin','Tveriya',31),
	   (12,'Rashi','Hilel 10','Jerusalem',31),
	   (93,'Kikar Hamedina','Vaizman 32','Tel Aviv',31)


---טבלת לקוחות
CREATE TABLE lekohot
       (customerId INT not null Primary Key,
	   firstname VARCHAR(25),
	   lastname VARCHAR(25),
	   city VARCHAR(50),
	   email VARCHAR(50),
	   birthdate date,
	   family_status VARCHAR(25),
	   gender VARCHAR(10),
	   profession VARCHAR(50),
	   bankId int references bank(bankId),
	   SnifId int references branch(snifid),
	   );


---פרטי לקוחות
INSERT INTO lekohot 
VALUES 
(243452627,'Moshe','Cohen','Tel Aviv','moshe152@gmail.com','1954-06-05','single','male','Engineer',10,811),
(105647398,'Pnina','Mualem','Jerusalem','pninush111@gmail.com','1967-04-12','married','female','Teacher',10,801),
(134255689,'Avraam','Mualem','Jerusalem','avraam62@gmail.com','1962-06-13','married','male','Doctor',10,801),
(345256682,'Netanel','Chen','Ramat Gan','natinati@gmail.com','1994-07-05','single','male','Software Developer',10,851),
(243672629,'Shira','Mizrahi','Eilat','shira1995@gmail.com','1995-12-12','married','female','Nurse',10,999),
(243672628,'Asaf','Mizrahi','Eilat','AsafM@gmail.com','1993-11-05','married','male','Architect',10,999),
(243434536,'Amnon','Chaplinski','Holon','Amnonon@gmail.com','1956-01-03','single','male','Retired',10,858),
(243486576, 'Avner', 'Abramov','Kiryat Haim','Abavner@gmail.com','1987-05-07','single','male','Marketing Specialist',11,76),
(154526538,'Menahem','Lotevski','Bat Yam','menahem1986@gmail.com','1986-12-12','married','male','Accountant',11,10),
(027346478,'Tzipi', 'Shmariyahu','Bat Yam','Tzipish@gmail.com','1988-12-10','married','female','Lawyer',11,10),
(004546637,'Dvora', 'Halfon','Givat Zeev','HDvora@gmail.com','1994-05-24','single','female','Pharmacist',11,159),
(245386647,'Karmela', 'Mentashvili','Har Gilo','karmelalala@gmail.com','1990-07-10','single','female','Journalist',11,162),
(343432556,'Rochale', 'Yarkoni','Asdod','RochYark@gmail.com','1989-08-10','single','female','Graphic Designer',11,4),
(213435245,'Shuki', 'Dalal','Tel Aviv','Dalal111@gmail.com','1993-03-30','single','male','Chef',12,638),
(027346479,'Shimi','Uzan','Yafo','Shimiimi@gmail.com','1982-10-12','married','male','Teacher',12,772),
(142343567,'Rachel','Pitusi','Yafo','Shimiimi@gmail.com','1984-12-07','married','female','Teacher',12,772),
(243556467,'Shifra','Cohen','Gadera','Shifrush@gmail.com','1974-03-03','single','female','Social Worker',12,646),
(344664533,'Ori', 'Cohen','Jerusalem','orirori77@gmail.com','1998-12-07','single','male','Student',12,782),
(024365675,'Menashe', 'Koznatcov','Ashdod','Menashe01@gmail.com','1986-09-07','single','male','Electrician',12,650),
(00454637,'Arie','Melamed','Beit Shemesh',null,'1965-03-01','single','male','Retired',20,567),
(343456276,'Shauli','Turgeman','Haifa','turgturg10@gmail.com','1976-04-04','single','male','Mechanic',20,449),
(213435249,'Zidkiyahu','Yohananof','Jerusalem','yoha777@gmail.com','1990-01-02','single','male','Photographer',20,856),
(042343555,'Hemi','Shakarchi','Nesher','hemihemi02@gmail.com','1982-10-12','married','male','Pilot',20,447),
(046563772,'Tziviya','Menasherov','Tel Aviv','menasherov87@gmail.com','1984-03-04','married','female','HR Manager',20,447),
(162547984,'Chen', 'Shimriz','Haifa','Chenchen84@gmail.com','1984-12-20','single','male','IT Specialist',20,446),
(078685754,'Samanta','Abadayo','Eilat',null,'1987-01-01','single','female','Tour Guide',31,3),
(354546573,'Mula','Mula','Holon','mulamula@gmail.com','1999-05-05','single','male','Student',31,39),
(345253677,'Svetlana','Ivanov','Tveriya','Sveta1987@gmail.com','1987-01-02','single','female','Nurse',31,2),
(354587673,'Matilda','Yosefi','Maale Adumim','Yosefi0101@gmail.com','1998-04-07','single','female','Artist',31,12),
(078975754,'Albina','Esterovich','Givataim',null,'1987-04-05','single','female','Writer',31,93);





---טבלת עובדים
CREATE TABLE ovdim (
    employeeId INT NOT NULL PRIMARY KEY,
    firstname VARCHAR(25),
    lastname VARCHAR(25),
    title VARCHAR(30),
    phone NVARCHAR(20),
    birthdate DATE,
    salary INT,
    hire_date DATE,
    bankId INT REFERENCES bank(bankId),
    SnifId INT REFERENCES branch(snifid)
);



---נתוני עובדים
INSERT INTO ovdim 
VALUES 
(1, 'דניאל', 'כהן', 'מנהל סניף', '054-123-4567', '1985-05-15', 15000, '2010-01-10', 10, 858),
(2, 'שרה', 'לוי', 'בנקאי', '052-987-6543', '1990-08-20', 12000, '2012-04-12', 10, 858),
(3, 'יעקב', 'מזרחי', 'בנקאי', '050-555-1234', '1988-03-10', 11000, '2011-09-15', 10, 811),
(4, 'רחל', 'אברמוב', 'מנהל סניף', '053-111-2222', '1992-12-25', 17000, '2013-06-05', 10, 811),
(5, 'משה', 'יעקב', 'בנקאי', '055-666-7777', '1983-06-05', 13000, '2014-03-20', 10, 851),
(6, 'אביגיל', 'קוייפמן', 'מנהל סניף', '054-123-4568', '1987-07-01', 16000, '2011-08-22', 10, 851),
(7, 'נתן', 'אטיאס', 'בנקאי', '052-987-6544', '1991-09-18', 12500, '2012-11-10', 10, 801),
(8, 'מיה', 'פרידמן', 'מנהל סניף', '050-555-1235', '1986-04-05', 18000, '2010-02-18', 10, 801),
(9, 'איתן', 'וולק', 'מנהל סניף', '053-111-2223', '1993-01-30', 14000, '2013-07-07', 10, 999),
(10, 'דב', 'רואש', 'בנקאי', '055-666-7778', '1984-11-12', 11500, '2014-11-01', 10, 999),
(11, 'עדי', 'קייקוב', 'מנהל סניף', '054-123-4569', '1989-08-07', 17500, '2015-06-15', 11, 76),
(12, 'אביה', 'גולנד', 'בנקאי', '052-987-6545', '1994-02-22', 10500, '2016-09-25', 11, 76),
(13, 'תמר', 'פנחסי', 'בנקאי', '050-555-1236', '1985-06-20', 13500, '2012-03-10', 11, 10),
(14, 'יעקב', 'טורגמן', 'מנהל סניף', '053-111-2224', '1990-12-15', 19000, '2013-10-20', 11, 10),
(15, 'רותם', 'אליסיאן', 'בנקאי', '055-666-7779', '1982-09-28', 11500, '2011-05-30', 11, 159),
(16, 'דניאל', 'נחמני', 'מנהל סניף', '054-123-4570', '1987-02-17', 18500, '2014-12-05', 11, 159),
(17, 'שרה', 'בוכמן', 'בנקאי', '052-987-6546', '1992-05-08', 12500, '2015-08-18', 11, 159),
(18, 'נתן', 'כהן', 'מנהל סניף', '050-555-1237', '1988-10-03', 20000, '2012-07-14', 11, 162),
(19, 'מיה', 'גרשון', 'בנקאי', '053-111-2225', '1993-03-25', 13000, '2015-10-30', 11, 162),
(20, 'דב', 'הרוש', 'מנהל סניף', '055-666-7780', '1983-12-10', 17000, '2013-04-28', 11, 4),
(21, 'אביה', 'כהן', 'בנקאי', '054-123-4571', '1986-04-15', 14000, '2011-09-12', 11, 4),
(22, 'תמר', 'לוי', 'מנהל סניף', '052-987-6547', '1991-09-30', 18000, '2013-11-11', 12, 638),
(23, 'ישראל', 'חייפץ', 'בנקאי', '050-555-1238', '1985-05-20', 11000, '2014-01-17', 12, 638),
(24, 'רותם', 'יעקב', 'בנקאי', '053-111-2226', '1990-11-25', 11500, '2015-02-20', 12, 772),
(25, 'דניאל', 'דהן', 'מנהל סניף', '055-666-7781', '1984-08-12', 17000, '2014-09-15', 12, 772),
(26, 'שרה', 'הלל', 'מנהל סניף', '054-123-4572', '1989-03-05', 16500, '2015-06-18', 12, 646),
(27, 'נתן', 'ויצמן', 'בנקאי', '052-987-6548', '1994-06-22', 11000, '2016-04-19', 12, 646),
(28, 'אביה', 'חנקין', 'בנקאי', '050-555-1239', '1987-01-10', 11500, '2012-08-25', 12, 782),
(29, 'תמר', 'אברגל', 'מנהל סניף', '053-111-2227', '1992-04-15', 17500, '2013-12-22', 12, 782),
(30, 'ישראל', 'פלד', 'מנהל סניף', '055-666-7782', '1983-07-30', 18000, '2014-03-13', 12, 650),
(31, 'דב', 'קולניק', 'בנקאי', '054-123-4573', '1988-10-12', 12000, '2015-07-21', 12, 650),
(32, 'רותם', 'שושני', 'בנקאי', '052-987-6549', '1993-12-05', 12500, '2016-02-14', 20, 567),
(33, 'אביה', 'ברק', 'מנהל סניף', '050-555-1240', '1986-07-20', 16500, '2012-09-16', 20, 567),
(34, 'תמר', 'שגב', 'מנהל סניף', '053-111-2228', '1991-02-15', 17000, '2013-05-28', 20, 449),
(35, 'ישראל', 'משה', 'בנקאי', '055-666-7783', '1985-05-30', 11500, '2014-11-02', 20, 449),
(36, 'דניאל', 'כהן', 'בנקאי', '052-123-4567', '1985-05-15', 14000, '2015-08-01', 20, 856),
(37, 'שרה', 'לוי', 'מנהל סניף', '054-234-5678', '1987-10-20', 18000, '2012-07-19', 20, 856),
(38, 'יעקב', 'אברהם', 'בנקאי', '056-345-6789', '1990-03-25', 11000, '2014-10-25', 20, 447),
(39, 'רחל', 'גולן', 'מנהל סניף', '058-456-7890', '1988-08-30', 17000, '2013-02-13', 20, 447),
(40, 'מלי', 'כהן', 'בנקאי', '050-567-8901', '1983-04-05', 12000, '2015-03-21', 20, 446),
(41, 'אליעזר', 'כהן', 'מנהל סניף', '052-123-4567', '1985-05-15', 16000, '2012-12-12', 20, 446),
(42, 'אלישבע', 'לוי', 'בנקאי', '054-234-5678', '1987-10-20', 11000, '2015-05-05', 31, 3),
(43, 'אהרון', 'אברהם', 'מנהל סניף', '056-345-6789', '1990-03-25', 17000, '2013-11-11', 31, 39),
(44, 'מרים', 'גולן', 'בנקאי', '058-456-7890', '1988-08-30', 11500, '2014-06-06', 31, 39),
(45, 'אברהם', 'כהן', 'מנהל סניף', '050-567-8901', '1983-04-05', 16000, '2015-08-08', 31, 2),
(46, 'שרה', 'אברהם', 'בנקאי', '052-123-4567', '1985-05-15', 11000, '2013-10-03', 31, 2),
(47, 'משה', 'לוי', 'מנהל סניף', '054-234-5678', '1987-10-20', 17000, '2012-02-19', 31, 12),
(48, 'שושנה', 'גולן', 'בנקאי', '056-345-6789', '1990-03-25', 12500, '2014-09-25', 31, 12),
(49, 'חנה', 'כהן', 'מנהל סניף', '058-456-7890', '1988-08-30', 18000, '2013-04-01', 31, 93),
(50, 'ישראל', 'אברהם', 'בנקאי', '050-567-8901', '1983-04-05', 13500, '2015-06-07', 31, 93);


---עובר ושב
CREATE TABLE account_details
       (customerId INT not null Primary Key,
	   salary money,
	   credit money,
	   HeshbonNumber int not null,
	   bankId int references bank(bankId),
	   SnifId int references branch(snifid)
	   );

---נתוני לקוח
INSERT INTO account_details
VALUES (243452627,6000,85000,4507,10,811),
       (105647398,7000,10000,6767,10,801),
	   (134255689,8500,null,6767,10,801),
       (345256682,4300,null,8234,10,851),
       (243672629,null,null,5464,10,999),
	   (243672628,12000,45000,5464,10,999),
	   (243434536,13000,3000,8678,10,858),
	   (243486576,7000,57000,9009,11,76),
	   (154526538,8200,45000,8790,11,10),
	   (027346478,5600,15000,8790,11,10),
	   (004546637,7400,null,8930,11,159),
	   (245386647,8500,null,0045,11,162),
	   (343432556,9400,70000,0495,11,4),
	   (213435245,23000,150000,0005,12,638),
	   (027346479,15000,75000,2121,12,772),
	   (142343567,3700,null,2121,12,772),
	   (243556467,8500,null,6121,12,646),
	   (344664533,6700,30000,8889,12,782),
	   (024365675,7200,25000,4040,12,650),
       (00454637,4200,38000,3334,20,567),
	   (343456276,null,15000,3939,20,449),
	   (213435249,null,null,0076,20,856),
	   (042343555,4500,null,0721,20,447),
	   (046563772,23000,50000,0721,20,447),
	   (162547984,15000,15000,5467,20,446),
       (078685754,12000,null,9091,31,3),
	   (354546573,6000,80000,8403,31,39),
	   (345253677,7500,50000,4546,31,2),
	   (354587673,6500,null,7778,31,12),
	   (078975754,9000,null,2106,31,93);

