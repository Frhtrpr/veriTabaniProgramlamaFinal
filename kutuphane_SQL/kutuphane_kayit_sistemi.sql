--create db
CREATE DATABASE kutuphane_db;

--db ye terminalden bağlanma (username=postgres)
--psql -U postgres -d kutuphane_db

--doğru database mi kontrol sorgusu
select current_database() 

--tabloları  oluşturma
CREATE TABLE kategoriler (
  kategori_id SERIAL PRIMARY KEY,
  kategori_adi VARCHAR(100) NOT NULL
);

CREATE TABLE kitaplar (
  kitap_id SERIAL PRIMARY KEY,
  kitap_adi VARCHAR(255) NOT NULL,
  yazar VARCHAR(255) NOT NULL,
  yayinevi VARCHAR(255),
  basim_yili INTEGER,
  stok_sayisi INTEGER DEFAULT 0,
  kategori_id INTEGER REFERENCES Kategoriler(kategori_id),
  aciklama TEXT,
  sayfa_sayisi INTEGER
);

CREATE TABLE uyeler (
  uye_id SERIAL PRIMARY KEY,
  ad VARCHAR(255) NOT NULL,
  soyad VARCHAR(255) NOT NULL,
  giris_tarihi DATE DEFAULT CURRENT_DATE,
  telefon VARCHAR(20),
  email VARCHAR(255),
  adres TEXT
);

CREATE TABLE personel (
  personel_id SERIAL PRIMARY KEY,
  ad VARCHAR(255) NOT NULL,
  soyad VARCHAR(255) NOT NULL,
  gorev VARCHAR(100),
  ise_giris_tarihi DATE DEFAULT CURRENT_DATE,
  email VARCHAR(255),
  telefon VARCHAR(20),
  durum VARCHAR(20) DEFAULT 'aktif' CHECK (durum IN ('aktif', 'pasif'))
);

CREATE TABLE kitap_hareketleri (
  hareket_id SERIAL PRIMARY KEY,
  kitap_id INTEGER REFERENCES Kitaplar(kitap_id) ON DELETE CASCADE,
  uye_id INTEGER REFERENCES Uyeler(uye_id) ON DELETE CASCADE,
  personel_id INTEGER REFERENCES Personel(personel_id) ON DELETE CASCADE,
  islem_tarihi DATE DEFAULT CURRENT_DATE,
  islem_tipi VARCHAR(20) CHECK (islem_tipi IN ('Odunc', 'Iade')),
  aciklama TEXT
);

-- tablolara kayıt atma ınsert
INSERT INTO Kategoriler (kategori_adi) VALUES('Roman'),('Bilim'),('Tarih'),('Sanat'),('Çocuk Kitapları'),
('Felsefe'),
('Biyografi'),
('Psikoloji'),
('Ekonomi'),
('Edebiyat'),
('Macera'),
('Fantastik'),
('Polisiye'),
('Kişisel Gelişim'),
('Sağlık'),
('Seyahat'),
('Din'),
('Spor'),
('Teknoloji'),
('Mizah');

