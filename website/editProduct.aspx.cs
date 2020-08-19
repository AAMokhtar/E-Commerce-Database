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
    public partial class editProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void updateProduct(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("EditProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            //get the vendor username logged in using sessions
            string username = (string) Session["username"];


            //To read the input from the user
            string serial = txt_serial.Text;
            string name = txt_name.Text;
            string category = txt_category.Text;
            string description = txt_description.Text;
            string price = txt_price.Text;
            string color = txt_color.Text;

            if (string.IsNullOrEmpty(name) && string.IsNullOrEmpty(category) && string.IsNullOrEmpty(description) &&
               string.IsNullOrEmpty(price) && string.IsNullOrEmpty(color))
                Response.Write("At least one field from name, category, description, price or color should be filled");
            else
            {
                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@vendorname", username));
                cmd.Parameters.Add(new SqlParameter("@serialnumber", serial));

                //Save the output from the procedure
                SqlParameter updated = cmd.Parameters.Add("@updated", SqlDbType.Bit);
                updated.Direction = ParameterDirection.Output;

                if (string.IsNullOrEmpty(name))
                    cmd.Parameters.Add(new SqlParameter("@product_name", DBNull.Value));
                else
                    cmd.Parameters.Add(new SqlParameter("@product_name", name));

                if (string.IsNullOrEmpty(category))
                    cmd.Parameters.Add(new SqlParameter("@category", DBNull.Value));
                else 
                    cmd.Parameters.Add(new SqlParameter("@category", category));

                if (string.IsNullOrEmpty(description))
                    cmd.Parameters.Add(new SqlParameter("@product_description", DBNull.Value));
                else
                  cmd.Parameters.Add(new SqlParameter("@product_description", description));

                if(string.IsNullOrEmpty(price))
                    cmd.Parameters.Add(new SqlParameter("@price", DBNull.Value));
                else
                    cmd.Parameters.Add(new SqlParameter("@price", double.Parse(price)));

                if (string.IsNullOrEmpty(color))
                    cmd.Parameters.Add(new SqlParameter("@color", DBNull.Value));
                else
                    cmd.Parameters.Add(new SqlParameter("@color", color));



                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (updated.Value.ToString().Equals("True"))
                    Response.Write("Product updated");
                else
                    Response.Write("Product serial number is not in database");
                    
                
            }

        }

    }
}