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
    public partial class StokTakibi : Sistem.Master
    {
        public StokTakibi()
        {
            InitializeComponent();
        }

        private void StokTakibi_Load(object sender, EventArgs e)
        {
            gridUpdate();
        }

        void gridUpdate()
        {
            dataGridView1.DataSource = MyClass.Model.Stoklar.SelectCount();
            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;

        }
    }
}