INSERT INTO kitaplar (kitap_adi, yazar, yayinevi, basim_yili, stok_sayisi, kategori_id, aciklama, sayfa_sayisi) VALUES
('Sefiller', 'Victor Hugo', 'Can Yayınları', 2015, 10, 1, 'Fransız klasikleri arasında yer alır.', 1463),
('1984', 'George Orwell', 'İthaki Yayınları', 2019, 8, 1, 'Distopik roman.', 328),
('Zamanın Kısa Tarihi', 'Stephen Hawking', 'Bilim Yayınları', 2018, 5, 2, 'Kozmoloji üzerine.', 256),
('Türklerin Tarihi', 'İlber Ortaylı', 'Kronik Kitap', 2020, 7, 3, 'Türk tarihi kitabı.', 412),
('Sanatın Öyküsü', 'E.H. Gombrich', 'Remzi Kitabevi', 2017, 3, 4, 'Sanat tarihi anlatılır.', 400),
('Masal Dünyası', 'J.K. Rowling', 'Çocuk Yayınları', 2015, 15, 5, 'Çocuklar için masallar.', 210),
('Felsefenin Temelleri', 'Aristoteles', 'Felsefe Yayınları', 2010, 9, 6, 'Felsefe tarihi.', 300),
('Yaşam Öyküsü', 'Barack Obama', 'Biyografi Yayınları', 2016, 12, 7, 'Obama''nın biyografisi.', 350),
('İnsan Psikolojisi', 'Sigmund Freud', 'Psikoloji Yayınları', 2013, 6, 8, 'Psikoloji üzerine.', 290),
('Ekonomi 101', 'John Maynard Keynes', 'Ekonomi Yayınları', 2018, 4, 9, 'Ekonomiye giriş.', 320),
('Edebiyat Tarihi', 'Orhan Pamuk', 'Edebiyat Yayınları', 2020, 7, 10, 'Edebiyatın gelişimi.', 450),
('Macera Adası', 'Jules Verne', 'Macera Yayınları', 2014, 11, 11, 'Macera dolu hikaye.', 375),
('Fantastik Dünya', 'J.R.R. Tolkien', 'Fantastik Yayınları', 2019, 5, 12, 'Fantastik roman.', 500),
('Dedektif Öyküleri', 'Agatha Christie', 'Polisiye Yayınları', 2017, 8, 13, 'Polisiye hikayeler.', 320),
('Kişisel Başarı', 'Tony Robbins', 'Kişisel Gelişim Yayınları', 2021, 14, 14, 'Motivasyon kitabı.', 280),
('Sağlıklı Yaşam', 'Dr. Mehmet Öz', 'Sağlık Yayınları', 2018, 9, 15, 'Sağlık önerileri.', 300),
('Dünya Turu', 'İsmail Yılmaz', 'Seyahat Yayınları', 2019, 6, 16, 'Seyahat rehberi.', 270),
('Dinler Tarihi', 'Karen Armstrong', 'Din Yayınları', 2015, 5, 17, 'Dinlerin tarihi.', 360),
('Spor ve Sağlık', 'Atletik Yayınları', 'Spor Kitapları', 2020, 10, 18, 'Sporla ilgili.', 220),
('Teknoloji Geleceği', 'Elon Musk', 'Teknoloji Yayınları', 2022, 7, 19, 'Teknoloji trendleri.', 310),
('Suç ve Ceza', 'Fyodor Dostoyevski', 'Can Yayınları', 2016, 9, 1, 'Rus edebiyatının önemli eserlerinden.', 671),
('Anna Karenina', 'Lev Tolstoy', 'İthaki Yayınları', 2017, 7, 1, 'Klasik Rus romanı.', 864),
('Aşk ve Gurur', 'Jane Austen', 'Edebiyat Yayınları', 2015, 12, 1, 'Klasik İngiliz romanı.', 432),
('Evrenin Karanlık Maddesi', 'Lisa Randall', 'Bilim Yayınları', 2019, 6, 2, 'Modern kozmoloji üzerine.', 352),
('Osmanlı İmparatorluğu Tarihi', 'Halil İnalcık', 'Kronik Kitap', 2014, 8, 3, 'Osmanlı tarihi detaylı anlatılır.', 580),
('Sokrates''in Savunması', 'Platon', 'Felsefe Yayınları', 2013, 10, 6, 'Felsefi diyaloglar.', 210),
('Steve Jobs', 'Walter Isaacson', 'Biyografi Yayınları', 2012, 5, 7, 'Steve Jobs''un hayatı ve kariyeri.', 656),
('Duygusal Zeka', 'Daniel Goleman', 'Psikoloji Yayınları', 2011, 7, 8, 'Duygusal zekanın önemi.', 352),
('Kapital', 'Karl Marx', 'Ekonomi Yayınları', 2010, 4, 9, 'Ekonomik teorilerin temeli.', 1152),
('Define Adası', 'Robert Louis Stevenson', 'Macera Yayınları', 2018, 11, 11, 'Macera dolu hazine arayışı.', 320),
('Kızıl Ölüm', 'Edgar Allan Poe', 'Polisiye Yayınları', 2016, 6, 13, 'Klasik polisiye hikayeleri.', 280),
('On Küçük Zenci', 'Agatha Christie', 'Polisiye Yayınları', 2015, 7, 13, 'Klasik bir polisiye romanı.', 272);


