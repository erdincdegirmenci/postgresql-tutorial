SELECT *
FROM HR.EMPLOYEES;

SELECT *
FROM HR.EMPLOYEES
ORDER BY firstname;


SELECT *
FROM HR.EMPLOYEES
WHERE country = 'TR'
ORDER BY firstname;

SELECT empid, firstname, lastname, countryS
FROM HR.EMPLOYEES
WHERE country = 'TR'
ORDER BY firstname;

--

SELECT empid, firstname, lastname, country
FROM HR.EMPLOYEES
WHERE country = 'TR'
ORDER BY firstname
Limit 3;

--

SELECT *
FROM Sales.Orders as o
JOIN HR.Employees as e on e.empid = o.empid;

--

SELECT *
FROM Sales.Orders as o
JOIN HR.Employees as e on e.empid = o.empid
WHERE o.shipcountry = 'TR'
--Limit 3;

--

SELECT
		e.empid, e.firstname, e.lastname,
		o.orderid, o.custid, o.orderdate, o.freight, o.shipcountry
FROM Sales.Orders as o
JOIN HR.Employees as e on e.empid = o.empid
WHERE o.shipcountry = 'TR';

--

SELECT
		e.empid, e.firstname, e.lastname,
		o.orderid, o.custid, o.orderdate, o.freight, o.shipcountry
FROM Sales.Orders as o
JOIN HR.Employees as e on e.empid = o.empid
WHERE o.shipcountry = 'TR'
ORDER BY e.empid;

--

SELECT
		e.empid, e.firstname, e.lastname,
		o.orderid, o.custid, o.orderdate, o.freight, o.shipcountry
FROM Sales.Orders as o
JOIN HR.Employees as e on e.empid = o.empid
WHERE o.shipcountry = 'TR'
ORDER BY e.empid desc;

SELECT
		e.empid,
		SUM(o.freight) as TotalFreight
FROM Sales.Orders as o
JOIN HR.Employees as e on e.empid = o.empid
WHERE o.shipcountry = 'TR'
GROUP BY e.empid
ORDER BY e.empid;


SELECT
		e.empid,
		SUM(o.freight) as TotalFreight
FROM Sales.Orders as o
JOIN HR.Employees as e on e.empid = o.empid
WHERE o.shipcountry = 'TR'
GROUP BY e.empid
HAVING SUM(o.freight) > 2000
ORDER BY e.empid;


SELECT
		e.empid,
		SUM(o.freight) as TotalFreight
FROM Sales.Orders as o
JOIN HR.Employees as e on e.empid = o.empid
WHERE o.shipcountry = 'TR'
GROUP BY e.empid
HAVING SUM(o.freight) > '2000'
ORDER BY e.empid;


SELECT
    e.empid,
    SUM(o.freight) AS TotalFreight
FROM Sales.Orders AS o
JOIN HR.Employees AS e ON e.empid = o.empid
WHERE o.shipcountry = 'TR'
GROUP BY e.empid
HAVING SUM(o.freight::numeric) > 2000
ORDER BY e.empid;


SELECT
		empid,
		sum(freight) as ToplamFreight
FROM
			 Sales.Orders
GROUP BY
		empid
ORDER BY
		ToplamFreight DESC
Limit 3;



SELECT
		empid,
		sum(freight) as ToplamFreight
FROM
			 Sales.Orders
GROUP BY
		empid
ORDER BY
		ToplamFreight
Limit 3;

--

SELECT
			orderid,
			orderdate,
			Extract(Year from orderdate) as Yillar,
			Extract(Quarter from orderdate) as Ceyrekler,
			Extract(Month from orderdate) as Aylar,
			Extract(Day from orderdate) as Gunler
FROM Sales.Orders;


SELECT *
FROM
			 Sales.Orders		as o
		JOIN HR.Employees		as e	on o.empid	= e.empid
		JOIN Sales.Customers	as c	on o.custid = c.custid
WHERE
		Extract(Year from orderdate) = 2007
ORDER BY
		o.custid;

--

SELECT
		o.orderid,
		o.custid,
		c.companyname,
		o.orderdate,
		o.freight,
		o.shipcity,
		o.shipcountry,
		e.firstname,
		e.lastname,
		Extract(Year from orderdate) as Yillar
FROM
			 Sales.Orders		as o
		JOIN HR.Employees		as e	on o.empid	= e.empid
		JOIN Sales.Customers	as c	on o.custid = c.custid
WHERE
		Extract(Year from orderdate) = 2007
ORDER BY
		o.custid;

SELECT
		o.shipcountry,
		SUM(o.freight) as TotalFreight
FROM
			 Sales.Orders		as o
		JOIN HR.Employees		as e	on o.empid	= e.empid
		JOIN Sales.Customers	as c	on o.custid = c.custid
WHERE
		Extract(Year from orderdate) = 2007
GROUP BY
		o.shipcountry
HAVING
		SUM(o.freight) >= '2000'
ORDER BY
		o.shipcountry;

SELECT
		o.shipcountry,
		SUM(o.freight) as TotalFreight
FROM
			 Sales.Orders		as o
		JOIN HR.Employees		as e	on o.empid	= e.empid
		JOIN Sales.Customers	as c	on o.custid = c.custid
WHERE
		Extract(Year from orderdate) = 2007
GROUP BY
		o.shipcountry
HAVING
		SUM(o.freight) >= '2000'
ORDER BY
		o.shipcountry
Limit 3;

SELECT 
		o.shipcountry,
		SUM(o.freight) as TotalFreight
FROM
			 Sales.Orders		as o
		JOIN HR.Employees		as e	on o.empid	= e.empid
		JOIN Sales.Customers	as c	on o.custid = c.custid
WHERE
		Extract(Year from orderdate) = 2007
GROUP BY
		o.shipcountry
ORDER BY
		TotalFreight desc;


SELECT
		orderid,
		orderdate,
		freight,
		Cast(freight as Numeric(6,2)) as FreightB,
		freight::Numeric(6,2) as FreightC,
		Extract(year from orderdate) as yillar
FROM 
		Sales.Orders;

--

SELECT
		Extract(year from orderdate) as yillar,
		sum(freight) as ToplamFreight,
		Min(freight) as MinFreight,
		Max(freight) as MaxFreight,
		Avg(freight::Numeric(6,2)) as AvgFreightA1,
		Avg(freight::Numeric(6,2))::Numeric(6,2) as AvgFreightA2,
		Avg(Cast(freight as Numeric(6,2))) as AvgFreightB1,
		Avg(Cast(freight as Numeric(6,2)))::Numeric(6,2) as AvgFreightB2,
		Count(*) as SiparisSayisiA,	-- Count  icerisinde yıldız kullanmanın olumsuz etkilerini left,right ve full joinlerde gormustuk	
		Count(orderid) as SiparisSayisiB
FROM 
		Sales.Orders
GROUP BY
		Extract(year from orderdate)
ORDER BY
		yillar;

SELECT
		Extract(year from orderdate) as yillar,
		Extract(quarter from orderdate) as Ceyrekler,
		sum(freight) as ToplamFreight,
		Min(freight) as MinFreight,
		Max(freight) as MaxFreight,
		Avg(freight::Numeric(6,2)) as AvgFreight,
		Count(*) as SiparisSayisi
FROM 
		Sales.Orders
GROUP BY
		Extract(year from orderdate),Extract(quarter from orderdate)
ORDER BY
		yillar;

--

SELECT
		Extract(year from orderdate) as yillar,
		Extract(quarter from orderdate) as Ceyrekler,
		sum(freight) as ToplamFreight,
		Min(freight) as MinFreight,
		Max(freight) as MaxFreight,
		Avg(freight::Numeric) as AvgFreight,
		Count(*) as SiparisSayisi
FROM 
		Sales.Orders
GROUP BY
		Extract(year from orderdate),Extract(quarter from orderdate)
ORDER BY
		yillar;

--

SELECT    
	orderid,
    EXTRACT(year FROM orderdate) AS yillar,
    EXTRACT(quarter FROM orderdate) AS ceyrek,
    freight,
	CAST(freight AS NUMERIC(6, 2)) as freightCastA,
	CAST(freight AS NUMERIC) as freightCastB
FROM 
    Sales.Orders
ORDER BY 
    yillar, ceyrek;

SELECT
	123.586987,
	Cast(123.586987 as Numeric(6,2)),
	Cast(123.586987 as Numeric);

--
Create SCHEMA ornek;

Create Table Ornek.Siparis
(
	orderid Serial Primary Key,
	custid int,
	empid int,
	orderdate Date,
	Sehir Varchar(50)
);

SELECT *
FROM Ornek.Siparis;

--

Create Table Siparis
(
	orderid Serial Primary Key,
	custid int,
	empid int,
	orderdate Date,
	Sehir Varchar(50)
);

SELECT *
FROM Siparis;

--

Create Table Public.SiparisB
(
	orderid Serial Primary Key,
	custid int,
	empid int,
	orderdate Date,
	Sehir Varchar(50)
);

SELECT *
FROM SiparisB;

--

INSERT into Ornek.Siparis(custid,empid,orderdate,Sehir)
	VALUES(1,1,'20240711','istanbul');

INSERT into Siparis(custid,empid,orderdate,Sehir)
	VALUES(1,9,'20240730','izmir');

SELECT * FROM Siparis;
SELECT * FROM Public.Siparis;

SELECT * FROM Ornek.Siparis;

-- Distinct

SELECT custid, country
FROM Sales.Customers;

SELECT country
FROM Sales.Customers;


SELECT Distinct country
FROM Sales.Customers;

SELECT country, city
FROM Sales.Customers
ORDER BY 1,2;

SELECT Distinct
		country, city
FROM Sales.Customers
ORDER BY 1,2;

-- 

SELECT Distinct country
FROM Sales.Customers;

SELECT Count(country) as Sayisi
FROM Sales.Customers;

SELECT Distinct Count(country) as Sayisi
FROM Sales.Customers;

SELECT Count(Distinct country) as Sayisi
FROM Sales.Customers;

-- 

SELECT
		orderid
		,Extract(Year from orderdate) as orderyear
		, orderyear + 1 as NextYear
FROM Sales.Orders;


SELECT
		orderid
		,Extract(Year from orderdate) as orderyear
		, Extract(Year from orderdate) + 1 as NextYear
FROM Sales.Orders;


SELECT
		orderid,
		orderyear,
		orderyear + 1 as nextyear
FROM (
		SELECT
				orderid
				,Extract(Year from orderdate) as orderyear				
		FROM Sales.Orders	
	 ) as Rapor;


With Rapor as
(
	SELECT
			orderid
			,Extract(Year from orderdate) as orderyear				
	FROM Sales.Orders		
)
SELECT
		orderid,
		orderyear,
		orderyear + 1 as nextyear
FROM Rapor;

-- Tekil Tablo Sorguları
SELECT *
FROM Sales.Orders;

SELECT *
FROM Sales.Orders
WHERE custid = 20;

SELECT
		empid,
		extract(year from orderdate) as Yillar,
		Count(*) as Sayisi
FROM Sales.Orders
WHERE custid = 20
GROUP BY empid, extract(year from orderdate)
HAVING Count(*) > 1
ORDER BY 1,2;

SELECT
		e.firstname,
		e.lastname,
		extract(year from orderdate) as Yillar,
		Count(*) as Sayisi
FROM Sales.Orders as o
JOIN Hr.employees as e on e.empid = o.empid
WHERE custid = 20
GROUP BY e.firstname, e.lastname, extract(year from orderdate)
HAVING Count(*) > 1
ORDER BY 1,2,3;

SELECT
		e.empid,
		e.firstname,
		e.lastname,
		(
			SELECT sum(o.freight)
			FROM Sales.Orders as o
			WHERE o.empid = e.empid
	    ) as ToplamFreight
FROM Hr.employees as e
ORDER BY empid;

--

SELECT *
FROM HR.Employees;

--

SELECT 
		empid,
		firstname || ' ' || lastname as FullName
FROM HR.Employees;


SELECT
		firstname || ' ' || lastname as FullName,
		extract(year from orderdate) as Yillar,
		Count(*) as Sayisi
FROM Sales.Orders as o
JOIN Hr.employees as e on e.empid = o.empid
WHERE custid = 20
GROUP BY e.firstname, e.lastname, extract(year from orderdate)
HAVING Count(*) > 1
ORDER BY 1,2;

--

SELECT 
		empid,
		Concat(firstname,' ',lastname) as FullName
FROM HR.Employees;

SELECT
		e.empid,
		e.firstname,
		e.lastname,
		(
			SELECT sum(o.freight)
			FROM Sales.Orders as o
			WHERE o.empid = e.empid
	    ) as ToplamFreight
FROM Hr.employees as e
ORDER BY empid;

SELECT
		e.empid,
		e.firstname,
		e.lastname,
		(
			SELECT sum(o.freight)
			FROM Sales.Orders as o
			WHERE o.empid = e.empid
	    ) as EmployeeToplamFreight,
		(
			SELECT sum(freight)
			FROM Sales.Orders	
		) as GenelToplam
FROM Hr.employees as e
ORDER BY empid;

-- Cozum 1
SELECT
		e.empid,
		e.firstname,
		e.lastname,
		(
			SELECT sum(o.freight)
			FROM Sales.Orders as o
			WHERE o.empid = e.empid
	    ) as EmployeeToplamFreight,
		(
			SELECT sum(freight)
			FROM Sales.Orders	
		) as GenelToplam,
	(
		(
			SELECT sum(o.freight)
			FROM Sales.Orders as o
			WHERE o.empid = e.empid
	    )
	/
		(
			SELECT sum(freight)
			FROM Sales.Orders	
		)
	* 100) as Oran
FROM Hr.employees as e
ORDER BY empid;

-- Yukarıdaki cozum karmasık gozukuyor ve kod gelistirmede istenilen gibi degil
-- Bunu ya derived table veya CTEs ile yapalım

-- Cozum 2 Derived Table
SELECT
		empid,
		firstname,
		lastname,
		EmployeeToplamFreight,
		GenelToplam,
		(EmployeeToplamFreight / GenelToplam * 100) as Oran
FROM (
		SELECT
				e.empid,
				e.firstname,
				e.lastname,
				(
					SELECT sum(o.freight)
					FROM Sales.Orders as o
					WHERE o.empid = e.empid
			    ) as EmployeeToplamFreight,
				(
					SELECT sum(freight)
					FROM Sales.Orders	
				) as GenelToplam
		FROM Hr.employees as e	
	 ) as Rapor;

-- Cozum 3 CTEs
With Rapor as
(
		SELECT
				e.empid,
				e.firstname,
				e.lastname,
				(
					SELECT sum(o.freight)
					FROM Sales.Orders as o
					WHERE o.empid = e.empid
			    ) as EmployeeToplamFreight,
				(
					SELECT sum(freight)
					FROM Sales.Orders	
				) as GenelToplam
		FROM Hr.employees as e		
)
SELECT
		empid,
		firstname,
		lastname,
		EmployeeToplamFreight,
		GenelToplam,
		(EmployeeToplamFreight / GenelToplam * 100) as Oran
FROM Rapor;

-- Erdinc beyin cozumu
WITH TotalFreight AS (
    SELECT SUM(freight) AS GenelToplamFreight
    FROM Sales.Orders
),
EmployeeFreight AS (
    SELECT
        e.empid,
        e.firstname,
        e.lastname,
        SUM(o.freight) AS ToplamFreight
    FROM Hr.employees AS e
    LEFT JOIN Sales.Orders AS o
        ON e.empid = o.empid
    GROUP BY e.empid, e.firstname, e.lastname
)
SELECT
    ef.empid,
    ef.firstname,
    ef.lastname,
    ef.ToplamFreight,
    tf.GenelToplamFreight,
    ef.ToplamFreight / tf.GenelToplamFreight * 100 AS Oran
FROM EmployeeFreight AS ef
CROSS JOIN TotalFreight AS tf
ORDER BY ef.empid;

--

SELECT 
		10/7,
	    10/7.0,
		10.0/7,
		10.0/7.0,
		10/7.,
		10./7,
		10./7.;

--

SELECT
		shipcountry,
		SUM(freight::Numeric(6,2)) as GenelToplam,
		AVG(freight::Numeric(6,2)) as GenelOrtalama
FROM Sales.Orders
GROUP BY shipcountry
ORDER BY 2 Desc;

--

SELECT
		shipcountry,
		SUM(freight::Numeric(6,2)) as GenelToplam,
		AVG(freight::Numeric(6,2))::Numeric(10,2) as GenelOrtalama
FROM Sales.Orders
GROUP BY shipcountry
ORDER BY 2 Desc;

-- Sales.Orders tablosunda yılların Aylara gore toplam freight dagilimini bulalım
SELECT
		Extract(Year FROM Orderdate),
		SUM(Freight) as ToplamFreight
FROM Sales.Orders
GROUP BY Extract(Year FROM Orderdate)
ORDER BY 1;

--

SELECT
		Extract(Year FROM Orderdate) as Yillar,
		SUM(Freight) as ToplamFreight
FROM Sales.Orders
GROUP BY
		Extract(Year FROM Orderdate)
ORDER BY 1;

--

SELECT
		Extract(Year FROM Orderdate)as Yillar,	
		Extract(Month FROM Orderdate)as Aylar,	
		SUM(Freight) as ToplamFreight
FROM Sales.Orders
GROUP BY
		Extract(Year FROM Orderdate),
		Extract(Month FROM Orderdate)
ORDER BY 1,2;

WITH YearlyFreight AS
(
    SELECT 
        EXTRACT(YEAR FROM orderdate) AS Yillar,
        EXTRACT(MONTH FROM orderdate) AS Aylar,
        SUM(Freight) AS toplamfreight
    FROM 
        Sales.Orders
    GROUP BY  
        EXTRACT(YEAR FROM orderdate), EXTRACT(MONTH FROM orderdate)
)
SELECT 
    Yillar,
    Aylar,
    toplamfreight
FROM 
    YearlyFreight
WHERE 
    (Yillar, toplamfreight) IN (
									SELECT 
										Yillar,
										MAX(toplamfreight)
									FROM 
										YearlyFreight
									GROUP BY 
										Yillar
								)
ORDER BY 
    Yillar;


WITH YılFreight AS
(
    SELECT
        Extract(Year FROM Orderdate) AS Yillar,
        Extract(Month FROM Orderdate) AS Aylar,
        SUM(Freight) AS ToplamFreight
    FROM Sales.Orders
    GROUP BY
        Extract(Year FROM Orderdate),
        Extract(Month FROM Orderdate)
),
MaxFreight AS
(
    SELECT
        Yillar,
        MAX(ToplamFreight) AS MaxFreight
    FROM YılFreight
    GROUP BY Yillar
)
SELECT
    y.Yillar,
    y.Aylar,
    y.ToplamFreight
FROM YılFreight y
JOIN MaxFreight mf
    ON y.Yillar = mf.Yillar AND y.ToplamFreight = mf.MaxFreight
ORDER BY y.Yillar, y.Aylar;

SELECT
		empid,
		firstname,
		lastname,
		country,
		Row_Number() Over(ORDER BY firstname) as SiraNo
FROM Hr.employees;

SELECT
		empid,
		firstname,
		lastname,
		country,
		Row_Number() Over(ORDER BY country, firstname) as SiraNo
FROM Hr.employees;


SELECT
		empid,
		firstname,
		lastname,
		country,
		Row_Number() Over(Partition By country ORDER BY country, firstname) as SiraNo
FROM Hr.employees;

--

SELECT
		empid,
		firstname,
		lastname,
		country,
		Row_Number() Over(Partition By country ORDER BY country, firstname) as SiraNo
FROM Hr.employees
WHERE Row_Number() Over(Partition By country ORDER BY country, firstname) = 1;

With
Rapor as
(
	SELECT
			empid,
			firstname,
			lastname,
			country,
			Row_Number() Over(Partition By country ORDER BY country, firstname) as SiraNo
	FROM Hr.employees	
)
SELECT *
FROM Rapor
WHERE sirano = 1;

--

With
A as
(
	SELECT
			Extract(Year FROM Orderdate)as Yillar,	
			Extract(Month FROM Orderdate)as Aylar,	
			SUM(Freight) as ToplamFreight
	FROM Sales.Orders
	GROUP BY
			Extract(Year FROM Orderdate),
			Extract(Month FROM Orderdate)
),
B as
(
	SELECT
			yillar,
			aylar,
			toplamfreight,
			Row_Number() Over(Partition By yillar ORDER BY toplamfreight desc) as SiraNo
	FROM A	
)
SELECT *
FROM B
WHERE SiraNo = 1
ORDER BY Yillar;

With
A as
(
	SELECT
			Extract(Year FROM Orderdate)as Yillar,	
			Extract(Month FROM Orderdate)as Aylar,	
			SUM(Freight) as ToplamFreight
	FROM Sales.Orders
	GROUP BY
			Extract(Year FROM Orderdate),
			Extract(Month FROM Orderdate)
),
B as
(
	SELECT
			yillar,
			aylar,
			toplamfreight,
			Row_Number() Over(Partition By yillar ORDER BY toplamfreight desc) as SiraNo
	FROM A	
)
SELECT *
FROM B
WHERE SiraNo <= 3
ORDER BY Yillar;

-- CASE yapısı 2 farklı sekilde kullanılabilir
-- Simple Case ve Searched Case
SELECT
		orderid,
		orderdate,
		freight,
		shipperid,
		Case shipperid
			When 1 Then 'Denizyolu'
			When 2 Then 'Havayolu'
			When 3 Then 'Karayolu'
		End as SevkiyatTuru
FROM Sales.Orders;

SELECT
		orderid,
		orderdate,
		freight,
		shipperid,
		Case 
			When shipperid = 1 Then 'Denizyolu'
			When shipperid = 2 Then 'Havayolu'
			When shipperid = 3 Then 'Karayolu'
		End as SevkiyatTuru
FROM Sales.Orders;

SELECT
		orderid,
		orderdate,
		Extract(Year FROM Orderdate)as Yillar,	
		Extract(Month FROM Orderdate)as Aylar,
		Case Extract(Month FROM Orderdate)
			When 1 Then 'Ocak'
			When 2 Then 'Subat'
			When 3 Then 'Mart'
			When 4 Then 'Nisan'
			When 5 Then 'Mayıs'
			When 6 Then 'Haziran'
			When 7 Then 'Temmuz'
			When 8 Then 'Agustos'
			When 9 Then 'Eylul'
			When 10 Then 'Ekim'
			When 11 Then 'Kasım'
			When 12 Then 'Aralık'
			Else 'Bilinmiyor'
		End as AyAdi,	
		Freight
FROM Sales.Orders
ORDER BY 1,2;

--

SELECT
		Extract(Year FROM Orderdate)as Yillar,	
		Extract(Month FROM Orderdate)as Aylar,
		Case Extract(Month FROM Orderdate)
			When 1 Then 'Ocak'
			When 2 Then 'Subat'
			When 3 Then 'Mart'
			When 4 Then 'Nisan'
			When 5 Then 'Mayıs'
			When 6 Then 'Haziran'
			When 7 Then 'Temmuz'
			When 8 Then 'Agustos'
			When 9 Then 'Eylul'
			When 10 Then 'Ekim'
			When 11 Then 'Kasım'
			When 12 Then 'Aralık'
			Else 'Bilinmiyor'
		End as AyAdi,	
		SUM(Freight) as ToplamFreight
FROM Sales.Orders
GROUP BY
		Extract(Year FROM Orderdate),
		Extract(Month FROM Orderdate)
ORDER BY 1,2;

SELECT
		Extract(Year FROM Orderdate)as Yillar,	
		Extract(Month FROM Orderdate)as Aylar,
		Case Extract(Month FROM Orderdate)
			When 1 Then '1.Ceyrek'
			When 2 Then '1.Ceyrek'
			When 3 Then '1.Ceyrek'
			When 4 Then '2.Ceyrek'
			When 5 Then '2.Ceyrek'
			When 6 Then '2.Ceyrek'
			When 7 Then '3.Ceyrek'
			When 8 Then '3.Ceyrek'
			When 9 Then '3.Ceyrek'
			When 10 Then '4.Ceyrek'
			When 11 Then '4.Ceyrek'
			When 12 Then '4.Ceyrek'
			Else 'Bilinmiyor'
		End as AyAdi,	
		Freight
FROM Sales.Orders
ORDER BY 1,2;

SELECT
		Extract(Year FROM Orderdate)as Yillar,	
		Extract(Month FROM Orderdate)as Aylar,
		Case 
			When Extract(Month FROM Orderdate) IN(1,2,3) 		Then '1.Ceyrek'
			When Extract(Month FROM Orderdate) IN(4,5,6) 	 	Then '2.Ceyrek'
			When Extract(Month FROM Orderdate) IN(7,8,9) 	 	Then '3.Ceyrek'
			When Extract(Month FROM Orderdate) IN(10,11,12)  	Then '4.Ceyrek'			
		End as AyAdi,	
		Freight
FROM Sales.Orders
ORDER BY 1,2;

