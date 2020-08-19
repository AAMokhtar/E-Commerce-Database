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
    public partial class viewProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

           

        }


        protected string getProducts()
        {

            //string to be outputted to the page
            string htmlString = "";


            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("vendorviewProducts", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //get the vendor username from the session
            string username = (string)Session["username"];

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@vendorname", username));

            conn.Open();

            //IF the output is a table, then we can read the records one at a time
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                //Getting the values of the attributes in the table
                int serial = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
                string productName = rdr.GetString(rdr.GetOrdinal("product_name"));
                string category = rdr.GetString(rdr.GetOrdinal("category"));
                string description = rdr.GetString(rdr.GetOrdinal("product_description"));
                double price = (double)rdr.GetDecimal(rdr.GetOrdinal("price"));
                double finalPrice = (double)rdr.GetDecimal(rdr.GetOrdinal("final_price"));
                string color = rdr.GetString(rdr.GetOrdinal("color"));
                bool available = rdr.GetBoolean(rdr.GetOrdinal("available"));
                double rate = 0.0;
                //TODO: Drop balabizo pls
                if (!rdr.IsDBNull(rdr.GetOrdinal("rate")))
                    rate = (double)rdr.GetDecimal(rdr.GetOrdinal("rate"));
                string customerUsername = "";
                if (!rdr.IsDBNull(rdr.GetOrdinal("customer_username")))
                    customerUsername = rdr.GetString(rdr.GetOrdinal("customer_username"));
                string vendorUsername = rdr.GetString(rdr.GetOrdinal("vendor_username"));
                string order = "";
                if (!rdr.IsDBNull(rdr.GetOrdinal("customer_order_id")))
                    order = rdr.GetString(rdr.GetOrdinal("customer_order_id"));


                htmlString += "<tr><td>" + serial + "</td><td>" + productName + "</td><td>" + category + "</td><td>" + description +
                             "</td><td>" + price + "</td><td>" + finalPrice + "</td><td>" + color + "</td><td>" + available +
                             "</td><td>" + rate + "</td><td>" + customerUsername + "</td><td>" + vendorUsername + "</td><td>" +
                             order + "</td></tr>";
            }

            return htmlString;
        }


    }
}