INSERT INTO uyeler (ad, soyad, giris_tarihi, telefon, email, adres) VALUES
('Ferhat', 'Urper', '2024-01-10', '05001112233', 'ferhat.urper@example.com', 'İstanbul, Türkiye'),
('Ayşe', 'Kara', '2024-02-15', '05002223344', 'ayse.kara@example.com', 'Ankara, Türkiye'),
('Mehmet', 'Demir', '2024-03-05', '05003334455', 'mehmet.demir@example.com', 'İzmir, Türkiye'),
('Elif', 'Şahin', '2024-04-20', '05004445566', 'elif.sahin@example.com', 'Bursa, Türkiye'),
('Murat', 'Çelik', '2024-05-01', '05005556677', 'murat.celik@example.com', 'Antalya, Türkiye'),
('Fatma', 'Aydın', '2024-01-18', '05006667788', 'fatma.aydin@example.com', 'Eskişehir, Türkiye'),
('Hakan', 'Öztürk', '2024-02-20', '05007778899', 'hakan.ozturk@example.com', 'Konya, Türkiye'),
('Selin', 'Kurt', '2024-03-25', '05008889900', 'selin.kurt@example.com', 'Samsun, Türkiye'),
('Bora', 'Yılmaz', '2024-04-10', '05009990011', 'bora.yilmaz@example.com', 'Trabzon, Türkiye'),
('Derya', 'Taş', '2024-05-15', '05001110022', 'derya.tas@example.com', 'Gaziantep, Türkiye'),
('Cem', 'Şen', '2024-01-12', '05002220033', 'cem.sen@example.com', 'Kayseri, Türkiye'),
('Nazlı', 'Öz', '2024-02-16', '05003330044', 'nazli.oz@example.com', 'Adana, Türkiye'),
('Onur', 'Kaya', '2024-03-22', '05004440055', 'onur.kaya@example.com', 'Mersin, Türkiye'),
('Sevgi', 'Demir', '2024-04-28', '', 'sevgi.demir@example.com', 'Malatya, Türkiye'),
('Tuna', 'Yıldız', '2024-05-05', '05006660077', 'tuna.yildiz@example.com', 'Denizli, Türkiye'),
('Ece', 'Koç', '2024-01-30', '05007770088', 'ece.koc@example.com', 'Eskişehir, Türkiye'),
('Barış', 'Gül', '2024-02-25', '05008880099', 'baris.gul@example.com', 'Elazığ, Türkiye'),
('Merve', 'Çetin', '2024-03-18', '05009991100', 'merve.cetin@example.com', 'Sivas, Türkiye'),
('Kerem', 'Polat', '2024-04-12', '05001112244', 'kerem.polat@example.com', 'Rize, Türkiye'),
('Selma', 'Uysal', '2024-05-10', '05002223355', 'selma.uysal@example.com', 'Ordu, Türkiye');