SELECT
		Extract(Year FROM Orderdate)as Yillar,	
		Extract(Month FROM Orderdate)as Aylar,
		Case 
			When Extract(Month FROM Orderdate) Between 1 and 3 		Then '1.Ceyrek'
			When Extract(Month FROM Orderdate) Between 1 and 3 	 	Then '2.Ceyrek'
			When Extract(Month FROM Orderdate) Between 1 and 3	 	Then '3.Ceyrek'
			When Extract(Month FROM Orderdate) Between 1 and 3 	Then '4.Ceyrek'			
		End as AyAdi,	
		Freight
FROM Sales.Orders
ORDER BY 1,2;

-- Searched Case
SELECT
		Extract(Year FROM Orderdate)as Yillar,
		Extract(Month FROM Orderdate) as Aylar,
		Case 
			When Extract(Month FROM Orderdate) IN(7,8,9) Then 'Ceyrek1'
			When Extract(Month FROM Orderdate) IN(10,11,12) Then 'Ceyrek2'
			When Extract(Month FROM Orderdate) IN(1,2,3) Then 'Ceyrek3'
			When Extract(Month FROM Orderdate) IN(4,5,6) Then 'Ceyrek4'	
		End as Ceyrekler,	
		SUM(Freight) as ToplamFreight
FROM Sales.Orders
GROUP BY
		Extract(Year FROM Orderdate),
		Extract(Month FROM Orderdate)
ORDER BY Yillar,Ceyrekler, Aylar;

--

SELECT
		Extract(Year FROM Orderdate),		
		Case Extract(Month FROM Orderdate)
			When 1 Then 'Ocak ' 	|| Extract(Year FROM Orderdate)
			When 2 Then 'Subat ' 	|| Extract(Year FROM Orderdate)
			When 3 Then 'Mart ' 	|| Extract(Year FROM Orderdate)
			When 4 Then 'Nisan ' 	|| Extract(Year FROM Orderdate)
			When 5 Then 'Mayıs ' 	|| Extract(Year FROM Orderdate)
			When 6 Then 'Haziran ' 	|| Extract(Year FROM Orderdate)
			When 7 Then 'Temmuz ' 	|| Extract(Year FROM Orderdate)
			When 8 Then 'Agustos ' 	|| Extract(Year FROM Orderdate)
			When 9 Then 'Eylul ' 	|| Extract(Year FROM Orderdate)
			When 10 Then 'Ekim ' 	|| Extract(Year FROM Orderdate)
			When 11 Then 'Kasım ' 	|| Extract(Year FROM Orderdate)
			When 12 Then 'Aralık ' 	|| Extract(Year FROM Orderdate)
			Else 'Bilinmiyor'
		End as AyAdi,	
		SUM(Freight) as ToplamFreight
FROM Sales.Orders
GROUP BY Extract(Year FROM Orderdate), Extract(Month FROM Orderdate)
ORDER BY 1,Extract(Month FROM Orderdate);

SELECT
	empid,
	firstname,
	lastname,
	titleofcourtesy,
	Case titleofcourtesy
			When 'Ms.'  Then 1
			When 'Mrs.' Then 2
			When 'Mr.'  Then 3
			Else 4
	End
FROM HR.Employees;
		

SELECT *
FROM HR.Employees
ORDER BY
		Case titleofcourtesy
			When 'Ms.'  Then 1
			When 'Mrs.' Then 2
			When 'Mr.'  Then 3
			Else 4
		End;

--

SELECT *
FROM HR.Employees
ORDER BY
		Case titleofcourtesy
			When 'Ms.'  Then 2
			When 'Mrs.' Then 3
			When 'Mr.'  Then 1
			Else 4
		End;

--

SELECT *
FROM HR.Employees
ORDER BY
		Case titleofcourtesy
			When 'Mr.'  Then 1
			When 'Ms.'  Then 2
			When 'Mrs.' Then 3			
			Else 4
		End;

SELECT
		empid,
		firstname,
		lastname,
		titleofcourtesy,
		Case titleofcourtesy
			When 'Mr.'  Then 'Erkek'
			When 'Ms.'  Then 'Kadın'
			When 'Mrs.' Then 'Kadın'	
			Else 'Bilinmiyor'
		End
FROM HR.Employees;


SELECT
		empid,
		firstname,
		lastname,
		titleofcourtesy,
		Case 
			When titleofcourtesy = 'Mr.'  Then 'Erkek'
			When titleofcourtesy = 'Ms.'  Then 'Kadın'
			When titleofcourtesy = 'Mrs.' Then 'Kadın'	
			Else 'Bilinmiyor'
		End
FROM HR.Employees;

--

SELECT
		empid,
		firstname,
		lastname,
		titleofcourtesy,
		Case 
			When titleofcourtesy = 'Mr.'  Then 'Erkek'
			When titleofcourtesy IN('Ms.','Mrs.')  Then 'Kadın'
			Else 'Bilinmiyor'
		End as Cinsiyet
FROM HR.Employees;

SELECT
		Case 
			When titleofcourtesy = 'Mr.'  Then 'Erkek'
			When titleofcourtesy IN('Ms.','Mrs.')  Then 'Kadın'
			Else 'Bilinmiyor'
		End as Cinsiyet,
		Count(*) as Sayisi
FROM HR.Employees
GROUP BY
			Case 
			When titleofcourtesy = 'Mr.'  Then 'Erkek'
			When titleofcourtesy IN('Ms.','Mrs.')  Then 'Kadın'
			Else 'Bilinmiyor'
		End;

SELECT *
FROM (....) as a;

SELECT
		cinsiyet,
		Count(*) as Sayisi
FROM
		(
			SELECT
					empid,
					firstname,
					lastname,
					titleofcourtesy,
					Case 
						When titleofcourtesy = 'Mr.'  Then 'Erkek'
						When titleofcourtesy IN('Ms.','Mrs.')  Then 'Kadın'
						Else 'Bilinmiyor'
					End as Cinsiyet
			FROM HR.Employees	
		) as A
GROUP BY Cinsiyet;

With
A as
(
			SELECT
					empid,
					firstname,
					lastname,
					titleofcourtesy,
					Case 
						When titleofcourtesy = 'Mr.'  Then 'Erkek'
						When titleofcourtesy IN('Ms.','Mrs.')  Then 'Kadın'
						Else 'Bilinmiyor'
					End as Cinsiyet
			FROM HR.Employees	
)
SELECT
		Cinsiyet,
		Count(*) as Sayisi
FROM A
GROUP BY Cinsiyet;

SELECT
    CASE 
        WHEN titleofcourtesy = 'Mr.' THEN 'Erkek'
        WHEN titleofcourtesy IN ('Ms.', 'Mrs.') THEN 'Kadın'
        ELSE 'Bilinmiyor'
    END AS Cinsiyet,
    COUNT(*) AS Toplam
FROM HR.Employees
GROUP BY Cinsiyet;

-- NULLS FIRST OR NULLS LAST

SELECT
		firstname,
		lastname,
		region
FROM HR.Employees
ORDER BY region;

SELECT
		firstname,
		lastname,
		region
FROM HR.Employees
ORDER BY region NULLS FIRST;

SELECT
		firstname,
		lastname,
		region
FROM HR.Employees
ORDER BY region NULLS LAST;

--

SELECT
		custid,
		companyname,
		region
FROM Sales.Customers
ORDER BY region;

SELECT
		custid,
		companyname,
		region
FROM Sales.Customers
ORDER BY region Nulls First;

SELECT
		custid,
		companyname,
		region
FROM Sales.Customers
ORDER BY region desc;

SELECT
		custid,
		companyname,
		region
FROM Sales.Customers
ORDER BY region desc Nulls Last;


SELECT
		custid,
		companyname,
		region
FROM Sales.Customers
WHERE region = 'SP';

--

SELECT
		custid,
		companyname,
		region
FROM Sales.Customers
WHERE region != 'SP';

--

SELECT
		custid,
		companyname,
		region
FROM Sales.Customers
WHERE region <> 'SP';

--

SELECT
		custid,
		companyname,
		region
FROM Sales.Customers
WHERE region = Null;

-- Yukarıdaki sorgu veri getirmez

SELECT
		custid,
		companyname,
		region
FROM Sales.Customers
WHERE region = 'Null';

SELECT
		custid,
		companyname,
		region
FROM Sales.Customers
WHERE region is Null;

SELECT
		custid,
		companyname,
		region
FROM Sales.Customers
WHERE region is Not Null;

--

	SELECT 
	    custid,
	    companyname,
	    region,
	    region AS regionB,
		COALESCE(region, '') as RegionC
	FROM 
	    sales.customers
	WHERE 
	    COALESCE(region, '') = '';

--

SELECT empid, firstname, lastname, country
FROM HR.Employees;

SELECT "empid", firstname, lastname, country
FROM HR.Employees;

SELECT 'empid', firstname, lastname, country
FROM HR.Employees;


Create Table HR.Personeller as
SELECT empid as "Employee ID", firstname as "Adi Name", lastname, country
FROM HR.Employees;

--

SELECT *
FROM HR.Personeller;

SELECT Employee ID, Adi Name, lastname, country
FROM HR.Personeller;


SELECT "Employee ID", "Adi Name", lastname, country
FROM HR.Personeller;

-- LIMIT ve OFFSET-FETCH
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate desc
Limit 5;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate desc
Limit (5);

--

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate desc
Limit (5) offset 3;
/*
Result
	11074 ...
	11073 ...
	11072 ...
	11071 ...
	11070 ...
*/


SELECT 
		orderid,
		orderdate,
		custid,
		empid,
		Row_Number() Over(ORDER BY orderdate desc) as SiraNo
FROM Sales.Orders
ORDER BY orderdate desc;


SELECT 
		orderid,
		orderdate,
		custid,
		empid,
		Row_Number() Over(ORDER BY orderdate desc) as SiraNo
FROM Sales.Orders;

-- CTEs

With Rapor as
(
	SELECT 
			orderid,
			orderdate,
			custid,
			empid,
			Row_Number() Over(ORDER BY orderdate desc) as SiraNo
	FROM Sales.Orders
	-- ORDER BY orderdate desc	
)
SELECT *
FROM Rapor
WHERE SiraNo >= 4 and SiraNo <= 8;

SELECT
    orderid,
    orderdate,
    custid,
    empid,
    ROW_NUMBER() OVER (ORDER BY orderdate DESC) AS sirano
FROM
    sales.orders
OFFSET 3 ROWS 
FETCH NEXT 5 ROWS ONLY;

-- View
Create View Erdinc.vwRapor1 as
SELECT 
			orderid,
			orderdate,
			custid,
			empid,
			Row_Number() Over(ORDER BY orderdate desc)
FROM Sales.Orders;

SELECT *
	FROM Erdinc.vwRapor1
	WHERE row_number >= 4 and row_number <= 8;

Create View Erdinc.vwRapor2 as
SELECT 
			orderid,
			orderdate,
			custid,
			empid,
			Row_Number() Over(ORDER BY orderdate desc) as SiraNo
FROM Sales.Orders;

SELECT *
	FROM Erdinc.vwRapor2;

SELECT *
FROM Erdinc.vwRapor2
WHERE SiraNo >= 4 and SiraNo <= 8;

SELECT *
FROM Sales.Orders
WHERE shipcountry = 'TR'
ORDER BY orderid desc
Limit 5;


SELECT *
FROM Sales.Orders
WHERE shipcountry = 'TR'
ORDER BY orderdate desc
Limit 5;

SELECT *
FROM Sales.Orders
WHERE shipcountry = 'TR'
ORDER BY orderdate desc
fetch first 5 rows with ties;


SELECT *
FROM Sales.Orders
WHERE shipcountry = 'TR'
ORDER BY orderdate desc
fetch first 2 rows with ties;


SELECT *
FROM Sales.Orders
WHERE shipcountry = 'TR'
ORDER BY orderdate desc
fetch first 7 rows with ties;

SELECT *
FROM Sales.Orders
WHERE 	shipcountry = 'TR' and
		empid = 1 and
		shippeddate is not null -- sevkedilen siparisleri bulur
ORDER BY 
	shippeddate desc
Limit 5;

--

SELECT *
FROM Sales.Orders
WHERE 	shipcountry = 'TR' and
		empid = 1 and
		shippeddate is not null -- sevkedilen siparisleri bulur
ORDER BY 
	shippeddate desc
Limit 2;

SELECT *
FROM Sales.Orders
WHERE 	shipcountry = 'TR' and
		empid = 1 and
		shippeddate is not null -- sevkedilen siparisleri bulur
ORDER BY 
	shippeddate desc
fetch first 2 rows with ties;

SELECT employee_id, first_name, Last_name, Salary
FROM ora.cErdinçsanlar
ORDER BY salary
fetch first 6 rows with ties;

-- Windows Functions Rank ile bakalım

SELECT
	employee_id,
	first_name,
	Last_name,
	Salary,
	Rank() Over(ORDER BY Salary) as RankNo
FROM ora.cErdinçsanlar
ORDER BY salary;

--

With
Rapor as
(
	SELECT
		employee_id,
		first_name,
		Last_name,
		Salary,
		Rank() Over(ORDER BY Salary) as RankNo
	FROM ora.cErdinçsanlar
	--ORDER BY salary	
)
SELECT *
FROM Rapor
WHERE RankNo <= 6;


SELECT *
FROM Sales.Orders
WHERE
		shipcountry = 'TR' and
		empid = 1 and
		Extract(year from orderdate) = '2008'
ORDER BY shippeddate desc Nulls Last;

SELECT
	custid,
	companyname,
	city,
	country,
	Case country
		When 'TR'  Then 1
		Else 2
	End	as SiraNo
FROM Sales.Customers
ORDER BY 
		Case country
			When 'TR'  Then 1
			Else 2
		End, 4 desc;

--

SELECT
	custid,
	companyname,
	city,
	country
FROM Sales.Customers
ORDER BY 
		Case country
			When 'TR'  Then 1
			Else 2
		End, 4 desc;

--

SELECT
	custid,
	companyname,
	city,
	country
FROM Sales.Customers
ORDER BY 
		Case country
			When 'TR'  Then 1
			Else 2
		End, country desc;

-- Taha Beyin Cozumu
SELECT
	custid,
	companyname,
	city,
	country	
FROM Sales.Customers
ORDER BY 
    country = 'TR' DESC, 
    country DESC;


SELECT first_name, last_name, salary 
FROM  Ora.CErdinçsanlar
ORDER BY Salary desc	
Limit 15	;

SELECT Count(*) * 0.15 FROM Ora.CErdinçsanlar;

SELECT first_name, last_name, salary 
FROM  Ora.CErdinçsanlar
ORDER BY Salary desc	
Limit (SELECT Count(*) * 0.15 FROM Ora.CErdinçsanlar);

SELECT (Count(*) * 0.15)::integer FROM Ora.CErdinçsanlar;

SELECT first_name, last_name, salary 
FROM  Ora.CErdinçsanlar
ORDER BY Salary desc	
Limit (SELECT (Count(*) * 0.15)::integer FROM Ora.CErdinçsanlar);

--

SELECT orderid, orderdate, custid, empid
FROM  Sales.Orders
ORDER BY orderdate desc
Limit(SELECT Count(*) * 0.01 FROM Sales.Orders);


SELECT Count(*)*0.01 FROM Sales.Orders -- %1 buluyoruz
SELECT Round(Count(*)*0.01) FROM Sales.Orders -- %1 buluyoruz, 8 Adet
SELECT Ceil(Count(*)*0.01) FROM Sales.Orders -- %1 buluyoruz,9 Adet

SELECT orderid, orderdate, custid, empid
FROM  Sales.Orders
ORDER BY orderdate desc
Limit(SELECT Ceil(Count(*)*0.01) FROM Sales.Orders)

--

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate, orderid
OFFSET 3 ROWS FETCH NEXT 5 ROW ONLY;
-- Yukarıdaki yapı hem MSSQL hemde PostgreSQL'de cErdinçsir
-- her iki sorguyu inceleyiniz ve yorumlayınız

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate, orderid
OFFSET 3 ROWS FETCH NEXT 5 ROWS ONLY;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate, orderid
Limit 5 offset 3;

--

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate, orderid
FETCH FIRST 1 ROW ONLY;


SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate, orderid
FETCH FIRST 1 ROWS ONLY;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate, orderid
FETCH FIRST 2 ROW ONLY;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate, orderid
FETCH FIRST 2 ROWS ONLY;

--

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
FETCH FIRST 3 ROW ONLY;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC
FETCH FIRST 3 ROW WITH TIES;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC
FETCH FIRST 3 ROWS WITH TIES;

--

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC
FETCH FIRST 2 ROWS ONLY
OFFSET 8;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC
FETCH FIRST 2 ROWS WITH TIES
OFFSET 8;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC
OFFSET 8 
FETCH FIRST 2 ROWS ONLY;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC
OFFSET 8 FETCH FIRST 2 ROWS WITH TIES;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate DESC
FETCH NEXT 2 ROWS WITH TIES
OFFSET 8;

-- Kosullar ve Operatorler
-- IN
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE 
	orderid = 10248 or 
	orderid = 10249 or
	orderid = 10259;

-- Yukarıdaki sorguyu IN ile yazalım
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE 
	orderid IN(10248,10249,10259);


WITH Personeller AS (
    SELECT 
        O.empid,
        SUM(O.freight) AS ToplamFreight
    FROM 
        Sales.Orders AS O
    WHERE 
        EXTRACT(YEAR FROM O.orderdate) = 2007
    GROUP BY 
        O.empid
    ORDER BY 
        ToplamFreight DESC
    LIMIT 3
)

SELECT 
 	*
FROM 
    Sales.Orders AS O
WHERE 
    O.empid IN (
				SELECT empid
				FROM Personeller
				)
    AND EXTRACT(YEAR FROM O.orderdate) = 2008;

WITH TopFreight AS
(
    SELECT empid
    FROM Sales.Orders
    WHERE EXTRACT(YEAR FROM orderdate) = 2007
    GROUP BY empid
    ORDER BY SUM(freight) DESC
    LIMIT 3
)
SELECT *
FROM Sales.Orders
WHERE EXTRACT(YEAR FROM orderdate) = 2008
  AND empid IN (
				SELECT empid FROM TopFreight
				)
ORDER BY orderdate;

--

SELECT *
FROM Sales.Orders
WHERE
		orderdate >= '20080101' and orderdate < '20090101' and
		empid IN(1,3,4);



SELECT empid--, sum(freight) as ToplamFreight
FROM Sales.Orders
WHERE
		orderdate >= '20070101' and orderdate < '20080101'
GROUP BY empid
ORDER BY sum(freight) desc
Limit 3;


SELECT *
FROM Sales.Orders
WHERE
		orderdate >= '20080101' and orderdate < '20090101' and
		empid IN(
					SELECT empid--, sum(freight) as ToplamFreight
					FROM Sales.Orders
					WHERE
							orderdate >= '20070101' and orderdate < '20080101'
					GROUP BY empid
					ORDER BY sum(freight) desc
					Limit 3	
	
				);

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE empid 
IN (
    SELECT empid
    FROM (
        SELECT empid
        FROM Sales.Orders
        WHERE EXTRACT(YEAR FROM orderdate) = 2007
        GROUP BY empid
        ORDER BY SUM(freight) DESC
        LIMIT 3
		) 
)
AND EXTRACT(YEAR FROM orderdate) = 2008;

-- Between
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE 
	orderid >= 10300 and orderid <= 10310;

-- Between ile yapılması lazım
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE 
	orderid Between 10300 and 10310;


SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE Extract(year from orderdate) = 2007;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE Extract(year from orderdate) IN(2007);

-- Cozum 2
SELECT orderid, empid, orderdate
FROM Sales.Orders
WHERE orderdate BETWEEN '2007-01-01' And '2007-12-31';

-- Eger orderdate date ile beraber time iceriyor ise cozume bakalım
SELECT orderid, empid, orderdate
FROM Sales.Orders
WHERE orderdate BETWEEN '2007-01-01 00:00:00' And '2007-12-31 23:59:59';

-- TR 	: 12-02-2024
-- UK	: 12-02-2024

SELECT orderid, empid, orderdate
FROM Sales.Orders
WHERE orderdate >= '20070101'  and orderdate < '20080101';

SELECT orderid, empid, orderdate
FROM Sales.Orders
WHERE orderdate >= '20070201'  and orderdate < '20070301';
					
-- LIKE

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE 'D%';

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE LEFT(lastname,1) = 'D';

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE 'd%';

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE '%s';

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE '%a%';

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE '%A%';

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE Upper(lastname) LIKE '%A%';

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE '_____'; 

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE '_____%';  

--

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE '_e%';  

-- ILIKE

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname ILIKE 'D%';

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname ILIKE 'd%';

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname ILIKE '%s';

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname ILIKE '%a%';

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname ILIKE '%A%';

-- Between

SELECT * 
FROM Production.Products
WHERE UnitPrice BETWEEN 10 AND 12;

SELECT *
FROM Production.Products
WHERE UnitPrice NOT BETWEEN 10 AND 12;

SELECT *
FROM Production.Products
WHERE (UnitPrice BETWEEN 10 AND 15)
AND categoryid NOT IN (1,2,3);

SELECT *
FROM Production.Products
WHERE ProductName BETWEEN 'Product DD' AND 'Product GG'
ORDER BY ProductName;

SELECT *
FROM Production.Products
WHERE ProductName NOT BETWEEN 'Product HHYDP' AND 'Product MHYDP'
ORDER BY ProductName;

SELECT *
FROM Sales.Orders
WHERE OrderDate BETWEEN '2008/05/01' AND '2008/07/31';

SELECT *
FROM Sales.Orders
WHERE OrderDate BETWEEN '20080501' AND '20080731';

SELECT *
FROM Sales.Orders
WHERE OrderDate NOT BETWEEN '2008-05-01' AND '2008-07-31';

SELECT orderid, empid, orderdate
FROM Sales.Orders
WHERE orderdate >= '20080101' and empid IN(1,3,5);

SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
WHERE  	custid = 1 AND empid IN(1, 3, 5) OR custid = 85 AND empid IN(2, 4, 6);


SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
WHERE  	(custid = 1 AND empid IN(1, 3, 5)) OR
		(custid = 85 AND empid IN(2, 4, 6));


SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
WHERE  	custid = 1 
		AND empid IN(1, 3, 5)
		OR custid = 85
		AND empid IN(2, 4, 6);

SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
WHERE  	custid = 1 AND empid IN(1, 3, 5)
		OR 
		custid = 85 AND empid IN(2, 4, 6);

SELECT
	orderid, custid, empid, orderdate
FROM 
	Sales.Orders
WHERE 	
	(custid = 1 AND empid IN(1, 3, 5))
  	OR
  	(custid = 85 AND empid IN(2, 4, 6));
SELECT
		 10 + 2 * 3,	-- = 16
		(10 + 2) * 3; 	-- = 36

-- CASE İfadesi
SELECT
		productid,
		productname,
		categoryid,
		CASE categoryid
				WHEN 1 THEN 'Beverages'
				WHEN 2 THEN 'Condiments'
				WHEN 3 THEN 'Confections'
				WHEN 4 THEN 'Dairy Products'
				WHEN 5 THEN 'Grains/Cereals'
				WHEN 6 THEN 'Meat/Poultry'
				WHEN 7 THEN 'Produce'
				WHEN 8 THEN 'Seafood'
				ELSE 'Unknown Category'
		END AS categoryname
FROM Production.Products;

--

SELECT *
FROM Sales.OrderVALUES; 

SELECT 
		orderid,
		custid,
		val,
		CASE
			WHEN val < 1000.00 THEN 'Less than 1000'
			WHEN val BETWEEN 1000.00 AND 3000.00 THEN 'Between 1000 and 3000'
			WHEN val > 3000.00 THEN 'More than 3000'ELSE 'Unknown'
		END AS valuecategory
FROM Sales.OrderVALUES;

--
SELECT
		empid, firstname, lastname,
		CASE 
			WHEN lastname='King' THEN 0 ELSE 1
		END as Sonuc	
FROM HR.Employees;

SELECT *
FROM HR.Employees
ORDER BY
CASE
	WHEN lastname='King' THEN 0 ELSE 1
END ASC;
--This will sort your results to have all records with the lastname='King' at the top

SELECT *
FROM HR.Employees
ORDER BY
		CASE
			WHEN lastname Like 'D%' THEN 0 ELSE 1
		END ASC;
--This will sort your results to have all records with the lastname Like 'D%' at the top


SELECT *
FROM HR.Employees
ORDER BY
			CASE
				WHEN lastname Like 'D%' THEN 0 ELSE 1
			END ASC, lastname;
--This will sort your results to have all records with the lastname Like 'D%' at the top

SELECT *
FROM Ora.CErdinçsanlar
WHERE job = 'IT_PROG';

SELECT
		job,
		Case job
				When 'IT_PROG' Then 1
				--When 'AD_VP' Then 1
				Else 0
		End as IT_Prog
FROM Ora.CErdinçsanlar;

