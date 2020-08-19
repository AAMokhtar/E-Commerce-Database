using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3v3
{
    public partial class oredr : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
         //   string username = (string)Session["username"];

            string orderid = Session["orderid"].ToString();
            string amount = Session["amount"].ToString();


            order.Text = "your order id :" + orderid;
            cost.Text="total coast is :"+ amount;
            
        }

        protected void update_Click(object sender, EventArgs e)
        {
            if (amount.Text == "" || Decimal.Parse(amount.Text)<0)
            {
                Response.Write("ERROR: please enter the amount you are willing to pay");

            }
            else
            {

                if (D1.SelectedValue == "cash")
                {
                    if (ccnum.Text != "")
                    {
                        Response.Write("ERROR: please select the proper payment method");

                    }
                    else
                    {
                        //Get the information of the connection to the database
                        string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

                        //create a new connection
                        SqlConnection conn = new SqlConnection(connStr);

                        /*create a new SQL command which takes as parameters the name of the stored procedure and
                         the SQLconnection name*/
                        SqlCommand cmd = new SqlCommand("SpecifyAmount", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        string username = (string)Session["username"];
                        //-------------------------------
                        cmd.Parameters.Add(new SqlParameter("@customername", username));
                        //--------------------------------
                        string orderid = Session["orderid"].ToString();
                        string amount1 = Session["amount"].ToString();

                        cmd.Parameters.Add(new SqlParameter("@orderID",orderid));
                        decimal cashamount= decimal.Parse(amount.Text);
                        cmd.Parameters.Add(new SqlParameter("@cash",cashamount));
                        decimal creditamount = 0;
                        cmd.Parameters.Add(new SqlParameter("@credit", creditamount));
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                        Response.Redirect("HomePageCustomer.aspx");



                    }

                }
                else
                {
                    if (ccnum.Text == "")
                    {
                        Response.Write("ERROR: please enter a credit card number");
                    }
                    else
                    {
                        string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

                        //create a new connection
                        SqlConnection conn = new SqlConnection(connStr);

                        /*create a new SQL command which takes as parameters the name of the stored procedure and
                         the SQLconnection name*/
                        string creditcardnum = (ccnum.Text);
                        string username = (string)Session["username"];

                        SqlCommand cmd = new SqlCommand("ccexists", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@username", username));
                        cmd.Parameters.Add(new SqlParameter("@ccnum", creditcardnum));
                        cmd.Parameters.Add("@count", SqlDbType.Int).Direction = ParameterDirection.Output;
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        int c = int.Parse(cmd.Parameters["@count"].Value.ToString());

                        conn.Close();
                        if (c == 0)
                        {
                            Response.Write("error: the is no such credit card");
                        }
                        else
                        {
                            /*create a new SQL command which takes as parameters the name of the stored procedure and
                         the SQLconnection name*/
                            SqlCommand cmd1 = new SqlCommand("SpecifyAmount", conn);
                            cmd1.CommandType = CommandType.StoredProcedure;
                            
                            //-------------------------------
                            string orderid = Session["orderid"].ToString();
                            string amount1 = Session["amount"].ToString();

                            cmd1.Parameters.Add(new SqlParameter("@customername", username));
                            //--------------------------------
                            cmd1.Parameters.Add(new SqlParameter("@orderID", orderid));
                            decimal cashamount = 0;
                            cmd1.Parameters.Add(new SqlParameter("@cash", cashamount));
                            decimal creditamount = decimal.Parse(amount.Text);
                            cmd1.Parameters.Add(new SqlParameter("@credit", creditamount));
                            conn.Open();
                            cmd1.ExecuteNonQuery();
                            conn.Close();
                            Response.Redirect("HomePageCustomer.aspx");

                        }

                    }
                }
            }
        }
    }
}