INSERT INTO personel (ad, soyad, gorev, ise_giris_tarihi, email, telefon, durum) VALUES
('Ferhat', 'Urper', 'Kütüphane Memuru', '2023-06-01', 'ferhat.urper@kutuphane.com', '05551112233', 'aktif'),
('Zeynep', 'Aydın', 'Kütüphane Memuru', '2023-07-15', 'zeynep.aydin@kutuphane.com', '05552223344', 'aktif'),
('Kemal', 'Yıldız', 'Müdür', '2022-01-01', 'kemal.yildiz@kutuphane.com', '05553334455', 'pasif'),
('Merve', 'Aksoy', 'Kütüphane Memuru', '2023-03-10', 'merve.aksoy@kutuphane.com', '05554445566', 'aktif'),
('Okan', 'Demir', 'Danışman', '2023-08-20', 'okan.demir@kutuphane.com', '05555556677', 'aktif'),
('Seda', 'Yılmaz', 'Kütüphane Memuru', '2023-09-05', 'seda.yilmaz@kutuphane.com', '05556667788', 'aktif'),
('Onur', 'Kaya', 'Memur', '2023-05-01', 'onur.kaya@kutuphane.com', '05557778899', 'pasif'),
('Burcu', 'Çelik', 'Kütüphane Memuru', '2023-06-15', 'burcu.celik@kutuphane.com', '05558889900', 'aktif'),
('Serkan', 'Şahin', 'Memur', '2023-07-22', 'serkan.sahin@kutuphane.com', '05559990011', 'aktif'),
('Dilek', 'Taş', 'Müdür Yardımcısı', '2023-08-11', 'dilek.tas@kutuphane.com', '05551110022', 'aktif'),
('Ahmet', 'Öz', 'Kütüphane Memuru', '2023-09-23', 'ahmet.oz@kutuphane.com', '05552220033', 'aktif'),
('Emre', 'Kurt', 'Danışman', '2023-10-01', 'emre.kurt@kutuphane.com', '05553330044', 'aktif'),
('Ceren', 'Gül', 'Memur', '2023-10-10', 'ceren.gul@kutuphane.com', '05554440055', 'aktif'),
('Tuna', 'Polat', 'Kütüphane Memuru', '2023-11-05', 'tuna.polat@kutuphane.com', '05555550066', 'pasif'),
('Ebru', 'Yıldız', 'Müdür', '2023-12-01', 'ebru.yildiz@kutuphane.com', '05556660077', 'aktif'),
('Serap', 'Kara', 'Kütüphane Memuru', '2023-12-15', 'serap.kara@kutuphane.com', '05557770088', 'aktif'),
('Can', 'Demir', 'Memur', '2023-11-22', 'can.demir@kutuphane.com', '05558880099', 'aktif'),
('Selin', 'Aydın', 'Danışman', '2023-11-10', 'selin.aydin@kutuphane.com', '05559991100', 'aktif'),
('Volkan', 'Taş', 'Kütüphane Memuru', '2023-10-30', 'volkan.tas@kutuphane.com', '05551112244', 'aktif'),
('Deniz', 'Yılmaz', 'Müdür Yardımcısı', '2023-12-05', 'deniz.yilmaz@kutuphane.com', '05552223355', 'aktif');


INSERT INTO kitap_hareketleri (kitap_id, uye_id, personel_id, islem_tarihi, islem_tipi, aciklama) VALUES
(1, 1, 1, '2024-05-01', 'Odunc', 'Kitap ödünç verildi'),
(2, 2, 2, '2024-05-02', 'Odunc', 'Üye tarafından alındı'),
(3, 3, 3, '2024-05-03', 'Odunc', 'Ödünç işlem yapıldı'),
(4, 4, 4, '2024-05-04', 'Odunc', 'Kitap teslim edildi'),
(5, 5, 5, '2024-05-05', 'Odunc', 'Kitap ödünç alındı'),
(6, 6, 6, '2024-05-06', 'Odunc', 'Üye teslim aldı'),
(7, 7, 7, '2024-05-07', 'Odunc', 'Kitap ödünç verildi'),
(8, 8, 8, '2024-05-08', 'Iade', 'Kitap iade edildi'),
(9, 9, 9, '2024-05-09', 'Iade', 'Üye kitap teslim etti'),
(10, 10, 10, '2024-05-10', 'Odunc', 'Kitap alındı'),
(11, 11, 11, '2024-05-11', 'Odunc', 'Ödünç işlemi gerçekleşti'),
(12, 12, 12, '2024-05-12', 'Iade', 'Kitap iadesi yapıldı'),
(13, 13, 13, '2024-05-13', 'Odunc', 'Üye kitap aldı'),
(14, 14, 14, '2024-05-14', 'Iade', 'Kitap teslimi yapıldı'),
(15, 15, 15, '2024-05-15', 'Odunc', 'Kitap ödünç verildi'),
(16, 16, 16, '2024-05-16', 'Odunc', 'Kitap teslim alındı'),
(17, 17, 17, '2024-05-17', 'Iade', 'Kitap iade edildi'),
(18, 18, 18, '2024-05-18', 'Iade', 'Üye kitap teslim etti'),
(19, 19, 19, '2024-05-19', 'Odunc', 'Kitap ödünç verildi'),
(20, 20, 20, '2024-05-20', 'Odunc', 'Kitap alındı'),
(1, 10, 5, '2024-06-01', 'Odunc', 'Başka üye aynı kitabı ödünç aldı'),
(2, 8, 6, '2024-06-02', 'Odunc', 'Başka üye aynı kitabı aldı'),
(3, 8, 7, '2024-06-03', 'Odunc', 'Aynı kitaba başka üye ödünç verdi'),
(4, 12, 8, '2024-06-04', 'Iade', 'Kitap ödünç işlemi gerçekleşti'),
(5, 13, 9, '2024-06-05', 'Odunc', 'Başka üye ödünç aldı'),
(6, 10, 10, '2024-06-06', 'Odunc', 'Kitap başka üyeye verildi'),
(7, 13, 11, '2024-06-07', 'Odunc', 'Başka üye ödünç işlemi yaptı'),
(8, 20, 12, '2024-06-08', 'Odunc', 'Üye kitabı ödünç aldı'),
(9, 15, 13, '2024-06-09', 'Odunc', 'Kitap ödünç verildi'),
(10, 15, 14, '2024-06-10', 'Odunc', 'Başka üye kitap aldı');