SELECT
		Count(job) as JobCount,
		SUM(
			Case job
				When 'IT_PROG' Then 1
				--When 'AD_VP' Then 1
				Else 0
			End
		   ) as TotErdinçT_Prog
FROM Ora.CErdinçsanlar;

SELECT
		Count(job) as JobCount,
		SUM(Case job When 'IT_PROG' Then 1	Else 0 End) as TotErdinçT_Prog,
		SUM(Case job When 'SA_REP' Then 1	Else 0 End) as TotalSA_REP,
		sum(
			Case  When job NOT IN('IT_PROG','SA_REP') Then 1 Else 0 End		
		   ) AS DigerJoblar
FROM Ora.CErdinçsanlar;

SELECT
		Count(job) as JobCount,
		Count(Case job When 'IT_PROG' Then 1	Else null End) as TotErdinçT_Prog,
		Count(Case job When 'SA_REP' Then 1	Else null End) as TotalSA_REP,
		Count(
			Case  When job NOT IN('IT_PROG','SA_REP') Then 1 Else null End		
		   ) AS DigerJoblar
FROM Ora.CErdinçsanlar;

--

With A as
(
	SELECT
			Count(job) as JobCount,
			SUM(Case job When 'IT_PROG' Then 1	Else 0 End) as TotErdinçT_Prog,
			SUM(Case job When 'SA_REP' Then 1	Else 0 End) as TotalSA_REP
	FROM Ora.CErdinçsanlar
)
SELECT
		JobCount,
		TotErdinçT_Prog,
		TotalSA_REP,
		JobCount - (TotErdinçT_Prog + TotalSA_REP) as Others
FROM A;

--

SELECT *
FROM Erdinc.Payments;

--

SELECT
		paymentid,
		empid,
		turu,
		Case
			When Turu = 'Debit' Then Tutar Else 0
		End as Debit,
		Case
			When Turu = 'Credit' Then Tutar Else 0
		End as Credit,
		Case
			When Turu = 'Debit' Then 1 Else 0
		End as DebitB,
		Case
			When Turu = 'Credit' Then 1 Else 0
		End as CreditB,	
		tarih,
		tutar
FROM Erdinc.Payments;

--

SELECT
		empid,
		SUM(Case When Turu = 'Debit' Then Tutar Else 0 End) as TotalDebit,
		SUM(Case When Turu = 'Credit' Then Tutar Else 0 End) as TotalCredit,
		SUM(Case When Turu = 'Debit' Then 1 Else 0 End) as CountDebit,
		SUM(Case When Turu = 'Credit' Then 1 Else 0 End) as CountCredit,
		Count(Case When Turu = 'Debit' Then 1 Else null End) as CountDebitB,
		Count(Case When Turu = 'Credit' Then 1 Else null End) as CountCreditB	
FROM Erdinc.Payments
GROUP BY empid;

SELECT
		shipcountry
FROM Sales.Orders
GROUP BY shipcountry;

SELECT
		shipcountry, freight
FROM Sales.Orders;

--

SELECT
	sum(case when 	shipcountry='TR' THEN freight else null END) AS TRToplamFreight,
	sum(case when 	shipcountry='UK' THEN freight else null END) AS UKToplamFreight,
	sum(case when 	shipcountry NOT IN ('UK','TR') THEN freight else null END) AS DigerToplamFreight
FROM Sales.Orders;

--

SELECT
	sum(case when 	shipcountry='TR' THEN freight::Numeric(6,2) else 0 END) AS TRToplamFreight,
	sum(case when 	shipcountry='UK' THEN freight::Numeric(6,2) else 0 END) AS UKToplamFreight,
	sum(case when 	shipcountry NOT IN ('UK','TR') THEN freight::Numeric(6,2) else 0 END) AS DigerToplamFreight
FROM Sales.Orders;

SELECT
	shipcountry,
	sum(case when 	shipcountry='TR' THEN freight::Numeric(6,2) else 0 END) AS TRToplamFreight,
	sum(case when 	shipcountry='UK' THEN freight::Numeric(6,2) else 0 END) AS UKToplamFreight,
	sum(case when 	shipcountry NOT IN ('UK','TR') THEN freight::Numeric(6,2) else 0 END) AS DigerToplamFreight
FROM Sales.Orders
GROUP BY shipcountry;

-- Yukarıdaki sorguda En alt satırda Genel Toplamlarıda gosterelim
SELECT
	shipcountry,
	sum(case when 	shipcountry='TR' THEN freight::Numeric(6,2) else 0 END) AS TRToplamFreight,
	sum(case when 	shipcountry='UK' THEN freight::Numeric(6,2) else 0 END) AS UKToplamFreight,
	sum(case when 	shipcountry NOT IN ('UK','TR') THEN freight::Numeric(6,2) else 0 END) AS DigerToplamFreight
FROM Sales.Orders
GROUP BY shipcountry

Union All	

SELECT
	'GenelToplam' as UlkeToplamlari,
	sum(case when 	shipcountry='TR' THEN freight::Numeric(6,2) else 0 END) AS TRToplamFreight,
	sum(case when 	shipcountry='UK' THEN freight::Numeric(6,2) else 0 END) AS UKToplamFreight,
	sum(case when 	shipcountry NOT IN ('UK','TR') THEN freight::Numeric(6,2) else 0 END) AS DigerToplamFreight
FROM Sales.Orders;

SELECT	
	orderid,
	custid,
	empid,
	orderdate,
	freight,
	shipcountry,
	shippeddate
FROM Sales.Orders;

SELECT
    SUM(CASE WHEN shippeddate IS NOT NULL THEN 1 ELSE 0 END) AS Sevkedilen,
    SUM(CASE WHEN shippeddate IS NULL THEN 1 ELSE 0 END) AS Bekleyen
FROM Sales.Orders;

SELECT 'Sevkedilen' AS SiparisDurumu, COUNT(*) AS SiparisSayisi
FROM Sales.Orders
WHERE shippeddate IS NOT NULL
UNION ALL
SELECT 'Bekleyen' AS SiparisDurumu, COUNT(*) AS SiparisSayisi
FROM Sales.Orders
WHERE shippeddate IS NULL;

SELECT 
	sum(Sevkedilen) as Sevkedilen,
	sum(Bekleyen) as Bekleyen
FROM(
		SELECT
		    CASE WHEN shippeddate IS NOT NULL THEN 1 ELSE 0 END AS Sevkedilen,
		    CASE WHEN shippeddate IS NULL THEN 1 ELSE 0 END AS Bekleyen
		FROM Sales.Orders
	)t;

--
SELECT	
	orderid,
	custid,
	empid,
	orderdate,
	freight,
	shipcountry,
	shippeddate,
	Case
		When shippeddate is not null Then 'Sevkedilen'
		Else 'Bekleyen'
	End  as SiparisDurumu
FROM Sales.Orders;

-- CTEs cozelim
-- Sorgu SiparisDurumu:
With
Rapor as
(
	SELECT	
		orderid,
		custid,
		empid,
		orderdate,
		freight,
		shipcity,
		shipcountry,
		shippeddate,
		Case
			When shippeddate is not null Then 'Sevkedilen'
			Else 'Bekleyen'
		End  as SiparisDurumu
	FROM Sales.Orders
)
SELECT
		SiparisDurumu,
		Count(*) as SiparisSayisi
FROM Rapor
GROUP BY SiparisDurumu
ORDER BY SiparisDurumu;


With
Rapor as
(
	SELECT	
		orderid,
		custid,
		empid,
		orderdate,
		freight,
		shipcity,
		shipcountry,
		shippeddate,
		Case
			When shippeddate is not null Then 'Sevkedilen'
			Else 'Bekleyen'
		End  as SiparisDurumu
	FROM Sales.Orders
)
SELECT
		SiparisDurumu,
		shipcountry,
		Count(*) as SiparisSayisi
FROM Rapor
WHERE siparisdurumu = 'Bekleyen'
GROUP BY SiparisDurumu, shipcountry
ORDER BY SiparisDurumu;

With
Rapor as
(
	SELECT	
		orderid,
		custid,
		empid,
		orderdate,
		freight,
		shipcity,
		shipcountry,
		shippeddate,
		Case
			When shippeddate is not null Then 'Sevkedilen'
			Else 'Bekleyen'
		End  as SiparisDurumu
	FROM Sales.Orders
)
SELECT
		SiparisDurumu,
		shipcountry,
		shipcity,
		Count(*) as SiparisSayisi
FROM Rapor
WHERE siparisdurumu = 'Bekleyen'
GROUP BY SiparisDurumu, shipcountry, shipcity
ORDER BY SiparisDurumu;

Drop View Erdinc.vw_siparisdurumu;

-- Create View Erdinc.vw_siparisdurumu
Create or Replace View Erdinc.vw_siparisdurumu
as
With
Rapor as
(
	SELECT	
		orderid,
		custid,
		empid,
		orderdate,
		freight,
		shipcity,
		shipcountry,
		shippeddate,
		Case
			When shippeddate is not null Then 'Sevkedilen'
			Else 'Bekleyen'
		End  as SiparisDurumu
	FROM Sales.Orders
)
SELECT *
FROM Rapor;

--
SELECT *
FROM Erdinc.vw_siparisdurumu;


SELECT
		SiparisDurumu,
		shipcountry,
		shipcity,
		Count(*) as SiparisSayisi
FROM Erdinc.vw_siparisdurumu
WHERE siparisdurumu = 'Bekleyen'
GROUP BY SiparisDurumu, shipcountry, shipcity
ORDER BY SiparisDurumu;
--

With
Rapor1 as
(
	SELECT	
		orderid,
		custid,
		empid,
		orderdate,
		freight,
		shipcountry,
		shippeddate,
		Case
			When shippeddate is not null Then 'Sevkedilen'
			Else 'Bekleyen'
		End  as SiparisDurumu
	FROM Sales.Orders
),
Rapor2 AS
(
	SELECT
			SiparisDurumu,
			Count(*) as SiparisSayisi
	FROM Rapor1
	GROUP BY SiparisDurumu
	
)
SELECT *
FROM Rapor2;

With
Rapor1 as
(
	SELECT	
		orderid,
		custid,
		empid,
		orderdate,
		freight,
		shipcountry,
		shippeddate,
		Case
			When shippeddate is not null Then 'Sevkedilen'
			Else 'Bekleyen'
		End  as SiparisDurumu
	FROM Sales.Orders
),
Personel as
(
	SELECT empid, firstname || ' ' || lastname as FullName
	FROM HR.Employees
),
Rapor3 AS
(
	SELECT
			SiparisDurumu,
			Count(*) as SiparisSayisi
	FROM Rapor1
	GROUP BY SiparisDurumu
	
)
SELECT *
FROM Rapor1
JOIN Personel on Rapor1.empid = Personel.empid;

--

With
Rapor1 as
(
	SELECT	
		orderid,custid,empid,orderdate,freight,shipcountry,shippeddate,
		Case
			When shippeddate is not null Then 'Sevkedilen'
			Else 'Bekleyen'
		End  as SiparisDurumu
	FROM Sales.Orders
),
Personel as
(
	SELECT empid, firstname || ' ' || lastname as FullName
	FROM HR.Employees
),
Rapor3 AS
(
	SELECT
			SiparisDurumu,
			Count(*) as SiparisSayisi
	FROM Rapor1
	GROUP BY SiparisDurumu
	
)
SELECT *
FROM Rapor3;

With
Rapor1 as
(
	SELECT	
		orderid,
		custid,
		empid,
		orderdate,
		freight,
		shipcountry,
		shippeddate,
		Case
			When shippeddate is not null Then 'Sevkedilen'
			Else 'Bekleyen'
		End  as SiparisDurumu
	FROM Sales.Orders
),
Rapor3 AS
(
	SELECT
			SiparisDurumu,
			Count(*) as SiparisSayisi
	FROM Rapor1
	GROUP BY SiparisDurumu
	
)
SELECT e.firstname, e.lastname, Rapor1.*
FROM Rapor1
JOIN HR.Employees as e on Rapor1.empid = e.empid;

--

-- NULLIF
-- Syntax : NULLIF(expression1, expression2)

SELECT Nullif(10,20);

SELECT Nullif(10,10);

SELECT *
FROM Ora.CErdinçsanlar;

SELECT 	Employee_id,
		first_name,
		last_name,
		"commission_pct",
		Case
			When commission_pct is not null Then 'Has Commission'
			Else 'No Comission'
		End as commission_status
FROM Ora.CErdinçsanlar;

SELECT 	Employee_id,
		first_name,
		last_name,
		"commission_pct",
		NULLIF(commission_pct, 0) as Sonuc1,
		NULLIF(commission_pct::float, 0) as Sonuc2,
		NULLIF(commission_pct::Numeric, 0) as Sonuc3,
		NULLIF(commission_pct::Varchar, '') as Sonuc4,
		COALESCE(NULLIF(commission_pct, 0), 0) AS commission_statTR,
		COALESCE(NULLIF(commission_pct::float, 0), 0) AS commission_statusB,
		COALESCE(NULLIF(commission_pct::Varchar, Null), 'No Commission') AS commission_statusC
FROM Ora.CErdinçsanlar;

SELECT *
FROM    Sales.OrderDetails;

SELECT 
  	orderid,
  	Qty,  	
	discount,
	NULLIF(discount, 0),	
  	COALESCE(NULLIF(discount, 0), 5) AS adjusted_discount
FROM Sales.OrderDetails
ORDER BY orderid;

SELECT 
		AVG(discount) AS average_discountA,
		AVG(NULLIF(discount, 0)) AS average_discountB
FROM    Sales.OrderDetails;

--

SELECT 
  	orderid,
  	Qty,  	
	discount,
	NULLIF(discount, 0) as Sonuc_0,	
	NULLIF(discount, 0.15) as Sonuc_0_15,	
	NULLIF(discount, 0.20) as Sonuc_0_20,	
  	COALESCE(NULLIF(discount, 0), 5) AS adjusted_discount
FROM Sales.OrderDetails
ORDER BY orderid;

-- COALESCE
-- Syntax COALESCE ( expression  ,...n  )

DROP TABLE if Exists wages;  

CREATE TABLE wages  
(  
    emp_id        Serial Primary Key,  
    hourly_wage   DECIMAL   NULL,  
    salary        DECIMAL   NULL,  
    commission    DECIMAL   NULL,  
    num_sales     Smallint   NULL  
);

INSERT Into wages (hourly_wage, salary, commission, num_sales)  
VALUES  
    (10.00, NULL, NULL, NULL),  
    (20.00, NULL, NULL, NULL),  
    (30.00, NULL, NULL, NULL),  
    (40.00, NULL, NULL, NULL),  
    (NULL, 10000.00, NULL, NULL),  
    (NULL, 20000.00, NULL, NULL),  
    (NULL, 30000.00, NULL, NULL),  
    (NULL, 40000.00, NULL, NULL),  
    (NULL, NULL, 15000, 3),  
    (NULL, NULL, 25000, 2),  
    (NULL, NULL, 20000, 6),  
    (NULL, NULL, 14000, 4);

SELECT *
FROM wages;

SELECT 
	emp_id,
	hourly_wage,
	salary,
	commission,
	num_sales,
	COALESCE(hourly_wage * 10,salary,commission * num_sales) AS "Total Salary"
FROM wages;

SELECT 
	CAST(COALESCE(hourly_wage * 40 * 52,salary,commission * num_sales) AS money) AS "Total Salary"
FROM wages  
ORDER BY "Total Salary";

--

SELECT 
	emp_id,
	hourly_wage,
	salary,
	commission,
	num_sales,
	COALESCE(hourly_wage * 10,salary) AS "Total SalaryA",
	COALESCE(hourly_wage * 10,salary,commission * num_sales) AS "Total SalaryB",
	COALESCE(hourly_wage * 10,salary,10000) AS "Total SalaryC",
	COALESCE(hourly_wage * 10,99999) AS "Total SalaryD"
FROM wages;

--

SELECT 
		custid,
		companyname,
		region,
		COALESCE(region,'coalesce örnek')
FROM Sales.Customers;

--

SELECT 
		custid, companyname, region, 
		COALESCE(region,'coalesce örnek') as Sonuc1,
		fax,
		COALESCE(fax,'0555 998 88 76') as Sonuc2
FROM Sales.Customers;

--

SELECT employee_id, first_name,last_name,
		commission_pct,
		Coalesce(commission_pct,0)
FROM Ora.CErdinçsanlar;

-- Character(n) and Char(n)

SELECT Cast('Erdinc' as Character(10)) as "Name";
-- *"Erdinc       "*

SELECT 'Erdinc'::Character(10) as "Name";
-- *"Erdinc       "*

SELECT Cast('Erdinc' as Char(10)) as "Name";
-- *"Erdinc       "*

SELECT 'Erdinc'::Char(10) as "Name";
-- *"Erdinc       "*

-- Character Varying(n) and Varchar(n)

SELECT Cast('Erdinc' as Character Varying(10)) as "Name"; **
-- *"Erdinc"*

SELECT 'Erdinc'::Character Varying(10) as "Name";
-- *"Erdinc"*

SELECT Cast('Erdinc' as Varchar(10)) as "Name";
-- *"Erdinc"*

SELECT 'Erdinc'::Varchar(10) as "Name";
-- *"Erdinc"*

SELECT *
FROM HR.Employees;

-- Character, Char, Character Varying and Varchar

SELECT
	Cast('Erdinc' as Character) as "Name1",
	'Erdinc'::Character as "Name2",
	Cast('Erdinc' as Char) as "Name3",
	'Erdinc'::Char as "Name4";
-- Result: "A""A""A""A"


SELECT
	Cast('Erdinc' as Character Varying) as "Name1",
	'Erdinc'::Character Varying as "Name2",
	Cast('Erdinc' as Varchar) as "Name3",
	'Erdinc'::Varchar as "Name4";

-- Result: "Erdinc""Erdinc""Erdinc""Erdinc"

-- Text

SELECT Cast('Merhaba arkadaslar, Text yapısı icinde uzun metinler yazabilirsiniz' as Text);
SELECT 'Merhaba arkadaslar, Text yapısı icinde uzun metinler yazabilirsiniz'::Text;

-- Result: "Merhaba arkadaslar, Text yapısı icinde uzun metinler yazabilirsiniz"

Drop Table if Exists table_characters;

Create Table table_characters
(
	col_char Char(10),
	col_varchar Varchar(10),
	col_text Text
);

INSERT into table_characters(col_char, col_varchar, col_text)
		VALUES
		('ABC','ABC','ABC'),
		('postgreSQL','postgreSQL','postgreSQL');

SELECT *
FROM table_characters;
-- Result
-- "ABC       ""ABC""ABC"
-- "postgreSQL""postgreSQL""postgreSQL"

/*
char
nchar
varchar
nvarchar

Text
*/


Drop Table if Exists table_numbers;

Create Table table_numbers
(
	col_numeric numeric(20,5),
	col_real real,
	col_double double precision
);

SELECT *
FROM table_numbers;

INSERT INTO public.table_numbers(col_numeric, col_real, col_double)
   VALUES
     (.9, .9, .9),
     (3.16969, 3.16969, 3.16969),
     (3.1696914569899, 3.1696914569899, 3.1696914569899),
     (3.1696914569899123456789, 3.1696914569899123456789, 3.1696914569899123456789);


SELECT *
FROM table_numbers;

-- Collation
-- MSSQL ile ornek deneyelim
SELECT * FROM sales.Customers
WHERE address collate latin1_general_ci_ai like (N'ä%');

SELECT * FROM sales.Customers
WHERE address collate latin1_general_ci_as like (N'ä%');

SELECT * FROM sales.Customers
WHERE address collate latin1_general_cs_ai like (N'ä%');

SELECT * FROM sales.Customers
WHERE address collate latin1_general_cs_as like (N'ä%');

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname = N'davis';

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname COLLATE Latin1_General_CI_AS = N'davis';

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname COLLATE Latin1_General_CS_AS = N'Davis';

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname COLLATE Latin1_General_CS_AS = N'davis';

-- Yukarıdaki sorgu ise veri bulamayacaktır.

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname collate latin1_general_ci_as = N'davis'


-- Yukarıdaki sorgu ise veri bulacaktır.

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE firstname COLLATE Latin1_General_CI_AS = N'sära';

-- Yukarıdaki sorgu sonuc dondermez
-- Asagıda yer alan sorgu sonuc donderir

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE firstname COLLATE Latin1_General_CI_AI = N'sära';


select * from pg_collation;

CREATE DATABASE polish_database  LC_COLLATE 'pl_PL.UTF-8' LC_CTYPE 'pl_PL.UTF-8';

CREATE DATABASE polish_database TEMPLATE template0 LC_COLLATE 'pl_PL.UTF-8' LC_CTYPE 'pl_PL.UTF-8';

Create collation ru (locale = "ru_RU.utf8");

SELECT 
lastname
FROM HR.EMPLOYEES
WHERE lastname = 'King';

SELECT 
lastname
FROM HR.EMPLOYEES
WHERE lastname = 'king';

SELECT 
lastname
FROM HR.EMPLOYEES
WHERE lastname COLLATE "ru" = 'King';

SELECT 
lastname
FROM HR.EMPLOYEES
WHERE lastname COLLATE "ru" = 'king';


-- https://www.postgresql.org/docs/current/collation.html

-- ignore differences in accents and case
CREATE COLLATION ignore_accent_case (provider = icu, deterministic = false, locale = 'und-u-ks-level1');

SELECT 'Å' = 'A'; -- Sorgu False degeri donecektir
SELECT 'Å' = 'A' COLLATE ignore_accent_case; -- true,

SELECT 'z' = 'Z'; -- Sorgu False degeri donecektir
SELECT 'z' = 'Z' COLLATE ignore_accent_case; -- true

-- upper case letters sort before lower case.
CREATE COLLATION upper_first (provider = icu, locale = 'und-u-kf-upper');
SELECT 'B' < 'b' COLLATE upper_first; -- true

-- treat digits numerically and ignore punctuation
CREATE COLLATION num_ignore_punct (provider = icu, deterministic = false, locale = 'und-u-ka-shifted-kn');
SELECT 'id-45' < 'id-123' COLLATE num_ignore_punct; -- true
SELECT 'w;x*y-z' = 'wxyz' COLLATE num_ignore_punct; -- true

SELECT lastname
FROM HR.EMPLOYEES
WHERE lastname COLLATE ignore_accent_case = 'King';
-- Yukarıdaki kullanım ile asagida yer alan kullanım aynı sonucu donecektir
SELECT lastname
FROM HR.EMPLOYEES
WHERE lastname COLLATE ignore_accent_case = 'king';

--

SELECT *
FROM HR.EMPLOYEES
WHERE lastname > 'E';

SELECT *
FROM HR.EMPLOYEES
WHERE lastname > 'King';

SELECT *
FROM HR.EMPLOYEES
WHERE lastname >= 'King';

SELECT *
FROM HR.EMPLOYEES
WHERE lastname < 'E';

SELECT *
FROM HR.EMPLOYEES
WHERE lastname = 'King';

SELECT *
FROM HR.EMPLOYEES
WHERE lastname <> 'King';

SELECT *
FROM HR.EMPLOYEES
WHERE lastname != 'King';

--11092024
-- Boolean Data Types
/*
	True
	False,
	Null
*/
Drop Table table_boolean;

Create Table table_boolean
(
	id Serial Primary Key,
	is_available Boolean Not Null
);

INSERT into table_boolean(is_available) VALUES(TRUE);
INSERT into table_boolean(is_available) VALUES(FALSE);

INSERT into table_boolean(is_available) VALUES('TRUE');
INSERT into table_boolean(is_available) VALUES('FALSE');

INSERT into table_boolean(is_available) VALUES('1');
INSERT into table_boolean(is_available) VALUES('0');

INSERT into table_boolean(is_available) VALUES('yes');
INSERT into table_boolean(is_available) VALUES('no');

INSERT into table_boolean(is_available) VALUES('y');
INSERT into table_boolean(is_available) VALUES('n');

INSERT into table_boolean(is_available) VALUES('t');
INSERT into table_boolean(is_available) VALUES('f');

SELECT *
FROM table_boolean;

SELECT *
FROM table_boolean
WHERE is_available = true;

SELECT *
FROM table_boolean
WHERE is_available = '1';

SELECT *
FROM table_boolean
WHERE is_available = 'y';

SELECT *
FROM table_boolean
WHERE is_available = 't';

SELECT *
FROM table_boolean
WHERE is_available = 'yes';

SELECT *
FROM table_boolean
WHERE is_available = 'true';

SELECT *
FROM table_boolean
WHERE is_available;

SELECT *
FROM table_boolean
WHERE Not is_available;

-- Set Default Value

Alter Table table_boolean
Alter Column is_available
Set Default False;

-- veya soyle yapabiliriz

Alter Table table_boolean
Alter Column is_available
Set Default 'False';

-- veya soyle yapabiliriz

Alter Table table_boolean
Alter Column is_available
Set Default '0';

SELECT *
FROM table_boolean;

-- Operators ve Functions
--  || Operator, CONCAT ve CONCAT_WS

