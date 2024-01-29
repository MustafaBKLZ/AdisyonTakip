using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace AdisyonTakip
{
    public partial class Anaform : Form
    {
        public Anaform()
        {
            InitializeComponent();
        }
        private void Anaform_Load(object sender, EventArgs e)
        {
            BolumleriGetir();
            tsl_kullanici.Text = "Kod: " + glb.aktif_kullanici_kodu + " -> Adı: " + glb.aktif_kullanici_adi;
            timer1.Enabled = true;
            timer1.Start();
            gridUpdate();
        }
        void BolumleriGetir()
        {
            tabControl1.Controls.Clear();
            DataTable dt = glb.sql.Table("select * from Bolum_Tanimlari where bol_aktif = 1 ");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TabPage tabPage1 = new TabPage();
                tabPage1.Name = dt.Rows[i]["bol_kodu"].ToString();
                tabPage1.Text = dt.Rows[i]["bol_adi"].ToString();

                FlowLayoutPanel flp = new FlowLayoutPanel();
                flp.Name = tabPage1.Name + "_" + i.ToString();
                flp.Dock = DockStyle.Fill;

                DataTable dt2 = glb.sql.Table("select * from Masa_Tanimlari where masa_aktif = 1 and masa_bolum_kodu = '" + tabPage1.Name + "' ");

                double siparis_adet = 0;
                double toplam_tutar = 0;
                for (int j = 0; j < dt2.Rows.Count; j++)
                {
                    Button btn = new Button();
                    string masa_kod = dt2.Rows[j]["masa_kodu"].ToString();

                    DataTable dt3 = glb.sql.Table("select * from fn_MasaButonOzet('" + masa_kod + "') ");
                    if (dt3.Rows.Count > 0)
                    {
                        siparis_adet = Convert.ToDouble(dt3.Rows[0]["siparis_adet"]);
                        toplam_tutar = Convert.ToDouble(dt3.Rows[0]["toplam_tutar"]);
                    }

                    btn.Height = 150;
                    btn.Width = 100;
                    btn.Font = new System.Drawing.Font("Segoe UI", 9F);
                    btn.Name = tabPage1.Name + "_" + masa_kod;
                    btn.Text =
                        dt2.Rows[j]["masa_adi"].ToString() + "_"
                        + Environment.NewLine
                        + "S. Adet: " + siparis_adet.ToString()
                        + Environment.NewLine
                        + "T. Tutar: " + toplam_tutar.ToString() + " TL";

                    int rezervasyon = Convert.ToInt16(dt2.Rows[j]["masa_rezerve"]);
                    btn.BackColor = Color.LimeGreen;
                    if (rezervasyon == 1) btn.BackColor = Color.LightSkyBlue;
                    btn.Tag = tabPage1.Text;
                    btn.Click += Btn_Click;
                    flp.Controls.Add(btn);
                }
                tabPage1.Controls.Add(flp);
                tabControl1.Controls.Add(tabPage1);
            }
        }
        private void Btn_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            //Masalar.Adisyonform fr = new Masalar.Adisyonform()
            //{
            //    masa_Adi = btn.Text,
            //    masa_kodu = btn.Name.Split('_')[1],
            //    bolum_kodu = btn.Name.Split('_')[0],
            //    bolum_adi = btn.Tag.ToString(),
            //    rezerve = btn.BackColor == Color.LightSkyBlue ? true : false,
            //};
            //fr.ShowDialog();


            MasaIslemleri.Adisyonform fr = new MasaIslemleri.Adisyonform();
            fr.masa_Adi = btn.Text.Split('_')[0];
            fr.masa_kodu = btn.Name.Split('_')[1];
            fr.bolum_kodu = btn.Name.Split('_')[0];
            fr.bolum_adi = btn.Tag.ToString();
            fr.rezerve = btn.BackColor == Color.LightSkyBlue ? true : false;
            fr.ShowDialog();
            BolumleriGetir();
            gridUpdate();

        }
        private void bölümEkleToolStripMenuItem_Click(object sender, EventArgs e)
        {
            new MasaIslemleri.Bolumler().ShowDialog();
            BolumleriGetir();
            gridUpdate();
        }
        private void masaEkleToolStripMenuItem_Click(object sender, EventArgs e)
        {
            new MasaIslemleri.Masalar().ShowDialog();
            BolumleriGetir();
            gridUpdate();
        }
        private void toolStripContainer1_TopToolStripPanel_Click(object sender, EventArgs e)
        {
        }
        private void timer1_Tick(object sender, EventArgs e)
        {
            tsl_tarih.Text = DateTime.Now.ToString();
        }
        private void label1_Click(object sender, EventArgs e)
        {

        }
        private void ürünEkleToolStripMenuItem_Click(object sender, EventArgs e)
        {
            StokIslemleri.Stoklar fr = new StokIslemleri.Stoklar();
            fr.ShowDialog();
            gridUpdate();
        }
        private void alınanHesaplarToolStripMenuItem_Click(object sender, EventArgs e)
        {
            new Yonetim.Raporlar().ShowDialog(); 
            gridUpdate();
        }
        private void stokGirişiToolStripMenuItem_Click(object sender, EventArgs e)
        {
            StokIslemleri.StokGirisCikis fr = new StokIslemleri.StokGirisCikis();
            fr.islem = "Giriş";
            fr.ShowDialog();
            gridUpdate();
        }
        private void stokÇıkışıToolStripMenuItem_Click(object sender, EventArgs e)
        {
            StokIslemleri.StokGirisCikis fr = new StokIslemleri.StokGirisCikis()
            {
                islem = "Çıkış",
            };
            fr.ShowDialog();
            gridUpdate();
        }
        private void stokAdetlerToolStripMenuItem_Click(object sender, EventArgs e)
        {
            StokIslemleri.StokTakibi fr = new StokIslemleri.StokTakibi();
            fr.ShowDialog();
            gridUpdate();
        }




        void gridUpdate()
        {
            dataGridView1.DataSource = MyClass.Model.Stoklar.SelectCountCritic();
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
        }
        private void timer_min_stok_Tick(object sender, EventArgs e)
        {
            gridUpdate();
        }
        private void btn_stok_uyarilari_Click(object sender, EventArgs e)
        {
            gridUpdate();
        }
    }
}
