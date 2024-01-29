using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace AdisyonTakip.MasaIslemleri
{
    public partial class Adisyonform : Form
    {
        public Adisyonform()
        {
            InitializeComponent();
        }


        public string masa_kodu = "";
        public string masa_Adi = "";
        public string bolum_kodu = "";
        public string bolum_adi = "";
        public bool rezerve = false;
        public int garson = 0;
        private void Adisyonform_Load(object sender, EventArgs e)
        {
            this.Text = "BÖLÜM KODU = " + bolum_kodu + " BOLUM_ADI = " + bolum_adi + " MASA KODU = " + masa_kodu + " MASA ADI = " + masa_Adi;
            garson = glb.aktif_kullanici_kodu;

            stokGetir();
            masaAdisyonGetir(masa_kodu);

            ozetBilgiler();

        }





        void ozetBilgiler()
        {

            DataTable dt = MyClass.Model.Adisyon.adisyonToplam(masa_kodu);

            lbl_bolum_adi.Text = bolum_adi;
            lbl_masa_adi.Text = masa_Adi;


            lbl_sip_adet.Text = dt.Rows[0]["siparis_edilen_urun_adet"].ToString();
            lbl_toplam_tutar.Text = dt.Rows[0]["satis_tutar"].ToString() + " ₺";


            DataTable dtGarson = MyClass.Model.Adisyon.adisyonGarsonlar(masa_kodu);
            string garsonlar = "";
            for (int i = 0; i < dtGarson.Rows.Count; i++)
            {
                garsonlar += dtGarson.Rows[i]["garson"].ToString() + Environment.NewLine;
            }
            lbl_garsonlar.Text = garsonlar; ;

        }



        void stokGetir()
        {
            DataTable dt2 = MyClass.Model.Stoklar.stokGetir();
            flp.Controls.Clear();

            for (int j = 0; j < dt2.Rows.Count; j++)
            {
                Button btn = new Button();
                btn.Height = 100;
                btn.Width = 100;
                btn.Name = dt2.Rows[j]["Kod"].ToString();
                object img = dt2.Rows[j]["Görsel"].ToString();
                if (string.IsNullOrWhiteSpace(img.ToString()) || string.IsNullOrEmpty(img.ToString()))
                {
                    btn.Text = dt2.Rows[j]["Ürün"].ToString();
                }
                else
                {
                    btn.BackgroundImageLayout = ImageLayout.Stretch;
                    btn.BackgroundImage = Image.FromFile(img.ToString());
                }
                btn.Click += Btn_Click;
                flp.Controls.Add(btn);
            }
        }
        double Adet = 0;

        private void Btn_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;

            if (!chk_tek_tek.Checked)
            {
                AdetGir fr = new AdetGir();
                fr.ShowDialog();
                Adet = fr.adet;
            }
            //Adet = 1;

            adisyonYaz(Adet, btn.Name);
            ozetBilgiler();
        }


        void adisyonYaz(double adet, string urun_kod)
        {
            MyClass.Model.Adisyon.Masa_Adisyonlari ad = new MyClass.Model.Adisyon.Masa_Adisyonlari()
            {
                adi_garson_kod = garson,
                adi_masa_kod = masa_kodu,
                adi_urun_adet = adet,
                adi_urun_kod = urun_kod,
            };
            MyClass.Model.Adisyon.Ekle(ad);

            masaAdisyonGetir(masa_kodu);
        }


        void masaAdisyonGetir(string masa_kodu)
        {
            dataGridView1.DataSource = MyClass.Model.Adisyon.urunListe(masa_kodu);
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

        }


        private void ürünEkleToolStripMenuItem_Click(object sender, EventArgs e)
        {
            new StokIslemleri.Stoklar().ShowDialog();
            stokGetir();
        }

        private void btn_yenile_Click(object sender, EventArgs e)
        {
            masaAdisyonGetir(masa_kodu);
        }

        private void btn_hesap_al_Click(object sender, EventArgs e)
        {
            MasaIslemleri.HesapAl fr = new HesapAl();
            fr.lbl_toplam_tutar.Text = lbl_toplam_tutar.Text;
            fr.lbl_masa_kod.Text = masa_kodu;
            fr.lbl_masa_adi.Text = lbl_masa_adi.Text;
            fr.ShowDialog();

            if (fr.basarili > 0) Close();
        }

        private void splitContainer2_Panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void btn_garson_ekle_degistir_Click(object sender, EventArgs e)
        {
            MasaIslemleri.GarsonSec fr = new MasaIslemleri.GarsonSec(); fr.ShowDialog();
            garson = fr.secilen;



        }
    }
}