SELECT
		empid,
		city,
		Region,
		Country,
		city || ' ' || Region || ' ' || Country As LocationA		
FROM HR.Employees;


SELECT
		empid,
		city,
		Region,
		Country,
		city || ' ' || Region || ' ' || Country As LocationA,
		Coalesce(region,'') as RegionB,
		city || ' ' || Coalesce(region,'') || ' ' || Country As LocationB
FROM HR.Employees;

SELECT
		empid,
		city,
		Region,
		Country,
		city || ' ' || Region || ' ' || Country As LocationA,
		Coalesce(region,'') as RegionB,
		city || ' ' || Coalesce(region,'') || ' ' || Country As LocationB,
		Concat(city, ' ', Region, ' ', Country) As LocationC
FROM HR.Employees;

--

SELECT
		empid,
		city,
		Region,
		Country,
		Concat(city, '-', Region, '-', Country) As LocationA,
		Concat_WS('-', city, Region, Country) As LocationB
FROM HR.Employees;

--

SELECT
		empid,
		city,
		Region,
		Country,
		Concat(city, '*', Region, '*', Country) As LocationA,
		Concat_WS('#', city, Region, Country) As LocationB
FROM HR.Employees;

SELECT 
	custid, country, region, city, 
	country || ',' || region || ',' || city AS locationA,
	CONCAT(country, ',', region, ',', city ) AS locationB,
	CONCAT_WS(',', country, region, city )  AS locationC
FROM Sales.Customers;

-- LEFT ve RIGHT Fonksiyonları

-- LEFT(string, n), RIGHT(string, n)

SELECT LEFT('abcde', 3);
-- abc doner

SELECT LEFT('abcdewww', -2);

SELECT Right('abcde', 3);

SELECT Right('qabcdew', -2);

SELECT
	LEFT(firstname,1) as Soldan1
FROM HR.Employees;

SELECT
	LEFT(firstname,1) as Soldan1,
	Count(*) as Sayisi
FROM HR.Employees
GROUP BY 1
ORDER BY 1;

SELECT
	LEFT(firstname,1) as Soldan1,
	Count(*) as Sayisi
FROM HR.Employees
GROUP BY 1
HAVING Count(*) >= 2
ORDER BY 1;

--

SELECT
	country,
	Count(*) as Sayisi
FROM HR.Employees
GROUP BY 1
ORDER BY 1;

--

SELECT
	country,
	Count(*) as Sayisi
FROM Sales.Customers
GROUP BY 1
ORDER BY 1;

--

SELECT
	country,
	city,
	Count(*) as Sayisi
FROM Sales.Customers
GROUP BY 1,2
ORDER BY 1;

--

-- SUBSTRING 
SELECT substring('Hello, world!', 1 , 5) AS Sonuc;

-- Extract substring using fixed positions
SELECT 
		substring('Hello, world!' FROM 1 FOR 5) AS extracted_text1,
		substring('Hello, world!', 1 , 5) AS extracted_text2;

SELECT 
		substring('Hello, world!' FROM 8 FOR 5) AS extracted_text1,
		substring('Hello, world!', 8 , 5) AS extracted_text2;

SELECT 
		substring('Hello, world! Amazing' FROM 8) AS extracted_text1,
		substring('Hello, world! Amazing', 8) AS extracted_text2;

SELECT 
		substring('Hello, world! Amazing' FOR 12) AS extracted_text;


-- Extract substring using a regex pattern
SELECT substring('abc123def456', '\d+') AS first_number;

-- Örneğin aşağıdaki kod ‘abc’ değerini döner.
SELECT SUBSTRING('abcde', 1, 3);
SELECT SUBSTRING('abcde', 1);

SELECT SUBSTRING('abcde', 2, 3);
SELECT SUBSTRING('abcde', 2);

SELECT SUBSTRING('PostgreSQL Data', 12, 4);
-- Result : Data

SELECT SUBSTR('PostgreSQL Data', 12, 4);
-- Result : Data

SELECT SUBSTRING('PostgreSQL Data' from 12 for 4);
-- Result: Data

SELECT SUBSTRING('PostgreSQL Data' from 12);
-- Result: Data

SELECT SUBSTRING('PostgreSQL Data' for 10);
-- Result: "PostgreSQL"

--

SELECT substring('hello@example.com' FROM '([^@]+)') AS username;

SELECT substring('hello1example.com' FROM '([^1]+)') AS username;

--

SELECT
		empid,
		firstname,
		-- Use the substring function to extract the first 4 characters of the firstname
		substring(firstname, 1, 4) AS "1st 4 characters of firstname"
FROM HR.employees;

--

SELECT
		empid,
		firstname,
		position('el' IN firstname) AS "Position of 'an'"
FROM HR.employees;

SELECT
		empid,
		firstname,
		position('el' IN firstname) AS "Position of 'an'",
		substring(firstname, position('el' IN firstname), 2) AS Sonuc
FROM HR.employees
WHERE substring(firstname, position('el' IN firstname), 2) = 'el';

--

SELECT position('_' IN 'Merhaba_Arkadaslar') AS "Position of '_'";

--

SELECT
		'erdinc.degirmenci@outlook.com' as email,
		(position('@' IN 'erdinc.degirmenci@outlook.com')) AS "Position of '@'",
		SubStr('erdinc.degirmenci@outlook.com', (position('@' IN 'erdinc.degirmenci@outlook.com')), 5) AS ResultA,
		SubStr('erdinc.degirmenci@outlook.com', (position('@' IN 'erdinc.degirmenci@outlook.com')) + 1, 5) AS ResultB;

--


SELECT
		'erdinc.degirmenci@outlook.com' as email,
		(position('@' IN 'erdinc.degirmenci@outlook.com')) AS "Position of '@'",
		SubStr('erdinc.degirmenci@outlook.com', (position('@' IN 'erdinc.degirmenci@outlook.com') + 1), 5) AS ResultA;

--


SELECT 
    empid,
	email,
    split_part(email, '.', 1) AS Adi,
	split_part(email, '.', 2) AS Sonuc2,
    split_part(split_part(email, '.', 2), '@', 1) AS Soyadi
FROM 
    Personel_email;

--

SELECT
    empid,
	email,
	POSITION('.' IN email) as NoktaninYeri,
	POSITION('@' IN email) as "Et_@_in_Yeri",
    SUBSTRING(email FROM 1 FOR POSITION('.' IN email) - 1) AS firstname,
    SUBSTRING(email FROM POSITION('.' IN email) + 1 FOR POSITION('@' IN email) - POSITION('.' IN email) - 1) AS lastname
FROM
    Personel_email;



SELECT
		empid,
		email,
		(position('@' IN email) + 1) AS "Position of '@'",
		SubStr(email, (position('@' IN email) + 1), 5) AS ResultA,
		(position('.' IN email)-1) AS "Position of '.'",
		LEFT(email,(position('.' IN email)-1)) as Adi
FROM Personel_email;

--

-- POSITION 
-- Syntax POSITION(substring in string)

SELECT POSITION(' ' IN 'Erdinc DEĞİRMENCİ TR');  -- Result 4
SELECT POSITION('TR' IN 'Erdinc DEĞİRMENCİ TR');  -- Result 13


SELECT POSITION('@' IN 'erdinc.degirmenci@outlook.com'); -- Result 11

SELECT 
 'erdinc.degirmenci@outlook.com'
 ,POSITION('@' IN 'erdinc.degirmenci@outlook.com')
 ,SUBSTRING('erdinc.degirmenci@outlook.com',1, 11-1)
 ,SUBSTRING('erdinc.degirmenci@outlook.com',1, POSITION('@' IN 'erdinc.degirmenci@outlook.com')-1);

-- STRPOS Fonksiyonu

-- Aşağıdaki sorgu 4 değeri bulur.

SELECT STRPOS('Erdinc DEĞİRMENCİ TR', ' ');  -- Result 4
SELECT STRPOS('Erdinc DEĞİRMENCİ TR', 'TR');  -- Result 13

SELECT STRPOS('erdinc.degirmenci@outlook.com', '@'); -- Result 11

SELECT 
 'erdinc.degirmenci@outlook.com'
 ,STRPOS('erdinc.degirmenci@outlook.com', '@')
 ,SUBSTRING('erdinc.degirmenci@outlook.com',1, 11-1)
 ,SUBSTRING('erdinc.degirmenci@outlook.com',1, STRPOS('erdinc.degirmenci@outlook.com', '@')-1);

-- Soru
-- HR.Employees tablosunda
-- firstname icerisinde e gecen verileri bulunuz
SELECT
		empid,
		firstname,
		lastname
FROM HR.Employees;


SELECT
		empid,
		firstname,
		lastname
FROM HR.Employees;

SELECT *
FROM HR.Employees
WHERE POSITION('E' IN Upper(firstname))> 0;


SELECT *
FROM HR.Employees
WHERE POSITION('e' IN firstname)> 0;

SELECT empid, firstname, lastname, POSITION('S' IN firstname)
FROM HR.Employees
WHERE POSITION('S' IN firstname)> 0;

SELECT empid, firstname, lastname, POSITION('S' IN firstname)
FROM HR.Employees
WHERE POSITION('S' IN Upper(firstname))> 0;


SELECT empid, firstname, lastname, POSITION('s' IN firstname)
FROM HR.Employees
WHERE POSITION('s' IN firstname)> 0;

SELECT *
FROM HR.Employees
WHERE POSITION('s' IN LOWER(firstname)) > 0;


SELECT *
FROM HR.Employees
WHERE STRPOS(Upper(firstname), 'E')> 0;

SELECT *
FROM HR.Employees
WHERE STRPOS(firstname, 'e')> 0;


SELECT empid, firstname, lastname, STRPOS(firstname, 'S')
FROM HR.Employees
WHERE STRPOS(firstname, 'S')> 0;

-- Cozum 3 / ILIKE
SELECT firstname
FROM HR.Employees
WHERE firstname ILIKE '%e%';

SELECT firstname
FROM HR.Employees
WHERE firstname ILIKE '%S%';

-- Reverse Fonksiyonu
SELECT Reverse('abcde');

SELECT
	firstname,
	Reverse(firstname) as "ReverseA",
	Reverse(Reverse(firstname)) as "ReverseB"
FROM HR.Employees;

-- LENGTH 

SELECT LENGTH(N'abcde');
SELECT LENGTH('abcde');

SELECT
	firstname,
	Length(firstname) as Uzunluk
FROM HR.Employees
ORDER BY Uzunluk desc;

SELECT Length(123456789);

SELECT Length('123456789');

SELECT Length(123456789::Text);
SELECT Length(Cast(123456789 as Text));

SELECT Length(123456789::Varchar);
SELECT Length(Cast(123456789 as Varchar));

SELECT Length(123456789::Char(20));
SELECT Length(Cast(123456789 as Char(20)));


SELECT Length(123456789::Varchar(20));
SELECT Length(Cast(123456789 as Varchar(20)));

SELECT
		orderid,
		freight,
		length(freight::text),
		length(cast(freight as text))
FROM Sales.Orders
ORDER BY 4 desc;


SELECT
		orderid,
		freight,
		freight::numeric,
		(freight::numeric)::integer,
		length((freight::numeric)::text) as uzunluk_numeric,
		length(((freight::numeric)::integer)::text) as Uzunluk_integer,
		length(freight::text),
		length(cast(freight as text))
FROM Sales.Orders
ORDER BY 4 desc;


SELECT char_length('');		-- Sonuc 0
SELECT char_length(' ');	-- Sonuc 1

SELECT char_length('A');	-- Sonuc 1
SELECT char_length('Elma');	-- Sonuc 4

SELECT char_length(null);	-- Sonuc null

-- UPPER ve LOWER 
-- Syntax UPPER(string), LOWER(string)
SELECT UPPER('amazing SQLData');

SELECT LOWER('amazing SQLData');

-- INITCAP 

-- Syntax INITCAP(string)
SELECT INITCAP('amazing SQLData');
-- Result: "Amazing Sqldata"

SELECT INITCAP('select DATA for analyzing');
-- Result: SELECT Data For Analyzing

SELECT
		firstname,
		lastname,
		INITCAP(CONCAT(firstname, ' ', lastname)) as FullName
FROM HR.Employees;

-- SPLIT_PART 

SELECT SPLIT_PART('1,229,3',',',2);-- 229 degerini doner
SELECT SPLIT_PART('10,245,969',',',2);-- 245 degerini doner

SELECT SPLIT_PART('Elma,Armut,Muz',',',1); -- Elma
SELECT SPLIT_PART('Elma,Armut,Muz',',',2); -- Armut
SELECT SPLIT_PART('Elma,Armut,Muz',',',3); -- Muz
SELECT SPLIT_PART('Elma,Armut,Muz',',',4); -- sonuc donmez


SELECT SPLIT_PART('Elma,Armut,Muz',',',-1); -- Muz
SELECT SPLIT_PART('Elma,Armut,Muz',',',-2); -- Armut
SELECT SPLIT_PART('Elma,Armut,Muz',',',-3); -- Elma
SELECT SPLIT_PART('Elma,Armut,Muz',',',-4); -- sonuc donmez


SELECT SPLIT_PART('Elma|Armut|Muz','|',1); -- Elma
SELECT SPLIT_PART('Elma|Armut|Muz','|',2); -- Armut
SELECT SPLIT_PART('Elma|Armut|Muz','|',3); -- Muz

--

SELECT split_part('TR,Canada', ',', 1) AS Ulke;
-- Result : TR

SELECT split_part('TR,Canada', ',', 2) AS Ulke;
-- Result : Canada

-- fisno tarih 		tutar cariunvan ...
-- 00001 12-07-2024 9000  Tesla

SELECT SPLIT_PART('00001 12-07-2024 9000 Tesla',' ',3); -- 9000
SELECT SPLIT_PART('00001 12-07-2024 9000 Tesla',' ',2); -- 12-07-2024


SELECT SPLIT_PART('00001 12-07-2024 9000 Tesla','-',1); -- Result: "00001 12"

SELECT SPLIT_PART('12-07-2024 9000 Tesla','-',3); -- Result: "2024 9000 Tesla"


-- SPLIT_PART ile birthdate alanından Yil, Ay, Gun bilgilerini elde ediniz

SELECT
	firstname,
	lastname,
	birthdate
FROM HR.Employees;

-- Taha beyin cozumu
SELECT
	birthdate ,
  	split_part(CAST(birthdate AS TEXT), '-', 1) AS year_,
  	split_part(CAST(birthdate AS TEXT), '-', 2) AS month_,
  	split_part(CAST(birthdate AS TEXT), '-', 3) AS day_
FROM HR.EMPLOYEES;

--

SELECT
	firstname,
	lastname,
	birthdate,
	SPLIT_PART(birthdate::text,'-',1) as Yillar,
	SPLIT_PART(birthdate::text,'-',2) as Aylar,
	SPLIT_PART(birthdate::text,'-',3) as Gunler
FROM HR.Employees;

-- Yukarıdaki sorguda Yillar, Aylar ve Gunler Text olarak doner
-- Bunu integer yapalım

SELECT
	firstname,
	lastname,
	birthdate,
	SPLIT_PART(birthdate::text,'-',1)::integer as Yillar,
	SPLIT_PART(birthdate::text,'-',2)::integer as Aylar,
	SPLIT_PART(birthdate::text,'-',3)::integer as Gunler
FROM HR.Employees;

-- The TRIM, BTRIM, RTRIM and LTRIM Functions
-- Syntax : TRIM(string), BRIM(string), RTRIM(string), LTRIM(string)

SELECT '      Hello   World      ';				--Sonuc :  "      Hello   World      " 
SELECT ltrim('      Hello   World      ');			--Sonuc :  "Hello   World      "
SELECT rtrim('      Hello   World      ');			--Sonuc :  "      Hello   World"
SELECT rtrim(ltrim('      Hello   World      '));	--Sonuc :  "Hello   World"
SELECT trim('      Hello   World      ');			--Sonuc :  "Hello   World"
SELECT btrim('      Hello   World      ');			--Sonuc :  "Hello   World"
-- trim ve btrim aynı sonucu doner(btrim both trim)

SELECT trim(Leading FROM '      Hello   World      ');
--Sonuc :  "Hello   World      "

SELECT trim(Trailing FROM '      Hello   World      ');
--Sonuc :  "      Hello   World"

SELECT trim(Both FROM '      Hello   World      ');
--Sonuc :  "Hello   World"

SELECT trim(Leading(' ') FROM '      Hello   World      ');
--Sonuc :  "Hello   World      "

SELECT trim(Leading('*') FROM '******Hello   World      ');
--Sonuc :  "Hello   World      "

SELECT trim(Leading('*') FROM '******Hello   World******');
--Sonuc :  "Hello   World******"

SELECT trim(Trailing('*') FROM '******Hello   World******');
--Sonuc :  "******Hello   World"


SELECT Cast(00012345600 as Text); 		--Sonuc :  "12345600"
SELECT trim(Leading FROM Cast(00012345600 as Text)); 		--Sonuc :  "12345600"
SELECT trim(Leading '0' FROM Cast(00012345600 as Text));	--Sonuc :  "12345600"
SELECT trim(Trailing '0' FROM Cast(00012345600 as Text));	--Sonuc :  "123456"
SELECT trim(Both '0' FROM Cast(00012345600 as Text));		--Sonuc :  "123456"

SELECT
		Ltrim('yyyummy','y'),	--Sonuc :"ummy"
		Ltrim('yummy','y'),		--Sonuc :"ummy"
		Rtrim('yummy','y'),		--Sonuc :"yumm"
		Btrim('yummy','y'), 	--Sonuc :"umm"
		Btrim('yyyummyyy','y');	--Sonuc :"umm"

SELECT Ltrim('  yyyummy  ','');	--Sonuc :"  yyyummy  " Sonuc Aynı degismez 
SELECT Rtrim('  yyyummy  ',''); 	--Sonuc :"  yyyummy  " Sonuc Aynı degismez
SELECT Btrim('  yyyummy  ','');	--Sonuc :"  yyyummy  " Sonuc Aynı degismez

SELECT Ltrim('  yyyummy  ',' ');	--Sonuc :"yyyummy  "
SELECT Rtrim('  yyyummy  ',' '); 	--Sonuc :"  yyyummy"
SELECT Btrim('  yyyummy  ',' ');	--Sonuc :"yyyummy"

-- LPAD ve RPAD Fonksiyonları
SELECT LPAD('SQL', 15, '*');-- "************SQL"
SELECT RPAD('SQL', 15, '*');-- "SQL************"
SELECT LPAD('3456', 10, '*');-- "******3456"
SELECT LPAD('3456', 10, 'A');-- "AAAAAA3456"
SELECT LPAD('3456', 10, '0');-- "0000003456"

SELECT
		empid,
		LPAD(empid, 10, '0'),
		firstname,
		lastname
FROM HR.Employees;


SELECT
		empid,
		LPAD(empid::Text, 10, '0')
		firstname,
		lastname
FROM HR.Employees;

SELECT
		custid,
		LPAD(custid::Text, 10, '0') as SonucA,
		LPAD(custid::Varchar, 10, '0') as SonucB,
		companyname
FROM Sales.Customers;

-- REGEXP_MATCHES() function
-- Here’s the basic syntax for the PostgreSQL REGEXP_MATCHES() function:
-- REGEXP_MATCHES(source_string, pattern [, flags])
-- The REGEXP_MATCHES() function accepts three arguments:

1) source
The source is a string that you want to extract substrings that match a regular expression.

2) pattern
The pattern is a POSIX regular expression for matching.

3) flags
The flags argument is one or more characters that control the behavior of the function. 
-- For example, i allows you to match case-insensitively.
/*
Flags
	The flags argument is a string where each character represents a different flag.
	Here are the commonly used flags:
	
	i: Case-insensitive matching.
	g: Global matching (returns all matches, not just the first one).
	n: Disables the capture of subexpressions (non-capturing mode).
	m: Multiline mode (changes the behavior of ^ and $ to match the start and end of any line within the string, not just the start and end of the string)
*/
-- The REGEXP_MATCHES() function returns a set of text, even if the result array only contains a single element.

-- 1. Case-Insensitive Matching
SELECT REGEXP_MATCHES('Hello World', 'hello', 'i');	-- flag 'i' ile Sonuc doner
-- This will return {"Hello"} because the i flag makes the match case-insensitive.

SELECT REGEXP_MATCHES('Hello World', 'hello', 'g');	-- flag 'g' ile Sonuc Donmez	
SELECT REGEXP_MATCHES('Hello World', 'hello');			-- flag gonderilmez ise Sonuc Donmez	

-- 2. Global Matching
SELECT REGEXP_MATCHES('abc abc abc', 'abc', 'g');	-- Tum sonucları doner

SELECT REGEXP_MATCHES('abc abc abc', 'abc', 'i');	-- Tek sonuc doner

SELECT REGEXP_MATCHES('Hello World', 'hello', 'g');	-- Sonuc Donmez
-- This will return {"abc","abc","abc"} because the g flag makes the function return all matches.

-- Example: Case-Insensitive and Global Matching
SELECT REGEXP_MATCHES('aBc AbC abc', 'abc', 'ig');
-- This will return {"aBc","AbC","abc"} because both the i (case-insensitive) and g (global) flags are used.

-- 3. Non-Capturing Mode
SELECT REGEXP_MATCHES('abc 123 def', '\d+', 'n');
-- This will return {} because the n flag disables the capture of subexpressions, and \d+ (matching digits) is treated as a non-capturing group.


-- Combining Flags
-- You can combine multiple flags by specifying them together in the flags argument.

-- Example Queries
-- Creating a Table and INSERTing Data

CREATE TABLE test_data (
    id SERIAL PRIMARY KEY,
    text_data TEXT
);

INSERT INTO test_data (text_data)
	VALUES
			('Hello World'),
			('hello world'),
			('HELLO WORLD'),
			('abc abc abc'),
			('123 456 789');

SELECT *
FROM test_data;

-- Using REGEXP_MATCHES with Flags
-- Case-insensitive matching
SELECT 
		id,
		REGEXP_MATCHES(text_data, 'hello', 'i') AS matches
FROM test_data;

-- Global matching
SELECT 
		id, 
		REGEXP_MATCHES(text_data, 'abc', 'g') AS matches
FROM test_data
-- WHERE text_data LIKE '%abc%';

SELECT 
		id, 
		REGEXP_MATCHES(text_data, 'abc', 'g') AS matches
FROM test_data
WHERE text_data LIKE '%abc%';	

-- Non-capturing mode (note that it might not be very useful with REGEXP_MATCHES)
SELECT 
		id,
		REGEXP_MATCHES(text_data, '\d+', 'n') AS matches
FROM test_data;
	
SELECT 
    REGEXP_MATCHES('Learning #PostgreSQL #REGEXP_MATCHES', 
         '#([A-Za-z0-9_]+)', 
        'g');

SELECT 
    REGEXP_MATCHES('Learning #PostgreSQL #REGEXP_MATCHES Hello #1World', 
         '#([A-Za-z0-9_]+)', 
        'g');

SELECT 
    REGEXP_MATCHES('Learning #PostgreSQL #REGEXP_MATCHES Hello #1World', 
         '([A-Za-z0-9_]+)', 
        'g');

SELECT 
    (REGEXP_MATCHES('Learning #PostgreSQL #REGEXP_MATCHES Hello #1World', 
         '([0-9_]+)', 
        'g'));

SELECT 
    (REGEXP_MATCHES('Learning #PostgreSQL #REGEXP_MATCHES Hello #1World', 
         '([0-9_]+)', 
        'g')) [1];


SELECT 
    (REGEXP_MATCHES('Learning #PostgreSQL #REGEXP_MATCHES Hello #1World #1259World', 
         '([0-9])', 
        'g'));

SELECT 
    (REGEXP_MATCHES('Learning #PostgreSQL #REGEXP_MATCHES Hello #1World #1259World', 
         '([0-9])', 
        'g')) [1];



SELECT shipaddress
FROM Sales.Orders;

SELECT
	Regexp_Matches(shipaddress, 'de') as Sonuc,
	shipaddress
FROM Sales.Orders;

SELECT
	Regexp_Matches(shipaddress, 'de|9012') as Sonuc,
	shipaddress
FROM Sales.Orders;

SELECT address
FROM HR.Employees;

SELECT 
	Regexp_Matches(address, 'Way|Rd.') as Sonuc,
	address
FROM HR.Employees;

-- REPLACE 
Syntax : REPLACE(string, substring1, substring2)
SELECT REPLACE('1-a 2-b', '-', ':');
-- Çıktı: ‘1:a 2:b’.

SELECT REPLACE('PostgreSQL SELECT Data', 'data', 'Veri');
-- Çıktı: Buyuk Kucuk harf duyarlı oldugu icin Sonuc aynı kalır
SELECT REPLACE('PostgreSQL SELECT Data', 'Data', 'Veri');
-- Çıktı: "PostgreSQL SELECT Veri"


SELECT
		empid,
		firstname,
		lastname,
		Replace(lastname, 'e', '') as SonucA,
		Length(lastname) - Length(Replace(lastname, 'e', '')) as "e harflerinin sayısı"
