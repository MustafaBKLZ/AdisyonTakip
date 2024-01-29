using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace AdisyonTakip.MyClass.Model
{
    public class Bolumler
    {
        public class Bolum_Tanimlari
        {
            public int bol_RECno = 0;
            public string bol_kodu = "";
            public string bol_adi = "";
            public int bol_masa_limiti = 0;
            public int bol_rezerve = 0;
            public int bol_aktif = 0;

        }
        public static int Kaydet(Bolum_Tanimlari bolum)
        {
            int sonuc = 0;

            if (bolum.bol_kodu.Trim().Length > 0 && bolum.bol_adi.Trim().Length > 0 && bolum.bol_masa_limiti > 0)
            {
                if (bolum.bol_RECno == 0)
                {
                    int kontrol_kod = Convert.ToInt16(glb.sql.Command("select count(*) from [dbo].[Bolum_Tanimlari] where bol_kodu = '" + bolum.bol_kodu + "' "));
                    if (kontrol_kod == 0)
                    {
                        glb.sql.Command(" INSERT INTO [dbo].[Bolum_Tanimlari] "
                                        + "          ([bol_kodu]                 "
                                        + "          ,[bol_adi]                  "
                                        + "          ,[bol_masa_limiti]"
                                        + "          ,[bol_rezerve]"
                                        + "          ,[bol_aktif]"
                                        + "          ,[bol_kayit_tarih]"
                                        + "          ,[bol_kaydeden]"
                                        + ")         "
                                        + "    VALUES                            "
                                        + "          ('" + bolum.bol_kodu + "' "
                                        + "          ,'" + bolum.bol_adi + "'  "
                                        + "          , " + bolum.bol_masa_limiti + "   "
                                        + "          , " + bolum.bol_rezerve + "   "
                                        + "          , " + bolum.bol_aktif + "   "
                                        + "          , getdate()  "
                                        + "          , " + glb.aktif_kullanici_kodu + "   "
                                        + ") ");
                        sonuc = Convert.ToInt16(glb.sql.Command("select SCOPE_IDENTITY() "));
                    }
                    else
                    {
                        glb.kayit_basarili = false;
                        MessageBox.Show(bolum.bol_kodu + " masa kodunu daha önce kullandız. Lütfen yeni bir masa kodu kullanınız."
                            , "Benzesiz Alanlar Hatası"
                            , MessageBoxButtons.OK
                            , MessageBoxIcon.Warning);
                    }
                }
                else
                {
                    glb.sql.Command("UPDATE [dbo].[Bolum_Tanimlari]  set "
                             + "           [bol_adi]     =    '" + bolum.bol_adi + "'            "
                             + "          ,[bol_masa_limiti]   =    " + bolum.bol_masa_limiti + "     "
                             + "          ,[bol_rezerve]   =    " + bolum.bol_rezerve + "     "
                             + "          ,[bol_aktif]   =    " + bolum.bol_aktif + "     "
                             + "          ,[bol_guncelleme_tarih]   = getdate()    "
                             + "          ,[bol_guncelleyen]   =  " + glb.aktif_kullanici_kodu + "     "
                             + "        where   bol_RECno =   " + bolum.bol_RECno + " "
                             + "  ");
                    sonuc = bolum.bol_RECno;
                }

            }
            else
            {
                glb.kayit_basarili = false;
                MessageBox.Show("Yıldızlı alanları boş bırakamazsınız ve masa limiti sıfırdan yüksek olmalıdır."
                            , "Bölüm Masa Limit Hatası"
                            , MessageBoxButtons.OK
                            , MessageBoxIcon.Warning);
            }
            return sonuc;
        }

        public static void Sil(int recno)
        {
            glb.sql.Command("DELETE from [dbo].[Bolum_Tanimlari]  where  bol_RECno =  " + recno + " " + "  ");
        }


        /// <summary>
        /// Bölümü rezerver etmek ve rezervasyonu iptal etmek için kullanılır.
        /// </summary>
        /// <param name="recno"> Bölüm RECno'su</param>
        /// <param name="durum"> 0 = Rezerve Değil || 1 = Rezerve </param>
        public static void bolumRezerveEt(int recno, int durum)
        {
            glb.sql.Command("UPDATE [dbo].[Bolum_Tanimlari] set [bol_rezerve] = " + durum
                        + " where   bol_RECno =   " + recno + "   ");
        }

        /// <summary>
        /// Bölümü Aktif veya Pasif etmek için kullanılır.
        /// </summary>
        /// <param name="recno">Bölüm RECno'su</param>
        /// <param name="durum">0 = Pasif || 1 = Aktif </param>
        public static void bolumDurumDegistir(int recno, int durum)
        {
            glb.sql.Command("UPDATE [dbo].[Bolum_Tanimlari] set [bol_aktif] = " + durum
                        + " where   bol_RECno =   " + recno + "   ");
        }


        public static DataTable bolumleriGetir()
        {
            return glb.sql.Table("Select " +
                "  bol_RECno as KayıtNo " +
                ", bol_kodu as Kodu " +
                ", bol_adi as Adı " +
                ", bol_masa_limiti as [Masa Limit]" +
                ", (select count(*) from Masa_Tanimlari where masa_bolum_kodu = bol_kodu) as [Masa Adedi]" +
                ", bol_rezerve as Rezervasyon" +
                ", bol_aktif as Durum" +
                " from Bolum_Tanimlari ");
        }

        public static DataTable bolumleriGetirCombo()
        {
            return glb.sql.Table("Select " +
                "  bol_kodu as Kodu " +
                ", bol_adi as Adı " +
                " from Bolum_Tanimlari where bol_aktif = 1");
        }
    }
}
