
namespace AdisyonTakip.MasaIslemleri
{
    partial class HesapAl
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
            this.btn_masayi_kapat = new System.Windows.Forms.Button();
            this.lbl_toplam_tutar = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.lbl_masa_kod = new System.Windows.Forms.Label();
            this.lbl_masa_adi = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // btn_masayi_kapat
            // 
            this.btn_masayi_kapat.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.btn_masayi_kapat.Location = new System.Drawing.Point(46, 176);
            this.btn_masayi_kapat.Name = "btn_masayi_kapat";
            this.btn_masayi_kapat.Size = new System.Drawing.Size(208, 65);
            this.btn_masayi_kapat.TabIndex = 17;
            this.btn_masayi_kapat.Text = "Masayı Kapat";
            this.btn_masayi_kapat.UseVisualStyleBackColor = true;
            this.btn_masayi_kapat.Click += new System.EventHandler(this.btn_masayi_kapat_Click);
            // 
            // lbl_toplam_tutar
            // 
            this.lbl_toplam_tutar.AutoSize = true;
            this.lbl_toplam_tutar.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.lbl_toplam_tutar.Location = new System.Drawing.Point(26, 62);
            this.lbl_toplam_tutar.Name = "lbl_toplam_tutar";
            this.lbl_toplam_tutar.Size = new System.Drawing.Size(191, 25);
            this.lbl_toplam_tutar.TabIndex = 20;
            this.lbl_toplam_tutar.Text = "siparişlerin toplamı";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.label4.Location = new System.Drawing.Point(26, 26);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(175, 25);
            this.label4.TabIndex = 18;
            this.label4.Text = "Toplam Tutar (₺)";
            // 
            // lbl_masa_kod
            // 
            this.lbl_masa_kod.AutoSize = true;
            this.lbl_masa_kod.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.lbl_masa_kod.Location = new System.Drawing.Point(26, 115);
            this.lbl_masa_kod.Name = "lbl_masa_kod";
            this.lbl_masa_kod.Size = new System.Drawing.Size(47, 25);
            this.lbl_masa_kod.TabIndex = 21;
            this.lbl_masa_kod.Text = "kod";
            // 
            // lbl_masa_adi
            // 
            this.lbl_masa_adi.AutoSize = true;
            this.lbl_masa_adi.Font = new System.Drawing.Font("Microsoft Sans Serif", 15F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.lbl_masa_adi.Location = new System.Drawing.Point(79, 115);
            this.lbl_masa_adi.Name = "lbl_masa_adi";
            this.lbl_masa_adi.Size = new System.Drawing.Size(36, 25);
            this.lbl_masa_adi.TabIndex = 22;
            this.lbl_masa_adi.Text = "ad";
            // 
            // HesapAl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(311, 270);
            this.Controls.Add(this.lbl_masa_adi);
            this.Controls.Add(this.lbl_masa_kod);
            this.Controls.Add(this.lbl_toplam_tutar);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.btn_masayi_kapat);
            this.Name = "HesapAl";
            this.Text = "Hesap Al";
            this.Load += new System.EventHandler(this.HesapAl_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btn_masayi_kapat;
        private System.Windows.Forms.Label label4;
        public System.Windows.Forms.Label lbl_toplam_tutar;
        public System.Windows.Forms.Label lbl_masa_kod;
        public System.Windows.Forms.Label lbl_masa_adi;
    }
}