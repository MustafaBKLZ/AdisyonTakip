using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace AdisyonTakip.MyClass.Model
{
    public class Masalar
    {
        public class Masa_Tanimlari
        {
            public int masa_RECno = 0;
            public string masa_kodu = "";
            public string masa_adi = "";
            public string masa_bolum_kodu = "";
            public int masa_rezerve = 0;
            public int masa_aktif = 0;
        }

        public static int Kaydet(Masa_Tanimlari masa)
        {
            int sonuc = 0;

            if (masa.masa_kodu.Trim().Length > 0 && masa.masa_adi.Trim().Length > 0 && masa.masa_bolum_kodu.Trim().Length > 0)
            {
                if (bolumMasaKontrol(masa.masa_bolum_kodu))
                {
                    if (masa.masa_RECno == 0)
                    {
                        int kontrol_kod = Convert.ToInt16(glb.sql.Command("select count(*) from [dbo].[Masa_Tanimlari] where masa_kodu = '" + masa.masa_kodu + "' "));
                        if (kontrol_kod == 0)
                        {
                            glb.sql.Command(" INSERT INTO [dbo].[Masa_Tanimlari] "
                              + "         ([masa_kodu]                           "
                              + "         ,[masa_adi]                            "
                              + "         ,[masa_bolum_kodu]                     "
                              + "         ,[masa_rezerve] "
                              + "         ,[masa_aktif] "
                              + "         ,[masa_kayit_tarih] "
                              + "         ,[masa_kaydeden] "
                              + "  )                            "
                              + "   VALUES                                     "
                              + "         ( '" + masa.masa_kodu + "'           "
                              + "         , '" + masa.masa_adi + "'            "
                              + "         , '" + masa.masa_bolum_kodu + "'     "
                              + "         ,  " + masa.masa_rezerve + "         "
                              + "         ,  " + masa.masa_aktif + "           "
                              + "         ,  getdate()          "
                              + "         ,  " + glb.aktif_kullanici_kodu + "           "
                              + " ) ");

                            sonuc = Convert.ToInt16(glb.sql.Command("select SCOPE_IDENTITY() "));

                        }
                        else
                        {
                            glb.kayit_basarili = false;
                            MessageBox.Show(masa.masa_kodu + " masa kodunu daha önce kullandız. Lütfen yeni bir masa kodu kullanınız."
                                , "Benzesiz Alanlar Hatası"
                                , MessageBoxButtons.OK
                                , MessageBoxIcon.Warning);
                        }
                    }
                    else
                    {
                        glb.sql.Command("UPDATE [dbo].[Masa_Tanimlari] "
                              + "      SET [masa_kodu] = '" + masa.masa_kodu + "' "
                              + "         ,[masa_adi] = '" + masa.masa_adi + "' "
                              + "         ,[masa_bolum_kodu] = '" + masa.masa_bolum_kodu + "' "
                              + "         ,[masa_rezerve] = " + masa.masa_rezerve + " "
                              + "         ,[masa_guncelleme_tarih] = getdate() "
                              + "         ,[masa_guncelleyen] = " + glb.aktif_kullanici_kodu + " "
                              + "   where masa_RECno = " + masa.masa_RECno + "  ");
                        sonuc = masa.masa_RECno;
                    }

                }
                else
                {
                    glb.kayit_basarili = false;
                    MessageBox.Show("Bölüm için verilen limiti aştığınız için bu masayı kayıt edemezsiniz."
                                           , "Bölüm Masa Limit Hatası"
                                           , MessageBoxButtons.OK
                                           , MessageBoxIcon.Warning);
                }
            }
            else
            {
                glb.kayit_basarili = false;
                MessageBox.Show("Yıldızlı alanları boş bırakamazsınız"
                                  , "Bölüm Masa Limit Hatası"
                                  , MessageBoxButtons.OK
                                  , MessageBoxIcon.Warning);
            }


            return sonuc;
        }

        public static void Sil(int recno)
        {
            glb.sql.Command("DELETE from [dbo].[Masa_Tanimlari]  where  masa_RECno =  " + recno + " " + "  ");
        }


        public static bool bolumMasaKontrol(string masa_bolum_kodu)
        {
            int bolum_masa_limit = Convert.ToInt16(glb.sql.Command("select bol_masa_limiti from [dbo].[Bolum_Tanimlari] where bol_kodu = '" + masa_bolum_kodu + "' "));
            int bolum_masa_adet = Convert.ToInt16(glb.sql.Command("select count(*) from [dbo].[Masa_Tanimlari] where masa_bolum_kodu = '" + masa_bolum_kodu + "' "));
            return bolum_masa_adet + 1 <= bolum_masa_limit;

        }



        public static DataTable masalarGetir()
        {
            return glb.sql.Table("select " +
                    " masa_RECno as KayıtNo" +
                    ", masa_kodu as Kodu" +
                    ", masa_adi as Adı" +
                    ", masa_bolum_kodu as [Bölüm Kodu] " +
                    ", (select bol_adi from Bolum_Tanimlari where bol_kodu = masa_bolum_kodu)  as [Bölüm Adı] " +
                    ", masa_rezerve as Rezervasyon " +
                    ", masa_aktif as Durum " +
                    " from Masa_Tanimlari ");
        }


        /// <summary>
        /// Masayı rezerver etmek ve rezervasyonu iptal etmek için kullanılır.
        /// </summary>
        /// <param name="recno"> Masa RECno'su</param>
        /// <param name="durum"> 0 = Rezerve Değil || 1 = Rezerve </param>
        public static void masaRezerveEt(int recno, int durum)
        {
            glb.sql.Command("UPDATE [dbo].[Masa_Tanimlari] set "
                + "          [masa_rezerve] = " + durum
                + "         ,[masa_guncelleme_tarih] = getdate() "
                + "         ,[masa_guncelleyen] = " + glb.aktif_kullanici_kodu + " "
                + " where   masa_RECno =   " + recno + "   ");
        }


        /// <summary>
        /// Masayı Aktif veya Pasif etmek için kullanılır.
        /// </summary>
        /// <param name="recno">Masa RECno'su</param>
        /// <param name="durum">0 = Pasif || 1 = Aktif </param>
        public static void masaDurumDegistir(int recno, int durum)
        {
            glb.sql.Command("UPDATE [dbo].[Masa_Tanimlari] set "
                + "          [masa_aktif] = " + durum
                + "         ,[masa_guncelleme_tarih] = getdate() "
                + "         ,[masa_guncelleyen] = " + glb.aktif_kullanici_kodu + " "
                + " where   masa_RECno =   " + recno + "   ");
        }


    }
}
