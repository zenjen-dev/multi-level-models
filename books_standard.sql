DROP TABLE authors;
CREATE TABLE authors
  (
  au_id    CHAR(3)     NOT NULL,
  au_fname VARCHAR(15) NOT NULL,
  au_lname VARCHAR(15) NOT NULL,
  phone    VARCHAR(12)         ,
  address  VARCHAR(20)         ,
  city     VARCHAR(15)         ,
  state    CHAR(2)             ,
  zip      CHAR(5)             ,
  CONSTRAINT pk_authors PRIMARY KEY (au_id)
  );
INSERT INTO authors VALUES('A01','Sarah','Buchman','718-496-7223','75 West 205 St','Bronx','NY','10468');
INSERT INTO authors VALUES('A02','Wendy','Heydemark','303-986-7020','2922 Baseline Rd','Boulder','CO','80303');
INSERT INTO authors VALUES('A03','Hallie','Hull','415-549-4278','3800 Waldo Ave, #14F','San Francisco','CA','94123');
INSERT INTO authors VALUES('A04','Klee','Hull','415-549-4278','3800 Waldo Ave, #14F','San Francisco','CA','94123');
INSERT INTO authors VALUES('A05','Christian','Kells','212-771-4680','114 Horatio St','New York','NY','10014');
INSERT INTO authors VALUES('A06','','Kellsey','650-836-7128','390 Serra Mall','Palo Alto','CA','94305');
INSERT INTO authors VALUES('A07','Paddy','O''Furniture','941-925-0752','1442 Main St','Sarasota','FL','34236');


DROP TABLE publishers;
CREATE TABLE publishers
  (
  pub_id   CHAR(3)     NOT NULL,
  pub_name VARCHAR(20) NOT NULL,
  city     VARCHAR(15) NOT NULL,
  state    CHAR(2)             ,
  country  VARCHAR(15) NOT NULL,
  CONSTRAINT pk_publishers PRIMARY KEY (pub_id)
  );
INSERT INTO publishers VALUES('P01','Abatis Publishers','New York','NY','USA');
INSERT INTO publishers VALUES('P02','Core Dump Books','San Francisco','CA','USA');
INSERT INTO publishers VALUES('P03','Schadenfreude Press','Hamburg',NULL,'Germany');
INSERT INTO publishers VALUES('P04','Tenterhooks Press','Berkeley','CA','USA');


DROP TABLE titles;
CREATE TABLE titles
  (
  title_id   CHAR(3)      NOT NULL,
  title_name VARCHAR(40)  NOT NULL,
  type       VARCHAR(10)          ,
  pub_id     CHAR(3)      NOT NULL,
  pages      INTEGER              ,
  price      DECIMAL(5,2)         ,
  sales      INTEGER              ,
  pubdate    DATE                 ,
  contract   SMALLINT     NOT NULL,
  CONSTRAINT pk_titles PRIMARY KEY (title_id)
  );
INSERT INTO titles VALUES('T01','1977!','history','P01',107,21.99,566,DATE '2000-08-01',1);
INSERT INTO titles VALUES('T02','200 Years of German Humor','history','P03',14,19.95,9566,DATE '1998-04-01',1);
INSERT INTO titles VALUES('T03','Ask Your System Administrator','computer','P02',1226,39.95,25667,DATE '2000-09-01',1);
INSERT INTO titles VALUES('T04','But I Did It Unconsciously','psychology','P04',510,12.99,13001,DATE '1999-05-31',1);
INSERT INTO titles VALUES('T05','Exchange of Platitudes','psychology','P04',201,6.95,201440,DATE '2001-01-01',1);
INSERT INTO titles VALUES('T06','How About Never?','biography','P01',473,19.95,11320,DATE '2000-07-31',1);
INSERT INTO titles VALUES('T07','I Blame My Mother','biography','P03',333,23.95,1500200,DATE '1999-10-01',1);
INSERT INTO titles VALUES('T08','Just Wait Until After School','children','P04',86,10.00,4095,DATE '2001-06-01',1);
INSERT INTO titles VALUES('T09','Kiss My Boo-Boo','children','P04',22,13.95,5000,DATE '2002-05-31',1);
INSERT INTO titles VALUES('T10','Not Without My Faberge Egg','biography','P01',NULL,NULL,NULL,NULL,0);
INSERT INTO titles VALUES('T11','Perhaps It''s a Glandular Problem','psychology','P04',826,7.99,94123,DATE '2000-11-30',1);
INSERT INTO titles VALUES('T12','Spontaneous, Not Annoying','biography','P01',507,12.99,100001,DATE '2000-08-31',1);
INSERT INTO titles VALUES('T13','What Are The Civilian Applications?','history','P03',802,29.99,10467,DATE '1999-05-31',1);


DROP TABLE title_authors;
CREATE TABLE title_authors
  (
  title_id      CHAR(3)      NOT NULL,
  au_id         CHAR(3)      NOT NULL,
  au_order      SMALLINT     NOT NULL,
  royalty_share DECIMAL(5,2) NOT NULL,
  CONSTRAINT pk_title_authors PRIMARY KEY (title_id, au_id)
  );
