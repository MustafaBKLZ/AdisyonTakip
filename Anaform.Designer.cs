
namespace AdisyonTakip
{
    partial class Anaform
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.dosyaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ürünEkleToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.masaEkleToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.bölümEkleToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.stokGirişiToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.stokÇıkışıToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.yönetimToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.hesaplarToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.alınanHesaplarToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.stoklaToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.stokAdetlerToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.tsl_kullanici = new System.Windows.Forms.ToolStripLabel();
            this.tsl_tarih = new System.Windows.Forms.ToolStripLabel();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.timer_min_stok = new System.Windows.Forms.Timer(this.components);
            this.btn_stok_uyarilari = new System.Windows.Forms.Button();
            this.menuStrip1.SuspendLayout();
            this.toolStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // menuStrip1
            // 
            this.menuStrip1.Font = new System.Drawing.Font("Segoe UI", 10F);
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.dosyaToolStripMenuItem,
            this.yönetimToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(1201, 27);
            this.menuStrip1.TabIndex = 0;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // dosyaToolStripMenuItem
            // 
            this.dosyaToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ürünEkleToolStripMenuItem,
            this.masaEkleToolStripMenuItem,
            this.bölümEkleToolStripMenuItem,
            this.toolStripSeparator1,
            this.stokGirişiToolStripMenuItem,
            this.stokÇıkışıToolStripMenuItem});
            this.dosyaToolStripMenuItem.Name = "dosyaToolStripMenuItem";
            this.dosyaToolStripMenuItem.Size = new System.Drawing.Size(59, 23);
            this.dosyaToolStripMenuItem.Text = "Dosya";
            // 
            // ürünEkleToolStripMenuItem
            // 
            this.ürünEkleToolStripMenuItem.Name = "ürünEkleToolStripMenuItem";
            this.ürünEkleToolStripMenuItem.Size = new System.Drawing.Size(145, 24);
            this.ürünEkleToolStripMenuItem.Text = "Ürün Ekle";
            this.ürünEkleToolStripMenuItem.Click += new System.EventHandler(this.ürünEkleToolStripMenuItem_Click);
            // 
            // masaEkleToolStripMenuItem
            // 
            this.masaEkleToolStripMenuItem.Name = "masaEkleToolStripMenuItem";
            this.masaEkleToolStripMenuItem.Size = new System.Drawing.Size(145, 24);
            this.masaEkleToolStripMenuItem.Text = "Masa Ekle";
            this.masaEkleToolStripMenuItem.Click += new System.EventHandler(this.masaEkleToolStripMenuItem_Click);
            // 
            // bölümEkleToolStripMenuItem
            // 
            this.bölümEkleToolStripMenuItem.Name = "bölümEkleToolStripMenuItem";
            this.bölümEkleToolStripMenuItem.Size = new System.Drawing.Size(145, 24);
            this.bölümEkleToolStripMenuItem.Text = "Bölüm Ekle";
            this.bölümEkleToolStripMenuItem.Click += new System.EventHandler(this.bölümEkleToolStripMenuItem_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(142, 6);
            // 
            // stokGirişiToolStripMenuItem
            // 
            this.stokGirişiToolStripMenuItem.Name = "stokGirişiToolStripMenuItem";
            this.stokGirişiToolStripMenuItem.Size = new System.Drawing.Size(145, 24);
            this.stokGirişiToolStripMenuItem.Text = "Stok Girişi";
            this.stokGirişiToolStripMenuItem.Click += new System.EventHandler(this.stokGirişiToolStripMenuItem_Click);
            // 
            // stokÇıkışıToolStripMenuItem
            // 
            this.stokÇıkışıToolStripMenuItem.Name = "stokÇıkışıToolStripMenuItem";
            this.stokÇıkışıToolStripMenuItem.Size = new System.Drawing.Size(145, 24);
            this.stokÇıkışıToolStripMenuItem.Text = "Stok Çıkışı";
            this.stokÇıkışıToolStripMenuItem.Click += new System.EventHandler(this.stokÇıkışıToolStripMenuItem_Click);
            // 
            // yönetimToolStripMenuItem
            // 
            this.yönetimToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.hesaplarToolStripMenuItem,
            this.stoklaToolStripMenuItem});
            this.yönetimToolStripMenuItem.Name = "yönetimToolStripMenuItem";
            this.yönetimToolStripMenuItem.Size = new System.Drawing.Size(71, 23);
            this.yönetimToolStripMenuItem.Text = "Yönetim";
            // 
            // hesaplarToolStripMenuItem
            // 
            this.hesaplarToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.alınanHesaplarToolStripMenuItem});
            this.hesaplarToolStripMenuItem.Name = "hesaplarToolStripMenuItem";
            this.hesaplarToolStripMenuItem.Size = new System.Drawing.Size(131, 24);
            this.hesaplarToolStripMenuItem.Text = "Hesaplar";
            // 
            // alınanHesaplarToolStripMenuItem
            // 
            this.alınanHesaplarToolStripMenuItem.Name = "alınanHesaplarToolStripMenuItem";
            this.alınanHesaplarToolStripMenuItem.Size = new System.Drawing.Size(173, 24);
            this.alınanHesaplarToolStripMenuItem.Text = "Alınan Hesaplar";
            this.alınanHesaplarToolStripMenuItem.Click += new System.EventHandler(this.alınanHesaplarToolStripMenuItem_Click);
            // 
            // stoklaToolStripMenuItem
            // 
            this.stoklaToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.stokAdetlerToolStripMenuItem});
            this.stoklaToolStripMenuItem.Name = "stoklaToolStripMenuItem";
            this.stoklaToolStripMenuItem.Size = new System.Drawing.Size(131, 24);
            this.stoklaToolStripMenuItem.Text = "Stoklar";
            // 
            // stokAdetlerToolStripMenuItem
            // 
            this.stokAdetlerToolStripMenuItem.Name = "stokAdetlerToolStripMenuItem";
            this.stokAdetlerToolStripMenuItem.Size = new System.Drawing.Size(153, 24);
            this.stokAdetlerToolStripMenuItem.Text = "Stok Adetler";
            this.stokAdetlerToolStripMenuItem.Click += new System.EventHandler(this.stokAdetlerToolStripMenuItem_Click);
            // 
            // tabControl1
            // 
            this.tabControl1.Dock = System.Windows.Forms.DockStyle.Left;
            this.tabControl1.Location = new System.Drawing.Point(0, 27);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(867, 650);
            this.tabControl1.TabIndex = 1;
            // 
            // toolStrip1
            // 
            this.toolStrip1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tsl_kullanici,
            this.tsl_tarih});
            this.toolStrip1.Location = new System.Drawing.Point(867, 652);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.Size = new System.Drawing.Size(334, 25);
            this.toolStrip1.TabIndex = 0;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // tsl_kullanici
            // 
            this.tsl_kullanici.Name = "tsl_kullanici";
            this.tsl_kullanici.Size = new System.Drawing.Size(86, 22);
            this.tsl_kullanici.Text = "toolStripLabel1";
            // 
            // tsl_tarih
            // 
            this.tsl_tarih.Alignment = System.Windows.Forms.ToolStripItemAlignment.Right;
            this.tsl_tarih.Name = "tsl_tarih";
            this.tsl_tarih.Size = new System.Drawing.Size(0, 22);
            // 
            // timer1
            // 
            this.timer1.Interval = 1000;
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridView1.Location = new System.Drawing.Point(867, 89);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(334, 563);
            this.dataGridView1.TabIndex = 2;
            // 
            // timer_min_stok
            // 
            this.timer_min_stok.Interval = 3600000;
            this.timer_min_stok.Tick += new System.EventHandler(this.timer_min_stok_Tick);
            // 
            // btn_stok_uyarilari
            // 
            this.btn_stok_uyarilari.Dock = System.Windows.Forms.DockStyle.Top;
            this.btn_stok_uyarilari.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.btn_stok_uyarilari.Location = new System.Drawing.Point(867, 27);
            this.btn_stok_uyarilari.Name = "btn_stok_uyarilari";
            this.btn_stok_uyarilari.Size = new System.Drawing.Size(334, 62);
            this.btn_stok_uyarilari.TabIndex = 3;
            this.btn_stok_uyarilari.Text = "Stok Uyarılarını Güncelle\r\n(Otomatik Yenileme: 60 dk)";
            this.btn_stok_uyarilari.UseVisualStyleBackColor = true;
            this.btn_stok_uyarilari.Click += new System.EventHandler(this.btn_stok_uyarilari_Click);
            // 
            // Anaform
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ButtonShadow;
            this.ClientSize = new System.Drawing.Size(1201, 677);
            this.Controls.Add(this.dataGridView1);
            this.Controls.Add(this.toolStrip1);
            this.Controls.Add(this.btn_stok_uyarilari);
            this.Controls.Add(this.tabControl1);
            this.Controls.Add(this.menuStrip1);
            this.MainMenuStrip = this.menuStrip1;
            this.Name = "Anaform";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "AnaForm";
            this.Load += new System.EventHandler(this.Anaform_Load);
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.toolStrip1.ResumeLayout(false);
            this.toolStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem dosyaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem masaEkleToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem ürünEkleToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem bölümEkleToolStripMenuItem;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private System.Windows.Forms.ToolStripLabel tsl_kullanici;
        private System.Windows.Forms.ToolStripLabel tsl_tarih;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.ToolStripMenuItem yönetimToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem hesaplarToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem alınanHesaplarToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem stokGirişiToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem stokÇıkışıToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem stoklaToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem stokAdetlerToolStripMenuItem;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Timer timer_min_stok;
        private System.Windows.Forms.Button btn_stok_uyarilari;
    }
}

