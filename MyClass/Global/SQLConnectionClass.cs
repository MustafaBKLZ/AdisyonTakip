using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace AdisyonTakip.MyClass.Global
{
    public class SQLConnectionClass
    {
        private static string SQLConnectionString = @"Server =.\sql2017; uid=sa; Database = AdisyonTakip; Trusted_Connection = True;";
        private static SqlConnection con = new SqlConnection();
        private static SqlDataAdapter da = new SqlDataAdapter();
        private static SqlCommand com = new SqlCommand();

        public void Baglanti()
        {
            con = new SqlConnection(SQLConnectionString);
            if (con.State == System.Data.ConnectionState.Closed)
            {
                con.Open();
            }
        }
        public object Command(string query)
        {
            object obj;
            com.Connection = con; // SqlCommand            
            com.CommandText = query; // SqlCommand
            obj = com.ExecuteScalar();
            return obj;
        }

        public DataTable Table(string query)
        {
            DataTable dt = new DataTable();
            com.Connection = con; // SqlCommand
            com.CommandText = query; // SqlCommand
            da.SelectCommand = com; // // SqlCommand'ın bir select sorgusu olduğunu belirtiyoruz.
            da.Fill(dt);
            return dt;
        }
    }
}
