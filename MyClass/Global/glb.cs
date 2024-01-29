using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace AdisyonTakip
{
    public class glb
    {

        /// CLASS TANIMLARI        
        public static MyClass.Global.SQLConnectionClass sql = new MyClass.Global.SQLConnectionClass();




        // DEGİŞKENLER

        /// <summary>
        /// Login olan kullanıcının kod bilgisi: Asla değiştirme yapmayın.
        /// </summary>
        public static int aktif_kullanici_kodu = 0;
        public static string aktif_kullanici_adi = "";


        public static bool kayit_basarili = true;

        public static string AppPath = System.Windows.Forms.Application.StartupPath;




        /// METHODS
        public static bool isNumeric(string str)
        {
            bool ret = false;
            try
            {
                int i = Convert.ToInt32(str);
                ret = true;
            }
            catch (FormatException)
            {
                ret = false;
            }
            catch (Exception ex)
            {
                ret = false;
                MessageBox.Show(ex.Message, "Hata!");
            }

            return ret;
        }





    }
}
