using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace AdisyonTakip.MyClass.Model
{
    public class Stoklar
    {
        public class Stok_Tanimlari
        {
            public int sto_RECno = 0;
            public string sto_kodu = "";
            public string sto_adi = "";
            public string sto_birim = "";
            public double sto_satis_fiyat = 0;
            public double sto_alis_fiyat = 0;
            public int sto_aktif = 0;
            public string sto_gorsel = "";


            public double sto_min = 0;
            public double sto_max = 0;

            public int sto_eksi_olabilir = 0;

        }
        public static DataTable stokGetir()
        {
            return glb.sql.Table("select sto_kodu as Kod , sto_adi as Ürün ,[sto_gorsel]  as [Görsel]  from Stok_Tanimlari where sto_aktif = 1");
        }
        public static double stokMaxMiktar(string sto_kodu)
        {
            return Convert.ToDouble(glb.sql.Command("select isnull(sto_max,0) from Stok_Tanimlari where sto_kodu = '" + sto_kodu + "'"));
        }
        public static double stokMinMiktar(string sto_kodu)
        {
            return Convert.ToDouble(glb.sql.Command("select isnull(sto_min,0) from Stok_Tanimlari where sto_kodu = '" + sto_kodu + "'"));
        }
        public static double stokAdet(string sto_kodu)
        {
            return Convert.ToDouble(glb.sql.Command("select dbo.fn_stokAdediGetir('" + sto_kodu + "') "));
        }
        public static int stokAdetEksiOlabilir(string sto_kodu)
        {
            return Convert.ToInt16(glb.sql.Command("select isnull(sto_eksi_olabilir,0) from Stok_Tanimlari where sto_kodu = '" + sto_kodu + "' "));
        }





        public static DataTable stokGetirListe()
        {
            return glb.sql.Table("select "
                      + "     sto_RECno as [KayıtNo] "
                      + "    ,[sto_kodu]  as Kod"
                      + "    ,[sto_adi]   as Ad             "
                      + "    ,[sto_birim] as Birim             "
                      + "    ,[sto_alis_fiyat]   as [Alış Fiyat]      "
                      + "    ,[sto_satis_fiyat]  as [Satış Fiyat]      " 
                      + "    ,isnull([sto_min],0)  as [Minimum Adet]      "
                      + "    ,isnull([sto_max],0)  as [Maksimum Adet]      "
                      + "    ,[sto_aktif]  as Durum            "
                      + "    ,[sto_gorsel]  as [Görsel]            "
                      + "    ,isnull([sto_eksi_olabilir],0)  as [Stok Eksi Olabilir Mi?]            "

                      + " from Stok_Tanimlari");
        }


        public static DataTable SelectCount(string where="")
        {
            return glb.sql.Table("select * from [dbo].[fn_StokAdetleri]('') " + where);
        }
        public static DataTable SelectCountCritic()
        {
            return glb.sql.Table("select [Adı], [Mevcut Adet] as Adet, [Min Stok] as [Min], [Durumu] from[dbo].[fn_StokAdetleri] ('') where Durumu = 'Uyarı!'");
        }




        public static int Kaydet(Stok_Tanimlari stok)
        {
            int sonuc = 0;

            if (stok.sto_kodu.Trim().Length > 0 && stok.sto_adi.Trim().Length > 0 && stok.sto_alis_fiyat > 0 && stok.sto_satis_fiyat > 0 && stok.sto_birim.Trim().Length > 0)
            {
                if (stok.sto_RECno == 0)
                {
                    int kontrol_kod = Convert.ToInt16(glb.sql.Command("select count(*) from [dbo].[Stok_Tanimlari] where sto_kodu = '" + stok.sto_kodu.Trim() + "' "));
                    if (kontrol_kod == 0)
                    {
                        glb.sql.Command(" INSERT INTO [dbo].[Stok_Tanimlari] "
                                        + "          ([sto_kodu]                 "
                                        + "          ,[sto_adi]                  "
                                        + "          ,[sto_birim]"
                                        + "          ,[sto_satis_fiyat]"
                                        + "          ,[sto_alis_fiyat]"
                                        + "          ,[sto_aktif]"
                                        + "          ,[sto_kayit_tarih]"
                                        + "          ,[sto_kaydeden]"
                                        + "          ,[sto_gorsel]"
                                        + "          ,[sto_min]"
                                        + "          ,[sto_max]"
                                        + "          ,[sto_eksi_olabilir]"
                                        + ")         "
                                        + "    VALUES                            "
                                        + "          ('" + stok.sto_kodu.Trim() + "' "
                                        + "          ,'" + stok.sto_adi.Trim() + "'  "
                                        + "          ,'" + stok.sto_birim.Trim() + "'   "
                                        + "          , " + stok.sto_satis_fiyat + "   "
                                        + "          , " + stok.sto_alis_fiyat + "   "
                                        + "          , " + stok.sto_aktif + "   "
                                        + "          , getdate()  "
                                        + "          , " + glb.aktif_kullanici_kodu + "   "
                                        + "          , '" + stok.sto_gorsel + "'   "
                                        + "          , " + stok.sto_min + "   "
                                        + "          , " + stok.sto_max + "   "
                                        + "          , " + stok.sto_eksi_olabilir + "   "


                                        + ") ");
                        sonuc = Convert.ToInt16(glb.sql.Command("select SCOPE_IDENTITY() "));
                    }
                    else
                    {
                        glb.kayit_basarili = false;
                        MessageBox.Show(stok.sto_kodu + " stok kodunu daha önce kullandız. Lütfen yeni bir stok kodu kullanınız."
                            , "Benzesiz Alanlar Hatası"
                            , MessageBoxButtons.OK
                            , MessageBoxIcon.Warning);
                    }
                }
                else
                {
                    glb.sql.Command("UPDATE [dbo].[Stok_Tanimlari]  set "
                                        + "           [sto_adi]           = '" + stok.sto_adi.Trim() + "'  "
                                        + "          ,[sto_birim]         = '" + stok.sto_birim.Trim() + "'   "
                                        + "          ,[sto_satis_fiyat]   =  " + stok.sto_satis_fiyat + "   "
                                        + "          ,[sto_alis_fiyat]     =  " + stok.sto_alis_fiyat + "   "
                                        + "          ,[sto_aktif]         =  " + stok.sto_aktif + "   "
                                        + "          ,[sto_guncelleme_tarih]   =  getdate()  "
                                        + "          ,[sto_guncelleyen]      =  " + glb.aktif_kullanici_kodu + "   "
                                        + "          ,[sto_gorsel]         = '" + stok.sto_gorsel + "'   "

                                        + "          ,[sto_min]     =  " + stok.sto_min + "   "
                                        + "          ,[sto_max]     =  " + stok.sto_max + "   "
                                        + "          ,[sto_eksi_olabilir]     =  " + stok.sto_eksi_olabilir + "   "




                             + "        where   sto_RECno =   " + stok.sto_RECno + " "
                             + "  ");
                    sonuc = stok.sto_RECno;
                }
            }
            else
            {
                glb.kayit_basarili = false;
                MessageBox.Show("Yıldızlı alanları boş bırakamazsınız."
                            , "Bölüm Masa Limit Hatası"
                            , MessageBoxButtons.OK
                            , MessageBoxIcon.Warning);
            }
            return sonuc;
        }


        /// <summary>
        /// Stok kaydının aktif kolonunu false yaparak ekranlarda görünmesini engeller
        /// </summary>
        /// <param name="sto_RECno">Silinecek stoğun RECNo bilgisi</param>
        public static void Sil(int sto_RECno, string stok_kodu)
        {
            //glb.sql.Command("INSERT INTO [Stok_Tanimlari_Silinenler] "
            //              + "     ([sto_kodu]                         "
            //              + "     ,[sto_adi]                          "
            //              + "     ,[sto_birim]                        "
            //              + "     ,[sto_satis_fiyat]                  "
            //              + "     ,[sto_alis_fiyat]                   "
            //              + "     ,[sto_aktif]                        "
            //              + "     ,[sto_kayit_tarih]                  "
            //              + "     ,[sto_kaydeden]                     "
            //              + "     ,[sto_guncelleme_tarih]             "
            //              + "     ,[sto_guncelleyen])                 "
            //              + "  SELECT                                 "
            //              + "     [sto_kodu]                          "
            //              + "    ,[sto_adi]                           "
            //              + "    ,[sto_birim]                         "
            //              + "    ,[sto_satis_fiyat]                   "
            //              + "    ,[sto_alis_fiyat]                    "
            //              + "    ,[sto_aktif]                         "
            //              + "    ,[sto_kayit_tarih]                   "
            //              + "    ,[sto_kaydeden]                      "
            //              + "    ,getdate()             "
            //              + "    ," + glb.aktif_kullanici_kodu + "                  "
            //              + " FROM [dbo].[Stok_Tanimlari] where [sto_RECno] = " + sto_RECno);
            //glb.sql.Command("DELETE FROM [Stok_Tanimlari] where [sto_RECno] = " + sto_RECno);


            int kontrol = Convert.ToInt16(glb.sql.Command("select count(*) from [dbo].[Masa_Adisyonlari] where adi_urun_kod = '" + stok_kodu + "' "));
            if (kontrol > 0)
            {
                MessageBox.Show("Kullanılan bir stoğu silemezsiniz. ");
            }
            else
            {
                glb.sql.Command("UPDATE [Stok_Tanimlari] SET " +
                             "  sto_aktif = 0" +
                             ", sto_guncelleme_tarih = getdate()" +
                             ", sto_guncelleyen = " + glb.aktif_kullanici_kodu + " " +
                             " where [sto_RECno] = " + sto_RECno);
            }

        }



        /// <summary>
        /// Bölümü Aktif veya Pasif etmek için kullanılır.
        /// </summary>
        /// <param name="recno">Bölüm RECno'su</param>
        /// <param name="durum">0 = Pasif || 1 = Aktif </param>
        public static void DurumDegistir(int recno, int durum)
        {
            glb.sql.Command("UPDATE [dbo].[Stok_Tanimlari] set [sto_aktif] = " + durum
                        + " where   sto_RECno =   " + recno + "   ");
        }
    }
}
