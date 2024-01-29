using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace AdisyonTakip.StokIslemleri
{
    public partial class StokGirisCikis : Sistem.Master
    {
        public string islem = "";
        public StokGirisCikis()
        {
            InitializeComponent();
        }

        private void StokGirisCikis_Load(object sender, EventArgs e)
        {
            gridGuncelle();
            temizle();

            DataTable dt = MyClass.Model.Stoklar.stokGetir();
            cmb_Stok_liste.DataSource = dt;
            cmb_Stok_liste.DisplayMember = "Ürün";
            cmb_Stok_liste.ValueMember = "Kod";

        }
        void gridGuncelle()
        {
            dataGridView1.DataSource = MyClass.Model.Stok_Hareket.Select(" and sth_tip = '" + islem + "' ");
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

        }

        private void btn_temizle_Click(object sender, EventArgs e)
        {
            temizle();
        }

        void temizle()
        {
            txt_RECno.Text = "0";
            txt_adet.Text = "0";
            cmb_Stok_liste.Text = "";
            txt_fiyat.Text = "0";
            cmb_islem.Text = islem;
        }

        private void btn_kaydet_Click(object sender, EventArgs e)
        {
            MyClass.Model.Stok_Hareket.Stok_Hareketleri stok = new MyClass.Model.Stok_Hareket.Stok_Hareketleri()
            {
                sth_adet = Convert.ToDouble(txt_adet.Text),
                sth_fiyat = Convert.ToDouble(txt_fiyat.Text),
                sth_kod = cmb_Stok_liste.SelectedValue.ToString(),
                sth_RECno = Convert.ToInt32(txt_RECno.Text),
                sth_tip = islem
            };
            MyClass.Model.Stok_Hareket.Save(stok);

            temizle();
            gridGuncelle();
        }

        private void btn_sil_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Bu hareketi silmek istediğinizden emin misiniz?",
                "Dikkat",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question) == DialogResult.Yes)
            {
                MyClass.Model.Stok_Hareket.Delete(Convert.ToInt32(txt_RECno.Text));
                temizle();
                gridGuncelle();
            }
            else
            {
                MessageBox.Show("İşlem Yapılmadı");
            }

        }
        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];
                txt_RECno.Text = row.Cells["KayıtNo"].Value.ToString();

                cmb_Stok_liste.SelectedValue = row.Cells["Stok Kodu"].Value.ToString();

                txt_adet.Text = row.Cells["Adet"].Value.ToString();
                txt_fiyat.Text = row.Cells["Fiyat"].Value.ToString();

            }

        }
    }
}