FROM HR.Employees;

-- Replacing Parts of a String: replace, regexp_replace
-- Replacing Parts of a String
-- Use the replace function or regexp_replace to replace parts of a string.

-- Using replace to replace occurrences of a substring
SELECT replace('Hello, world!', 'world', 'PostgreSQL') AS new_text;

-- Using regexp_replace to replace occurrences based on a regex pattern
SELECT regexp_replace('abc123def456', '\d+', 'XYZ') AS new_text;

SELECT regexp_replace('abc123def456', '\d+', 'DUNYA') AS new_text;

-- REPEAT Function
Belirtilen string ifadeyi belirtilen kez yineler.
-- Syntax REPLICATE(string, n) => MSSQL
-- Syntax REPEAT(string, n) => PostgreSQL

/*
-- MSSQL ile
SELECT Replicate('abc', 3);
--‘abcabcabc’

SELECT Replicate('*', 8);
--Result:********
*/
	
SELECT REPEAT('abc', 3);
‘abcabcabc’

SELECT Repeat('*', 8);
--Result:********

SELECT 
		supplierid,
		REPEAT('0', 9) || CAST(supplierid AS VARCHAR(10)),
        RIGHT(REPEAT('0', 9) || CAST(supplierid AS VARCHAR(10)), 10) AS strsupplierid
FROM Production.Suppliers;



-- Overlay Fonksiyonu
-- (STUFF Fonksiyonu)
-- overlay fonksiyonu bir substring’i  string’ den çıkarıp yerine yeni bir substring ekler.

-- Syntax overlay(string, pos, delete_length, INSERTstring)
SELECT overlay ('xyz' Placing 'abc' FROM 2 for 1);	-- Çıktı:  "xabcz"

SELECT overlay ('abcdexyz' Placing 'elma' FROM 2 for 3);	-- Çıktı:  "aelmaexyz"

SELECT overlay ('xyz super' Placing 'ab' FROM 2);	-- Çıktı:  "xabc uper"

SELECT overlay ('xyz super' Placing 'abc' FROM 2);	-- Çıktı:  "xabcsuper"

SELECT overlay ('xyz super' Placing 'Dunya' FROM 2);	-- Çıktı:  "xDunyaper"

-- Silme işlemi yapmak istemiyorsanız, 3. parametre olarak 0 kullanmanız yeterli olur
SELECT overlay ('xyz super' Placing 'abc' FROM 2 for 0); -- Çıktı:  "xabcyz super"

SELECT overlay ('VeriTabanı Egitimi' Placing ' Sorgulama' FROM 5 for 6);	
-- Çıktı:  "Veri Sorgulama Egitimi"

SELECT overlay ('1234456741253251' Placing '****' FROM 13 for 4);
--Çıktı: "123445674125****"
SELECT overlay ('1234456741253251' Placing repeat('*',4) FROM 13 for 4);

-- IBAN : '1234456741253251' icin ortadaki 8 karakteri maskeleyiniz
-- Result: 1234********3251

SELECT overlay ('1234456741253251' Placing '********' FROM 5 for 8);

SELECT overlay ('1234456741253251' Placing repeat('*',8) FROM 5 for 8);
--Çıktı: "1234********3251"


-- PostgreSQL
SELECT overlay ('xyz' Placing 'abc' FROM 2 for 0);	-- Çıktı:  "xabcyz"
-- MSSQL
-- SELECT STUFF('xyz',2,0,'abc');	-- Çıktı:  "xabcyz"

-- SELECT STUFF('1234456741253251',5,8,'********');
-- SELECT REPLICATE('*',8);
-- SELECT STUFF('1234456741253251',5,8, REPLICATE('*',8));

--
Drop Table if exists Personel;

Create Table Personel(
	id Serial,
	isim Varchar(50),
	IBAN Varchar(16)
);

INSERT into Personel(isim, IBAN)
VALUES
		('Selen','1234567890123456'),
		('Yasin','9245645601234569'),
		('Buket','9945678901234999');

INSERT into Personel(isim, IBAN) VALUES  ('Yildiz','1234567890123456');
INSERT into Personel(IBAN, isim) VALUES ('8834567898123459', 'irem');

SELECT *
FROM Personel;

--Personel tablosundaki IBAN bilgisinin ortadaki 8 karakterini maskeleyiniz
SELECT
		id,
		isim,
		-- IBAN,
		OVERLAY(IBAN Placing '********' FROM 5 For 8) AS IBANMASKELI1,
		OVERLAY(IBAN Placing Repeat('*', 8) FROM 5 For 8) AS IBANMASKELI2	
FROM Personel;

-- FORMAT
-- String Functions and Operators
-- Syntax format(formatstr text [, formatarg "any" [, ...] ])

Format Specifiers
	%s: Formats the argument as a simple string.
	%I: Formats the argument as an SQL identifier, ensuring it is properly quoted and 	    escaped.
	%L: Formats the argument as an SQL literal, ensuring it is properly quoted and   	    escaped.

SELECT format('Hello %s', 'World');
-- Result: Hello World

SELECT format('Herkese %s %s', 'Mutlu','Pazarlar');
-- Result: "Herkese Mutlu Pazarlar"

SELECT format('Testing %s, %s, %s, %%', 'one', 'two', 'three');
-- Result: Testing one, two, three, %

SELECT format('INSERT INTO %I VALUES(%L)', 'Foo bar', 'Reilly');
-- Result: "INSERT INTO "Foo bar" VALUES('Reilly')"

-- SELECT format('INSERT INTO %I VALUES(%L)', 'Foo bar', E'O\'Reilly');
SELECT *
FROM HR.Employees
WHERE empid = 1;

SELECT *
FROM HR.Employees
WHERE empid = '1';

SELECT *
FROM HR.Employees
WHERE empid = integer '1';


SELECT
	shipcountry,
	freight
FROM Sales.Orders
WHERE freight >= '800';

SELECT
	shipcountry,
	freight
FROM Sales.Orders
WHERE freight >= money '800';

--
SELECT
	shipcountry,
	freight
FROM Sales.Orders
WHERE freight >= 800::money;

--
-- TO_Char Function

SELECT To_Char(5559988876,'(999) 999 99 99') as PhoneNumber;

SELECT
		To_Char(5559988876,'9 999 999 99 99') as Phone1,
		To_Char(5559988876,'0 000 000 00 00') as Phone2,
		To_Char(5559988876,'0 999 999 99 99') as Phone3,
		To_Char(5559988876,'0 (999) 999 99 99') as Phone4,
		To_Char(5559988876,'0 (000) 000 00 00') as Phone5,
		'+90 ' || To_Char(5559988876,'(999) 999 99 99') as Phone6;

SELECT 
	    '+90 (' || substr(CAST(5559988876 AS TEXT), 1, 3) || ') ' || 
	    substr(CAST(5559988876 AS TEXT), 4, 3) || ' ' || 
	    substr(CAST(5559988876 AS TEXT), 7, 2) || ' ' || 
	    substr(CAST(5559988876 AS TEXT), 9, 2) AS Phone5;

SELECT
		orderid,
		custid,
		empid,
		orderdate,
		To_Char(orderdate,'ddMMyyyy') as TarihA,
		To_Char(orderdate,'dd-MM-yyyy') as TarihB,
		freight,
		To_Char(freight::numeric, 'FM999,999,999.00') as NavlunA1,
		To_Char(freight::numeric, 'FM999,999,999.00 $') as NavlunA2,
		To_Char(freight::numeric, '$ FM999,999,999.00') as NavlunA3,
		To_Char((freight*1000)::numeric, '$ FM999,999,999.00') as NavlunA4
FROM Sales.Orders;

-- To_Char format yapılarını PostgreSQL sitesinin su linkinden inceleyebiliriz
-- https://www.postgresql.org/docs/current/functions-formatting.html

-- STRING_TO_ARRAY, REGEXP_SPLIT_TO_ARRAY, REGEXP_SPLIT_TO_TABLE Functions
/*
To split a string into an array or table, 
you can use functions like 
	string_to_array,
	regexp_split_to_array or 
	regexp_split_to_table
*/
	
-- Using string_to_array to split a string into an array
SELECT string_to_array('Lorem ipsum dolor sit amet', ' ') AS words;

-- Using regexp_split_to_array to split a string into an array based on a regex
SELECT regexp_split_to_array('Lorem ipsum dolor sit amet', '\s+') AS words;

-- Using regexp_split_to_table to split a string into a table based on a regex
SELECT regexp_split_to_table('Lorem ipsum dolor sit amet', '\s+') AS word;
SELECT regexp_split_to_table('Lorem ipsum dolor sit amet', ' ') AS word;

SELECT regexp_split_to_table('8901 Garrett Hill', '\s+') AS word;


SELECT *
FROM HR.Employees;


SELECT
	address,
	(SELECT Count(*) FROM regexp_split_to_table (address,' ')) as KelimeSayisi
FROM HR.Employees;

SELECT
	empid,
	firstname,
	lastname,
	address
FROM HR.Employees;

SELECT
	empid,
	firstname,
	lastname,
	address,
	regexp_split_to_table (address,' ') as Sonuc
FROM HR.Employees;


SELECT 
	empid, -- Assuming there's an employee ID column to identify each employee
	firstname,	
	lastname,
	address,    
	regexp_split_to_table(address, '\s+') AS Sonuc
FROM 
    HR.Employees;

-- Unnest

Drop TABLE if exists CategoryTest;

CREATE TABLE CategoryTest (
    CategoryId SERIAL PRIMARY KEY,
    Name TEXT,
    Aciklama TEXT
);

INSERT INTO CategoryTest (Name, Aciklama) VALUES 
('Category1', 'Uzum,Erik,Muz'),
('Category2', 'Karpuz,Kavun'),
('Category3', 'Elma');

SELECT *
FROM CategoryTest;

SELECT 
    CategoryId, 
    Name, 
    string_to_array(Aciklama, ',') AS SonucA
FROM 
    CategoryTest;

SELECT 
    CategoryId, 
    Name, 
    unnest(string_to_array(Aciklama, ',')) AS SonucA
FROM 
    CategoryTest;

--

Drop Table if exists StringSplitTable;

Create Table StringSplitTable
(
	ProductId Serial,
	Name varchar(50),
	Tags varchar(200)
);

INSERT into StringSplitTable(Name, Tags) VALUES('Full-Finger Gloves', 'clothing,road,touring,bike');
INSERT into StringSplitTable(Name, Tags) VALUES('LL Headset', 'bike');
INSERT into StringSplitTable(Name, Tags) VALUES('HL Mountain Frame', 'bike,mountain');

SELECT *
FROM StringSplitTable;


SELECT
	productid,
	name,
	tags,
	string_to_array(tags, ',') AS value
FROM StringSplitTable;

SELECT
	productid,
	name,
	tags,
	unnest(string_to_array(tags, ',')) AS value
FROM StringSplitTable;

--

SELECT  
	unnest(string_to_array(tags, ',')) AS value,
	COUNT(*) AS number_of_articles
FROM StringSplitTable
GROUP BY unnest(string_to_array(tags, ','))
ORDER BY COUNT(*) DESC;

--

SELECT  
	unnest(string_to_array(tags, ',')) AS value,
	COUNT(*) AS number_of_articles
FROM StringSplitTable
GROUP BY 1
ORDER BY COUNT(*) DESC;

--

SELECT  
	unnest(string_to_array(tags, ',')) AS value,
	COUNT(*) AS number_of_articles
FROM StringSplitTable
GROUP BY unnest(string_to_array(tags, ','))
HAVING COUNT(*) > 1  
ORDER BY COUNT(*) DESC;

--

With
A AS
(
	SELECT 
		ProductId,
		Name,
		Tags,
		unnest(string_to_array(tags, ',')) AS value  
 	FROM StringSplitTable
)
SELECT *
FROM A
WHERE value IN ('clothing','bike');

-- WHERE kosulu icinde value IN ('clothing','road') olan verileri bulalım

With
A AS
(
	SELECT
		ProductId,
		Name,
		Tags,
		unnest(string_to_array(tags, ',')) AS value  
 	FROM StringSplitTable
)
SELECT *
FROM A
WHERE value IN ('clothing','road');



With
A AS
(
	SELECT
		ProductId,
		Name,
		Tags,
		unnest(string_to_array(tags, ',')) AS value  
 	FROM StringSplitTable
)
SELECT Distinct
		ProductId,
		Name,
		Tags	
FROM A
WHERE value IN ('clothing','road');

--

With
A AS
(
	SELECT 
		ProductId::VarChar,
		Name,
		Tags,
		unnest(string_to_array(tags, ',')) AS valueA  
	FROM StringSplitTable
)
SELECT *
FROM A
JOIN (
		SELECT *
		FROM unnest(string_to_array('1,2,3',',')) AS valueB
	  ) on valueB = ProductId;

SELECT *
FROM unnest(string_to_array('Austin,Texas,Seattle,Washington,Denver,Colorado', ','));


SELECT *
FROM Sales.Customers
WHERE country IN
					(
						SELECT *
						FROM unnest(string_to_array('TR,UK', ','))
					);

-- Gelen veri TR|UK olsaydı nasıl cozecegimize bakalım
SELECT *
FROM Sales.Customers
WHERE country IN
					(
						SELECT *
						FROM unnest(string_to_array('TR|UK', '|'))
					);

-- Gelen veri TR#UK olsaydı nasıl cozecegimize bakalım
SELECT *
FROM Sales.Customers
WHERE country IN
					(
						SELECT *
						FROM unnest(string_to_array('TR#UK', '#'))
					);

--

SELECT
		shipcountry,
		Count(*) as Sayisi
FROM Sales.Orders
GROUP BY 1
ORDER BY 1;

SELECT
		shipcountry,
		empid,
		Count(*) as Sayisi
FROM Sales.Orders
GROUP BY 1,2
ORDER BY 1,2;

SELECT
	empid,
	shipcountry,
	case when shipcountry = 'TR' then 1 else 0 end as TR_,
	case when shipcountry = 'UK' then 1 else 0 end as UK_
FROM Sales.Orders;

SELECT
	empid,
	sum(case when shipcountry = 'TR' then 1 else 0 end) as TR_,
	sum(case when shipcountry = 'UK' then 1 else 0 end) as UK_
FROM Sales.Orders
GROUP BY empid;

SELECT
	empid,
	sum(case when shipcountry = 'TR' then 1 else 0 end) as TR_,
	sum(case when shipcountry = 'UK' then 1 else 0 end) as UK_
FROM Sales.Orders
GROUP BY empid
HAVING sum(case when shipcountry = 'TR' then 1 else 0 end) > 10;

-- Yukarıdaki sorguyu CTEs ile inceleyelim
With
A as
(
	SELECT
		empid,
		sum(case when shipcountry = 'TR' then 1 else 0 end) as TR_,
		sum(case when shipcountry = 'UK' then 1 else 0 end) as UK_
	FROM Sales.Orders
	GROUP BY empid	
)
SELECT *
FROM A
WHERE TR_ > 10;


-- STRING_AGG Function
-- Syntax : STRING_AGG ( expression, separator )

-- HR.Employees tablosundan Erdinc.email2 tablosu icine mail olusturalım
Create Table Erdinc.email2 as
SELECT
		empid,
		lower(firstname || '.' || lastname || '@logo.com.tr') as email,
		country
FROM HR.Employees;

SELECT *
FROM Erdinc.email2;

SELECT STRING_AGG(email,';') as Sonuc
FROM Erdinc.email2;

SELECT
		country,
		STRING_AGG(email,';') as Sonuc
FROM Erdinc.email2
GROUP BY country;

--

Drop TABLE if Exists EmployeesOrnek;

CREATE TABLE EmployeesOrnek (
    Department TEXT,
    EmployeeName TEXT
);

INSERT INTO EmployeesOrnek(Department, EmployeeName) VALUES 
('HR', 'Erdinçce'),
('HR', 'Bob'),
('IT', 'Charlie'),
('IT', 'Dave'),
('Sales', 'Eve');

SELECT *
FROM EmployeesOrnek;

-- EmployeeName bilgilerini ; ayracıyla yanyana yazdıralım
SELECT String_Agg(EmployeeName,';') as Sonuc
FROM EmployeesOrnek;

-- Herbir Department icin
-- EmployeeName bilgilerini ; ayracıyla yanyana yazdıralım
SELECT
		Department,
		STRING_AGG(EmployeeName,';') as Sonuc
FROM
		EmployeesOrnek
GROUP BY Department;

--

SELECT STRING_AGG(firstname,', ') as Sonuc
FROM HR.Employees;

SELECT country, STRING_AGG(firstname,', ') as Sonuc
FROM HR.Employees
GROUP BY country;

SELECT country, STRING_AGG(firstname,'/') as Sonuc
FROM HR.Employees
GROUP BY country;

SELECT country, STRING_AGG(firstname,'#') as Sonuc
FROM HR.Employees
GROUP BY country;

With A AS
(
	SELECT 
			Lower(firstname || '.' || lastname || '@gmail.com') as EmailAddress,
			country
	FROM HR.Employees
)
SELECT
		Country,
		STRING_AGG(EmailAddress, ';') AS emails
FROM A
GROUP BY Country;

-- PostgreSQL
SELECT empid, lastname
FROM HR.Employees
WHERE lastname ~ '[ABC]';

-- Yukarıdaki ifade ile Buyuk harf ile ABC harflerinden herhangi birini iceren verileri arar
-- Asagidaki ifade ise buyuk kucuk harf ABC(abc) harflerinden herhangi birini iceren verileri arar
-- Buradaki * Buyuk Kucuk harf duyarlılıgı icindir(Yani Case insensitive)
-- Yani A = a ... gibi

SELECT empid, lastname
FROM HR.Employees
WHERE lastname ~* '[ABC]';

SELECT empid, lastname
FROM HR.Employees
WHERE lastname ~ '[USG]';

-- Yukarıdaki ifade ile Buyuk harf ile USG iceren verileri arar
-- Asagidaki ifade ise buyuk kucuk harf farketmeksizin USG(usg) iceren verileri arar

SELECT empid, lastname
FROM HR.Employees
WHERE lastname ~* '[USG]';

SELECT empid, lastname
FROM HR.Employees
WHERE lastname ~ '[ABC]';

SELECT empid, lastname
FROM HR.Employees
WHERE lastname ~ '^[ABC]';
-- Yukarıdaki ifade ile Buyuk harf ile ABC harflerinden herhangi biri ile baslayan verileri arar

SELECT empid, lastname
FROM HR.Employees
WHERE lastname ~ '^[abc]';
-- Yukarıdaki ifade ile kucuk harf ile abc harflerinden herhangi biri ile baslayan verileri arar

SELECT empid, lastname
FROM HR.Employees
WHERE lastname ~* '^[abc]';

SELECT empid, lastname
FROM HR.Employees
WHERE lastname !~* '^[abc]';

SELECT empid, lastname
FROM HR.Employees
WHERE lastname ~* '^[ABC]';

SELECT empid, lastname
FROM HR.Employees
WHERE lastname ~* '^[abc]';

-- <Character>-<Character> 

SELECT empid, lastname
FROM HR.Employees
WHERE lastname ~* '^[A-C]';

SELECT empid, lastname
FROM HR.Employees
WHERE lastname ~* '^[A-E]';


SELECT empid, lastname
FROM HR.Employees
WHERE lastname !~* '^[A-E]';

Drop TABLE if exists ProductsB;

CREATE TABLE ProductsB(
    product_id SERIAL PRIMARY KEY,
    product_name TEXT,
    rating TEXT
);

INSERT INTO ProductsB(product_name, rating)
	VALUES
		('Product A', '5'),
		('Product B', 'Excellent'),
		('Product C', '10'),
		('Product D', 'Good'),
		('Product E', '4.5'),
		('Product A1', '5'),
		('Product B1', '4.5'),
		('Product C1', '10'),
		('Product D1', '4.5'),
		('Product E1', 'Excellent'),
		('Product E2', '4.0');
-- Query to SELECT Rows WHERE rating Contains Only Digits

SELECT *
FROM ProductsB;


--
	
SELECT *
FROM ProductsB
WHERE rating ~ '^\d+$';
/*
Expected Output
product_id product_name rating
1 Product A 5
3 Product C 10
6 Product A1 5
8 Product C1 10
Query to SELECT Rows WHERE rating Does Not Contain Only Digits
*/

--

SELECT *
FROM ProductsB
WHERE rating ~ '^\d+(\.\d+)?$';

SELECT *
FROM ProductsB
WHERE rating ~ '\d+(\.\d+)?$';

SELECT *
FROM ProductsB
WHERE rating ~ '^\d+(\.\d+)$';

SELECT *
FROM ProductsB
WHERE rating ~ '\d+(\.\d+)$';

SELECT *
FROM ProductsB
WHERE rating ~ '^\d+$';

SELECT *
FROM ProductsB
WHERE rating !~ '^\d+$';

/*
Expected Output
product_id product_name rating
2 Product B Excellent
4 Product D Good
5 Product E 4.5

Summary
~: Used for matching a regular expression.
!~: Used for not matching a regular expression.
'^\d+$': Pattern to match strings containing only digits.
This approach allows you to filter rows based on whether the rating column contains only digits or not.
*/

-- ARRAY Data Type
Drop Table if exists table_array;

Create Table table_array
(
	id Serial Primary Key,
	firstname Varchar(30),
	phone text[]
);

INSERT into table_array(firstname,phone) 
VALUES
		('Erdinc',Array['05559988876','00905559988876']),
		('Radi',Array['05359988899','00905359988899']);

INSERT into table_array(firstname,phone) 
VALUES
		('Yaren',Array['05332244459','00905551234569']);

SELECT *
FROM table_array;

SELECT
		firstname,
		phone,
		phone[1] as Telno1,
		phone[2] as Telno2
FROM table_array;

SELECT
		firstname,
		phone,
		phone[1] as Telno1,
		phone[2] as Telno2
FROM table_array
WHERE phone[2] = '00905559988876';

-- Yukarıdaki sorguya unnest ile bakalım

SELECT
		id,
		firstname,
		unnest(phone) as PhoneB
FROM table_array;

SELECT
		id,
		firstname,
		unnest(phone) as PhoneB
FROM table_array
WHERE phone[2] = '00905559988876';

SELECT
		id,
		firstname,
		phone,
		unnest(phone) as PhoneB
FROM table_array
WHERE unnest(phone) = '00905559988876';

-- Yukarıdaki sorgu hata verecektir
-- Cozelim
With
A as
(
	SELECT
			id,
			firstname,
			phone,
			unnest(phone) as PhoneB
	FROM table_array
)
SELECT *
FROM A
WHERE PhoneB = '00905559988876';

-- hstore  Data Type

Create Extension if not Exists hstore;

Create Table Table_hstore
(
	id Serial Primary Key,
	title Varchar(50) Not Null,
	book_info hstore
);

INSERT into Table_hstore(title, book_info)
VALUES
(
	'Uzay Kesifi',
	'
	"publisher" => "ABC publisher",
	"Kagit_Baski_Fiyati" => "1000",
	"Digital_Baski_Fiyati" => "200"
	'
);

INSERT into Table_hstore(title, book_info)
VALUES
(
	'Universes',
	'
	"publisher" => "Erdinc publisher",
	"Kagit_Baski_Fiyati" => "2000",
	"Digital_Baski_Fiyati" => "1200"
	'
);

SELECT *
FROM Table_hstore;

SELECT
	title,
	book_info,
	book_info -> 'publisher' as "Yayimci",
	book_info -> 'Kagit_Baski_Fiyati' as "KagitBaski",
	book_info -> 'Digital_Baski_Fiyati' as "DigitalBaski"
FROM Table_hstore;

--

SELECT
	title,
	book_info -> 'publisher' as "publisher",
	book_info -> 'Kagit_Baski_Fiyati' as "KagitBaski",
	book_info -> 'Digital_Baski_Fiyati' as "DigitalBaski"
FROM Table_hstore;

-- JSON  Data Type
Drop Table if exists Table_json;

Create Table Table_json
(
	id Serial Primary Key,
	docs JSON
);

INSERT into Table_json(docs)
VALUES
		('[1,2,3,4,5,6]'),
		('[2,3,4,5,6,7]'),
		('{"key":"value"}');

SELECT *
FROM Table_json;

SELECT docs
FROM Table_json;

SELECT *
FROM Table_json
WHERE docs @> '2';
Alter Table table_json
Alter Column docs TYPE JSONB;

SELECT *
FROM Table_json
WHERE docs @> '2';


Drop index table_json_docs_idx;
-- Create index On table_json Using GIN(docs jsonb_path_ops);
Create index table_json_docs_idx On table_json Using GIN(docs jsonb_path_ops);

SELECT *
FROM Table_json
WHERE docs @> '2';


-- Assuming a table with a JSONB column
Drop TABLE if exists products;

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_data JSONB
);

-- INSERTing a sample JSON data
INSERT INTO products (product_data)
VALUES ('{"name": "Widget", "price": 25.00, "tags": ["sale", "popular"]}');

-- Extracting VALUES from JSON
SELECT *
FROM products;

