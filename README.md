# AdisyonTakip
Discord sunucumda canlı olarak yayın yaparak geliştirdiğim projedir. 


Bu proje basit anlamda cafeler için adisyon takip uygulamasıdır. Canlı yayın kayıtlarına aşağıdaki youtube izleme listesinden ulaşabilirsiniz. 
https://www.youtube.com/watch?v=G5thTH6AmZQ&list=PLj4D8-rnEvlZxQJ8-qoGEVyxL6POz7iiR
Bu listede ilk 4 video yeni başlayanlar için önerdiğim videolardır. Unutmayın ki videolar projenin son halini yansıtmıyor yani bu proje şuan bitmiştir.

NOT: Lütfen yüklediğim projeleri, bilgisayarınıza nasıl kuracağınızı bana sormadan önce bu videoyu izlediğinizden emin olun.
https://youtu.be/mosSkPlxDos


Proje neler içeriyor?

Kullanıcı Girişi: Varsayılan kullanıcı girişi 0 şifre 0'dır. (Kullanıcı ekleme ve yetkilendirme işlemleri yapılmamıştır.)
Ürün Ekle: Üst menüden Dosya'nın altından ulabilirsiniz. Standart stok ekleme işlemi. Min ve Max stok ayarı ile birlikte stok eksiye inebilir mi ayarları vardır ve çalışmaktadır.
Masa Ekle: Üst menüden Dosya'nın altından ulabilirsiniz. Kafedeki masaları temsilen eklenen masalar. 
Bölüm Ekle: Üst menüden Dosya'nın altından ulabilirsiniz. Kafedeki bölümleri temsilen eklenen bölümler. Daha net olması için örneğin giriş kat, ön bahçe, 2.kat, teras vs.

Alınan Adisyonlar: Üst menüden Yönetim'in altından ulabilirsiniz. Burada alınan tüm adisyonlar listelenir.
Stok Adetleri:  Üst menüden Yönetim'in altından ulabilirsiniz. Burada alınan mevcut stok listesi ve adetleri listelenir.

Ana ekranda sağ kısımda, minimum stok adedi altına düşen stoklar listelenir.

Eklenen bölümler ana forma sekmeler halinde dinamik olarak eklenir. Bölümlere eklenen masalar, dinamik olarak kendi bölümlerine eklenir. Bir masaya tıklandığında Adisyon ekranı açılır. Sol tarafta menü ürünleri yer alır. Ürün ekleme sırasında görsel seçilirse burada görsel görünür. Eğer görsel seçilmezse ürün adı görünür. Tek Tek Ekle seçimi işaretlenirse adet sorma ekranı çıkmadan her tıklama da 1 adet adisyona eklenir. Aksi takdirde adet sorulan bir ekran gelir.

Ekranın ortasında masa bilgisi görünür. Burada dikkat edilecek şeylerden birisi de masa ile ilgilenen garsonlardır. Garsonlar etiketinin sağındaki Garson Değiştir butonuna tıklanınca garson listesi açılır. Buradan bir garson seçilirse, o andan itibaren adisyon ekranı kapanana yada garspn tekrar değiştirilene kadar adisyona eklenen ürünler seçilen garsonun adı ile adisyona eklenir. Buradaki mantık, siparişi kimin aldığını takip etmektir.
NOT: Burada kötüye kullanımı için RFID okuyucu bir cihaz ile garsonlara verilen kartların okutulması ile engellenebilir.
Eklenen ürünler sağdaki listeye düşer. 
Hesap al butonu ile hesap alınır, adisyon kapatılır ve masaya eklenen ürünler stoktan otomatik düşülür.


## Lisans
[MIT](https://choosealicense.com/licenses/mit/)
