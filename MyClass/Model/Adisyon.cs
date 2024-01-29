using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace AdisyonTakip.MyClass.Model
{
    public class Adisyon
    {

        public class Masa_Adisyonlari
        {
            public int adi_RECno = 0;
            public string adi_masa_kod = "";
            public int adi_garson_kod = 0;
            public string adi_urun_kod = "";
            public double adi_urun_adet = 0;
        }


        public static void Ekle(Masa_Adisyonlari ad)
        {
            glb.sql.Command("INSERT INTO [dbo].[Masa_Adisyonlari]    "
                      + "\r          ( [adi_masa_kod]                    "
                      + "\r           ,[adi_garson_kod]                  "
                      + "\r           ,[adi_urun_kod]                    "
                      + "\r           ,[adi_urun_adet]                   "
                      + "\r           ,[adi_kayit_tarih]                  "
                      + "\r           ,[adi_kaydeden]                    "                     
                      + "\r           ,[adi_adisyon_sirano]                    "
                      + "\r           ,[adi_hesap_alindi]                    "
                      + "\r           ,[adi_hesap_alan]                    "
                      + "\r )                  "
                      + "\r     VALUES                                   "
                      + "\r           (  '" + ad.adi_masa_kod + "'   "
                      + "\r           ,   " + ad.adi_garson_kod + "           "
                      + "\r           ,  '" + ad.adi_urun_kod + "'   "
                      + "\r           ,   " + ad.adi_urun_adet + "  "
                      + "\r           ,   getdate() "
                      + "\r           ,   " + glb.aktif_kullanici_kodu + "  "
                      + "\r           ,   0 "
                      + "\r           ,   0 "
                      + "\r           ,   0 "
                      + "\r  )");
        }

        public static DataTable urunListe(string masa_kodu)
        {
            return glb.sql.Table("SELECT "
                  + "  sum([adi_urun_adet]) as Adet  "
                  + ", (select sto_adi from Stok_Tanimlari where sto_kodu = adi_urun_kod ) as [Ürün] "
                  + ", (select kul_adi from Kullanici_Tanimlari where kul_kod = adi_garson_kod ) as [Garson] "
                  + " FROM [dbo].[Masa_Adisyonlari] where adi_masa_kod = '" + masa_kodu + "' and adi_hesap_alindi = 0 "
                  + " group by [adi_urun_kod], adi_garson_kod ");
        }


        public static DataTable adisyonToplam(string masa_kodu)
        {
            return glb.sql.Table("SELECT * from fn_MasaAdisyonToplam('" + masa_kodu + "')");
        }


        public static DataTable adisyonGarsonlar(string masa_kodu)
        {
            return glb.sql.Table(" select    "
                 + "    (select kul_adi from Kullanici_Tanimlari where kul_kod = adi_garson_kod) as garson "
                 + "    from Masa_Adisyonlari "
                 + "    where adi_masa_kod = '" + masa_kodu + "' and adi_hesap_alindi = 0 "
                 + "    group by adi_garson_kod");
        }

    }
}