-- SELECT 1: Kitap ve kategori bilgilerini getiren sorgu
SELECT k.kitap_adi, ka.kategori_adi, k.yazar, k.stok_sayisi
FROM kitaplar k
JOIN kategoriler ka ON k.kategori_id = ka.kategori_id
ORDER BY ka.kategori_adi, k.kitap_adi;

-- SELECT 2: Ödünç verilen kitap hareketlerini üye ve personel bilgileriyle listele 
SELECT kh.islem_tarihi, kh.islem_tipi, u.ad AS uye_ad, u.soyad AS uye_soyad, p.ad AS personel_ad, p.soyad AS personel_soyad, k.kitap_adi
FROM kitap_hareketleri kh
JOIN uyeler u ON kh.uye_id = u.uye_id
JOIN personel p ON kh.personel_id = p.personel_id
JOIN kitaplar k ON kh.kitap_id = k.kitap_id
WHERE kh.islem_tipi = 'Odunc';

-- SELECT 3: Stok sayısı 5'ten az olan kitaplar 
SELECT kitap_adi, yazar, stok_sayisi
FROM kitaplar
WHERE stok_sayisi < 5;

-- SELECT 4: Tüm personellerin bilgilerini görevlerine göre sıralayarak getiren sorgu 
SELECT ad, soyad, gorev, durum
FROM personel
ORDER BY gorev, ad

-- SELECT 5: En yeni üye kayıtlarını getirn sorgu
SELECT ad, soyad, giris_tarihi
FROM uyeler
ORDER BY giris_tarihi DESC
LIMIT 5;

-- SELECT 6: Kategorilere göre toplam kitap sayfa sayısı 
SELECT ka.kategori_adi, SUM(k.sayfa_sayisi) AS toplam_sayfa
FROM kitaplar k
JOIN kategoriler ka ON k.kategori_id = ka.kategori_id
GROUP BY ka.kategori_adi
ORDER BY toplam_sayfa DESC;

--UPDATE sorgular
-- UPDATE 1: Bir kitap stoktan ödünç verilince stok azalt 
UPDATE kitaplar
SET stok_sayisi = stok_sayisi - 1
WHERE kitap_id = 1 AND stok_sayisi > 0;

-- UPDATE 2: Bir personelin durumunu pasif yap  email koşulu ile
UPDATE personel
SET durum = 'pasif'
WHERE email = 'ferhat.urper@kutuphane.com';


--DELETE sorgular
-- DELETE 1: 2023'ten önce işe giren pasif personelleri sil
DELETE FROM personel
WHERE durum = 'pasif' AND ise_giris_tarihi < '2023-01-01';

-- DELETE 2: Telefon bilgisi olmayan üyeleri sil 
DELETE FROM uyeler
WHERE telefon IS NULL OR telefon = '';


--GROUP BY + HAVING sorgular
-- GROUP BY + HAVING: Her kitaptan kaç kez ödünç verildi ve 1'den fazla ödünç verilenleri getir
SELECT kh.kitap_id, k.kitap_adi, COUNT(*) AS odunc_sayisi
FROM kitap_hareketleri kh
JOIN kitaplar k ON kh.kitap_id = k.kitap_id
WHERE kh.islem_tipi = 'Odunc'
GROUP BY kh.kitap_id, k.kitap_adi
HAVING COUNT(*) > 0
ORDER BY odunc_sayisi DESC;


