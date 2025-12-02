E-Ticaret Yönetim Sistemi – Veritabanı Projesi

Öğrenci: Burhan Aydemir
Proje Türü: SQL Veritabanı Tasarımı ve Fonksiyonel Örnekler
Araçlar: Microsoft SQL Server (SSMS), DrawSQL (ERD)

📌 Proje Hakkında

Bu proje, basit bir E-Ticaret Yönetim Sistemi için veritabanı tasarımını ve işlevsel özelliklerini kapsamaktadır. Amaç, bir e-ticaret platformunun temel veri yönetimini SQL üzerinde modellemek ve ilişkili veri akışını görselleştirmektir.

🗂 Veritabanı Yapısı

Projede aşağıdaki tablolar bulunmaktadır:

Categories (Kategoriler)

Products (Ürünler)

Customers (Müşteriler)

Shipping Addresses (Teslimat Adresleri)

Orders (Siparişler)

Order Items (Sipariş Detayları)

Reviews (Ürün Yorumları)

Tüm tablolar anahtar ilişkileri (PK-FK) ile birbirine bağlanmıştır. Veritabanı diyagramı DrawSQL üzerinde oluşturulmuş ve ERD ile görselleştirilmiştir.

⚙️ Fonksiyonlar ve İşlevler

Projede aşağıdaki temel fonksiyonlar ve işlevler tasarlanmıştır:

Siparişlerin toplam tutarını hesaplama

Müşterilerin toplam harcamasını izleme (Lifetime Value)

Ürün stok durumunu takip etme

🔔 Triggerlar ve Stored Procedure’ler

Veri bütünlüğünü ve iş süreçlerini otomatikleştirmek için:

Sipariş oluşturulduğunda stok otomatik düşürülür

Ürün fiyatı değişiklikleri loglanır

Sipariş iptal edildiğinde stok geri yüklenir

Sipariş oluşturma ve iptal işlemleri için prosedürler hazırlanmıştır

📊 View’lar ve Sorgular

Veri analizi için:

Kategorilere göre satış istatistikleri

Müşteri sipariş özetleri

En çok satan ürünler, kategori bazlı stok ve fiyat durumu

Ortalama sipariş tutarından yüksek siparişler

gibi raporlamalar ve görünümler oluşturulmuştur.

📝 Örnek Veriler

Projede test ve örnek veri setleri eklenmiştir. Böylece tablo ilişkileri ve fonksiyonlar doğrudan test edilebilir.

💡 Kullanım Notları

Proje SSMS üzerinde çalıştırılabilir.

DrawSQL ile oluşturulan ERD diyagramı projenin görselleştirilmiş yapısını gösterir.

Tüm işlevler yorum satırları ile açıklanmıştır.

📂 Dosya İçeriği

.sql dosyası: Veritabanı tabloları, fonksiyonlar, triggerlar, stored procedure’ler, view’lar ve örnek veriler

ERD.png veya ERD.pdf: DrawSQL diyagramı