INSERT INTO title_authors VALUES('T01','A01',1,1.0);
INSERT INTO title_authors VALUES('T02','A01',1,1.0);
INSERT INTO title_authors VALUES('T03','A05',1,1.0);
INSERT INTO title_authors VALUES('T04','A03',1,0.6);
INSERT INTO title_authors VALUES('T04','A04',2,0.4);
INSERT INTO title_authors VALUES('T05','A04',1,1.0);
INSERT INTO title_authors VALUES('T06','A02',1,1.0);
INSERT INTO title_authors VALUES('T07','A02',1,0.5);
INSERT INTO title_authors VALUES('T07','A04',2,0.5);
INSERT INTO title_authors VALUES('T08','A06',1,1.0);
INSERT INTO title_authors VALUES('T09','A06',1,1.0);
INSERT INTO title_authors VALUES('T10','A02',1,1.0);
INSERT INTO title_authors VALUES('T11','A03',2,0.3);
INSERT INTO title_authors VALUES('T11','A04',3,0.3);
INSERT INTO title_authors VALUES('T11','A06',1,0.4);
INSERT INTO title_authors VALUES('T12','A02',1,1.0);
INSERT INTO title_authors VALUES('T13','A01',1,1.0);


DROP TABLE royalties;
CREATE TABLE royalties
  (
  title_id     CHAR(3)      NOT NULL,
  advance      DECIMAL(9,2)         ,
  royalty_rate DECIMAL(5,2)         ,
  CONSTRAINT pk_royalties PRIMARY KEY (title_id)
  );
INSERT INTO royalties VALUES('T01',10000,0.05);
INSERT INTO royalties VALUES('T02',1000,0.06);
INSERT INTO royalties VALUES('T03',15000,0.07);
INSERT INTO royalties VALUES('T04',20000,0.08);
INSERT INTO royalties VALUES('T05',100000,0.09);
INSERT INTO royalties VALUES('T06',20000,0.08);
INSERT INTO royalties VALUES('T07',1000000,0.11);
INSERT INTO royalties VALUES('T08',0,0.04);
INSERT INTO royalties VALUES('T09',0,0.05);
INSERT INTO royalties VALUES('T10',NULL,NULL);
INSERT INTO royalties VALUES('T11',100000,0.07);
INSERT INTO royalties VALUES('T12',50000,0.09);
INSERT INTO royalties VALUES('T13',20000,0.06);


DROP TABLE au_orders;
CREATE TABLE au_orders (
  title_id CHAR(3),
  author1  CHAR(3),
  author2  CHAR(3),
  author3  CHAR(3)
  );
INSERT INTO au_orders VALUES('T01','A01',NULL,NULL);
INSERT INTO au_orders VALUES('T02','A01',NULL,NULL);
INSERT INTO au_orders VALUES('T03','A05',NULL,NULL);
INSERT INTO au_orders VALUES('T04','A03','A04',NULL);
INSERT INTO au_orders VALUES('T05','A04',NULL,NULL);
INSERT INTO au_orders VALUES('T06','A02',NULL,NULL);
INSERT INTO au_orders VALUES('T07','A02','A04',NULL);
INSERT INTO au_orders VALUES('T08','A06',NULL,NULL);
INSERT INTO au_orders VALUES('T09','A06',NULL,NULL);
INSERT INTO au_orders VALUES('T10','A02',NULL,NULL);
INSERT INTO au_orders VALUES('T11','A06','A03','A04');
INSERT INTO au_orders VALUES('T12','A02',NULL,NULL);
INSERT INTO au_orders VALUES('T13','A01',NULL,NULL);


DROP TABLE dups;
CREATE TABLE dups (
  id         INTEGER,
  title_name VARCHAR(40),
  type       VARCHAR(10),
  price      DECIMAL(5,2)
  );
INSERT INTO dups VALUES(1,'Book Title 5','children',15.00);
INSERT INTO dups VALUES(2,'Book Title 3','biography',7.00);
INSERT INTO dups VALUES(3,'Book Title 1','history', 10.00);
INSERT INTO dups VALUES(4,'Book Title 2','children',20.00);
INSERT INTO dups VALUES(5,'Book Title 4','history', 15.00);
INSERT INTO dups VALUES(6,'Book Title 1','history', 10.00);
INSERT INTO dups VALUES(7,'Book Title 3','biography',7.00);
INSERT INTO dups VALUES(8,'Book Title 1','history', 10.00);


DROP TABLE empsales;
CREATE TABLE empsales (
  emp_id CHAR(3) NOT NULL PRIMARY KEY,
  sales  INTEGER NOT NULL
  );
INSERT INTO empsales VALUES('E01',600);
INSERT INTO empsales VALUES('E02',800);
INSERT INTO empsales VALUES('E03',500);
INSERT INTO empsales VALUES('E04',500);
INSERT INTO empsales VALUES('E05',700);
INSERT INTO empsales VALUES('E06',500);
INSERT INTO empsales VALUES('E07',300);
INSERT INTO empsales VALUES('E08',400);
INSERT INTO empsales VALUES('E09',900);
INSERT INTO empsales VALUES('E10',700);