SELECT
	product_id,
	product_data,
    product_data->>'name' AS product_name,
    (product_data->>'price')::NUMERIC AS product_price,
    product_data->'tags' AS product_tags
FROM products;

--

SELECT
    product_data->'name' AS product_name,
    (product_data->>'price')::NUMERIC AS product_price,
    product_data->'tags' AS product_tags
FROM products;

-- Yukarıdaki sorguda product_data->'name'  ifadesi ile gelen sonuc "Widget"
-- Asagidaki  sorguda product_data->>'name' ifadesi ile gelen sonuc  Widget

SELECT
    product_data->>'name' AS product_name,
    (product_data->>'price')::NUMERIC AS product_price,
    product_data->'tags' AS product_tags
FROM products;

-- Extracting array elements from JSON
SELECT
    jsonb_array_elements_text(product_data->'tags') AS tag
FROM products;
-- Parsing JSON Data: JSON functions like ->>, jsonb_array_elements_text

SELECT
    product_data->>'name' AS product_name,
    (product_data->>'price')::NUMERIC AS product_price,
    product_data->'tags' AS product_tags,
	jsonb_array_elements_text(product_data->'tags') AS tag
FROM products;


--
-- XML / XPATH 
-- PostgreSQL also supports XML parsing and extraction.
-- Assuming a table with an XML column
Drop Table if Exists orders;

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_data XML
);

-- INSERTing a sample XML data
INSERT INTO orders (order_data) VALUES ('<order><item>Widget</item><price>25.00</price></order>');

SELECT *
FROM Orders;

-- Extracting VALUES from XML
SELECT
    xpath('//item/text()', order_data) AS item_name,
    xpath('//price/text()', order_data) AS item_price
FROM orders;
-- Parsing XML Data: xpath

-- Tarih ve saat verileri
Drop Table if exists table_dates;

Create Table table_dates
(
	id serial Primary Key,
	firstname varchar(50) Not Null,
	hire_date Date Not Null,
	add_date Date Default Current_date
);

SELECT Current_date;

SELECT *
FROM table_dates;

INSERT INTO table_dates(firstname, hire_date)
   VALUES
		('Erdinc 1','2024-06-04'),
		('Erdinc 2','04-06-2024'),
		('Erdinc 3','20240604');

SELECT *
FROM table_dates;


SELECT
		Now(),
		Current_date,
		Current_time;

--

Drop Table if exists table_times;

Create Table table_times
(
	id serial Primary Key,
	class_name varchar(50) Not Null,
	start_time time Not Null,
	end_time time Not Null
);

SELECT *
FROM table_times;

INSERT INTO table_times(class_name, start_time,end_time)
   VALUES
		('Matematik','08:00:00','09:45:00'),
		('Fizik','10:00:00','12:00:00'),
		('SQL','13:00:00','16:30:00');

SELECT *
FROM table_times;

--

SELECT 
		Now(),
		Current_time,
		LocalTime;

SELECT 
		Current_time,
		Current_time(1),
		Current_time(2),
		Current_time(4),
		Current_time(0);
-- (1) yani virgulden sonra tek hane gelsin
-- (2) yani virgulden sonra 2 hane gelsin

SELECT LocalTime, LocalTime(1),LocalTime(2),LocalTime(4), LocalTime(0);

SELECT time '11:00' - time '08:00';

-- Using interval
interval 'n type'

n = number

type = second, minute, hours, day, month, year.....

SELECT
		Current_time,
		Current_time + interval '2 hours' as resultA,
		Current_time + interval '-2 hours' as resultB,
		Current_date + interval '99 year' as resultC;

--

SELECT *
FROM Sales.Orders
WHERE orderdate >= '20240731' and orderdate < '20240801';
-- 31-07-2024 00:00.... ile 31-07-2024 23:59... arasındaki tüm günün verilerini dönderir

-- TIMESTAMP VE TIMESTAMPTZ 
Drop Table if exists table_time_tz;

Create Table table_time_tz
(
	zaman1 Timestamp,
	zaman2 Timestamptz
);

SELECT *
FROM table_time_tz;

INSERT INTO table_time_tz(zaman1, zaman2)
   VALUES ('2024-04-06 00:00:00-07','2024-04-06 00:00:00-07');

SELECT *
FROM table_time_tz;

INSERT INTO table_time_tz(zaman1, zaman2)
   VALUES
		('2024-04-06 12:49:59-07','2024-04-06 12:49:59-07'), -- 7 saat eklenir +3 saat eklenir
		('2024-04-06 12:49:50-09','2024-04-06 12:49:50-09'), -- 9 saat eklenir +3 saat eklenir
		('2024-04-06 12:50:59-3','2024-04-06 12:50:59-3'),
		('2024-04-06 12:50:59+3','2024-04-06 12:50:59+3'),
		('2024-04-06 12:50:59+5','2024-04-06 12:50:59+5');

SELECT *
FROM table_time_tz;

Show Timezone;-- Result : Europe/Istanbul

Set Timezone = 'America/New_York';
Show Timezone;-- Result : America/New_York
SELECT Now();

Set Timezone = 'America/Los_Angeles';
Show Timezone;-- Result : America/Los_Angeles
SELECT Now();

Set Timezone = 'Europe/Istanbul';
Show Timezone;-- Result : Europe/Istanbul
SELECT Now();

SELECT Current_Timestamp;

SELECT Timeofday();

SELECT Timezone('Asia/Singapore','2020-01-01 00:00:00');
SELECT Timezone('Asia/Singapore','2024-04-06 00:00:00');
SELECT Timezone('Europe/Istanbul','2024-04-06 00:00:00');
SELECT Timezone('Europe/Istanbul','2024-04-06 13:01:00');




SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
WHERE orderdate = '20070212'; 


SELECT orderid, custid, empid, orderdate
FROM Sales.Orders
WHERE orderdate = CAST('20070212' AS DATE); 

SELECT CAST('20070212' AS DATE);


SELECT *
FROM Sales.Orders
WHERE orderdate >= '20070101' and orderdate < '20080101';

SELECT *
FROM Sales.Orders
WHERE orderid = 10807;

Update Sales.Orders
Set orderdate = '2007-12-31 00:05:00'	-- "2007-12-31 00:00:00"
WHERE orderid = 10807;

SELECT *
FROM Sales.Orders
WHERE orderid = 10807;

SELECT *
FROM Sales.Orders
WHERE orderdate >= '20070101' and orderdate < '20080101';

SELECT *
FROM Sales.Orders
WHERE orderdate >= '20070101' and orderdate <= '20071231';

SELECT *
FROM Sales.Orders
WHERE orderdate >= '20071231' and orderdate < '20080101';


Update Sales.Orders
Set orderdate = '2007-12-31 00:00:00'	-- "2007-12-31 00:00:00"
WHERE orderid = 10807;

SELECT Cast('18-06-2024' as Date);
SELECT Cast('2024-06-18' as Date);
SELECT Cast('2024-18-06' as Date);-- Bu error verecektir
SELECT Cast('18-MAY-2024' as Date);
SELECT Cast('18-JUN-2024' as Date);

SELECT Cast('18-NOV-2024' as Date);
SELECT Cast('18-NOVEMBER-2024' as Date);

SELECT Now();
SELECT Cast(Now() as Date);
SELECT Cast(Now() as Time);
SELECT Cast('20240618' as Date);

SELECT 
	Now(),
	Cast(Now() as Date),
	Cast(Now() as Time);

SELECT
		Cast('10' as integer),
		Cast('199.4569896' as Money),
		Cast('199.4569896' as Double Precision),
		Cast('199.4569896' as Numeric(6,2)),
		Cast(Now() as Date),
		Cast(Now() as Time),
		Cast(Now() as TimeStamp),
		Cast(Now() as TimeStamptz);

SELECT
		'10'::integer,
		'199.4569896'::Money,
		'199.4569896'::Double Precision,
		'199.4569896'::Numeric(6,2),
		Now():: Date,
		Now()::Time,
		Now()::TimeStamp,
		Now()::TimeStamptz;

--

SELECT
		Cast('10 minute' as interval),
		Cast('4 hour' as interval),
		Cast('10 day' as interval),
		Cast('3 week' as interval),
		Cast('3 month' as interval),
		Cast('3 year' as interval);

SELECT
		'10 minute'::interval,
		'4 hour'::interval,
		'10 day'::interval,
		'3 week'::interval,
		'3 month'::interval,
		'3 year'::interval;

--

Drop table if exists ratings;

Create table ratings
( 	rating_id Serial Primary Key,
	rating Varchar(1) Not Null
);

SELECT * FROM ratings;

INSERT into ratings(rating) VALUES ('A'),('B'),('C'),('D');
SELECT * FROM ratings;

INSERT into ratings(rating) VALUES (1),(2),(3),(4);
INSERT into ratings(rating) VALUES (6),(9),(9);

SELECT * FROM ratings;

SELECT
		rating_id, rating,
		Case 
			When rating ~E'^\\d+$' Then Cast(rating as integer)
			Else 0
		End as ratingResultA,
		Case 
			When rating ~'^\d+$' Then Cast(rating as integer)
			Else 0
		End as ratingResultB,
		rating!~E'^\\d+$' as SonucA,
		rating!~'^\d+$' as SonucB,
		Case 
			When rating !~E'^\\d+$' Then Cast(rating as VarChar)
			Else ''
		End as ratingResultC
FROM ratings;

-- To_Char
SELECT
	123456789.569459,
	to_char(123456789.569459,'999999999D999'),
	to_char(123456789.569459,'999,999,999D999'),
	to_char(123456789.569459,'$999,999,999D999'),
	to_char(123456789.569459,'999,999,999D999 $'),
	to_char(123456789.569459,'9,99999999D999 $'),
	to_char(123456789.569459,'9,999D999 $');	
SELECT
		orderid,
		custid,
		empid,
		orderdate,
		to_char(orderdate, 'DD-MM-YYYY'),
		to_char(orderdate, 'DD MM YYYY'),
		to_char(orderdate, 'Dy, MM, YYYY'),
		to_char(orderdate, 'DY-MM-YYYY'),
		to_char(orderdate, 'Day MM-YYYY'),
		to_char(orderdate, 'Day Month YYYY'),
		to_char(orderdate, 'YYYY-Month') as AyYil
FROM Sales.Orders;

SELECT To_Char(TimeStamp '2024-06-18 15:01:59', 'HH:MI:SS');
SELECT To_Char(TimeStamp '2024-06-18 15:01:59', 'HH12:MI:SS');
SELECT To_Char(TimeStamp '2024-06-18 15:01:59', 'HH24:MI:SS');

-- To_Number
SELECT
	To_Number('1459.89', '9999.99'),
	To_Number('1459.89', '9999D99'), -- Yukarıdaki ile aynı sonucu verir
	To_Number('1459.89', '9999.9'),
	To_Number('1459.89', '9999.'),
	To_Number('1459.89', '9999');

SELECT To_Number('14,596.89-', '99G999D99');
-- Result : 14596.89
SELECT To_Number('14,596.89-', '99G999D99S');
-- Result : -14596.89


SELECT To_Number('$14,596.89', 'L99G999');
-- Result : 14596

SELECT To_Number('$1,596.89', 'L9G999');
-- Result : 1596
SELECT To_Number('$1,596.89', '9G999');		-- Result : 15

SELECT 
		To_Number('$1,596.89', 'L9G999'),	-- Result : 1596
		To_Number('$1,596.89', '9G999');	-- Result : 15

SELECT 
		To_Number('1,596.89$', 'L9G999'),	-- Result : 1596
		To_Number('1,596.89$', '9G999');	-- Result : 1596

SELECT To_Number('1,596.89$', 'L9G999');		-- Result : 1596
SELECT To_Number('$1,596.89', 'L9G999');		-- Result : 1596

SELECT To_Number('1,596.89$', '9G999');		-- Result : 1596
SELECT To_Number('$1,596.89', '9G999');		-- Result : 15


SELECT To_Number('1,234,567.89', '9G999g999');	-- Result : 1234567
SELECT To_Number('1,234,567.89', '9G999G999');	-- Result : 1234567

SELECT To_Number('1,234,567.89', '9g999g999');
-- Result : 1234567

SELECT To_Number('1,234,567.89', '9G999');
-- Result : 1234

SELECT To_Number('1,234,567.89', '9g999');
-- Result : 1234

SELECT To_Number('1,234,567.89', '9G999g9999D99');
-- Result : 1234567.89

SELECT To_Number('$1,234,567.89', 'L9G999g9999D99');
-- Result : 1234567.89

-- To_Date
SELECT
	To_Date('2024-06-18','YYYY-MM-DD'),
	To_Date('20240618','YYYYMMDD'),
	To_Date('20241806','YYYYDDMM');

SELECT To_Date('061899','MMDDYY');

SELECT To_Date('June 18, 2024','Month DD, YYYY');

--

SELECT To_TimeStamp('2024-06-18 16:40:59','YYYY-MM-DD HH24:MI:SS');
-- Result : "2024-06-18 16:40:59+03"

SELECT
	Now(),
	Cast(Now() as TimeStamp),
	To_TimeStamp('2024-06-18 16:46:47.681992','YYYY-MM-DD HH24:MI:SS'),
	To_TimeStamp('2024-06-18 16:46:47.681992','YYYY-MM-DD HH24:MI:SS.US');
-- Result : "2024-06-18 16:40:59+03"

SELECT To_TimeStamp('2024 Nov','YYYY Mon');
-- Result : "2024-11-01 00:00:00+03"


SELECT To_TimeStamp('2024           Nov','YYYY Mon');
-- Result : "2024-11-01 00:00:00+03"


SHOW datestyle;

-- Set the date style us_English
SET datestyle TO 'ISO, MDY';
SHOW datestyle;
SELECT CAST('02/12/2007' AS DATE);
-- Result: "2007-02-12"

-- Set the date style British
SET datestyle TO 'ISO, DMY';
SHOW datestyle;
SELECT CAST('02/12/2007' AS DATE);
-- Result: "2007-12-02"


-- Set the date style us_English
SET datestyle TO 'ISO, MDY';
SHOW datestyle;
SELECT CAST('20070212' AS DATE);
-- Result: "2007-02-12"

-- Set the date style British
SET datestyle TO 'ISO, DMY';
SHOW datestyle;
SELECT CAST('20070212' AS DATE);
-- Result: "2007-02-12"

-- Set the date style us_English
SET datestyle TO 'ISO, MDY';
SHOW datestyle;

SELECT *
FROM Sales.Orders
WHERE orderdate >= '20070101' and orderdate < '20080101';

-- Converting Text to Timestamp

SELECT '2023-06-27 15:30:00'::TIMESTAMP;
SELECT CAST('2023-06-27 15:30:00' AS TIMESTAMP);

-- Extracting Parts of a Timestamp

SELECT EXTRACT(YEAR FROM TIMESTAMP '2023-06-27 15:30:00');
SELECT EXTRACT(MONTH FROM TIMESTAMP '2023-06-27 15:30:00');
SELECT EXTRACT(DAY FROM TIMESTAMP '2023-06-27 15:30:00');
SELECT EXTRACT(QUARTER FROM TIMESTAMP '2023-06-27 15:30:00');
SELECT EXTRACT(WEEK FROM TIMESTAMP '2023-06-27 15:30:00');


SELECT
		orderid,
		orderdate,
		EXTRACT(YEAR FROM orderdate) as Yillar,
		EXTRACT(MONTH FROM orderdate) as Aylar,
		EXTRACT(DAY FROM orderdate) as Gunler,
		EXTRACT(QUARTER FROM orderdate) as Ceyrekler,
		EXTRACT(WEEK FROM orderdate) as Haftalar
FROM Sales.Orders;
	
SELECT *
FROM Sales.Orders
WHERE  EXTRACT(YEAR FROM orderdate)= 2007;

SELECT *
FROM Sales.Orders
WHERE  EXTRACT(YEAR FROM orderdate)= '2007';

-- Converting Numeric Types

-- Converting Integer to Float
SELECT 123::FLOAT;
SELECT CAST(123 AS FLOAT);

-- Converting Float to Integer
SELECT 123.45::INTEGER;
SELECT CAST(123.45 AS INTEGER);

--

SELECT
 	 Now() as Now_
	,CURRENT_DATE as GETDATE_
	,CURRENT_TIMESTAMP as A_CURRENT_TIMESTAMP
	,clock_timestamp();

-- GETUTCDATE
-- Using now() with AT TIME ZONE
SELECT
	now(),
	now() AT TIME ZONE 'UTC' AS current_utc_datetime;

-- Using current_timestamp with AT TIME ZONE
SELECT
		current_timestamp,
		current_timestamp AT TIME ZONE 'UTC' AS current_utc_timestamp;

-- Using clock_timestamp() with AT TIME ZONE
SELECT clock_timestamp() AT TIME ZONE 'UTC' AS current_utc_clock_timestamp;

-- Retrieving the Current UTC Date Only
-- If you want just the UTC date without the time, you can cast the timestamp to a date:
SELECT 
		now(),
		now() AT TIME ZONE 'UTC' as Sonuc,
		(now() AT TIME ZONE 'UTC')::date AS current_utc_date;

SELECT
		now(),
		now() AT TIME ZONE 'UTC' as Sonuc,
		(now() AT TIME ZONE 'UTC')::time AS current_utc_time;

SELECT 
		Now(),
		(now() AT TIME ZONE 'UTC')::date AS current_utc_date,
		(now() AT TIME ZONE 'UTC')::time AS current_utc_time;

/*
Examples
Example 1: Retrieving Current UTC Date and Time
*/
SELECT now() AT TIME ZONE 'UTC' AS current_utc_datetime;
-- This will return the current date and time in UTC.

/*
Example 2: Retrieving Current UTC Date
SELECT (now() AT TIME ZONE 'UTC')::date AS current_utc_date;
*/
-- This will return the current date in UTC.

/*
	DATEADD Fonksiyonu / MSSQL


Adding Days to a Date
SQL Server DATEADD
SELECT DATEADD(day, 10, '2024-07-06') AS NewDate;
*/

PostgreSQL Equivalent
SELECT '2024-07-06'::date + INTERVAL '10 days' AS NewDate;

Adding Months to a Date
SQL Server DATEADD
SELECT DATEADD(month, 2, '2024-07-06') AS NewDate;

PostgreSQL Equivalent
SELECT '2024-07-06'::date + INTERVAL '2 months' AS NewDate;

Adding Years to a Date
SQL Server DATEADD
SELECT DATEADD(year, 1, '2024-07-06') AS NewDate;

PostgreSQL Equivalent
SELECT '2024-07-06'::date + INTERVAL '1 year' AS NewDate;
	
Adding Hours to a Timestamp
SQL Server DATEADD
SELECT DATEADD(hour, 5, '2024-07-06 12:00:00') AS NewDateTime;

PostgreSQL Equivalent
SELECT '2024-07-06 12:00:00'::timestamp + INTERVAL '5 hours' AS NewDateTime;

Adding Minutes to a Timestamp
SQL Server DATEADD
SELECT DATEADD(minute, 30, '2024-07-06 12:00:00') AS NewDateTime;

PostgreSQL Equivalent
SELECT '2024-07-06 12:00:00'::timestamp + INTERVAL '30 minutes' AS NewDateTime;

Adding Seconds to a Timestamp
SQL Server DATEADD
SELECT DATEADD(second, 45, '2024-07-06 12:00:00') AS NewDateTime;

PostgreSQL Equivalent
SELECT '2024-07-06 12:00:00'::timestamp + INTERVAL '45 seconds' AS NewDateTime;


-- DATEDIFF / AGE
PostgreSQL Equivalent Using Arithmetic
SELECT ('2024-07-06'::date - '2024-07-01'::date) AS DateDifference;
SELECT ('2024-07-06'::date - '2024-01-01'::date) AS DateDifference;
SELECT Age('2024-07-06'::date, '2024-01-01'::date) AS DateDifference;

SELECT 
			('2024-07-06'::date - '2024-01-01'::date) AS DateDifferenceA,
			Age('2024-07-06'::date, '2024-01-01'::date) AS DateDifferenceB;

SELECT 
			('2024-07-06'::date - '2020-01-01'::date) AS DateDifferenceA,
			Age('2024-07-06'::date, '2020-01-01'::date) AS DateDifferenceB;


Difference in Months
SQL Server DATEDIFF
SELECT DATEDIFF(month, '2024-01-01', '2024-07-01') AS DateDifference;

PostgreSQL Equivalent Using AGE
SELECT
		AGE('2024-07-01'::date, '2024-01-01'::date) AS Sonuc,
		EXTRACT(MONTH FROM AGE('2024-07-01'::date, '2024-01-01'::date)) AS DateDifference;

--

SELECT
		AGE('2024-07-01'::date, '2022-01-12'::date) AS Sonuc,
		EXTRACT(YEAR FROM AGE('2024-07-01'::date, '2022-01-12'::date)) AS DateDifference_Year,
		EXTRACT(MONTH FROM AGE('2024-07-01'::date, '2022-01-12'::date)) AS DateDifference_Month,
		EXTRACT(DAY FROM AGE('2024-07-01'::date, '2022-01-12'::date)) AS DateDifference_Day;

SELECT
		empid, firstname, lastname,
		now()::date as SimdikiZaman,
		birthdate,
		AGE(now()::date, birthdate::date) AS Sonuc,
		EXTRACT(YEAR FROM AGE(now()::date, birthdate::date)) AS DateDifference_Year,
		EXTRACT(MONTH FROM AGE(now()::date, birthdate::date)) AS DateDifference_Month,
		EXTRACT(DAY FROM AGE(now()::date, birthdate::date)) AS DateDifference_Day
FROM HR.Employees;	

--

Difference in Years
SQL Server DATEDIFF
SELECT DATEDIFF(year, '2020-07-01', '2024-07-01') AS DateDifference;

PostgreSQL Equivalent Using AGE
SELECT EXTRACT(YEAR FROM AGE('2024-07-01'::date, '2020-07-01'::date)) AS DateDifference;

Difference in Hours
SQL Server DATEDIFF
SELECT DATEDIFF(hour, '2024-07-01 08:00:00', '2024-07-01 18:00:00') AS DateDifference;

PostgreSQL Equivalent Using Arithmetic
SELECT EXTRACT(EPOCH FROM ('2024-07-01 18:00:00'::timestamp - '2024-07-01 08:00:00'::timestamp)) / 3600 AS DateDifference;

SELECT
	EXTRACT(EPOCH FROM Now()) AS EPOCH_A,
	EXTRACT(EPOCH FROM '2024-06-18'::date) AS EPOCH_B,
	EXTRACT(EPOCH FROM '2024-06-18 18:00:00'::date) AS EPOCH_C,
	EXTRACT(EPOCH FROM '2024-06-18 18:00:00'::timestamp) AS EPOCH_D;

--DATE_PART
SELECT
	DATE_PART('year',Now()) as Yillar,
	DATE_PART('MONTH',Now()) as Aylar,
	DATE_PART('DAY',Now()) as Gunler,
	DATE_PART('WEEK',Now()) as Haftalar,
	DATE_PART('HOUR',Now()) as HOUR_,
	DATE_PART('MINUTE',Now()) as MINUTE_,
	DATE_PART('SECOND',Now()) as SECOND_,
	DATE_PART('MILLISECOND',Now()) as MILLISECOND_,
	DATE_PART('MICROSECOND',Now()) as MICROSECOND_;

-- Using DATE_TRUNC to Truncate Dates and Timestamps
The DATE_TRUNC function can be used to truncate dates and timestamps to the specified precision.

Truncate to Year
SELECT DATE_TRUNC('year', '2024-07-06'::timestamp) AS TruncatedToYear;
-- Result: "2024-01-01 00:00:00"

Truncate to Month
SELECT DATE_TRUNC('month', '2024-07-06'::timestamp) AS TruncatedToMonth;
-- Result: "2024-07-01 00:00:00"

Truncate to Day
SELECT
	DATE_TRUNC('day', '2024-07-06'::timestamp) AS TruncatedToDay,
	now(),
	DATE_TRUNC('day', Now()::timestamp) AS TruncatedToDay;


Truncate to Hour
SELECT DATE_TRUNC('hour', '2024-07-06 12:34:56'::timestamp) AS TruncatedToHour;

Truncate to Minute
SELECT DATE_TRUNC('minute', '2024-07-06 12:34:56'::timestamp) AS TruncatedToMinute;

Truncate to Second
SELECT DATE_TRUNC('second', '2024-07-06 12:34:56.123459'::timestamp) AS TruncatedToSecond;

SELECT ('1 ' || 'Day')::interval;
SELECT (1 || 'Day')::interval;


SELECT Cast ('1' as interval) || ' second';


DO $$
DECLARE
    Ulke VARCHAR(30) := 'TR';
BEGIN
    
    RAISE NOTICE 'Employee records selected for country: %', Ulke;
END $$;

-- veya

DO
$$
DECLARE
    Ulke VARCHAR(30) := 'TR';
BEGIN
    
    RAISE NOTICE 'Employee records selected for country: %', Ulke;
END
$$;

