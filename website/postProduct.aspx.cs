using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace vendor
{
    public partial class postProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void addProduct(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("postProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            //getting the username from the session
            string username = (string)Session["username"];


            //To read the input from the user
            string name = txt_name.Text;
            string category = txt_category.Text;
            string description = txt_description.Text;
            double price = double.Parse(txt_price.Text);
            string color = txt_color.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@vendorUsername", username));
            cmd.Parameters.Add(new SqlParameter("@product_name", name));
            cmd.Parameters.Add(new SqlParameter("@category", category));
            cmd.Parameters.Add(new SqlParameter("@product_description", description));
            cmd.Parameters.Add(new SqlParameter("@price", price));
            cmd.Parameters.Add(new SqlParameter("@color", color));


            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();


            Response.Write("Product Added");
            
        }

    }
}