DROP TABLE roadtrip;
CREATE TABLE roadtrip (
  seq   INTEGER     NOT NULL PRIMARY KEY,
  city  VARCHAR(17) NOT NULL,
  miles REAL        NOT NULL
  );
INSERT INTO roadtrip VALUES(1,'Seattle, WA',0);
INSERT INTO roadtrip VALUES(2,'Portland, OR',174);
INSERT INTO roadtrip VALUES(3,'San Francisco, CA',808);
INSERT INTO roadtrip VALUES(4,'Monterey, CA',926);
INSERT INTO roadtrip VALUES(5,'Los Angeles, CA',1251);
INSERT INTO roadtrip VALUES(6,'San Diego, CA',1372);


DROP TABLE telephones;
CREATE TABLE telephones (
  au_id    CHAR(3)  NOT NULL,
  tel_type CHAR(1)  NOT NULL,
  tel_no   CHAR(12) NOT NULL,
  PRIMARY KEY (au_id, tel_type)
  );
INSERT INTO telephones VALUES('A01','H','111-111-1111');
INSERT INTO telephones VALUES('A01','W','222-222-2222');
INSERT INTO telephones VALUES('A02','W','333-333-3333');
INSERT INTO telephones VALUES('A04','H','444-444-4444');
INSERT INTO telephones VALUES('A04','W','555-555-5555');
INSERT INTO telephones VALUES('A05','H','666-666-6666');


DROP TABLE temps;
CREATE TABLE temps (
  id      INTEGER NOT NULL PRIMARY KEY,
  hi_temp INTEGER NOT NULL
  );
INSERT INTO temps VALUES( 1,49);
INSERT INTO temps VALUES( 2,46);
INSERT INTO temps VALUES( 3,48);
INSERT INTO temps VALUES( 4,50);
INSERT INTO temps VALUES( 5,50);
INSERT INTO temps VALUES( 6,50);
INSERT INTO temps VALUES( 7,51);
INSERT INTO temps VALUES( 8,52);
INSERT INTO temps VALUES( 9,53);
INSERT INTO temps VALUES(10,50);
INSERT INTO temps VALUES(11,50);
INSERT INTO temps VALUES(12,47);
INSERT INTO temps VALUES(13,50);
INSERT INTO temps VALUES(14,51);
INSERT INTO temps VALUES(15,52);


DROP TABLE time_series;
CREATE TABLE time_series (
  seq   INTEGER NOT NULL PRIMARY KEY,
  price REAL    NOT NULL
  );
INSERT INTO time_series VALUES( 1,10.0);
INSERT INTO time_series VALUES( 2,10.5);
INSERT INTO time_series VALUES( 3,11.0);
INSERT INTO time_series VALUES( 4,11.0);
INSERT INTO time_series VALUES( 5,10.5);
INSERT INTO time_series VALUES( 6,11.5);
INSERT INTO time_series VALUES( 7,12.0);
INSERT INTO time_series VALUES( 8,13.0);
INSERT INTO time_series VALUES( 9,15.0);
INSERT INTO time_series VALUES(10,13.5);
INSERT INTO time_series VALUES(11,13.0);
INSERT INTO time_series VALUES(12,12.5);
INSERT INTO time_series VALUES(13,12.0);
INSERT INTO time_series VALUES(14,12.5);
INSERT INTO time_series VALUES(15,11.0);


DROP TABLE employees;
CREATE TABLE employees (
  emp_id   CHAR(3)     NOT NULL PRIMARY KEY,
  emp_name VARCHAR(20) NOT NULL,
  boss_id  CHAR(3)
  );
INSERT INTO employees VALUES('E01','Lord Copper',NULL);
INSERT INTO employees VALUES('E02','Jocelyn Hitchcock','E01');
INSERT INTO employees VALUES('E03','Mr. Salter','E01');
INSERT INTO employees VALUES('E04','William Boot','E03');
INSERT INTO employees VALUES('E05','Mr. Corker','E03');


DROP TABLE hier;
CREATE TABLE hier (
  emp_id    CHAR(3)     NOT NULL PRIMARY KEY,
  emp_title VARCHAR(20) NOT NULL,
  boss_id   CHAR(3)
  );
INSERT INTO hier VALUES('E01','CEO',NULL);
INSERT INTO hier VALUES('E02','VP1','E01');
INSERT INTO hier VALUES('E03','VP2','E01');
INSERT INTO hier VALUES('E04','DIR1','E02');
INSERT INTO hier VALUES('E05','DIR2','E02');
INSERT INTO hier VALUES('E06','DIR3','E03');
INSERT INTO hier VALUES('E07','WS1','E04');
INSERT INTO hier VALUES('E08','WS2','E04');
INSERT INTO hier VALUES('E09','WS3','E04');
INSERT INTO hier VALUES('E10','WS4','E06');
INSERT INTO hier VALUES('E11','WS5','E06');