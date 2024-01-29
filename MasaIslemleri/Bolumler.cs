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
    public partial class Bolumler : Form
    {
        public Bolumler()
        {
            InitializeComponent();
        }
        private void Bolumler_Load(object sender, EventArgs e)
        {
            gridGuncelle();
            temizle();
        }
        private void btn_kaydet_Click(object sender, EventArgs e)
        {
            bool kontrol = glb.isNumeric(txt_limit.Text);
            if (kontrol)
            {
                MyClass.Model.Bolumler.Bolum_Tanimlari bolum = new MyClass.Model.Bolumler.Bolum_Tanimlari()
                {
                    bol_adi = txt_ad.Text,
                    bol_kodu = txt_kod.Text,
                    bol_masa_limiti = Convert.ToInt16(txt_limit.Text),
                    bol_RECno = Convert.ToInt16(txt_RECno.Text),
                    bol_rezerve = Convert.ToInt16(chk_rezerve.Checked),
                    bol_aktif = Convert.ToInt16(chk_aktif.Checked),
                };
                txt_RECno.Text = MyClass.Model.Bolumler.Kaydet(bolum).ToString();
                if (glb.kayit_basarili)
                {
                    temizle();
                    gridGuncelle();
                }
            }
            else
            {
                MessageBox.Show("Limit alanı sayısal bir değer olmak zorundadır.", "Limit Alanı Hatası", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }

        }
        private void btn_temizle_Click(object sender, EventArgs e)
        {
            temizle();
        }
        void temizle()
        {
            txt_RECno.Text = "0";
            txt_ad.Text = "";
            txt_kod.Text = "";
            txt_limit.Text = "0";
            chk_rezerve.Checked = false;
            chk_aktif.Checked = true;
            txt_kod.Enabled = true;

        }
        void gridGuncelle()
        {
            dataGridView1.DataSource = MyClass.Model.Bolumler.bolumleriGetir();
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

        }
        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];
                txt_RECno.Text = row.Cells["KayıtNo"].Value.ToString();
                txt_ad.Text = row.Cells["Adı"].Value.ToString();
                txt_kod.Text = row.Cells["Kodu"].Value.ToString();
                txt_kod.Enabled = false;
                txt_limit.Text = row.Cells["Masa Limit"].Value.ToString();

                chk_aktif.Checked = Convert.ToBoolean(row.Cells["Durum"].Value.ToString());
                chk_rezerve.Checked = Convert.ToBoolean(row.Cells["Rezervasyon"].Value.ToString());
            }
        }
        private void btn_sil_Click(object sender, EventArgs e)
        {
            MyClass.Model.Bolumler.Sil(Convert.ToInt16(txt_RECno.Text));
            gridGuncelle();
            temizle();
        }
        private void aktfToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MyClass.Model.Bolumler.bolumRezerveEt(RECno, 1);
            gridGuncelle();
        }
        private void pasifToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MyClass.Model.Bolumler.bolumRezerveEt(RECno, 0);
            gridGuncelle();
        }
        private void aktifToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MyClass.Model.Bolumler.bolumDurumDegistir(RECno, 1);
            gridGuncelle();
        }
        private void pasifToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            MyClass.Model.Bolumler.bolumDurumDegistir(RECno, 0);
            gridGuncelle();
        }
        int RECno = 0;
        string BolumKodu = "";
        private void dataGridView1_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
            {
                var hti = dataGridView1.HitTest(e.X, e.Y);
                if (hti.RowIndex >= 0)
                {
                    DataGridViewRow row = this.dataGridView1.Rows[hti.RowIndex];
                    RECno = Convert.ToInt16(row.Cells["KayıtNo"].Value);
                    BolumKodu = Convert.ToString(row.Cells["Kodu"].Value);

                }
            }
        }

        private void bölümeMasaEkleToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (MyClass.Model.Masalar.bolumMasaKontrol(BolumKodu))
            {
                Masalar frm = new Masalar();
                frm.bolum_kodu = BolumKodu;
                frm.ShowDialog();
                gridGuncelle();
            }
            else
            {
                MessageBox.Show("Bu bölüme daha fazla masa ekleyemezsiniz.");
            }





        }
    }
}
