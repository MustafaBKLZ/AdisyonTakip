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
    public partial class AdetGir : Form
    {
        public AdetGir()
        {
            InitializeComponent();
        }
        public double adet = 0;
        private void AdetGir_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            adet = Convert.ToDouble(textBox1.Text);
            Close();
        }
    }
}
