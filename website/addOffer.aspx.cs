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
    public partial class addOffer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataBind();
        }

        protected void postOffer(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addOffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;



            //To read the input from the user
            int amount = Int32.Parse(txt_amount.Text);
            DateTime date = DateTime.Parse(txt_date.Text);
           

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@offeramount", amount));
            cmd.Parameters.Add(new SqlParameter("@expiry_date", date));
          

            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();


            Response.Write("Offer Added");
        }
    }
}