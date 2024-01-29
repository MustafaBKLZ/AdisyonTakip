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
    public partial class Masalar : Form
    {
        public string bolum_kodu = "";
        public Masalar()
        {
            InitializeComponent();
        }

        private void MasaListe_Load(object sender, EventArgs e)
        {
            gridGuncelle();
            bolumleriGetir();
            temizle();


            if (bolum_kodu.Trim().Length > 0)
            {
                cmb_bolumler.SelectedValue = bolum_kodu;
            }
        }

        private void btn_kaydet_Click(object sender, EventArgs e)
        {
            MyClass.Model.Masalar.Masa_Tanimlari masa = new MyClass.Model.Masalar.Masa_Tanimlari()
            {
                masa_adi = txt_masa_adi.Text,
                masa_bolum_kodu = cmb_bolumler.SelectedValue.ToString(),
                masa_kodu = txt_masa_kodu.Text,
                masa_RECno = Convert.ToInt32(txt_RECno.Text),
                masa_rezerve = Convert.ToInt16(chk_rezerve.Checked),
                masa_aktif = Convert.ToInt16(chk_aktif.Checked),
            };
            txt_RECno.Text = MyClass.Model.Masalar.Kaydet(masa).ToString();
            if (glb.kayit_basarili)
            {
                temizle();
                gridGuncelle();
            }
        }

        void temizle()
        {
            txt_masa_adi.Text = "";
            cmb_bolumler.Text = "";
            txt_masa_kodu.Text = "";
            txt_RECno.Text = "0";
            chk_rezerve.Checked = false;
            chk_aktif.Checked = true;
            txt_masa_kodu.Enabled = true;
        }

        void gridGuncelle()
        {
            dataGridView1.DataSource = MyClass.Model.Masalar.masalarGetir();
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

        }

        void bolumleriGetir()
        {
            cmb_bolumler.DataSource = MyClass.Model.Bolumler.bolumleriGetirCombo();
            cmb_bolumler.DisplayMember = "Adı";
            cmb_bolumler.ValueMember = "Kodu";
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];
                txt_RECno.Text = row.Cells["KayıtNo"].Value.ToString();
                txt_masa_adi.Text = row.Cells["Adı"].Value.ToString();
                txt_masa_kodu.Text = row.Cells["Kodu"].Value.ToString();
                txt_masa_kodu.Enabled = false;
                chk_rezerve.Checked = Convert.ToBoolean(row.Cells["Rezervasyon"].Value);
                cmb_bolumler.SelectedValue = row.Cells["Bölüm Kodu"].Value.ToString();

                chk_aktif.Checked = Convert.ToBoolean(row.Cells["Durum"].Value.ToString());
                chk_rezerve.Checked = Convert.ToBoolean(row.Cells["Rezervasyon"].Value.ToString());
            }
        }

        private void aktfToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MyClass.Model.Masalar.masaRezerveEt(RECno, 1);
            gridGuncelle();
        }

        private void pasifToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MyClass.Model.Masalar.masaRezerveEt(RECno, 0);
            gridGuncelle();

        }

        private void aktifToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MyClass.Model.Masalar.masaDurumDegistir(RECno, 1);
            gridGuncelle();
        }

        private void pasifToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            MyClass.Model.Masalar.masaDurumDegistir(RECno, 0);
            gridGuncelle();
        }

        int RECno = 0;
        private void dataGridView1_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
            {
                var hti = dataGridView1.HitTest(e.X, e.Y);
                DataGridViewRow row = this.dataGridView1.Rows[hti.RowIndex];
                RECno = Convert.ToInt16(row.Cells["KayıtNo"].Value);
            }
        }

        private void btn_temizle_Click(object sender, EventArgs e)
        {
            temizle();
        }

        private void btn_sil_Click(object sender, EventArgs e)
        {
            MyClass.Model.Bolumler.Sil(Convert.ToInt16(txt_RECno.Text));
            gridGuncelle();
            temizle();
        }

        private void cmb_bolumler_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmb_bolumler.SelectedValue.ToString() != "System.Data.DataRowView")
            {
                if (MyClass.Model.Masalar.bolumMasaKontrol(cmb_bolumler.SelectedValue.ToString()))
                {
                    btn_kaydet.Enabled = true;
                    lbl_max_limit_uyari.Visible = false;
                }
                else
                {
                    btn_kaydet.Enabled = false;
                    lbl_max_limit_uyari.Visible = true;
                }
            }
        }



    }
}
