
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
    public partial class RegistrationVendor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void regVen(object sender, EventArgs e)
        {

            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("vendorRegister", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = usernameV.Text;
            string password = passwordV.Text;
            string first_name = firstNameV.Text;
            string last_name = lastNameV.Text;
            string email = emailV.Text;
            string company = companyV.Text;
            string bankAccNo = BankNumV.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@first_name", first_name));
            cmd.Parameters.Add(new SqlParameter("@last_name", last_name));
            cmd.Parameters.Add(new SqlParameter("@password", password));
            cmd.Parameters.Add(new SqlParameter("@email", email));
            cmd.Parameters.Add(new SqlParameter("@company_name", company));
            cmd.Parameters.Add(new SqlParameter("@bank_acc_no", bankAccNo));


            ////Save the output from the procedure
            //SqlParameter count = cmd.Parameters.Add("@count", SqlDbType.Int);
            //count.Direction = ParameterDirection.Output;

            //Executing the SQLCommand
            conn.Open();
            if (username == "" || password == "" || first_name == "" || last_name =="" || email == "" ||
               company == "" || bankAccNo == "")
            {
                Response.Write("ERROR: at least one of your entries is empty!");

            }

            else
            {
                try
                {
                    cmd.ExecuteNonQuery();
                    Response.Write("Vendor Registration successful.");
                }

                catch (System.Data.SqlClient.SqlException E)
                {
                    Response.Write("Vendor Registration failed: username already taken. Please try again with a more creative username!");
                    SqlCommand cmd1 = new SqlCommand("deleteVendor", conn);
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