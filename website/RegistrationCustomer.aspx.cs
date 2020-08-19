
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
    public partial class RegistrationCustomer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void regCus(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("customerRegister", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = usernameC.Text;
            string password = passwordC.Text;
            string first_name = firstNameC.Text;
            string last_name = lastNameC.Text;
            string email = emailC.Text;
        
            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@first_name", first_name));
            cmd.Parameters.Add(new SqlParameter("@last_name", last_name));
            cmd.Parameters.Add(new SqlParameter("@password", password));
            cmd.Parameters.Add(new SqlParameter("@email", email));
  


            ////Save the output from the procedure
            //SqlParameter count = cmd.Parameters.Add("@count", SqlDbType.Int);
            //count.Direction = ParameterDirection.Output;

            //Executing the SQLCommand
            conn.Open();
            if (username == "" || password == "" || first_name == "" || last_name == "" || email == "")
            {
                Response.Write("ERROR: at least one of your entries is empty!");

            }

            else
            {
                try
                {
                    cmd.ExecuteNonQuery();
                    Response.Write("Customer Registration successful.");
                }

                catch (System.Data.SqlClient.SqlException E)
                {
                    Response.Write("Customer Registration failed: username already taken. Please try again with a more creative username!");
                    SqlCommand cmd1 = new SqlCommand("deleteCustomer", conn);
                    cmd1.CommandType = CommandType.StoredProcedure;
                    cmd1.Parameters.Add(new SqlParameter("@username", username));
                    cmd1.ExecuteNonQuery();

                }
            }
            conn.Close();




        }


        protected void logF(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Clear();
            Response.Redirect("Login.aspx", true);
        }
    }


}