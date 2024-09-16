# PostgreSQL Kapsamlı Kılavuzu

## 1. Temel SQL İşlemleri

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
- **`INTEGER`, `BIGINT`, `SMALLINT`, `SERIAL`, `BIGSERIAL`**  
  Tam sayı veri türleri.  
- **`NUMERIC`, `DECIMAL`, `FLOAT`, `REAL`, `DOUBLE PRECISION`**  
  Kesirli ve ondalıklı sayılar için veri türleri.  
- **`CHAR`, `VARCHAR`, `TEXT`**  
  Metin veri türleri.  
- **`DATE`, `TIME`, `TIMESTAMP`, `INTERVAL`**  
  Tarih ve zaman veri türleri.

### İleri Düzey Veri Türleri
- **`ARRAY`**  
  Birden fazla değeri tek bir veri türü olarak saklar.  
- **`JSON`, `JSONB`**  
  Yapısal veri saklamak için kullanılır; JSONB ikili formatta daha hızlı sorgulama sağlar.  
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

### Veri Yapıları ve İndeksler
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
  Temel tablo yapısı.  
- **`VIEW`**  
  Sanal tablo.  
- **`MATERIALIZED VIEW`**  
  Saklı sanal tablo, verileri fiziksel olarak saklar.  
- **`INDEX`**  
  Verileri hızlıca aramak için kullanılır.  
- **`SEQUENCE`**  
  Otomatik artan değerler üretir.

## 5. İleri Düzey Fonksiyonlar ve İşlemler

### CTES (Common Table Expressions)
- **`CTES`**  
  Geçici sonuç kümeleri oluşturmak için kullanılır. Karmaşık sorguları daha okunabilir hale getirir.

### ROW_NUMBER
- **`ROW_NUMBER`**  
  Satırlara sıra numarası atar, genellikle pencere fonksiyonları ile birlikte kullanılır.

### PARTITION
- **`PARTITION`**  
  Veri kümesini belirli bölgelere ayırarak daha etkili yönetim ve sorgulama sağlar.

### CASE
- **`CASE`**  
  Koşullu mantık sağlar ve sorgu sonuçlarını belirli şartlara göre döndürebilir.

### COALESCE
- **`COALESCE`**  
  NULL değerler yerine bir varsayılan değer döndürür.

### STRING_AGG
- **`STRING_AGG`**  
  Birden fazla string'i tek bir string'e birleştirir ve belirli bir ayırıcı ile ayırır.

## 6. XML / XPATH
- **`XML`**  
 ## 6. XML / XPATH
- **`XML`**  
  XML verilerini saklamak ve işlemek için kullanılır. PostgreSQL, XML veri türleri ve fonksiyonları ile XML belgeleri üzerinde sorgulama ve manipülasyon yapmanızı sağlar.

- **`XPATH`**  
  XML belgelerinde veri aramak ve sorgulamak için kullanılan bir dil. PostgreSQL, XML belgeleri üzerinde XPATH ifadeleri ile veri çekmenizi sağlar.

## 7. Tarih ve Zaman Fonksiyonları

### DATE Fonksiyonları
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

## 8. Dizi ve Matris İşlemleri

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

## 9. Performans ve Kilitleme

### Kilitleme Seçenekleri
- **`WITH (NOLOCK)`**  
  Okuma işlemleri sırasında tablolarda kilitlenmeleri engeller ve okuma kilitlenmeleri olmadan veri okur.

- **`SKIP LOCKED`**  
  Kilitlenmiş satırları atlar ve sadece kilitlenmemiş satırları okur.

- **`NOWAIT`**  
  Kilitlenmiş satırlar varsa hata döndürür ve işlemi hemen durdurur.

### Transaction Isolation Level
- **`READ COMMITTED`**  
  İşlemlerin okuma seviyesini belirler ve diğer işlemler tarafından yapılan değişiklikleri okur. Bu seviyede yapılan sorgular, sadece commit edilmiş verileri döndürür.

## 10. Veritabanı Yönetimi ve Bilgi

### Veri Görüntüleme
- **`SHOW datestyle;`**  
  Tarih biçimini görüntüler. Veritabanında tarihlerin nasıl formatlandığını gösterir.

### Veritabanı Bilgisi
- **`CATALOG`**  
  Veritabanı yapısını ve metadataları hakkında bilgi sağlar.

- **`INFORMATION_SCHEMA`**  
  Veritabanının şeması hakkında bilgi sağlar; tablolar, sütunlar, veri türleri vb. hakkında bilgi alabilirsiniz.

### Kümeleme ve Birleştirme
- **`INTERSECT`**  
  İki sorgunun kesişim kümesini döndürür. Ortak olan satırları getirir.

- **`UNION`**  
  İki veya daha fazla sorgunun birleşim kümesini döndürür. Aynı sütun yapısına sahip sonuçları birleştirir.

- **`EXCEPT`**  
  Bir sorgunun diğer sorgunun sonucundan farklarını döndürür. İlk sorguda olup, ikinci sorguda olmayan satırları getirir.

### Diğer İşlemler
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

## 11. Ek Konular

### NULLS FIRST, NULLS LAST
- **`NULLS FIRST`**  
  NULL değerlerini sıralama işlemlerinde başa yerleştirir. Örneğin, sıralama işlemi sırasında NULL değerler ilk sırada gösterilir.

- **`NULLS LAST`**  
  NULL değerlerini sıralama işlemlerinde sona yerleştirir. Örneğin, sıralama işlemi sırasında NULL değerler en sonunda gösterilir.

### OPERATORLER
- **`<>`, `=`, `>`, `<`**  
  Karşılaştırma ve mantıksal işlemler için çeşitli operatörler kullanılır. İki değer arasındaki ilişkileri belirlemek için kullanılır.

### COLLATE
- **`COLLATE`**  
  Metin verilerinin sıralama ve karşılaştırma kurallarını belirler. Özellikle farklı dillerdeki verilerin sıralanması için kullanılır.

### TABLESAMPLE
- **`TABLESAMPLE`**  
  Büyük tablolardan rastgele örnekler almanızı sağlar. Örneğin, bir tablodan belirli bir oran veya sayıda örnek veri almak için kullanılır.

### ROW LEVEL SECURITY
- **`ROW LEVEL SECURITY`**  
  Satır bazında güvenlik sağlar ve belirli kullanıcıların verileri görmesini veya değiştirmesini kontrol eder. Veri güvenliğini artırır.

### TEMPORARY TABLES
- **`TEMPORARY TABLES`**  
  Geçici verileri saklamak için kullanılır ve oturum sonunda otomatik olarak silinir. Genellikle geçici veri işleme için kullanılır.

### LISTAGG
- **`LISTAGG`**  
  Birden fazla satırdaki verileri birleştirir ve belirli bir ayırıcı ile bir string oluşturur. Örneğin, birden fazla satırdaki değerleri tek bir satırda birleştirmek için kullanılır.

