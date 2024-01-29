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
    public partial class HesapAl : Sistem.Master
    {
        public HesapAl()
        {
            InitializeComponent();
        }

        public int basarili = 0;

        private void HesapAl_Load(object sender, EventArgs e)
        {

        }

        private void btn_masayi_kapat_Click(object sender, EventArgs e)
        {
            int sira_no = Convert.ToInt32(glb.sql.Command("exec sp_MasaHesapAl  '" + lbl_masa_kod.Text + "' , " + glb.aktif_kullanici_kodu + "  "));

            if (sira_no > 0)
            {
                basarili = 1;
                MessageBox.Show("Hesap başarı ile alındı", "OK", MessageBoxButtons.OK, MessageBoxIcon.Information);
                Close();
            }
            else
            {
                MessageBox.Show("Hesap alınırken hata oluştu", "HATA!", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

        }
    }
}
