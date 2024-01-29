
namespace AdisyonTakip.MasaIslemleri
{
    partial class Masalar
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
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.lbl_max_limit_uyari = new System.Windows.Forms.Label();
            this.chk_aktif = new System.Windows.Forms.CheckBox();
            this.btn_sil = new System.Windows.Forms.Button();
            this.btn_temizle = new System.Windows.Forms.Button();
            this.btn_kaydet = new System.Windows.Forms.Button();
            this.chk_rezerve = new System.Windows.Forms.CheckBox();
            this.cmb_bolumler = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.txt_masa_adi = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.txt_masa_kodu = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.txt_RECno = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.contextMenuStrip1 = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.rezerveEtToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.aktfToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.pasifToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.durumuToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.aktifToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.pasifToolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.contextMenuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // splitContainer1
            // 
            this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer1.Location = new System.Drawing.Point(0, 0);
            this.splitContainer1.Name = "splitContainer1";
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.groupBox1);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.groupBox2);
            this.splitContainer1.Size = new System.Drawing.Size(1039, 307);
            this.splitContainer1.SplitterDistance = 314;
            this.splitContainer1.TabIndex = 0;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.lbl_max_limit_uyari);
            this.groupBox1.Controls.Add(this.chk_aktif);
            this.groupBox1.Controls.Add(this.btn_sil);
            this.groupBox1.Controls.Add(this.btn_temizle);
            this.groupBox1.Controls.Add(this.btn_kaydet);
            this.groupBox1.Controls.Add(this.chk_rezerve);
            this.groupBox1.Controls.Add(this.cmb_bolumler);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.txt_masa_adi);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.txt_masa_kodu);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.txt_RECno);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox1.Location = new System.Drawing.Point(0, 0);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(314, 307);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Ekle";
            // 
            // lbl_max_limit_uyari
            // 
            this.lbl_max_limit_uyari.AutoSize = true;
            this.lbl_max_limit_uyari.Font = new System.Drawing.Font("Microsoft Sans Serif", 11F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.lbl_max_limit_uyari.ForeColor = System.Drawing.Color.Red;
            this.lbl_max_limit_uyari.Location = new System.Drawing.Point(44, 245);
            this.lbl_max_limit_uyari.Name = "lbl_max_limit_uyari";
            this.lbl_max_limit_uyari.Size = new System.Drawing.Size(210, 36);
            this.lbl_max_limit_uyari.TabIndex = 15;
            this.lbl_max_limit_uyari.Text = "Seçilen bölüme daha fazla \r\nmasa kayıt edilemez";
            this.lbl_max_limit_uyari.Visible = false;
            // 
            // chk_aktif
            // 
            this.chk_aktif.AutoSize = true;
            this.chk_aktif.Location = new System.Drawing.Point(93, 162);
            this.chk_aktif.Name = "chk_aktif";
            this.chk_aktif.Size = new System.Drawing.Size(47, 17);
            this.chk_aktif.TabIndex = 14;
            this.chk_aktif.Text = "Aktif";
            this.chk_aktif.UseVisualStyleBackColor = true;
            // 
            // btn_sil
            // 
            this.btn_sil.Location = new System.Drawing.Point(93, 196);
            this.btn_sil.Name = "btn_sil";
            this.btn_sil.Size = new System.Drawing.Size(88, 23);
            this.btn_sil.TabIndex = 13;
            this.btn_sil.Text = "Sil";
            this.btn_sil.UseVisualStyleBackColor = true;
            this.btn_sil.Click += new System.EventHandler(this.btn_sil_Click);
            // 
            // btn_temizle
            // 
            this.btn_temizle.Location = new System.Drawing.Point(12, 196);
            this.btn_temizle.Name = "btn_temizle";
            this.btn_temizle.Size = new System.Drawing.Size(75, 23);
            this.btn_temizle.TabIndex = 12;
            this.btn_temizle.Text = "Temizle";
            this.btn_temizle.UseVisualStyleBackColor = true;
            this.btn_temizle.Click += new System.EventHandler(this.btn_temizle_Click);
            // 
            // btn_kaydet
            // 
            this.btn_kaydet.Location = new System.Drawing.Point(187, 196);
            this.btn_kaydet.Name = "btn_kaydet";
            this.btn_kaydet.Size = new System.Drawing.Size(88, 23);
            this.btn_kaydet.TabIndex = 11;
            this.btn_kaydet.Text = "Kaydet";
            this.btn_kaydet.UseVisualStyleBackColor = true;
            this.btn_kaydet.Click += new System.EventHandler(this.btn_kaydet_Click);
            // 
            // chk_rezerve
            // 
            this.chk_rezerve.AutoSize = true;
            this.chk_rezerve.Location = new System.Drawing.Point(93, 139);
            this.chk_rezerve.Name = "chk_rezerve";
            this.chk_rezerve.Size = new System.Drawing.Size(66, 17);
            this.chk_rezerve.TabIndex = 2;
            this.chk_rezerve.Text = "Rezerve";
            this.chk_rezerve.UseVisualStyleBackColor = true;
            // 
            // cmb_bolumler
            // 
            this.cmb_bolumler.FormattingEnabled = true;
            this.cmb_bolumler.Location = new System.Drawing.Point(93, 109);
            this.cmb_bolumler.Name = "cmb_bolumler";
            this.cmb_bolumler.Size = new System.Drawing.Size(121, 21);
            this.cmb_bolumler.TabIndex = 2;
            this.cmb_bolumler.SelectedIndexChanged += new System.EventHandler(this.cmb_bolumler_SelectedIndexChanged);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(17, 113);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(49, 13);
            this.label4.TabIndex = 8;
            this.label4.Text = "Bölüm (*)";
            // 
            // txt_masa_adi
            // 
            this.txt_masa_adi.Location = new System.Drawing.Point(93, 83);
            this.txt_masa_adi.Name = "txt_masa_adi";
            this.txt_masa_adi.Size = new System.Drawing.Size(100, 20);
            this.txt_masa_adi.TabIndex = 5;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(17, 87);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(64, 13);
            this.label3.TabIndex = 6;
            this.label3.Text = "Masa Adı (*)";
            // 
            // txt_masa_kodu
            // 
            this.txt_masa_kodu.Location = new System.Drawing.Point(93, 57);
            this.txt_masa_kodu.Name = "txt_masa_kodu";
            this.txt_masa_kodu.Size = new System.Drawing.Size(100, 20);
            this.txt_masa_kodu.TabIndex = 3;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(17, 61);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(74, 13);
            this.label2.TabIndex = 4;
            this.label2.Text = "Masa Kodu (*)";
            // 
            // txt_RECno
            // 
            this.txt_RECno.Enabled = false;
            this.txt_RECno.Location = new System.Drawing.Point(93, 31);
            this.txt_RECno.Name = "txt_RECno";
            this.txt_RECno.Size = new System.Drawing.Size(100, 20);
            this.txt_RECno.TabIndex = 2;
            this.txt_RECno.Text = "0";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(17, 35);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(47, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "Kayıt No";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.dataGridView1);
            this.groupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox2.Location = new System.Drawing.Point(0, 0);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(721, 307);
            this.groupBox2.TabIndex = 1;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Liste";
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.ContextMenuStrip = this.contextMenuStrip1;
            this.dataGridView1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dataGridView1.Location = new System.Drawing.Point(3, 16);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(715, 288);
            this.dataGridView1.TabIndex = 0;
            this.dataGridView1.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellClick);
            this.dataGridView1.MouseDown += new System.Windows.Forms.MouseEventHandler(this.dataGridView1_MouseDown);
            // 
            // contextMenuStrip1
            // 
            this.contextMenuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.rezerveEtToolStripMenuItem,
            this.durumuToolStripMenuItem});
            this.contextMenuStrip1.Name = "contextMenuStrip1";
            this.contextMenuStrip1.Size = new System.Drawing.Size(140, 48);
            // 
            // rezerveEtToolStripMenuItem
            // 
            this.rezerveEtToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.aktfToolStripMenuItem,
            this.pasifToolStripMenuItem});
            this.rezerveEtToolStripMenuItem.Name = "rezerveEtToolStripMenuItem";
            this.rezerveEtToolStripMenuItem.Size = new System.Drawing.Size(139, 22);
            this.rezerveEtToolStripMenuItem.Text = "Rezervasyon";
            // 
            // aktfToolStripMenuItem
            // 
            this.aktfToolStripMenuItem.Name = "aktfToolStripMenuItem";
            this.aktfToolStripMenuItem.Size = new System.Drawing.Size(99, 22);
            this.aktfToolStripMenuItem.Text = "Aktf";
            this.aktfToolStripMenuItem.Click += new System.EventHandler(this.aktfToolStripMenuItem_Click);
            // 
            // pasifToolStripMenuItem
            // 
            this.pasifToolStripMenuItem.Name = "pasifToolStripMenuItem";
            this.pasifToolStripMenuItem.Size = new System.Drawing.Size(99, 22);
            this.pasifToolStripMenuItem.Text = "Pasif";
            this.pasifToolStripMenuItem.Click += new System.EventHandler(this.pasifToolStripMenuItem_Click);
            // 
            // durumuToolStripMenuItem
            // 
            this.durumuToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.aktifToolStripMenuItem,
            this.pasifToolStripMenuItem1});
            this.durumuToolStripMenuItem.Name = "durumuToolStripMenuItem";
            this.durumuToolStripMenuItem.Size = new System.Drawing.Size(139, 22);
            this.durumuToolStripMenuItem.Text = "Durum";
            // 
            // aktifToolStripMenuItem
            // 
            this.aktifToolStripMenuItem.Name = "aktifToolStripMenuItem";
            this.aktifToolStripMenuItem.Size = new System.Drawing.Size(99, 22);
            this.aktifToolStripMenuItem.Text = "Aktif";
            this.aktifToolStripMenuItem.Click += new System.EventHandler(this.aktifToolStripMenuItem_Click);
            // 
            // pasifToolStripMenuItem1
            // 
            this.pasifToolStripMenuItem1.Name = "pasifToolStripMenuItem1";
            this.pasifToolStripMenuItem1.Size = new System.Drawing.Size(99, 22);
            this.pasifToolStripMenuItem1.Text = "Pasif";
            this.pasifToolStripMenuItem1.Click += new System.EventHandler(this.pasifToolStripMenuItem1_Click);
            // 
            // Masalar
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1039, 307);
            this.Controls.Add(this.splitContainer1);
            this.Name = "Masalar";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "MasaListe";
            this.Load += new System.EventHandler(this.MasaListe_Load);
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
            this.splitContainer1.ResumeLayout(false);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.contextMenuStrip1.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.SplitContainer splitContainer1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txt_masa_adi;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txt_masa_kodu;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txt_RECno;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox cmb_bolumler;
        private System.Windows.Forms.CheckBox chk_rezerve;
        private System.Windows.Forms.Button btn_sil;
        private System.Windows.Forms.Button btn_temizle;
        private System.Windows.Forms.Button btn_kaydet;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.CheckBox chk_aktif;
        private System.Windows.Forms.ContextMenuStrip contextMenuStrip1;
        private System.Windows.Forms.ToolStripMenuItem rezerveEtToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem aktfToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem pasifToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem durumuToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem aktifToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem pasifToolStripMenuItem1;
        private System.Windows.Forms.Label lbl_max_limit_uyari;
    }
}