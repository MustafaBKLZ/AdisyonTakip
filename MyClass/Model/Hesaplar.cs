using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AdisyonTakip.MyClass.Model
{
    public class Hesaplar
    {

        public class Alinan_Hesaplar
        {
            public int hsp_RECno = 0;
            public int hsp_adisyon_sirano = 0;
            public string hsp_adisyon_tarih = "";
            public double hsp_toplam_tutar = 0;
            public int hsp_adisyonu_kapatan = 0;
        }



        public static int Kaydet(Alinan_Hesaplar hesap)
        {
            int sonuc = 0;
            glb.sql.Command(""
                        + "\r       INSERT INTO [dbo].[Alinan_Hesaplar]         "
                        + "\r                  ([hsp_adisyon_sirano]         "
                        + "\r                  ,[hsp_adisyon_tarih]         "
                        + "\r                  ,[hsp_toplam_tutar]         "
                        + "\r                  ,[hsp_adisyonu_kapatan])         "
                        + "\r            VALUES         "
                        + "\r                  ( " + hesap.hsp_adisyon_sirano + "        "
                        + "\r                  , " + hesap.hsp_adisyon_tarih + "        "
                        + "\r                  , " + hesap.hsp_toplam_tutar + "       "
                        + "\r                  , " + glb.aktif_kullanici_kodu + " )         ");

            sonuc = Convert.ToInt16(glb.sql.Command("select SCOPE_IDENTITY() "));




            return sonuc;
        }

    }
}
