using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace M3v3
{
    public partial class ProductsPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("showProductsByPrice", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            conn.Open();

            //IF the output is a table, then we can read the records one at a time
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
              
                string productName = rdr.GetString(rdr.GetOrdinal("product_name"));
                string productDesc = rdr.GetString(rdr.GetOrdinal("product_description"));
                decimal productPrice = rdr.GetDecimal( rdr.GetOrdinal("price"));
                string productColor = rdr.GetString(rdr.GetOrdinal("color"));

                //Create a new label and add it to the HTML form
                Label lbl_productName = new Label();
                lbl_productName.Text = "PRODUCT NAME: "+productName + "   |   ";
                form1.Controls.Add(lbl_productName);

                Label lbl_productDesc = new Label();
                lbl_productDesc.Text = "PRODUCT DESCRIPTION: " +productDesc + "   |   ";
                form1.Controls.Add(lbl_productDesc);

                Label lbl_productPrice = new Label();
                lbl_productPrice.Text = "PRODUCT PRICE: " + productPrice + "   |   ";
                form1.Controls.Add(lbl_productPrice);


                Label lbl_productColor = new Label();
                lbl_productColor.Text = "PRODUCT COLOR: " + productColor + "  <br /> <br />  <br />";
                form1.Controls.Add(lbl_productColor);
            }
        
        }
    }
}