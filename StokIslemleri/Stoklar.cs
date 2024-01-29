using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace AdisyonTakip.StokIslemleri
{
    public partial class Stoklar : Sistem.Master
    {
        public Stoklar()
        {
            InitializeComponent();
        }

        private void Stoklar_Load(object sender, EventArgs e)
        {
            gridGuncelle();
            temizle();
        }


        void gridGuncelle()
        {
            dataGridView1.DataSource = MyClass.Model.Stoklar.stokGetirListe();
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

        }

        private void btn_temizle_Click(object sender, EventArgs e)
        {
            temizle();
        }

        void temizle()
        {
            txt_RECno.Text = "0";
            txt_a_fiyat.Text = "0";
            txt_stok_adi.Text = "";
            txt_stok_kodu.Text = "";
            txt_s_fiyat.Text = "0";
            chk_aktif.Checked = true;
            txt_stok_kodu.Enabled = true;
            pic_stok_gorsel.Image = null;
        }

        private void btn_kaydet_Click(object sender, EventArgs e)
        {
            int eksi = chk_stok_eksi_izin.CheckState == CheckState.Checked ? 1 : 0;

            MyClass.Model.Stoklar.Stok_Tanimlari stok = new MyClass.Model.Stoklar.Stok_Tanimlari()
            {
                sto_adi = txt_stok_adi.Text,
                sto_aktif = Convert.ToInt16(chk_aktif.Checked),
                sto_alis_fiyat = Convert.ToDouble(txt_a_fiyat.Text),
                sto_birim = cmb_birim.Text,
                sto_kodu = txt_stok_kodu.Text,
                sto_satis_fiyat = Convert.ToDouble(txt_s_fiyat.Text),
                sto_RECno = Convert.ToInt32(txt_RECno.Text),
                sto_eksi_olabilir = eksi,
                sto_max = Convert.ToDouble(txt_max_adet.Text),
                sto_min = Convert.ToDouble(txt_min_adet.Text),
                    
                sto_gorsel = dest_path,
            };
            MyClass.Model.Stoklar.Kaydet(stok);


            try
            {
                File.Copy(path, dest_path);
            }
            catch (ArgumentException)
            {
            }

            temizle();
            gridGuncelle();

        }

        private void btn_sil_Click(object sender, EventArgs e)
        {
            MyClass.Model.Stoklar.Sil(Convert.ToInt32(txt_RECno.Text), txt_stok_kodu.Text);
        }


        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];
                txt_RECno.Text = row.Cells["KayıtNo"].Value.ToString();

                txt_stok_adi.Text = row.Cells["Ad"].Value.ToString();
                txt_stok_kodu.Text = row.Cells["Kod"].Value.ToString();
                txt_stok_kodu.Enabled = false;

                txt_a_fiyat.Text = row.Cells["Alış Fiyat"].Value.ToString();
                txt_s_fiyat.Text = row.Cells["Satış Fiyat"].Value.ToString();
                cmb_birim.Text = row.Cells["Birim"].Value.ToString();

                chk_aktif.Checked = Convert.ToBoolean(row.Cells["Durum"].Value.ToString());


                txt_max_adet.Text = row.Cells["Maksimum Adet"].Value.ToString();
                txt_min_adet.Text = row.Cells["Minimum Adet"].Value.ToString();
                chk_stok_eksi_izin.Checked = Convert.ToBoolean(row.Cells["Stok Eksi Olabilir Mi?"].Value.ToString());




                try
                {
                    pic_stok_gorsel.Image = Image.FromFile(row.Cells["Görsel"].Value.ToString());
                }
                catch (ArgumentException)
                {

                    pic_stok_gorsel.Image = null;
                }

            }

        }


        int RECno = 0;
        private void dataGridView1_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
            {
                var hti = dataGridView1.HitTest(e.X, e.Y);
                if (hti.RowIndex >= 0)
                {
                    DataGridViewRow row = this.dataGridView1.Rows[hti.RowIndex];
                    RECno = Convert.ToInt16(row.Cells["KayıtNo"].Value);

                }
            }
        }

        private void aktifToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MyClass.Model.Stoklar.DurumDegistir(RECno, 1);
        }

        private void pasifToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            MyClass.Model.Stoklar.DurumDegistir(RECno, 0);
        }
        string dest_path = "";
        string path = "";
        private void btn_resim_Sec_Click(object sender, EventArgs e)
        {
            OpenFileDialog op = new OpenFileDialog()
            {
                Title = "Stok Resmi Seçin",
                Multiselect = false,
            };
            if (op.ShowDialog() == DialogResult.OK)
            {
                path = op.FileName;
                string filename = op.SafeFileName;
                dest_path = glb.AppPath + "\\Stok_Gorselleri\\SK_" + txt_stok_kodu.Text + "_" + filename;
                try
                {
                }
                catch (System.IO.DirectoryNotFoundException ex)
                {

                    MessageBox.Show("Yolun bir parçası bulunamadı");
                }

            }

        }
    }
}
