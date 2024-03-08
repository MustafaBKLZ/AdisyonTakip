using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace AdisyonTakip.MyClass.Model
{
    public class Stok_Hareket
    {

        public class Stok_Hareketleri
        {
            public int sth_RECno = 0;      //       int
            public string sth_kod = "";      //       nvarchar(50)
            public string sth_tip = "";      //       nvarchar(50)
            public double sth_adet = 0;      //       float
            public double sth_fiyat = 0;      //       float
            public int sth_kaydeden = 0;      //       int
            public string sth_kayit_tarih = "";      //       datetime
            public int sth_guncelleyen = 0;      //       int
            public string sth_guncelleme_tarih = "";      //       datetime

        }




        private static void Create(Stok_Hareketleri sth)
        {

            glb.sql.Command(""
                 + "\r       INSERT INTO [dbo].[Stok_Hareketleri]         "
                 + "\r                  (         "
                 + "\r                   [sth_kod]         "
                 + "\r                  ,[sth_tip]         "
                 + "\r                  ,[sth_adet]         "
                 + "\r                  ,[sth_fiyat]         "
                 + "\r                  ,[sth_kaydeden]         "
                 + "\r                  ,[sth_kayit_tarih] )         "
                 + "\r            VALUES         "
                 + "\r                  (         "
                 + "\r                   '" + sth.sth_kod + "'         "
                 + "\r                  ,'" + sth.sth_tip + "'         "
                 + "\r                  , " + sth.sth_adet.ToString().Replace(",", ".") + "         "
                 + "\r                  , " + sth.sth_fiyat.ToString().Replace(",", ".") + "        "
                 + "\r                  ," + glb.aktif_kullanici_kodu + "      "
                 + "\r                  ,getdate()   )     "
                 );


        }

        private static void Update(Stok_Hareketleri sth)
        {
            glb.sql.Command(""
            + "\r       UPDATE [dbo].[Stok_Hareketleri]    SET     "
            + "\r                   [sth_adet]              = " + sth.sth_adet.ToString().Replace(",", ".") + "         "
            + "\r                  ,[sth_fiyat]             = " + sth.sth_fiyat.ToString().Replace(",", ".") + "        "
            + "\r                  ,[sth_guncelleyen]       = " + glb.aktif_kullanici_kodu + "          "
            + "\r                  ,[sth_guncelleme_tarih]  = getdate()       "
            + "\r            where sth_RECno = " + sth.sth_RECno + "         "

            );
        }


        public static void Save(Stok_Hareketleri sth)
        {
            double stok_adet = MyClass.Model.Stoklar.stokAdet(sth.sth_kod);
            double stok_min = MyClass.Model.Stoklar.stokMinMiktar(sth.sth_kod);
            double stok_max = MyClass.Model.Stoklar.stokMaxMiktar(sth.sth_kod);
            int stok_eksi_olabilir = MyClass.Model.Stoklar.stokAdetEksiOlabilir(sth.sth_kod);

            if (sth.sth_tip == "Çıkış")
            {
                if (stok_adet - sth.sth_adet < stok_min) MessageBox.Show("Stok minimum adedin altına düşmüştür.", "Bilgi");

                if (stok_adet - sth.sth_adet < 0 & stok_eksi_olabilir == 0)
                {
                    MessageBox.Show("Bu çıkış işlemini, stoğun eksi değere düşmesine izin verilmediği için gerçekleştiremezsiniz. Stok eksiye düşebilme ayarını değiştirmeyi deneyebilirsiniz.");
                }
                if (stok_adet - sth.sth_adet < 0 & stok_eksi_olabilir == 1)
                {
                    _Save(sth);
                }
            }
            if (sth.sth_tip == "Giriş")
            {
                if (stok_adet + sth.sth_adet > stok_max)
                {
                    MessageBox.Show("Bu giriş, stoğun izin verilen maksimum adedini aştığı için işlemi gerçekleştiremezsiniz. Stok maksimum adedi arttırmayı deneyebilirsiniz.");
                }
                else
                {
                    _Save(sth);
                }
            }
        }

        private static void _Save(Stok_Hareketleri sth)
        {
            if (sth.sth_RECno == 0)
                Create(sth);
            else
                Update(sth);
        }


        public static DataTable Select(string where)
        {
            return glb.sql.Table("SELECT [sth_RECno] as KayıtNo "
             + "     ,[sth_kod] as [Stok Kodu] "
             + "     , (Select sto_adi from Stok_Tanimlari where sto_kodu = [sth_kod]) as [Stok Adı] "
             + "     ,[sth_tip] as [İşlem] "
             + "     ,[sth_adet] as [Adet] "
             + "     ,[sth_fiyat] as [Fiyat] "


             + "     ,(select sto_min from stok_tanimlari where sto_kodu = sth_kod) as [Min Adet] "
             + "     ,(select sto_max from stok_tanimlari where sto_kodu = sth_kod) as [Max Adet] "
             + "     ,(select sto_eksi_olabilir from stok_tanimlari where sto_kodu = sth_kod) as [Stok Eksi Olabilir] "


             + "     ,[sth_kaydeden] as [Kaydeden Kod] "
             + "     ,(select kul_adi from Kullanici_Tanimlari where kul_kod =  [sth_kaydeden]) as [Kaydeden] "
             + "     ,[sth_kayit_tarih] as [Kayıt Tarihi] "
             + "     ,[sth_guncelleyen] as [Güncelleyen Kodu] "
             + "     ,(select kul_adi from Kullanici_Tanimlari where kul_kod = [sth_guncelleyen]) as [Güncelleyen] "
             + "     ,[sth_guncelleme_tarih] as [Güncelleme Tarihi] "
             + " FROM[dbo].[Stok_Hareketleri] where 1=1 " + where);
        }
    
        public static void Delete(int sth_RECno)
        {
            glb.sql.Command("DELETE from [dbo].[Stok_Hareketleri]  where sth_RECno = " + sth_RECno + " ");
        }






    }
}
