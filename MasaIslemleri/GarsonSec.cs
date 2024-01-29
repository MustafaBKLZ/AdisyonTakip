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
    public partial class GarsonSec : Sistem.Master
    {
        public GarsonSec()
        {
            InitializeComponent();
        }

        private void GarsonSec_Load(object sender, EventArgs e)
        {

            DataTable dt = MyClass.Model.Kullanici.KullanicilariGetir();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                RadioButton checkBox = new RadioButton();
                checkBox.AutoSize = true;
                checkBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
                checkBox.Location = new System.Drawing.Point(39, 39);
                checkBox.Name = dt.Rows[i]["Kodu"].ToString();
                checkBox.Size = new System.Drawing.Size(106, 24);
                checkBox.TabIndex = i;
                checkBox.Text = dt.Rows[i]["Adı"].ToString();
                checkBox.CheckedChanged += CheckBox_CheckedChanged;
                flowLayoutPanel1.Controls.Add(checkBox);
            }




        }

        public int secilen = 0;

        private void CheckBox_CheckedChanged(object sender, EventArgs e)
        {
            RadioButton chk = sender as RadioButton;

            if (chk.Checked)
                secilen = Convert.ToInt16(chk.Name);
            if (!chk.Checked)
                secilen = Convert.ToInt16(chk.Name);



        }

        private void btn_kaydet_Click(object sender, EventArgs e)
        {
            Close();

        }


    }
}
