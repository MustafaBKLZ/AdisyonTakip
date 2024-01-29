using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace AdisyonTakip.MyClass.Model
{
    public class Kullanici
    {

        public class Kullanici_Tanimlari
        {
            public int kul_RECno = 0;
            public int kul_kod = 0;
            public string kul_adi = "";
            public string kul_psw = "";
            public string kul_kayit_tarihi = "";
            public int kul_kaydeden = 0;
            public string kul_guncelleme_tarih = "";
            public int kul_guncelleyen = 0;
        }



        public static int Kaydet(Kullanici_Tanimlari kullanici)
        {
            int sonuc = 0;

            if (kullanici.kul_kod > 0 && kullanici.kul_adi.Trim().Length > 0 && kullanici.kul_psw.Trim().Length > 0)
            {
                if (kullanici.kul_RECno == 0)
                {
                    int kontrol_kod = Convert.ToInt16(glb.sql.Command("select count(*) from [dbo].[Kullanici_Tanimlari] where bol_kodu = '" + kullanici.kul_kod + "' "));
                    if (kontrol_kod == 0)
                    {
                        glb.sql.Command(""
                        + "\r       INSERT INTO [dbo].[Kullanici_Tanimlari]         "
                        + "\r                  ([kul_kod]         "
                        + "\r                  ,[kul_adi]         "
                        + "\r                  ,[kul_psw]         "
                        + "\r                  ,[kul_kayit_tarihi]         "
                        + "\r                  ,[kul_kaydeden]         "
                        + "\r                  ,[kul_guncelleme_tarih]         "
                        + "\r                  ,[kul_guncelleyen]  )       "
                        + "\r            VALUES         "
                        + "\r                  (  " + kullanici.kul_kod + "        "
                        + "\r                  , '" + kullanici.kul_adi + "'        "
                        + "\r                  , '" + kullanici.kul_psw + "'       "
                        + "\r                  , getdate()      "
                        + "\r                  , " + glb.aktif_kullanici_kodu + " "
                        + "\r                  , getdate()      "
                        + "\r                  , " + glb.aktif_kullanici_kodu + " "
                        + ")         ");

                        sonuc = Convert.ToInt16(glb.sql.Command("select SCOPE_IDENTITY() "));
                    }
                    else
                    {
                        MessageBox.Show("Bu kullanıcı kodu daha önce kullanılmış");
                    }
                }
                else
                {
                    glb.sql.Command(""
                        + "\r       UPDATE [dbo].[Kullanici_Tanimlari]       SET  "
                        + "\r                   [kul_adi]        = '" + kullanici.kul_adi + "'        "
                        + "\r                  ,[kul_psw]         ='" + kullanici.kul_psw + "'       "
                        + "\r                  ,[kul_guncelleme_tarih]        =getdate()      "
                        + "\r                  ,[kul_guncelleyen]  =" + glb.aktif_kullanici_kodu + " "
                        + "\r            where      kul_kod = " + kullanici.kul_kod + "    "
                         + "");
                }
            }
            else
            {
                MessageBox.Show("Zorunlu alanları boş bırakılamaz");
            }
            return sonuc;
        }

        public static DataTable KullanicilariGetir()
        {
            return glb.sql.Table("Select " +
                "  kul_RECno as KayıtNo " +
                ", kul_kod as Kodu " +
                ", kul_adi as Adı " +
                " from Kullanici_Tanimlari ");
        }
    }
}