DO $Ornek$
DECLARE
    Ulke VARCHAR(30) := 'TR';
BEGIN
    
    RAISE NOTICE 'Employee records selected for country: %', Ulke;
END $Ornek$;


DO $Ornek$
DECLARE
	Sehir VARCHAR(30) := 'Newyork';
    Ulke VARCHAR(30) := 'TR';
BEGIN
    
    RAISE NOTICE 'Employee records selected for City: % / country: %', Sehir,Ulke;
END $Ornek$;


SELECT empid, firstname, lastname, country
FROM HR.Employees
WHERE country = 'TR';

Drop Function EmployeeRapor;

Create Function EmployeeRapor(inparam_country VARCHAR)
Returns Table(r_empid int, r_firstname VARCHAR, r_lastname VARCHAR, r_country VARCHAR)
AS $$
Begin
	Return Query
	SELECT empid, firstname, lastname, country
	FROM HR.Employees
	WHERE country = inparam_country;
End $$ Language plpgsql;


SELECT *
FROM EmployeeRapor('TR');

SELECT *
FROM EmployeeRapor('UK');

Drop FUNCTION get_fn_employees_by_country;

CREATE OR REPLACE FUNCTION get_fn_employees_by_country(inparam_country VARCHAR)
RETURNS TABLE(employee_id INT,employee_firstname VARCHAR, employee_lastname VARCHAR, countryA VARCHAR)
AS $$
BEGIN
    RETURN QUERY
    SELECT empid, firstname, lastname, country
    FROM HR.Employees
    WHERE country = inparam_country;
END $$ LANGUAGE plpgsql;

SELECT * FROM get_fn_employees_by_country('TR');

SELECT * FROM get_fn_employees_by_country('UK');

-- Bir function yazalım ve parametre ile tablo donsun
Drop FUNCTION get_orders_by_country;

CREATE OR REPLACE FUNCTION get_orders_by_country(country VARCHAR)
RETURNS TABLE(order_id INT, order_date DATE, customer_id INT, ulke VARCHAR)
AS $$
DECLARE
    rec RECORD;
BEGIN
    RETURN QUERY
    SELECT orderid, orderdate, custid, shipcountry
    FROM sales.orders
    WHERE shipcountry = country;
END $$ LANGUAGE plpgsql;

-- Call the function
SELECT * FROM get_orders_by_country('TR');

SELECT * FROM get_orders_by_country('UK');


DO $$
DECLARE
    interval_value INTEGER := 5;
    dynamic_interval INTERVAL;
BEGIN
    dynamic_interval := (interval_value || ' day')::interval;
    RAISE NOTICE 'The interval is: % ', dynamic_interval;
	RAISE NOTICE 'The interval is: Yes Of Course Sonuc: % Budur', dynamic_interval;
	RAISE NOTICE 'The interval is: % Yes Of Course', dynamic_interval;
END $$;

--
DO $$
DECLARE
    interval_value INTEGER := 5;
    dynamic_interval INTERVAL;
BEGIN
    dynamic_interval := (interval_value || ' day')::interval;
    RAISE NOTICE 'The interval is: % ', dynamic_interval;
END $$;

Drop FUNCTION create_dynamic_interval;


CREATE OR REPLACE FUNCTION create_dynamic_interval(days INTEGER)
RETURNS INTERVAL
AS $$
DECLARE
    dynamic_interval INTERVAL;
BEGIN
    dynamic_interval := (days || ' day')::interval;
    RETURN dynamic_interval;
END $$ LANGUAGE plpgsql;

-- SELECT ile cekelim
SELECT create_dynamic_interval(1);
SELECT create_dynamic_interval(10);


-- Using MAKE_DATE Function
The MAKE_DATE function in PostgreSQL is specifically designed for this purpose:

SELECT MAKE_DATE(2024, 7, 6) AS ConstructedDate;

SELECT ('2024' || '-' || '07' || '-' || '06') AS SonucDate_Text;

SELECT ('2024' || '-' || '07' || '-' || '06')::date AS ConstructedDate;

SELECT ('2024' || '-' || '7' || '-' || '6')::date AS ConstructedDate;

SELECT ('2024' || '-' || '12' || '-' || '30')::date AS ConstructedDate;


SELECT  LPAD(9::text,2,'0');
SELECT  LPAD(12::text,2,'0');

SELECT  (2024||'-'||LPAD(9::text,2,'0')||'-'||LPAD(9::text,2,'0'))::date AS ConstructedDate;
SELECT  (2024||'-'||LPAD(12::text,2,'0')||'-'||LPAD(30::text,2,'0'))::date AS ConstructedDate;


Day name: 			TO_CHAR(date_column, 'Day')
Month name: 		TO_CHAR(date_column, 'Month')
Day of the week: 	TO_CHAR(date_column, 'D')
Full date format: 	TO_CHAR(date_column, 'FMDay, DD FMMonth YYYY')

Here are some examples:
Extracting the day name from a date:

/*
	SELECT TO_CHAR(your_date_column, 'Day') AS day_name 
	FROM your_table;
*/

SELECT
	orderid, 
	orderdate,
	TO_CHAR(orderdate, 'Day') AS day_name,
	TO_CHAR(orderdate, 'FMDay') AS day_name,
	TO_CHAR(orderdate, 'Month') AS Month_name,
	TO_CHAR(orderdate, 'FMMonth') AS Month_name,
	TO_CHAR(orderdate, 'D') As Day_of_the_week,
	TO_CHAR(orderdate, 'Day, DD Month YYYY') as TarihA,
	TO_CHAR(orderdate, 'FMDay, DD FMMonth YYYY') as TarihB
FROM Sales.Orders;

--

SELECT
	orderid,
	orderdate,
	TO_CHAR(orderdate, 'Month') as Ay,
	TO_CHAR(orderdate, 'Day') as Gun,
	TO_CHAR(orderdate, 'D') as HaftaninGunu_D1,
	TO_CHAR(orderdate, 'd') as HaftaninGunu_D2,
	TO_CHAR(orderdate, 'FMDay') as HaftaninGunu_FMDay,
	TO_CHAR(orderdate, 'FMDay, DD FMMonth YYYY') as Tarih
FROM Sales.Orders;


SELECT 
 DATE_TRUNC('month', Now()) as Tarih,
(DATE_TRUNC('month', Now()) + INTERVAL '1 month')::date AS TarihB,
(DATE_TRUNC('month', Now()) + INTERVAL '1 month - 1 day')::date AS end_of_month;

SELECT (DATE_TRUNC('month', your_date_column) + INTERVAL '1 month - 1 day')::date AS end_of_month
FROM your_table;

SELECT
	 	orderid,
		orderdate,
		(DATE_TRUNC('month', orderdate) + INTERVAL '1 month - 1 day')::date AS end_of_month
FROM Sales.Orders;


SELECT
	orderid,
	orderdate,
	(DATE_TRUNC('month', orderdate) + INTERVAL '1 month - 1 day')::date AS end_of_month
FROM Sales.Orders
WHERE orderdate = (DATE_TRUNC('month', orderdate) + INTERVAL '1 month - 1 day')::date
ORDER BY orderid;


SELECT *	
FROM Sales.Orders
WHERE orderdate = (DATE_TRUNC('month', orderdate) + INTERVAL '1 month - 1 day')::date
ORDER BY orderid;


SELECT
		orderid,
		custid,
		empid,
		orderdate,
		(DATE_TRUNC('month', orderdate) + INTERVAL '1 month - 1 day')::date
FROM Sales.Orders
WHERE orderdate = (DATE_TRUNC('month', orderdate) + INTERVAL '1 month - 1 day')::date
ORDER BY orderid;

SELECT
		 orderid
		,custid
		,empid
		,orderdate
		,(DATE_TRUNC('month', orderdate) + INTERVAL '1 month - 1 day')::date
FROM Sales.Orders
WHERE orderdate = (DATE_TRUNC('month', orderdate) + INTERVAL '1 month - 1 day')::date
ORDER BY orderid;


SELECT 
  date_column,
  (EXTRACT(DOW FROM date_column) + 6) % 7 AS adjusted_dow
FROM your_table;

SELECT 
    Now(),
  	(EXTRACT(DOW FROM Now())) AS adjusted_dow1,
	(EXTRACT(DOW FROM Now()) + 6) AS adjusted_dow2,
	(EXTRACT(DOW FROM Now()) + 6) % 7 AS adjusted_dow3;

SELECT 
    Now(),
  	(EXTRACT(DOW FROM Now())) AS adjusted_dow1,
	(EXTRACT(DOW FROM Now()) + 7) AS adjusted_dow2,
	(EXTRACT(DOW FROM Now()) + 1) % 7 AS adjusted_dow3; -- 1 Sunday olarak ayarladık
-- This query will return 1 for Sunday, 2 for Monday, ..., 7 yani (0) for Saturday.

SELECT 
  date_column,
  CASE 
    	WHEN EXTRACT(DOW FROM date_column) = 0 THEN 7 
    	ELSE EXTRACT(DOW FROM date_column) 
  END AS day_of_week_monday_first
FROM your_table;
This query will return 1 for Monday, 2 for Tuesday, ..., 7 for Sunday.



SELECT 
  orderdate,
  To_Char(orderdate, 'D') as Gun,
  To_Char(orderdate, 'Day') as GunAdi,
  EXTRACT(DOW FROM orderdate) as Gun2,
  CASE 
    WHEN EXTRACT(DOW FROM orderdate) = 0 THEN 7 
    ELSE EXTRACT(DOW FROM orderdate) 
  END AS day_of_week_monday_first
FROM Sales.Orders;

Finding the First Day of the Current Week (Monday):

SELECT 
  date_column,
  date_column - INTERVAL '1 day' * ((EXTRACT(DOW FROM date_column) + 6) % 7) AS start_of_week
FROM your_table;

SELECT 
  orderdate,
  (EXTRACT(DOW FROM orderdate) + 6) % 7,
  orderdate - INTERVAL '1 day' * ((EXTRACT(DOW FROM orderdate) + 6) % 7) AS start_of_week
FROM Sales.Orders;


SELECT 
  Now(),
  Now() - INTERVAL '1 day' * ((EXTRACT(DOW FROM Now()) + 6) % 7) AS start_of_week;

SELECT 
  Current_Date,
  Current_Date - INTERVAL '1 day' * ((EXTRACT(DOW FROM Current_Date) + 6) % 7) AS start_of_week,
  (Current_Date - INTERVAL '1 day' * ((EXTRACT(DOW FROM Current_Date) + 6) % 7))::date AS start_of_week;


SELECT 
  date_column,
  date_column + INTERVAL '1 day' * (6 - ((EXTRACT(DOW FROM date_column) + 6) % 7)) AS end_of_week
FROM your_table;


SELECT 
  orderdate,
        (EXTRACT(DOW FROM orderdate) + 6) % 7,
  (6 - ((EXTRACT(DOW FROM orderdate) + 6) % 7)),
  orderdate + INTERVAL '1 day' * (6 - ((EXTRACT(DOW FROM orderdate) + 6) % 7)) AS end_of_week
FROM Sales.Orders;

--

SELECT 
	  	orderid,
		orderdate,
	  	orderdate - INTERVAL '1 day' * ((EXTRACT(DOW FROM orderdate) + 6) % 7) AS start_of_week,
	  	orderdate + INTERVAL '1 day' * (6 - ((EXTRACT(DOW FROM orderdate) + 6) % 7)) AS end_of_week
FROM Sales.Orders;


-- Function
Drop FUNCTION adjusted_dow;

CREATE or Replace FUNCTION adjusted_dow(date_column DATE, first_day INTEGER)
RETURNS INTEGER 
AS $$
BEGIN
  RETURN (EXTRACT(DOW FROM date_column) + (7 - first_day)) % 7;
END;
$$ LANGUAGE plpgsql;

--

SELECT 
  date_column,
  adjusted_dow(date_column, 1) AS adjusted_dow -- 1 means Monday
FROM your_table;

SELECT 
  Now()::date,
  EXTRACT(DOW FROM Now()),
  (7 - 0) % 7,
  (7 - 1) % 7,
  (7 - 2) % 7,
  EXTRACT(DOW FROM Now()) + (7 - 1) % 7,
  adjusted_dow(Now()::date, 1) AS adjusted_dow, -- 1 means Tuesday
  adjusted_dow(Now()::date, 0) AS adjusted_dow; -- 1 means Monday

SELECT 
   date_column
  ,adjusted_dow(date_column, 0) AS adjusted_dow -- 1 means Monday
  ,adjusted_dow(date_column, 1) AS adjusted_dow -- 1 means Tuesday	
FROM your_table;
This approach allows you to define any day as the first day of the week by passing the appropriate integer (0 for Sunday, 1 for Monday, etc.).

Feel free to provide more details if you need a specific implementation or have a different context!


SELECT EXTRACT(DOW FROM CURRENT_DATE);
SELECT EXTRACT(ISODOW FROM CURRENT_DATE);
SELECT EXTRACT(ISODOW FROM CURRENT_DATE + INTERVAL '1 day');
SELECT to_char(CURRENT_DATE, 'ID');  -- 'ID' returns the ISO day of the week (1-7, where 1 is Monday)

SELECT
	CURRENT_DATE,
	CURRENT_DATE + INTERVAL '1 day',
	date_trunc('week', CURRENT_DATE + INTERVAL '1 day'),
	date_trunc('week', CURRENT_DATE + INTERVAL '1 day') - INTERVAL '1 day' AS start_of_week;

SELECT EXTRACT(DOW FROM CURRENT_DATE);

Custom Function: 
	The start_of_iso_week function adjusts the start of the week to Monday.

-- Create a function to set the first day of the week to Monday
Drop FUNCTION set_datefirst_monday;

CREATE OR REPLACE FUNCTION set_datefirst_monday(date)
RETURNS date 
AS $$
BEGIN
    RETURN date_trunc('week', $1 + INTERVAL '1 day') - INTERVAL '1 day';
END;
$$ LANGUAGE plpgsql;

--

SELECT set_datefirst_monday(CURRENT_DATE);

--

Drop FUNCTION set_datefirst_mondayB;

CREATE OR REPLACE FUNCTION set_datefirst_mondayB(date)
RETURNS date 
AS $$
BEGIN
    RETURN date_trunc('week', $1) - INTERVAL '1 day';
END;
$$ LANGUAGE plpgsql;

--

SELECT 	set_datefirst_monday(CURRENT_DATE);
SELECT	set_datefirst_mondayB(CURRENT_DATE);

SELECT
	set_datefirst_monday(CURRENT_DATE),
	set_datefirst_mondayB(CURRENT_DATE);


SELECT
		orderid,
		orderdate,
		set_datefirst_monday(orderdate) as HaftaninBaslangicTarihi	
FROM Sales.Orders;


Creating a Custom ISDATE Function

Drop FUNCTION isdate;

CREATE OR REPLACE FUNCTION isdate(date_text TEXT)
RETURNS BOOLEAN
AS $$
BEGIN
  PERFORM date_text::DATE;
  RETURN TRUE;
EXCEPTION WHEN OTHERS THEN
  RETURN FALSE;
END;
$$ LANGUAGE plpgsql;



SELECT 
  	isdate('20240229') AS is_vErdinçd_date,
	isdate('20250229') AS is_not_vErdinçd_date;

SELECT
		ISDATE('20090212') as Tarih1,
		ISDATE('20090230') as Tarih2;

--
Drop TABLE if exists example_dates;

CREATE TABLE example_dates (
  id SERIAL PRIMARY KEY,
  date_str TEXT
);

INSERT INTO example_dates (date_str) VALUES 
('2024-07-06'),
('not_a_date'),
('2024-02-30'), -- InvErdinçd date
('2023-12-31');

-- Using the isdate function to check these strings:
SELECT 
  id,
  date_str,
  isdate(date_str) AS is_vErdinçd_date
FROM example_dates;


Drop FUNCTION try_cast;

CREATE OR REPLACE FUNCTION try_cast(_in text, INOUT _out ANYELEMENT)
LANGUAGE plpgsql AS
$func$
BEGIN
   EXECUTE format('SELECT %L::%s', $1, pg_typeof(_out))
   INTO _out;
EXCEPTION WHEN others THEN
   -- do nothing: _out already carries default
END
$func$;

SELECT try_cast('2024-02-29', Null::date) AS Tarih;
SELECT try_cast('2025-02-29', Null::date) AS Tarih;

SELECT try_cast('foo', NULL::varchar);
SELECT try_cast('2024-01-41', NULL::date);   -- returns NULL
SELECT try_cast('2024-01-41', CURRENT_DATE); -- returns current date


PostgreSQL Transaction İsolation Level Öğrenme

SHOW TRANSACTION ISOLATION LEVEL;

SELECT *
FROM pg_settings
WHERE name = 'transaction_isolation';

SELECT name, setting
FROM pg_settings
WHERE name = 'transaction_isolation';


-- PostgreSQL / Selecting without Locking the table
/*
In PostgreSQL, there is no direct equivalent to SQL Server's WITH (NOLOCK) hint. 
The WITH (NOLOCK) hint in SQL Server allows you to read data without acquiring shared locks, 
which can result in reading uncommitted data (also known as "dirty reads"). 
This is not directly supported in PostgreSQL because PostgreSQL emphasizes data integrity and consistency.

However, you can achieve similar behavior by using different transaction isolation levels or using advisory locks if you are trying to control locking behavior. Below are some approaches to achieve similar outcomes:

Read Uncommitted Equivalent in PostgreSQL
PostgreSQL does not support the READ UNCOMMITTED isolation level, as it is equivalent to READ COMMITTED in PostgreSQL. 
This means that in PostgreSQL, you cannot directly read uncommitted data.

Using Lower Isolation Levels
The default isolation level in PostgreSQL is READ COMMITTED, 
which allows a transaction to read only committed data but does not guarantee repeatable reads.
*/

Example of READ COMMITTED
-- Start a transaction with READ COMMITTED isolation level
BEGIN;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Your SELECT statement
SELECT * FROM your_table;

COMMIT;

/*
Using NOWAIT and SKIP LOCKED for Locking Control
If your goal is to avoid blocking on locked rows, you can use the FOR UPDATE NOWAIT or FOR UPDATE SKIP LOCKED clauses.

Using NOWAIT
SELECT * FROM your_table
FOR UPDATE NOWAIT;
This will cause the query to fail immediately if it encounters a locked row.

Using SKIP LOCKED
SELECT * FROM your_table
FOR UPDATE SKIP LOCKED;
This will skip rows that are currently locked by other transactions.
*/

-- PostgreSQL / Selecting without Locking the table
SELECT orderid, orderdate, custid
FROM Sales.Orders
FOR UPDATE NOWAIT;

SELECT orderid, orderdate, custid
FROM Sales.Orders
FOR UPDATE SKIP LOCKED;

--

-- Catalog Views
Catalog views veri tabanındaki objeler hakkında çok detaylı bilgi sağlar.
Örneğin, veritabanındaki  tabloları şema isimleriyle beraber listelemek istediğinizde
pg_tables sorgulamanız yeterli olur. Aşağıdaki örneğe bakınız:

SELECT *
FROM pg_tables
ORDER BY schemaname;


SELECT current_schema();

Using the System Catalog (pg_namespace)
If you need more detailed information, you can query the pg_namespace table, which contains information about all schemas:

SELECT *
FROM pg_namespace;

SELECT pg_my_temp_schema();


SELECT schemaname,*
FROM pg_tables
WHERE tablename = 'employees';

SELECT *
FROM HR.Employees;

SELECT *
FROM Employees;

SELECT *
FROM public.Employees;

SELECT *
FROM INFORMATION_SCHEMA.TABLES;


SELECT Distinct TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;

SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = N'BASE TABLE';

SELECT TABLE_SCHEMA, TABLE_NAME,*
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = N'BASE TABLE';


SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY TABLE_NAME;

SELECT
	COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH,
	COLLATION_NAME, IS_NULLABLE,*
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = N'sales'
	  AND TABLE_NAME = N'orders'
ORDER BY TABLE_NAME;

--

SELECT 
    table_schema,
    table_name,
    column_name,
    data_type,
    character_maximum_length,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE 
    table_schema = 'public' AND
    table_name = 'ornek';
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = N'BASE TABLE';

SELECT TABLE_SCHEMA, TABLE_NAME,*
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = N'BASE TABLE';

SELECT
	COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH,
	COLLATION_NAME, IS_NULLABLE,*
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = N'sales'
	  AND TABLE_NAME = N'orders'
ORDER BY TABLE_NAME;

--

SELECT 
    table_schema,
    table_name,
    column_name,
    data_type,
    character_maximum_length,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE 
    table_schema = 'public' AND
    table_name = 'ornek';


-- Using pg_catalog Tables
-- For more detailed information, you can query the PostgreSQL system catalog tables directly.

SELECT 
    n.nspname AS schema_name,
    c.relname AS table_name,
	c.relkind as relkind_,
    CASE c.relkind
        WHEN 'r' THEN 'table'
        WHEN 'v' THEN 'view'
        WHEN 'm' THEN 'materiErdinçzed view'
        WHEN 'i' THEN 'index'
        WHEN 'S' THEN 'sequence'
        WHEN 's' THEN 'special'
        WHEN 'f' THEN 'foreign table'
        ELSE 'other'
    END AS table_type
FROM 
    	 pg_catalog.pg_class c
	JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
WHERE 
    c.relkind IN ('r', 'f') -- 'r' for regular table, 'f' for foreign table
    AND n.nspname NOT IN ('pg_catalog', 'information_schema')
ORDER BY 
    schema_name, table_name;


SELECT 
		orderid,
		orderdate,
		custid,
		empid,
		-- DATE_TRUNC('month', orderdate),
		(DATE_TRUNC('month', orderdate) + INTERVAL '1 month - 1 day')::date AS end_of_month
FROM sales.orders
WHERE orderdate =  (DATE_TRUNC('month', orderdate) + INTERVAL '1 month - 1 day')::date;


SELECT *
FROM Sales.OrderDetails;

--

SELECT
		orderid,
		sum(unitprice * qty) as totalvalue 
FROM sales.OrderDetails
GROUP BY orderid
HAVING sum(unitprice * qty) > 10000
ORDER BY totalvalue desc;


SELECT
		shipcountry,		
		To_Char(AVG(freight::Numeric(6,2)), '9,999.9999') as AVGFreight2
FROM Sales.Orders
WHERE orderdate >= '20070101' and orderdate < '20080101'
GROUP BY shipcountry
ORDER BY 2 desc
Limit 3;

SELECT
		shipcountry,
		AVG(freight::Numeric(6,2)) as AVGFreight1,
		To_Char(AVG(freight::Numeric(6,2)), '9,999.9999') as AVGFreight2
FROM Sales.Orders
WHERE orderdate >= '20070101' and orderdate < '20080101'
GROUP BY shipcountry
ORDER BY 2 desc
Limit 3;


SELECT
	o.shipcountry,
	To_Char(AVG(freight::Numeric(6,2)),'9,999.9999') as avgfreight
FROM sales.Orders as o
WHERE o.orderdate >= '20070101' and o.orderdate < '20080101'
GROUP BY o.shipcountry
ORDER BY avgfreight desc
Limit 3;


SELECT custid, region
FROM Sales.Customers as c
ORDER BY c.region Nulls Last, custid;

SELECT custid, region
FROM Sales.Customers as c
ORDER BY c.region Nulls First;

SELECT
		custid,
		orderdate,
		orderid,
		empid,
		shipcountry,
 		ROW_NUMBER() over(order by orderid) as RowNum
FROM Sales.Orders;

SELECT
		custid,
		orderdate,
		orderid,
		empid,
		shipcountry,
 		ROW_NUMBER() over(Partition By custid order by orderid) as RowNum
FROM Sales.Orders;

SELECT
		custid,
		orderdate,
		orderid,
		empid,
		shipcountry,
 		ROW_NUMBER() over(order by shipcountry,orderid) as RowNum
FROM Sales.Orders;

-- Ornek ShipcountryB Sorgusu
SELECT
		custid,
		orderdate,
		orderid,
		empid,
		shipcountry,
 		ROW_NUMBER() over(Partition By shipcountry order by orderid) as RowNum
FROM Sales.Orders;


SELECT
		custid,
		orderdate,
		orderid,
		empid,
		shipcountry,
 		ROW_NUMBER() over(Partition By shipcountry order by orderid desc) as RowNum
FROM Sales.Orders;


SELECT *
FROM 
		(
			SELECT
					custid,
					orderdate,
					orderid,
					empid,
					shipcountry,
			 		ROW_NUMBER() over(Partition By shipcountry order by orderid desc) as RowNum
			FROM Sales.Orders	
		) as UlkeSonSiparisRaporlari
WHERE RowNum <= 3;


With
UlkeSonSiparisRaporlari as
(
	SELECT
			custid,
			orderdate,
			orderid,
			empid,
			shipcountry,
	 		ROW_NUMBER() over(Partition By shipcountry order by orderid desc) as RowNum
	FROM Sales.Orders	
)
SELECT *
FROM UlkeSonSiparisRaporlari
WHERE RowNum <= 3;


