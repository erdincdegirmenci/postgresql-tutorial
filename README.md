# PostgreSQL Kapsamlı Kılavuzu

PostgreSQL, açık kaynak kodlu, güçlü ve esnek bir ilişkisel veritabanı yönetim sistemidir. SQL standardını destekleyen ve geniş bir fonksiyon yelpazesine sahip olan PostgreSQL, veri yönetimi, sorgulama ve analiz konularında sağlam bir temel sağlar. Bu kılavuz, PostgreSQL'in temel ve ileri düzey özelliklerini kapsamlı bir şekilde ele alarak, veritabanı yönetimi konusunda derinlemesine bilgi edinmenize yardımcı olmayı amaçlamaktadır. Veritabanı işlemleri, veri manipülasyonu ve performans iyileştirme gibi konulara dair kapsamlı bilgilerle, PostgreSQL'in sunduğu imkanları en iyi şekilde kullanabilmeniz için gereken tüm detayları sunacaktır.

Bu kılavuz, PostgreSQL Egzersizleri üzerindeki tüm soruları ve cevapları derlemektedir. Bu problemlerin gerçekten çözülmesi, sadece bu kılavuzu gözden geçirmekten daha ileriye gitmenizi sağlayacaktır, bu yüzden [PostgreSQL Exercises](https://pgexercises.com) ziyaret etmenizi öneririm.

## İçindekiler

[BASLANGIC](#baslangic)
1. [Temel SQL İşlemleri](#1-temel-sql-işlemleri)
   - [SELECT](#select)
   - [UPDATE](#update)
   - [DELETE](#delete)
   - [JOIN](#join)
2. [Filtreleme ve Sıralama](#2-filtreleme-ve-sıralama)
   - [WHERE](#where)
   - [GROUP BY](#group-by)
   - [ORDER BY](#order-by)
   - [HAVING](#having)
   - [BETWEEN](#between)
   - [LIMIT](#limit)
   - [OFFSET-FETCH](#offset-fetch)
3. [Veri Manipülasyonu ve Fonksiyonlar](#3-veri-manipülasyonu-ve-fonksiyonlar)
   - [Aritmetik Fonksiyonlar](#aritmetik-fonksiyonlar)
   - [String Fonksiyonları](#string-fonksiyonları)
   - [Dizi Fonksiyonları](#dizi-fonksiyonları)
4. [Veri Türleri ve Yapılar](#4-veri-türleri-ve-yapılar)
   - [Temel Veri Türleri](#temel-veri-türleri)
   - [İleri Düzey Veri Türleri](#ileri-düzey-veri-türleri)
   - [Veri Yapıları ve İndeksler](#veri-yapıları-ve-indeksler)
   - [Diğer Yapılar](#diğer-yapılar)
5. [İleri Düzey Fonksiyonlar ve İşlemler](#5-ileri-düzey-fonksiyonlar-ve-i̇şlemler)
   - [CTES (Common Table Expressions)](#ctes-common-table-expressions)
   - [ROW_NUMBER](#row_number)
   - [PARTITION](#partition)
   - [CASE](#case)
   - [COALESCE](#coalesce)
   - [STRING_AGG](#string_agg)
6. [Tarih ve Zaman Fonksiyonları](#7-tarih-ve-zaman-fonksiyonları)
   - [DATE Fonksiyonları](#date-fonksiyonları)
7. [Dizi ve Matris İşlemleri](#8-dizi-ve-matris-i̇şlemleri)
8. [Performans ve Kilitleme](#9-performans-ve-kilitleme)
   - [Kilitleme Seçenekleri](#kilitleme-seçenekleri)
   - [Transaction Isolation Level](#transaction-isolation-level)
9. [Veritabanı Yönetimi ve Bilgi](#10-veritabanı-yönetimi-ve-bilgi)
    - [Veri Görüntüleme](#veri-görüntüleme)
    - [Veritabanı Bilgisi](#veritabanı-bilgisi)
    - [Kümeleme ve Birleştirme](#kümeleme-ve-birleştirme)
    - [Diğer İşlemler](#diğer-i̇şlemler)
10. [Ek Konular](#11-ek-konular)
    - [NULLS FIRST, NULLS LAST](#nulls-first-null-s-last)
    - [OPERATORLER](#operatorler)
    - [COLLATE](#collate)
    - [TABLESAMPLE](#tablesample)
    - [ROW LEVEL SECURITY](#row-level-security)
    - [TEMPORARY TABLES](#temporary-tables)
    - [LISTAGG](#listagg)

***

## BASLANGIC

Başlamak için öncelikle yapmanız gereken tek şey çalışmaları açmak, sorulara göz atmak ve cevaplamaya çalışmak!

Bu çalışmalar için kullanılan veri setinin sadece çalışmaları desteklemek için tasarlandığını ve veri tabanı şemasının bazı açılardan kusurlu olduğunu unutmayın; bu yüzden iyi bir tasarım örneği olarak değerlendirmeyin. 

Aşağıda yer alan sorgu dosyasındaki veri setini postgresql üzerinde sırası ile çalıştırınız.

[Database ve Tablolar](sqldata.sql)

### 1. Temel SQL İşlemleri

### SELECT
- **`SELECT *` ve `SELECT empid, firstname, lastname, country`**  
  PostgreSQL'de verileri sorgulamak için kullanılan `SELECT` komutları, veritabanındaki tablo veya görünümlerden belirli sütunları veya tüm sütunları seçmenizi sağlar. `SELECT *` tüm sütunları seçerken, belirli sütunları belirttiğinizde sadece o sütunları getirir.  

```sql
SELECT *  FROM HR.EMPLOYEES;
SELECT empid, firstname, lastname, country FROM HR.EMPLOYEES;
```

### INSERT
- **`INSERT`**  
  Yeni veri ekler.
### UPDATE
- **`UPDATE`**  
  Mevcut verileri günceller.
### DELETE
- **`DELETE`**  
  Verileri siler.

### JOIN
- **`JOIN`,`RIGHT JOIN`, `LEFT JOIN`, `CROSS JOIN`, `FULL JOIN`, `OUTER JOIN`**  
  `JOIN` Birden fazla tabloyu ilişkilendirerek birleştirmenizi sağlar.
  ```sql
  SELECT *
  FROM Sales.Orders as o
  JOIN HR.EMPLOYEES as e on e.empid = o.empid;
  ```
  `RIGHT JOIN` ve `LEFT JOIN` tablolardaki verilerin birleşimini sağlar.
    ```sql
  ```
  `CROSS JOIN` tüm kombinasyonları döndürür.
    ```sql
  ```
  `FULL JOIN` tüm verileri getirir.
    ```sql
  ```
  `OUTER JOIN` ise bazı verileri hariç tutar.
    ```sql
  ```
  

## 2. Filtreleme ve Sıralama

### WHERE
- **`WHERE`**  
  Belirli koşullara uyan verileri sorgulamak için kullanılır.
  ```sql
  SELECT empid, firstname, lastname, country
  FROM hr.employees
  WHERE country = 'USA';
  ```

### GROUP BY
- **`GROUP BY`**  
  Verileri belirli bir sütuna göre gruplamak için kullanılır.
  ```sql
   SELECT
   		e.empid,
   FROM Sales.Orders as o
   JOIN HR.Employees as e on e.empid = o.empid
   WHERE o.shipcountry = 'USA'
   GROUP BY e.empid
  ```

### ORDER BY
- **`ORDER BY`**  
  Sorgu sonuçlarını belirli bir sıraya koymak için kullanılır. `ORDER BY` ifadesi ile verileri artan veya azalan sıraya göre düzenleyebilirsiniz.
  ```sql
  SELECT empid, firstname, lastname, country
  FROM hr.employees
  WHERE country = 'USA'
  ORDER BY firstname;
  ```

### HAVING
- **`HAVING`**  
  `GROUP BY` ile gruplanmış veriler üzerinde filtreleme yapmak için kullanılır.  [SUM](#aritmetik-fonksiyonlar)
  ```sql
   SELECT
   		e.empid,
   		SUM(o.freight) as TotalFreight
   FROM Sales.Orders as o
   JOIN HR.Employees as e on e.empid = o.empid
   WHERE o.shipcountry = 'USA'
   GROUP BY e.empid
   HAVING SUM(o.freight) > '2000'
   ORDER BY e.empid;
  ```

### BETWEEN
- **`BETWEEN`**  
  Belirli bir aralık içindeki verileri seçmek için kullanılır. 
    ```sql
   SELECT *
   FROM Sales.Orders
   WHERE OrderDate NOT BETWEEN '2008-05-01' AND '2008-07-31';
  ```

### LIMIT
- **`LIMIT`**  
  Sorgu sonuçlarının kaç satır döndürüleceğini belirler.
   ```sql
   SELECT empid, firstname, lastname, country
   FROM hr.employees
   WHERE country = 'USA'
   ORDER BY firstname
   Limit 3;
  ```
### OFFSET-FETCH
- **`OFFSET-FETCH`**  
  Verilerin hangi noktadan itibaren döndürülmeye başlanacağını belirtir. Bu, büyük veri setleriyle çalışırken verilerin sayısını kontrol etmek için kullanılır.
   ```sql
   SELECT orderid, orderdate, custid, empid
   FROM Sales.Orders
   ORDER BY orderdate, orderid
   Limit 5 OFFSET 3;
  ```
 ```sql
   SELECT orderid, orderdate, custid, empid
   FROM Sales.Orders
   ORDER BY orderdate, orderid
   FETCH FIRST 1 ROW ONLY;
  ```
   ```sql
   SELECT orderid, orderdate, custid, empid
   FROM Sales.Orders
   ORDER BY orderdate, orderid
   OFFSET 3 ROWS FETCH NEXT 5 ROW ONLY;
  ```
  ```sql
   SELECT orderid, orderdate, custid, empid
   FROM Sales.Orders
   ORDER BY orderdate DESC
   FETCH NEXT 2 ROWS WITH TIES
   OFFSET 8;
  ```
## 3. Veri Manipülasyonu ve Fonksiyonlar

### Aritmetik Fonksiyonlar
- **`SUM`, `ROUND`, `CEIL`**  
  `SUM`, bir sütundaki tüm değerlerin toplamını verir.
  `ROUND` ve `CEIL` sayıları yuvarlamak için kullanılır.
  ```sql
   SELECT SUM(freight) as TotalFreight  FROM Sales.Orders
   SELECT Count(*)*0.01 FROM Sales.Orders
   SELECT CEIL(Count(*)*0.01) FROM Sales.Orders  
   SELECT Round(Count(*)*0.01) FROM Sales.Orders
  ```
### String Fonksiyonları
- **`CONCAT`, `CONCAT_WS`**  
  `CONCAT` String'leri birleştirir.
  ```sql
   SELECT
   CONCAT(city, ' ', Region, ' ', Country) As LocationC
   FROM HR.Employees;
  ```
  `CONCAT_WS` bir ayırıcı kullanarak string'leri birleştirir.
    ```sql
     SELECT 
     CONCAT_WS(',', country, region, city )  AS locationC
     FROM Sales.Customers;
   ```
- **`SUBSTRING`**  
  String'in bir kısmını almak için kullanılır.
   ```sql
     SELECT 
    'erdinc.degirmenci@outlook.com'
    ,POSITION('@' IN 'erdinc.degirmenci@outlook.com')
    ,SUBSTRING('erdinc.degirmenci@outlook.com',1, 11-1)
    ,SUBSTRING('erdinc.degirmenci@outlook.com',1, POSITION('@' IN 'erdinc.degirmenci@outlook.com')-1);
   ```
- **`POSITION`**  
  Bir substring'in, ana string içindeki konumunu bulur.
   ```sql
   SELECT POSITION(' ' IN 'Erdinç DEĞİRMENCİ TR');
   SELECT POSITION('TR' IN 'Erdinç DEĞİRMENCİ TR');
  ```
- **`UPPER`, `LOWER`**  
  String'i büyük harfe veya küçük harfe dönüştürür.
     ```sql
   SELECT UPPER('amazing SQLData');   
   SELECT LOWER('amazing SQLData');
  ```
- **`REVERSE`**  
  String'in tersini alır.  
- **`LENGTH`**  
  String'in uzunluğunu döndürür.
  ```sql
   SELECT LENGTH(N'abcde');
   SELECT LENGTH('abcde');
  ```
- **`INITCAP`**  
  String'deki her kelimenin ilk harfini büyük yapar.
   ```sql
   SELECT INITCAP('amazing SQLData');
   SELECT INITCAP('select DATA for analyzing');
  ```
- **`RTRIM`, `LTRIM`, `TRIM`, `BTRIM`**
  String'in sağından, solundan veya her iki tarafından boşlukları temizler.
  ```sql
   SELECT ltrim('      Hello   World      ');			--Sonuc :  "Hello   World      "
   SELECT rtrim('      Hello   World      ');			--Sonuc :  "      Hello   World"
   SELECT rtrim(ltrim('      Hello   World      '));	--Sonuc :  "Hello   World"
   SELECT trim('      Hello   World      ');			--Sonuc :  "Hello   World"
   SELECT btrim('      Hello   World      ');			--Sonuc :  "Hello   World"
  ```
- **`LPAD`, `RPAD`**  
  String'i belirli bir uzunluğa kadar sola veya sağa doldurur.
    ```sql
   SELECT LPAD('SQL', 15, '*');-- "************SQL"
   SELECT RPAD('SQL', 15, '*');-- "SQL************"
   SELECT LPAD('3456', 10, '*');-- "******3456"
   SELECT LPAD('3456', 10, 'A');-- "AAAAAA3456"
   SELECT LPAD('3456', 10, '0');-- "0000003456"
   SELECT  LPAD(9::text,2,'0');
   SELECT  LPAD(12::text,2,'0');
   SELECT  (2024||'-'||LPAD(9::text,2,'0')||'-'||LPAD(9::text,2,'0'))::date AS ConstructedDate;
   SELECT  (2024||'-'||LPAD(12::text,2,'0')||'-'||LPAD(30::text,2,'0'))::date AS ConstructedDate;
  ```
- **`REPLACE`**  
  String içindeki belirli karakterleri veya kelimeleri değiştirir.
  ```sql
   SELECT REPLACE('PostgreSQL SELECT Data', 'data', 'Veri');
   SELECT REPLACE('PostgreSQL SELECT Data', 'Data', 'Veri');
  ```
- **`REGEXP_MATCHES`, `REGEXP_REPLACE`**  
  Düzenli ifadeler kullanarak string'leri eşleştirir veya değiştirir.
    ```sql
   SELECT REGEXP_MATCHES('Hello World', 'hello', 'i');
   SELECT REGEXP_MATCHES('Hello World', 'hello', 'g');
   SELECT REGEXP_MATCHES('Hello World', 'hello');	
  ```
   ```sql
   SELECT regexp_replace('abc123def456', '\d+', 'XYZ') AS new_text;   
   SELECT regexp_replace('abc123def456', '\d+', 'DUNYA') AS new_text;
  ```
- **`REPEAT`**  
  String'i belirli bir sayıda tekrarlar.  
   ```sql
   SELECT REPEAT('abc', 3);
   SELECT REPEAT('*', 8);
  ```
- **`OVERLAY`**  
  String'in bir kısmını başka bir string ile değiştirir.
   ```sql
   SELECT OVERLAY ('xyz' Placing 'abc' FROM 2 for 1);
   SELECT OVERLAY ('abcdexyz' Placing 'elma' FROM 2 for 3);
   SELECT OVERLAY ('xyz super' Placing 'abc' FROM 2 for 0);
   SELECT OVERLAY ('VeriTabanı Egitimi' Placing ' Sorgulama' FROM 5 for 6);
  ```
- **`FORMAT`**  
  String'i belirli bir formatta döndürür.
    ```sql
   SELECT FORMAT('Hello %s', 'World');
   SELECT FORMAT('Testing %s, %s, %s, %%', 'one', 'two', 'three');
   SELECT FORMAT('INSERT INTO %I VALUES(%L)', 'Foo bar', 'Reilly');
  ```

### Dizi Fonksiyonları
- **`STRING_TO_ARRAY`**  
  String'i bir diziye dönüştürür.
   ```sql
   SELECT STRING_TO_ARRAY('Lorem ipsum dolor sit amet', ' ') AS words;
  ```
- **`REGEXP_SPLIT_TO_ARRAY`, `REGEXP_SPLIT_TO_TABLE`**  
  String'i düzenli ifadeler kullanarak diziye veya tabloya böler.
     ```sql
   SELECT regexp_split_to_array('Lorem ipsum dolor sit amet', '\s+') AS words;
  ```
     ```sql
     SELECT regexp_split_to_table('Lorem ipsum dolor sit amet', '\s+') AS word;
   SELECT regexp_split_to_table('Lorem ipsum dolor sit amet', ' ') AS word;
  ```
- **`ARRAY_AGG`**  
  Satırlardan bir dizi oluşturur.
   ```sql
  ```
- **`UNNEST`**  
  Diziyi satırlara dönüştürür.
   ```sql
   SELECT 
       CategoryId, 
       Name, 
       UNNEST(Aciklama, ',') AS SonucA
   FROM 
       CategoryTest;
  ```
- **`ARRAY_LENGTH`**  
  Dizinin uzunluğunu döndürür.

## 4. Veri Türleri ve Yapılar

### Temel Veri Türleri
- **`INTEGER`, `FLOAT`, `VARCHAR`**  
  Temel veri türleri, sayısal ve string veri saklamak için kullanılır.  
- **`BOOLEAN`**  
  Boolean veri türü, `TRUE` veya `FALSE` değerlerini saklar.  
- **`CHAR`, `TEXT`**  
  Tek karakter veya metin veri saklar.

### İleri Düzey Veri Türleri
- **`JSON`, `JSONB`**  
  JSON verilerini saklar. `JSONB` daha verimli bir depolama sağlar.
     ```sql
   SELECT
   	title,
   	book_info -> 'publisher' as "publisher",
   	book_info -> 'Kagit_Baski_Fiyati' as "KagitBaski",
   	book_info -> 'Digital_Baski_Fiyati' as "DigitalBaski"
   FROM Table_hstore;
   
   -- JSON  Data Type
   DROP TABLE IF EXISTS Table_json;
   
   CREATE TABLE Table_json
   (
   	id Serial Primary Key,
   	docs JSON
   );
   
   INSERT INTO Table_json(docs)
   Values
   		('[1,2,3,4,5,6]'),
   		('[2,3,4,5,6,7]'),
   		('{"key":"value"}');
   
   SELECT *
   FROM Table_json;
   
   SELECT docs
   FROM Table_json;
     ```
   ```sql
   ALTER TABLE table_json
   ALTER COLUMN docs TYPE JSONB;
   
   SELECT *
   FROM Table_json
   WHERE docs @> '2';
  ```
- **`ARRAY`**  
  Birden fazla değeri bir veri türünde saklar.
   ```sql
   -- ARRAY Data Type
   DROP TABLE IF EXISTS table_array;
   
   CREATE TABLE table_array
   (
   	id Serial Primary Key,
   	firstname Varchar(30),
   	phone text[]
   );
   
   INSERT INTO table_array(firstname,phone) 
   Values
   		('Ali',Array['05559988876','00905559988876']),
   		('Radi',Array['05359988899','00905359988899']);
   
   INSERT INTO table_array(firstname,phone) 
   Values
   		('Yaren',Array['05332244459','00905551234569']);
   
   SELECT *
   FROM table_array;
   
   SELECT
   		firstname,
   		phone,
   		phone[1] as Telno1,
   		phone[2] as Telno2
   FROM table_array;
  ```
- **`HSTORE`**  
  Anahtar-değer çiftlerini saklar.
    ```sql
     CREATE Extension IF NOT EXISTS hstore;
       
     CREATE TABLE Table_hstore
      (
      	id Serial Primary Key,
      	title Varchar(50) NOT Null,
      	book_info hstore
      );
      
      INSERT INTO Table_hstore(title, book_info)
      Values
      (
      	'Uzay Kesifi',
      	'
      	"publisher" => "ABC publisher",
      	"Kagit_Baski_Fiyati" => "1000",
      	"Digital_Baski_Fiyati" => "200"
      	'
      );
      
      INSERT INTO Table_hstore(title, book_info)
      Values
      (
      	'Universes',
      	'
      	"publisher" => "Ali publisher",
      	"Kagit_Baski_Fiyati" => "2000",
      	"Digital_Baski_Fiyati" => "1200"
      	'
      );
      
      SELECT *
      FROM Table_hstore;
    ```
- **`XML`, ``**  
  XML veri türü ile verileri saklar ve işler.
 `XPATH`
  XPATH, XML verileri üzerinde sorgulama yapar.

    ```sql
    DROP TABLE IF EXISTS orders;
   
   CREATE TABLE orders (
       order_id SERIAL PRIMARY KEY,
       order_data XML
   );
   
   -- Inserting a sample XML data
   INSERT INTO orders (order_data) VALUES ('<order><item>Widget</item><price>25.00</price></order>');
   
   SELECT *
   FROM Orders;
    ```
   ```sql
   SELECT
       xpath('//item/text()', order_data) AS item_name,
       xpath('//price/text()', order_data) AS item_price
   FROM orders;
    ```
- **`UUID`**  
  Evrensel benzersiz tanımlayıcı.  
- **`BYTEA`**  
  İkili veri saklamak için kullanılır.  
- **`ENUM`**  
  Kısıtlı değerler listesi sağlar.  
- **`GEOMETRY`, `GEOGRAPHY`**  
  Coğrafi verileri saklamak için (PostGIS eklentisi ile).
  
### Veri Yapıları ve İndeksler
- **`INDEX`**  
  Veritabanı sorgularının hızını artırmak için kullanılır.  
- **`BTREE`**  
  Varsayılan indeks türüdür ve verileri sıralı olarak tutar.
     ```sql
   DROP INDEX table_json_docs_idx;
   -- CREATE INDEX On table_json Using GIN(docs jsonb_path_ops);
   CREATE INDEX table_json_docs_idx On table_json Using GIN(docs jsonb_path_ops);
   
   SELECT *
   FROM Table_json
   WHERE docs @> '2';
    ```
- **`HASH`**  
  Hash tabanlı indeksler sağlar.  
- **`GIN`**  
  JSONB ve diğer koleksiyon türleri için kullanılır.
   ```sql
         DROP INDEX table_json_docs_idx;
         -- CREATE INDEX On table_json Using GIN(docs jsonb_path_ops);
         CREATE INDEX table_json_docs_idx On table_json Using GIN(docs jsonb_path_ops);
      
      SELECT *
      FROM Table_json
      WHERE docs @> '2';
    ```
- **`GiST`**  
  Coğrafi ve diğer yapılandırılmış veriler için kullanılır.  
- **`SP-GiST`**  
  Uzamsal veriler için kullanılır.  
- **`BRIN`**  
  Büyük veri kümeleri için etkili bir indeks türüdür.

### Diğer Yapılar
- **`TABLE`**  
  Verileri düzenlemek için kullanılır.  
- **`VIEW`**  
  Sanal tablo oluşturur.  
- **`SEQUENCE`**  
  Otomatik artan değerler üretir.

## 5. İleri Düzey Fonksiyonlar ve İşlemler

### CTES (Common Table Expressions)
- **`WITH`**  
  Geçici sonuçlar oluşturur ve sorguların daha okunabilir olmasını sağlar.

### ROW_NUMBER
- **`ROW_NUMBER()`**  
  Her satıra bir sıra numarası atar.

### PARTITION
- **`PARTITION BY`**  
  Verileri gruplara ayırarak pencere fonksiyonları uygulamanızı sağlar.

### CASE
- **`CASE`**  
  Koşullu mantık sağlar. Belirli koşullara göre değer döndürür.

### COALESCE
- **`COALESCE`**  
  NULL değerler yerine ilk geçerli değeri döndürür.

### STRING_AGG
- **`STRING_AGG`**  
  Birden fazla satırı tek bir string'e birleştirir.

## 6. Tarih ve Zaman Fonksiyonları

- **`CURRENT_DATE`, `CURRENT_TIME`, `CURRENT_TIMESTAMP`**  
  Tarih ve saat bilgilerini döndürür.
- **`DATEADD`**  
  Tarihe belirli bir süre ekler. Örneğin, `DATEADD(day, 5, CURRENT_DATE)` ifadesi, bugünkü tarihe 5 gün ekler.

- **`DATEDIFF`**  
  İki tarih arasındaki farkı hesaplar. Örneğin, `DATEDIFF(day, '2024-01-01', CURRENT_DATE)` ifadesi, iki tarih arasındaki gün sayısını verir.

- **`DATEPART`**  
  Tarihin belirli bir bölümünü döndürür (yıl, ay, gün vb.). Örneğin, `DATEPART(year, CURRENT_DATE)` ifadesi, mevcut tarihin yılını döndürür.

- **`DATE_TRUNC`**  
  Tarihi belirli bir süre birimine (yıl, ay, gün vb.) yuvarlar. Örneğin, `DATE_TRUNC('month', CURRENT_DATE)` ifadesi, mevcut tarihi ayın ilk gününe yuvarlar.

- **`MAKE_DATE`**  
  Belirli yıl, ay ve gün bileşenlerinden bir tarih oluşturur. Örneğin, `MAKE_DATE(2024, 9, 15)` ifadesi 15 Eylül 2024 tarihini oluşturur.

### DATE Fonksiyonları
- **`CURRENT_DATE`, `CURRENT_TIMESTAMP`, `AGE`, `DATE_TRUNC`**  
  Tarih ve zaman bilgilerini sağlar ve manipüle eder.

## 7. Dizi ve Matris İşlemleri

- **`ARRAY` ve `ARRAY_AGG`**  
  Dizileri işlemek ve birleştirmek için kullanılır.
  - **`STRING_TO_ARRAY`**  
  Bir string'i diziye dönüştürür. Örneğin, `STRING_TO_ARRAY('a,b,c', ',')` ifadesi `['a', 'b', 'c']` dizisini oluşturur.

- **`REGEXP_SPLIT_TO_ARRAY`**  
  Düzenli ifadeler kullanarak bir string'i diziye böler. Örneğin, `REGEXP_SPLIT_TO_ARRAY('a1b2c3', '[0-9]')` ifadesi `['a', 'b', 'c']` dizisini oluşturur.

- **`REGEXP_SPLIT_TO_TABLE`**  
  Düzenli ifadeler kullanarak bir string'i tabloya böler. Her bir elemanı bir satır olarak döndürür.

- **`ARRAY_AGG`**  
  Satırları bir diziye dönüştürür. Örneğin, `ARRAY_AGG(column_name)` ifadesi belirli bir sütundaki tüm değerleri bir diziye toplar.

- **`UNNEST`**  
  Bir diziyi satırlarına ayırır. Örneğin, `UNNEST(ARRAY[1, 2, 3])` ifadesi her bir dizi elemanını bir satıra dönüştürür.

- **`ARRAY_LENGTH`**  
  Bir dizinin uzunluğunu döndürür. Örneğin, `ARRAY_LENGTH(ARRAY[1, 2, 3], 1)` ifadesi `3` döndürür.

## 8. Performans ve Kilitleme

### Kilitleme Seçenekleri
- **`WITH (NOLOCK)`**  
  Okuma işlemleri sırasında tablolarda kilitlenmeleri engeller ve okuma kilitlenmeleri olmadan veri okur.

- **`SKIP LOCKED`**  
  Kilitlenmiş satırları atlar ve sadece kilitlenmemiş satırları okur.

- **`NOWAIT`**  
  Kilitlenmiş satırlar varsa hata döndürür ve işlemi hemen durdurur.
### Transaction Isolation Level
- **`SERIALIZABLE`, `REPEATABLE READ`**  
  İşlemlerin izolasyon seviyelerini belirler.
  
- **`READ COMMITTED`**  
  İşlemlerin okuma seviyesini belirler ve diğer işlemler tarafından yapılan değişiklikleri okur. Bu seviyede yapılan sorgular, sadece commit edilmiş verileri döndürür.

## 9. Veritabanı Yönetimi ve Bilgi

### Veri Görüntüleme
- **`pg_stat_activity`, `pg_stat_database`**  
  Veritabanı etkinliğini ve performansını görüntüler.

### Veritabanı Bilgisi
- **`pg_tables`, `pg_indexes`**  
  Veritabanındaki tablolar ve indeksler hakkında bilgi verir.
  - **`CATALOG`**  
  Veritabanı yapısını ve metadataları hakkında bilgi sağlar.

- **`INFORMATION_SCHEMA`**  
  Veritabanının şeması hakkında bilgi sağlar; tablolar, sütunlar, veri türleri vb. hakkında bilgi alabilirsiniz.


### Kümeleme ve Birleştirme
- **`CLUSTER`**  
  Tabloyu bir dizine göre sıralar ve fiziksel olarak yeniden düzenler.
- **`INTERSECT`**  
  İki sorgunun kesişim kümesini döndürür. Ortak olan satırları getirir.

- **`UNION`**  
  İki veya daha fazla sorgunun birleşim kümesini döndürür. Aynı sütun yapısına sahip sonuçları birleştirir.

- **`EXCEPT`**  
  Bir sorgunun diğer sorgunun sonucundan farklarını döndürür. İlk sorguda olup, ikinci sorguda olmayan satırları getirir.

### Diğer İşlemler
- **`VACUUM`**  
  Ölü verileri temizler ve veritabanının performansını artırır.
- **`REINDEX`**  
  İndeksleri yeniden oluşturur.
- **`ANALYZE`**  
  Tablo istatistiklerini günceller.
  - **`STORED PROCEDURE`**  
  Saklı prosedürler oluşturur. SQL kodlarını saklı prosedürlerde tutarak yeniden kullanılabilir.

- **`CALL`**  
  Saklı prosedürleri çağırır. Saklı prosedürleri çalıştırmak için kullanılır.

- **`TRIGGER`**  
  Belirli olaylara yanıt olarak otomatik işlemler tanımlar. Bir veri değişikliği gerçekleştiğinde otomatik olarak çalışır.

- **`CURSOR`**  
  Sorgu sonuçlarını satır satır işlemek için kullanılır. Özellikle büyük veri setleri ile çalışırken kullanışlıdır.

- **`RAISE`**  
  Hata mesajları veya uyarılar oluşturur. Kullanıcıya veya yöneticilere mesaj iletmek için kullanılır.

- **`FUNCTION`**  
  Tekrarlanabilir işlemleri kapsayan fonksiyonlar tanımlar. İşlevsellik sağlar ve kod tekrarını azaltır.

## 10. Ek Konular

### NULLS FIRST, NULLS LAST
- **`NULLS FIRST`, `NULLS LAST`**  
  NULL değerlerini sıralama sırasında nasıl ele alacağınızı belirler.

### OPERATORLER
- **`+`, `-`, `*`, `/`, `%`, `||`**  
  Aritmetik ve string operatörleri sağlar.

### COLLATE
- **`COLLATE`**  
  String'lerin karşılaştırılmasında kullanılan dil ve sıralama kurallarını belirtir.

### TABLESAMPLE
- **`TABLESAMPLE`**  
  Tablo örneklemesi sağlar.

### ROW LEVEL SECURITY
- **`ROW LEVEL SECURITY`**  
  Satır bazında güvenlik sağlar.

### TEMPORARY TABLES
- **`TEMPORARY TABLES`**  
  Geçici tablolar oluşturur ve bu tablolar sadece oturum süresince geçerli olur.

### LISTAGG
- **`LISTAGG`**  
  Dizi elemanlarını belirli bir ayırıcı ile birleştirir.

