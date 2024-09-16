# PostgreSQL Kapsamlı Kılavuzu

PostgreSQL, açık kaynak kodlu, güçlü ve esnek bir ilişkisel veritabanı yönetim sistemidir. SQL standardını destekleyen ve geniş bir fonksiyon yelpazesine sahip olan PostgreSQL, veri yönetimi, sorgulama ve analiz konularında sağlam bir temel sağlar. Bu kılavuz, PostgreSQL'in temel ve ileri düzey özelliklerini kapsamlı bir şekilde ele alarak, veritabanı yönetimi konusunda derinlemesine bilgi edinmenize yardımcı olmayı amaçlamaktadır. Veritabanı işlemleri, veri manipülasyonu ve performans iyileştirme gibi konulara dair kapsamlı bilgilerle, PostgreSQL'in sunduğu imkanları en iyi şekilde kullanabilmeniz için gereken tüm detayları sunacaktır.

Bu kılavuz, PostgreSQL Egzersizleri üzerindeki tüm soruları ve cevapları derlemektedir. Bu problemlerin gerçekten çözülmesi, sadece bu kılavuzu gözden geçirmekten daha ileriye gitmenizi sağlayacaktır, bu yüzden [PostgreSQL Exercises](https://pgexercises.com) ziyaret etmenizi öneririm.

## İçindekiler

[BAŞLANGIÇ](#baslangic)
1. [Temel SQL İşlemleri](#1-temel-sql-işlemleri)
   - [SELECT](#select)
   - [INSERT, UPDATE, DELETE](#insert-update-delete)
   - [JOIN](#join)
2. [Filtreleme ve Sıralama](#2-filtreleme-ve-sıralama)
   - [WHERE](#where)
   - [GROUP BY](#group-by)
   - [ORDER BY](#order-by)
   - [HAVING](#having)
   - [BETWEEN](#between)
   - [LIMIT ve OFFSET-FETCH](#limit-ve-offset-fetch)
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

## Getting Started

Başlamak için öncelikle yapmanız gereken tek şey çalışmaları açmak, sorulara göz atmak ve cevaplamaya çalışmak!

Bu çalışmalar için kullanılan veri setinin sadece çalışmaları desteklemek için tasarlandığını ve veri tabanı şemasının bazı açılardan kusurlu olduğunu unutmayın; bu yüzden iyi bir tasarım örneği olarak değerlendirmeyin. 

Aşağıda yer alan sorgu dosyasındaki veri setini postgresql üzerinde sırası ile çalıştırınız.

[Örnek Dosya](docs/example.md)

### 1. Temel SQL İşlemleri

### SELECT
- **`SELECT *` ve `SELECT empid, firstname, lastname, country`**  
  PostgreSQL'de verileri sorgulamak için kullanılan `SELECT` komutları, veritabanındaki tablo veya görünümlerden belirli sütunları veya tüm sütunları seçmenizi sağlar. `SELECT *` tüm sütunları seçerken, belirli sütunları belirttiğinizde sadece o sütunları getirir.

### INSERT, UPDATE, DELETE
- **`INSERT`**  
  Yeni veri ekler.  
- **`UPDATE`**  
  Mevcut verileri günceller.  
- **`DELETE`**  
  Verileri siler.

### JOIN
- **`RIGHT JOIN`, `LEFT JOIN`, `CROSS JOIN`, `FULL JOIN`, `OUTER JOIN`**  
  Birden fazla tabloyu ilişkilendirerek birleştirmenizi sağlar. `RIGHT JOIN` ve `LEFT JOIN` tablolardaki verilerin birleşimini sağlarken, `CROSS JOIN` tüm kombinasyonları döndürür. `FULL JOIN` tüm verileri getirir, `OUTER JOIN` ise bazı verileri hariç tutar.

## 2. Filtreleme ve Sıralama

### WHERE
- **`WHERE`**  
  Belirli koşullara uyan verileri sorgulamak için kullanılır. Örneğin, `WHERE age > 30` ifadesi yaşı 30'dan büyük olan verileri getirir.

### GROUP BY
- **`GROUP BY`**  
  Verileri belirli bir sütuna göre gruplamak için kullanılır. Örneğin, satış verilerini ürünlere göre gruplamak için `GROUP BY` kullanabilirsiniz.

### ORDER BY
- **`ORDER BY`**  
  Sorgu sonuçlarını belirli bir sıraya koymak için kullanılır. `ORDER BY` ifadesi ile verileri artan veya azalan sıraya göre düzenleyebilirsiniz.

### HAVING
- **`HAVING`**  
  `GROUP BY` ile gruplanmış veriler üzerinde filtreleme yapmak için kullanılır. Örneğin, sadece 10'dan fazla satışı olan ürünleri gösterebilir.

### BETWEEN
- **`BETWEEN`**  
  Belirli bir aralık içindeki verileri seçmek için kullanılır. Örneğin, `BETWEEN 10 AND 20` ifadesi 10 ile 20 arasındaki değerleri getirir.

### LIMIT ve OFFSET-FETCH
- **`LIMIT`**  
  Sorgu sonuçlarının kaç satır döndürüleceğini belirler.  
- **`OFFSET-FETCH`**  
  Verilerin hangi noktadan itibaren döndürülmeye başlanacağını belirtir. Bu, büyük veri setleriyle çalışırken verilerin sayısını kontrol etmek için kullanılır.

## 3. Veri Manipülasyonu ve Fonksiyonlar

### Aritmetik Fonksiyonlar
- **`SUM`, `ROUND`, `CEIL`**  
  `SUM`, bir sütundaki tüm değerlerin toplamını verir. `ROUND` ve `CEIL` sayıları yuvarlamak için kullanılır.

### String Fonksiyonları
- **`CONCAT`, `CONCAT_WS`**  
  String'leri birleştirir. `CONCAT_WS` bir ayırıcı kullanarak string'leri birleştirir.  
- **`SUBSTRING`**  
  String'in bir kısmını almak için kullanılır.  
- **`POSITION`**  
  Bir substring'in, ana string içindeki konumunu bulur.  
- **`UPPER`, `LOWER`**  
  String'i büyük harfe veya küçük harfe dönüştürür.  
- **`REVERSE`**  
  String'in tersini alır.  
- **`LENGTH`**  
  String'in uzunluğunu döndürür.  
- **`INITCAP`**  
  String'deki her kelimenin ilk harfini büyük yapar.  
- **`RTRIM`, `LTRIM`, `TRIM`**  
  String'in sağından, solundan veya her iki tarafından boşlukları temizler.  
- **`LPAD`, `RPAD`**  
  String'i belirli bir uzunluğa kadar sola veya sağa doldurur.  
- **`REPLACE`**  
  String içindeki belirli karakterleri veya kelimeleri değiştirir.  
- **`REGEXP_MATCHES`, `REGEXP_REPLACE`**  
  Düzenli ifadeler kullanarak string'leri eşleştirir veya değiştirir.  
- **`REPLICATE`, `REPEAT`**  
  String'i belirli bir sayıda tekrarlar.  
- **`OVERLAY`**  
  String'in bir kısmını başka bir string ile değiştirir.  
- **`FORMAT`**  
  String'i belirli bir formatta döndürür.

### Dizi Fonksiyonları
- **`STRING_TO_ARRAY`**  
  String'i bir diziye dönüştürür.  
- **`REGEXP_SPLIT_TO_ARRAY`, `REGEXP_SPLIT_TO_TABLE`**  
  String'i düzenli ifadeler kullanarak diziye veya tabloya böler.  
- **`ARRAY_AGG`**  
  Satırlardan bir dizi oluşturur.  
- **`UNNEST`**  
  Diziyi satırlara dönüştürür.  
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
- **`ARRAY`**  
  Birden fazla değeri bir veri türünde saklar.  
- **`HSTORE`**  
  Anahtar-değer çiftlerini saklar.
- **`XML`**  
  XML verisini saklamak için kullanılır.  
- **`UUID`**  
  Evrensel benzersiz tanımlayıcı.  
- **`BYTEA`**  
  İkili veri saklamak için kullanılır.  
- **`ENUM`**  
  Kısıtlı değerler listesi sağlar.  
- **`GEOMETRY`, `GEOGRAPHY`**  
  Coğrafi verileri saklamak için (PostGIS eklentisi ile).
- **`XML`**  
  XML veri türü ile verileri saklar ve işler.
- **`XPATH`**  
  XML verileri üzerinde sorgulama yapar.

### Veri Yapıları ve İndeksler
- **`INDEX`**  
  Veritabanı sorgularının hızını artırmak için kullanılır.  
- **`BTREE`**  
  Varsayılan indeks türüdür ve verileri sıralı olarak tutar.  
- **`HASH`**  
  Hash tabanlı indeksler sağlar.  
- **`GIN`**  
  JSONB ve diğer koleksiyon türleri için kullanılır.  
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

