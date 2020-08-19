
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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void logFun(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("userlogin", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = eUsername.Text;
            string password = ePassword.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@password", password));

            //Save the output from the procedure
            SqlParameter suc = cmd.Parameters.Add("@success", SqlDbType.Bit);
            suc.Direction = ParameterDirection.Output;
            SqlParameter type = cmd.Parameters.Add("@type", SqlDbType.Int);
            type.Direction = ParameterDirection.Output;

            //Executing the SQLCommand

            if (username == "" || password == "")
            {
                Response.Write("ERROR: at least one of your entries is empty!");

            }

            else
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();


                if (suc.Value.ToString().Equals("0") || type.Value.ToString().Equals("-1"))
                {
                    //To send response data to the client side (HTML)
                    Response.Write("Login failed. Check your username and password again.");
                }
                else if (suc.Value.ToString().Equals("1") || !type.Value.ToString().Equals("-1"))
                {
                    /*ASP.NET session state enables you to store and retrieve values for a user
                   as the user navigates ASP.NET pages in a Web application.
                   This is how we store a value in the session*/

                    //NOT SURE!
                    Session["username"] = eUsername.Text;
                    Response.Write("Login succeeded!" + type.Value.ToString());


                    if (type.Value.ToString().Equals("0"))
                    {
                        Response.Redirect("HomePageCustomer.aspx", true);
                    }

                    if (type.Value.ToString().Equals("1"))
                    {
                        Response.Redirect("vendorHome.aspx", true);
                    }

                    if (type.Value.ToString().Equals("2"))
                    {
                        Response.Redirect("HomePageAdmin.aspx", true);
                    }
                    //To navigate to another webpage

                }
            }
        }

        protected void registration_Click(object sender, EventArgs e)
        {
            Response.Redirect("Registration.aspx", true);
        }
    }
}