With
UlkeilkSiparisRaporlari as
(
	SELECT
			custid,
			orderdate,
			orderid,
			empid,
			shipcountry,
	 		ROW_NUMBER() over(Partition By shipcountry order by orderid) as RowNum
	FROM Sales.Orders	
)
SELECT *
FROM UlkeilkSiparisRaporlari
WHERE RowNum <= 3;


With
HerUlkeninilkSiparisListesi_n as
(
	SELECT
			custid,
			orderdate,
			orderid,
			empid,
			shipcountry,
	 		ROW_NUMBER() over(Partition By shipcountry order by orderid) as RowNum,
			'ilkSiparis' as TabloBilgisi
	FROM Sales.Orders
),
HerUlkeninSonSiparisListesi_n as
(
	SELECT
			custid,
			orderdate,
			orderid,
			empid,
			shipcountry,
	 		ROW_NUMBER() over(Partition By shipcountry order by orderid desc) as RowNum,
			'sonSiparis' as TabloBilgisi
	FROM Sales.Orders	
)	
SELECT custid,orderdate,orderid,empid,shipcountry,RowNum,TabloBilgisi
FROM HerUlkeninilkSiparisListesi_n 
WHERE Rownum <= 3
Union
SELECT custid,orderdate,orderid,empid,shipcountry,RowNum,TabloBilgisi
FROM HerUlkeninSonSiparisListesi_n
WHERE Rownum <= 3	
ORDER BY shipcountry,TabloBilgisi, RowNum;


SELECT string_to_array('TR,Canada', ',') AS Ulkeler;

SELECT Unnest(string_to_array('TR,Canada', ',')) AS Ulkeler;
/*
Result : 
"street"
"TR"
"Canada"
*/

SELECT regexp_split_to_table('TR,Canada', ',') AS Ulkeler;

SELECT shipcountry, SUM(freight) as TotalFreight
FROM Sales.Orders
WHERE shipcountry in(SELECT * FROM regexp_split_to_table('TR,Canada,Norway,Switzerland',','))
GROUP BY shipcountry;

SELECT shipcountry, SUM(freight) as TotalFreight
FROM Sales.Orders
WHERE shipcountry in(SELECT * FROM Unnest(string_to_array('TR,Canada,Norway,Switzerland', ',')))
GROUP BY shipcountry;

-- Joins
SELECT *
FROM Erdinc.CityJoin as ci;

SELECT *
FROM Erdinc.CustomersJoin as cu;


SELECT *
FROM Erdinc.CityJoin as ci
JOIN Erdinc.CustomersJoin as cu on cu.cityid = ci.cityid;

SELECT ci.*, cu.*
FROM Erdinc.CityJoin as ci
JOIN Erdinc.CustomersJoin as cu on cu.cityid = ci.cityid;

SELECT *
FROM Erdinc.CityJoin as ci
inner JOIN Erdinc.CustomersJoin as cu on cu.cityid = ci.cityid;


SELECT *
FROM Erdinc.CityJoin as ci, Erdinc.CustomersJoin as cu
WHERE cu.cityid = ci.cityid;

-- natural JOIN

SELECT *
FROM Erdinc.CityJoin as ci
natural JOIN Erdinc.CustomersJoin as cu;


SELECT *
FROM Erdinc.CityJoin
natural JOIN Erdinc.CustomersJoin;


SELECT *
FROM Erdinc.CityJoin as ci
LEFT JOIN Erdinc.CustomersJoin as cu on cu.cityid = ci.cityid;

SELECT *
FROM Erdinc.CityJoin as ci
LEFT Outer JOIN Erdinc.CustomersJoin as cu on cu.cityid = ci.cityid;


SELECT *
FROM Erdinc.CityJoin as ci
Right JOIN Erdinc.CustomersJoin as cu on cu.cityid = ci.cityid;

SELECT *
FROM Erdinc.CityJoin as ci
Right Outer JOIN Erdinc.CustomersJoin as cu on cu.cityid = ci.cityid;


SELECT *
FROM Erdinc.CityJoin as ci
Full JOIN Erdinc.CustomersJoin as cu on cu.cityid = ci.cityid;

SELECT *
FROM Erdinc.CityJoin as ci
Full Outer JOIN Erdinc.CustomersJoin as cu on cu.cityid = ci.cityid;

SELECT *
FROM Musteriler JOIN hareketler .. JOIN urunler ...

SELECT *
FROM Erdinc.CityJoin as ci
CROSS JOIN Erdinc.CustomersJoin as cu;

SELECT *
FROM Erdinc.CityJoin
CROSS JOIN Erdinc.CustomersJoin;

-- Self Joins

SELECT empid, firstname, lastname, mgrid
FROM HR.Employees;

SELECT
        emp.empid,
        emp.firstname || ' ' || emp.lastname as EmployeeName,
        emp.mgrid,
        mng.firstname || ' ' || mng.lastname as ManagerName
FROM HR.Employees as emp
LEFT JOIN HR.Employees as mng on emp.mgrid = mng.empid;


SELECT
		c.custid, c.companyname,
		o.*
FROM Sales.Customers as c
JOIN Sales.Orders as o on o.custid = c.custid
ORDER BY c.custid;

SELECT
		c.custid, c.companyname,
		o.*	
FROM Sales.Customers as c
LEFT JOIN Sales.Orders as o on o.custid = c.custid
ORDER BY c.custid;


SELECT
		c.custid, c.companyname,
		o.*	
FROM Sales.Orders as o
Right JOIN Sales.Customers as c on o.custid = c.custid
ORDER BY c.custid;


SELECT
		c.custid, c.companyname,
		o.orderid, o.orderdate, o.freight,
		od.*
FROM Sales.Customers as c
LEFT JOIN Sales.Orders as o on o.custid = c.custid
LEFT JOIN Sales.OrderDetails as od on od.orderid = o.orderid
LEFT JOIN production.Products as p on p.productid = od.productid	
ORDER BY c.custid;


INSERT into production.products(productid, productname, supplierid, categoryid, unitprice, discontinued)
VALUES(99,'Karpuz', 12,2,30.0000,0);

INSERT into production.products(productid, productname, supplierid, categoryid, unitprice, discontinued)
VALUES(100,'Çilek', 12,2,30.0000,0);	


SELECT
		c.custid, c.companyname,
		o.orderid, o.orderdate, o.freight,
		od.*
FROM Sales.Customers as c
LEFT JOIN Sales.Orders as o on o.custid = c.custid
LEFT JOIN Sales.OrderDetails as od on od.orderid = o.orderid
LEFT JOIN production.Products as p on p.productid = od.productid	
ORDER BY c.custid;

-- 	

SELECT
		c.custid, c.companyname,
		o.orderid, o.orderdate, o.freight,
		od.*,
		p.*
FROM Sales.Customers as c
Full JOIN Sales.Orders as o on o.custid = c.custid
Full JOIN Sales.OrderDetails as od on od.orderid = o.orderid
Full JOIN production.Products as p on p.productid = od.productid	
ORDER BY c.custid;


SELECT
		c.custid, c.companyname,
		o.orderid, o.orderdate, o.freight,
		od.qty,
		p.productid, p.productname
FROM Sales.Customers as c
Full JOIN Sales.Orders as o on o.custid = c.custid
Full JOIN Sales.OrderDetails as od on od.orderid = o.orderid
Full JOIN production.Products as p on p.productid = od.productid	
ORDER BY c.custid;

SELECT
		c.custid, c.companyname,
		o.orderid, o.orderdate, o.freight,
		od.qty,
		p.productid, p.productname
FROM Sales.Customers as c
Full JOIN Sales.Orders as o on o.custid = c.custid
Full JOIN Sales.OrderDetails as od on od.orderid = o.orderid
Full JOIN production.Products as p on p.productid = od.productid	
WHERE o.orderid is null
ORDER BY c.custid;


SELECT
		c.custid, c.companyname,
		o.orderid, o.orderdate, o.freight	
FROM Sales.Customers 	as c
JOIN Sales.Orders 		as o on o.custid = c.custid
ORDER BY c.custid;

SELECT
		c.custid, c.companyname,
		o.orderid, o.orderdate, o.freight		
FROM 	  Sales.Customers 	as c
LEFT JOIN Sales.Orders 		as o on o.custid = c.custid
ORDER BY c.custid;


SELECT
		c.custid, c.companyname,
		o.orderid, o.orderdate, o.freight		
FROM 	  Sales.Customers 	as c
LEFT JOIN Sales.Orders 		as o on o.custid = c.custid
WHERE o.orderid is null	
ORDER BY c.custid;


SELECT
		c.custid, c.companyname,
		o.orderid, o.orderdate, o.freight		
FROM 	  Sales.Customers 	as c
LEFT JOIN Sales.Orders 		as o 	on o.custid = c.custid
LEFT JOIN Sales.Orderdetails 	as od	on od.orderid = o.orderid
-- WHERE o.orderid is null	
ORDER BY c.custid;

SELECT
		c.custid, c.companyname,
		o.orderid, o.orderdate, o.freight		
FROM 	  Sales.Customers 	as c
LEFT JOIN Sales.Orders 		as o 	on o.custid = c.custid
LEFT JOIN Sales.Orderdetails 	as od	on od.orderid = o.orderid
WHERE o.orderid is null	
ORDER BY c.custid;

SELECT
		c.custid, c.companyname,
		o.orderid, o.orderdate, o.freight		
FROM 	  Sales.Customers 	as c
LEFT JOIN Sales.Orders 		as o on o.custid = c.custid
ORDER BY c.custid;


SELECT
		c.custid, 
		Count(*) as SiparisSayisi		
FROM 	  
			  Sales.Customers 	as c
	LEFT JOIN Sales.Orders 		as o on o.custid = c.custid
GROUP BY c.custid	
ORDER BY c.custid;

SELECT
		c.custid, 
		Count(o.orderid) as SiparisSayisi		
FROM 	  
			  Sales.Customers 	as c
	LEFT JOIN Sales.Orders 		as o on o.custid = c.custid
GROUP BY c.custid	
ORDER BY c.custid;


SELECT *
FROM Sales.Orders
WHERE custid = 32;


SELECT sum(qty)
FROM Sales.Orderdetails
WHERE orderid IN(
					SELECT orderid
					FROM Sales.Orders
					WHERE custid = 32
				);
SELECT *
FROM Sales.Orderdetails
WHERE orderid IN(
					SELECT orderid
					FROM Sales.Orders
					WHERE custid = 32
				);	


SELECT
		c.custid,
		count(Distinct o.orderid) as SiparisSayisi,
		sum(od.qty)
FROM
			 Sales.Customers 	as c
		JOIN Sales.Orders 		as o 	on o.custid = c.custid
		JOIN Sales.Orderdetails 	as od	on od.orderid = o.orderid
WHERE shipcountry = 'TR'	
GROUP BY c.custid	
ORDER BY c.custid;

--

SELECT
		c.custid,
		count(Distinct o.orderid) as SiparisSayisi,
		sum(od.qty)
FROM
	 	  Sales.Customers 	as c
LEFT JOIN Sales.Orders 		as o 	on o.custid = c.custid
LEFT JOIN Sales.Orderdetails 	as od	on od.orderid = o.orderid
GROUP BY c.custid	
ORDER BY c.custid;

SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM sales.Customers as c
left outer JOIN sales.orders as o on c.custid = o.custid
WHERE o.orderdate = '20070212';


SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM sales.Customers as c
left outer JOIN sales.orders as o on c.custid = o.custid and o.orderdate = '20070212';


With
Musteriler as
(
	SELECT custid,companyname
	FROM sales.Customers
)
,Siparisler as
(
	SELECT custid, orderid, orderdate
	FROM sales.orders	
	WHERE orderdate = '20070212'
)
SELECT *
FROM Musteriler as m
LEFT JOIN Siparisler as s on s.custid = m.custid;

-- SubQuery


SELECT MAX(orderid)
FROM Sales.Orders;

SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE orderid = 11077;

SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE orderid = (
				 SELECT MAX(orderid)
		   		 FROM Sales.Orders
	  			);

SELECT MAX(orderdate)
FROM Sales.Orders;

SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE orderdate = '20080506';

SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE orderdate = (
				 	SELECT MAX(orderdate)
		   		 	FROM Sales.Orders
	  				);

SELECT custid, orderid, orderdate, empid
FROM Sales.Orders as o1
WHERE orderdate = (
				 	SELECT MAX(o2.orderdate)
		   		 	FROM Sales.Orders as o2
					WHERE o2.custid = o1.custid
	  				)
ORDER BY o1.custid	;

SELECT 
	orderid
FROM Sales.Orders
WHERE empid =
			(SELECT E.empid
			 FROM HR.Employees AS E
			 WHERE E.lastname LIKE N'D%');

SELECT 
	orderid
FROM Sales.Orders
WHERE empid IN
				(SELECT E.empid
				 FROM HR.Employees AS E
				 WHERE E.lastname LIKE N'D%');

--TR müşterilerini listeleyen script aşağıdaki gibidir.

SELECT
	custid
	,orderid
	,orderdate
	,empid

FROM
	Sales.Orders
WHERE
		custid IN
					(SELECT C.custid
					 FROM Sales.Customers AS C
					 WHERE C.country = 'TR');
SELECT 
	custid, 
	companyname
FROM Sales.Customers
WHERE custid NOT IN
					(
					 SELECT custid
					 FROM Sales.Orders
					);

-- 

SELECT 
	custid, 
	companyname
FROM Sales.Customers
WHERE custid NOT IN
					(
					 SELECT custid
					 FROM Sales.Orders
					 WHERE custid is not null
					);

SELECT 
	custid, 
	companyname
FROM Sales.Customers as c
WHERE Not Exists (
					 SELECT custid
					 FROM Sales.Orders as o
					 WHERE o.custid = c.custid
				 );

--

SELECT 
	custid, 
	companyname
FROM Sales.Customers as c
WHERE Not Exists (
					 SELECT *
					 FROM Sales.Orders as o
					 WHERE o.custid = c.custid
				 );


--

SELECT 
	custid, 
	companyname
FROM Sales.Customers AS C
WHERE 	country = N'Spain'
		AND EXISTS
					(SELECT * FROM Sales.Orders AS O
					 WHERE O.custid = C.custid);

SELECT 
	custid, 
	companyname
FROM Sales.Customers AS C
WHERE 	country = N'Spain'
		AND Not EXISTS
					(SELECT * FROM Sales.Orders AS O
					 WHERE O.custid = C.custid);

-- Views

Create View vw_raporB
as
SELECT 
	custid, 
	companyname
FROM Sales.Customers AS C
WHERE 	country = N'Spain'
		AND EXISTS
					(SELECT * FROM Sales.Orders AS O
					 WHERE O.custid = C.custid);

--

SELECT *
FROM vw_raporA;


SELECT *
FROM vw_raporA as v
JOIN Sales.orders as o on o.custid = v.custid;


/*

PostgreSQL 3 tane set operatör içerir:
 
	* UNION, 
	* INTERSECT, 
	* EXCEPT

query1 UNION [ALL] query2
query1 INTERSECT [ALL] query2
query1 EXCEPT [ALL] query2

Tek tek operatörleri inceleyeceğiz.

 Input Query1
<set_operator>
Input Query2
ORDER BY ... 
*/

/*
A : 1,3,5
B : 2,5,9,10,12

	A
	UNION
	B
	Sonuc : 1,3,5,2,9,10,12

	A
	UNION ALL
	B
	Sonuc : 1,3,5,2,5,9,10,12

	A
	INTERSECT
	B
	Sonuc : 5

A : 1,3,5
B : 2,5,9,10,12

	A
	EXCEPT
	B
	Sonuc : 1,3

	B
	EXCEPT
	A
	Sonuc : 2,9,10,12


*/

SELECT country, region, city FROM HR.Employees
UNION ALL
SELECT country, region, city FROM Sales.Customers;


SELECT country FROM Sales.Customers
UNION ALL
SELECT country FROM HR.Employees;


SELECT country FROM Sales.Customers
UNION
SELECT country FROM HR.Employees;

SELECT Distinct country FROM Sales.Customers
UNION
SELECT Distinct country FROM HR.Employees


SELECT Distinct country FROM Sales.Customers
INTERSECT
SELECT Distinct country FROM HR.Employees


SELECT Distinct country FROM Sales.Customers
EXCEPT
SELECT Distinct country FROM HR.Employees


SELECT country, region, city FROM Production.Suppliers
EXCEPT
SELECT country, region, city FROM HR.Employees
INTERSECT
SELECT country, region, city FROM Sales.Customers;


(SELECT country, region, city FROM Production.Suppliers
EXCEPT
SELECT country, region, city FROM HR.Employees)
INTERSECT
SELECT country, region, city FROM Sales.Customers;

-- System Stored procedures and Functions
/*
	create [or replace] procedure procedure_name(parameter_list)
	language plpgsql
	as $$
	declare

		-- variable declaration

	begin

		-- stored procedure body

	end; $$
*/

-- Parameters in stored procedures can have the
-- in and inout modes but cannot have the out mode

-- PostgreSQL CREATE PROCEDURE statement examples
-- We will use the following accounts table for the demonstration:

Drop Table if exists accounts;

create table accounts (
    id int generated by default as identity,
    name varchar(100) not null,
    balance dec(15,2) not null,
    primary key(id)
);

INSERT into accounts(name,balance)
VALUES('Bob',10000);

INSERT into accounts(name,balance)
VALUES('Erdinçce',10000);

SELECT *
from accounts;

-- Stored Procedure yazalım
Drop procedure transfer;

create or replace procedure transfer
(
   sender int,
   receiver int, 
   amount dec
)
language plpgsql    
as $$
begin
    -- subtracting the amount from the sender's account 
    update accounts 
    set balance = balance - amount 
    where id = sender;

    -- adding the amount to the receiver's account
    update accounts 
    set balance = balance + amount 
    where id = receiver;

    commit;
end;$$;

-- CALLING A STORED PROCEDURE
Call Transfer(1,2,1000);

SELECT *
FROM accounts;

--

DO $$
BEGIN

	RAISE NOTICE 'Order IDOrder Date Customer ID';
	RAISE NOTICE '==========================================================';

END $$;

DO $$
DECLARE
	maxid INTEGER = (SELECT MAX(orderid) FROM Sales.Orders);
	rec RECORD;
BEGIN
	RAISE NOTICE 'Order_ID Order_Date Empid  Customer_ID';
	RAISE NOTICE '==========================================================';
	
	FOR rec IN
				SELECT orderid, orderdate, empid, custid
				FROM Sales.Orders
				WHERE orderid = maxid
	LOOP        
		RAISE NOTICE '%,  %,  %, %', rec.orderid, rec.orderdate, rec.empid, rec.custid;
	END LOOP;
END $$;

--

DO $$
DECLARE
	minid INTEGER = (SELECT Min(orderid) FROM Sales.Orders);
	rec RECORD;
BEGIN
	RAISE NOTICE 'Order_ID Order_Date Empid  Customer_ID';
	RAISE NOTICE '==========================================================';
	
	FOR rec IN
				SELECT orderid, orderdate, empid, custid
				FROM Sales.Orders
				WHERE orderid >= minid
	LOOP        
		RAISE NOTICE '%,  %,  %, %', rec.orderid, rec.orderdate, rec.empid, rec.custid;
	END LOOP;
END $$;
--

SELECT *
FROM sales.orders
WHERE 	shipcountry = 'TR' and 
 		empid = 1 and 
 		Extract(year from orderdate) = '2008'

-- Yukarıdaki islemi Declare ile yapalım


	
DO $$
DECLARE
    ulke VARCHAR(30) := 'TR';
    personel INTEGER := 1;
    rec RECORD;
BEGIN
    FOR rec IN
	        	SELECT *
	        	FROM sales.orders
				WHERE shipcountry = ulke and 
		 			  empid = personel and 
		 		 	  Extract(year from orderdate) = '2008'
    LOOP
        RAISE NOTICE 'Order: %', rec;
    END LOOP;
END $$;


--Stored Procedure

create [or replace] procedure procedure_name(parameter_list)
language 'plpgsql'
as $$
declare
-- variable declaration
begin
-- stored procedure body
end; $$

--


SELECT *
FROM HR.Employees
WHERE country = 'TR';

Drop PROCEDURE Erdinc.Proc_Get_Employees;

Create or Replace PROCEDURE Erdinc.Proc_Get_Employees
(
	IN Param_Country  Varchar(50),
	INOUT get_result refcursor
)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	OPEN get_result FOR
						SELECT *
						FROM HR.Employees e
						WHERE e.country = Param_Country;
END;
$BODY$;

Call Erdinc.Proc_Get_Employees('TR','Sonuc');
FETCH ALL IN "Sonuc";


Call Erdinc.Proc_Get_Employees('UK','Sonuc');
FETCH ALL IN "Sonuc";

--

Drop Table employeesP;

Create Table employeesP
(
empid Serial,
name Varchar(50),
age int,
department Varchar(50)
);

Drop PROCEDURE INSERT_employeesP;

CREATE PROCEDURE INSERT_employeesP(
    IN emp_name VARCHAR,
    IN emp_age INT,
    IN emp_department VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO employeesP(name, age, department)
    VALUES (emp_name, emp_age, emp_department);
END;
$$;

--
CALL INSERT_employeesP('John Doe', 30, 'Engineering');

SELECT *
FROM employeesP;

-- VALUES degerinin icerisinde $1,$2,$3 v.s. kullanalım

Drop PROCEDURE INSERT_employeesPB;

CREATE Or REPLACE PROCEDURE INSERT_employeesPB(
    IN emp_name VARCHAR,
    IN emp_age INT,
    IN emp_department VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO employeesP(name, age, department)
    VALUES ($1, $2, $3);
END;
$$;

CALL INSERT_employeesPB('Erdinc DEĞİRMENCİ', 34, 'Engineering');

SELECT *
FROM employeesP;

--

Drop PROCEDURE update_employee_age;

CREATE PROCEDURE update_employee_age(
    IN emp_id INT,
    IN new_age INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF new_age <= 0 THEN
        RAISE EXCEPTION 'Age must be greater than 0';
    ELSE
        UPDATE employeesP
        SET age = new_age
        WHERE empid = emp_id;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'An error occurred: %', SQLERRM;
END;
$$;

--

CALL update_employee_age(1, 20);

SELECT *
FROM employeesP;

CALL update_employee_age(1, 0);

SELECT *
FROM employeesP;

CALL update_employee_age(1, 34);

SELECT *
FROM employeesP;
-- This example demonstrates a stored procedure that updates an employee's age with basic error handling.

-- Using Cursors in Stored Procedures
-- Cursors allow you to iterate through query results within a stored procedure.

-- Example: Procedure with a Cursor
DROP PROCEDURE list_employees;

CREATE OR REPLACE PROCEDURE list_employees()
LANGUAGE plpgsql
AS $$
DECLARE
    emp_record RECORD;
    emp_cursor CURSOR FOR SELECT empid, name, age, department FROM employeesP;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'ID: %, Name: %, Age: %, Department: %',
            emp_record.empid, emp_record.name, emp_record.age, emp_record.department;
    END LOOP;
    CLOSE emp_cursor;
END;
$$;

-- Executing the Procedure
CALL list_employees();
-- This procedure will raise a notice for each employee record in the employees table


SELECT *
FROM employeesP;

DROP PROCEDURE if EXISTS list_employeesB;

CREATE OR REPLACE PROCEDURE list_employeesB(INOUT get_result refcursor)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN get_result For 
						SELECT *
						FROM employeesP;
END;
$$;

-- Executing the Procedure
CALL list_employeesB('Rapor_Employees');
FETCH ALL IN "Rapor_Employees";

-- This procedure will SELECT for each employee record in the employees table

-- Trigger
Drop Table if exists employees_trg;

CREATE TABLE employees_trg (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    salary NUMERIC
);

Drop Table if exists employees_log;

CREATE TABLE employees_trg_log (
    log_id SERIAL PRIMARY KEY,
    employee_id INT,
    old_salary NUMERIC,
    new_salary NUMERIC,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


SELECT *
FROM employees_trg;

SELECT *
FROM employees_trg_log;


-- Create the Trigger Function
Drop FUNCTION if exists log_salary_changes;

CREATE OR REPLACE FUNCTION log_salary_changes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO employees_trg_log (employee_id, old_salary, new_salary)
    VALUES (OLD.id, OLD.salary, NEW.salary);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create the Trigger
CREATE TRIGGER salary_update_trigger
AFTER UPDATE OF salary ON employees_trg
FOR EACH ROW
EXECUTE FUNCTION log_salary_changes();

INSERT into employees_trg(name,position,salary) VALUES('Erdinc', 'IT',99999);

SELECT *
FROM employees_trg;

SELECT *
FROM employees_trg_log;

Update employees_trg
Set salary = 100000
WHERE id = 1;

SELECT *
FROM employees_trg;

SELECT *
FROM employees_trg_log;

-- Backup
/*
	Custom
	Tar
	Plain(Text metin olarak yedekler)
	Directory
*/

Create Database TestBB;