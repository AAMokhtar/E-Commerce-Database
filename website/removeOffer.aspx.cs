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
    public partial class removeOffer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void deleteOffer(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("checkandremoveExpiredoffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;



            //To read the input from the user
            int offer = Int32.Parse(txt_offer.Text);
           

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@offerid", offer));

            //store the output from the stored procedure
            SqlParameter removed = cmd.Parameters.Add("@removed", SqlDbType.Bit);
            removed.Direction = ParameterDirection.Output;

            SqlParameter inDB = cmd.Parameters.Add("@inDb", SqlDbType.Bit);
            inDB.Direction = ParameterDirection.Output;




           
             //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery(); //leads to an sqlexception if the offer id was not in table
            conn.Close();

            //inform the user if the offer was removed or not depending if the offer expired or not
            if (inDB.Value.ToString().Equals("True"))
            {
                if (removed.Value.ToString().Equals("True"))
                    Response.Write("Offer deleted");
                else
                    Response.Write("Offer was not removed as it is still not expired yet");
            }
            else
                Response.Write("Offer id not in database");
            
        }
    }
}