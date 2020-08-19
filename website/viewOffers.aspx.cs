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
    public partial class viewOffers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected string getOffers()
        {

            //string to be outputted to the page
            string htmlString = "";


            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("viewOffers", conn);
            cmd.CommandType = CommandType.StoredProcedure;

          
            conn.Open();

            //IF the output is a table, then we can read the records one at a time
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                //Getting the values of the attributes in the table
                int id = rdr.GetInt32(rdr.GetOrdinal("offer_id"));
                int amount = rdr.GetInt32(rdr.GetOrdinal("offer_amount"));
                DateTime date = rdr.GetDateTime(rdr.GetOrdinal("expiry_date"));
            
                htmlString += "<tr><td>" + id + "</td><td>" + amount + "</td><td>" + date  + "</td></tr>";
            }

            return htmlString;
        }
    }
}