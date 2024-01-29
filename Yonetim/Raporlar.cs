using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace AdisyonTakip.Yonetim
{
    public partial class Raporlar : Form
    {
        public Raporlar()
        {
            InitializeComponent();
        }

        private void Raporlar_Load(object sender, EventArgs e)
        {
            gridGuncelle();
        }


        void gridGuncelle()
        {
            dataGridView1.DataSource = glb.sql.Table("select * from dbo.fn_AlinanHesaplar(0) ");
        }

        private void btn_Yenile_Click(object sender, EventArgs e)
        {
            gridGuncelle();
        }
    }
}
