using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3v3
{
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void registerVendor(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            Response.Write("User type: vendor successful");
      

            //To navigate to another webpage
            Response.Redirect("RegistrationVendor.aspx", true);

        }


        protected void registerCustomer(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            Response.Write("User type: customer successful");


            //To navigate to another webpage
            Response.Redirect("RegistrationCustomer.aspx", true);



        }

        protected void logF(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx", true);
        }
    }

}