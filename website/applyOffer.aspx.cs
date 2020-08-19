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
    public partial class applyOffer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void putOffer(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("applyOffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            //getting the username from the session
            string username = (string)Session["username"];


            //To read the input from the user
            int offer = Int32.Parse(txt_offer.Text);
            int serial = Int32.Parse(txt_serial.Text);
           
            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@vendorname", username));
            cmd.Parameters.Add(new SqlParameter("@offerid", offer));
            cmd.Parameters.Add(new SqlParameter("@serial", serial));


            //store the output from the stored procedure
            SqlParameter applied = cmd.Parameters.Add("@applied", SqlDbType.Bit);
            applied.Direction = ParameterDirection.Output;


            try
            {
                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (applied.Value.ToString().Equals("True"))
                    Response.Write("Offer applied to product");
                else
                    Response.Write("Product already has an active offer");
            }
            catch(SqlException x)
            {
                Response.Write("Offer id or serial number is not in the database");
            }
        }
    }
}