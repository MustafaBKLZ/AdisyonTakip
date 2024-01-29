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
    public partial class Login : Form
    {
        public Login()
        {
            InitializeComponent();
        }
        private void Login_Load(object sender, EventArgs e)
        {

            kulAdGetir();
        }

        private void btn_giris_Click(object sender, EventArgs e)
        {
            if (txt_kulkod.Text.Trim().Length > 0)
            {
                //int kontrol = Convert.ToInt16(glb.sql.Command("select count(*) from " +
                //              "Kullanici_Tanimlari where kul_kod = " + txt_kulkod.Text + " and kul_psw = '" + txt_psw.Text + "' "));

                DataTable dt = glb.sql.Table("select kul_adi from Kullanici_Tanimlari where kul_kod = " + txt_kulkod.Text + " and kul_psw = '" + txt_psw.Text + "' ");

                //if (kontrol > 0)

                if (dt.Rows.Count > 0)
                {
                    //glb.aktif_kullanici_adi = lbl_kul_Adi.Text;
                    glb.aktif_kullanici_adi = dt.Rows[0]["kul_adi"].ToString();
                    glb.aktif_kullanici_kodu = Convert.ToInt16(txt_kulkod.Text);

                    Anaform fr = new Anaform();
                    fr.Show();
                    this.Hide();
                }
                else
                {
                    MessageBox.Show("Bilgiler hatalı.");
                }
            }
            else
            {
                MessageBox.Show("Kullanıcı kodu girilmelidir.");
            }
        }

        private void btn_cikis_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void txt_kulkod_TextChanged(object sender, EventArgs e)
        {
            kulAdGetir();
        }
        void kulAdGetir()
        {
            if (txt_kulkod.Text.Trim().Length > 0)
            {
                try
                {
                    lbl_kul_Adi.Text = glb.sql.Command("select kul_adi from Kullanici_Tanimlari where kul_kod = " + txt_kulkod.Text + " ").ToString();
                }
                catch
                {
                    lbl_kul_Adi.Text = "";
                }
            }
        }
    }
}
