
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
    public partial class HomePageCustomer : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            DataBind();
            Response.Write(Session["username"] + "\n\n");
        }

        protected void addTelephone(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addMobile", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = (string) Session["username"];
            string mobile = addTel.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@mobile_number", mobile));
            ////Save the output from the procedure
            //SqlParameter count = cmd.Parameters.Add("@count", SqlDbType.Int);
            //count.Direction = ParameterDirection.Output;

            //Executing the SQLCommand
            conn.Open();

            if (username == "" || mobile == "")
            {
                Response.Write("ERROR: at least one of your entries is empty!");
            }

            else
            {
                try
                {
                    cmd.ExecuteNonQuery();
                    Response.Write("\n\n New number successfully added.");
                }

                catch (System.Data.SqlClient.SqlException E)
                {
                    Response.Write("Number already exists. Add a number you haven't added before, or don't add anything.");
                    //SqlCommand cmd1 = new SqlCommand("deleteCustomer", conn);
                    //cmd1.CommandType = CommandType.StoredProcedure;
                    //cmd1.Parameters.Add(new SqlParameter("@username", username));
                    //cmd1.ExecuteNonQuery();

                }
            }

            conn.Close();


        }

        protected void displayProducts(object sender, EventArgs e)
        {
            Response.Redirect("ProductsPage.aspx", true);
        }

        protected void createWL(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("createWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = (string)Session["username"];
            string WLname = WLNAME.Text;
            
            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@customername", username));
            cmd.Parameters.Add(new SqlParameter("@name", WLname));
           

            conn.Open();

            if (username == "" || WLname == "")
            {
                Response.Write("ERROR: at least one of your entries is empty!");
            }

            else
            {

                try
                {
                    cmd.ExecuteNonQuery();
                    Response.Write("\n\n Wishlist successfully added.");
                }

                catch (System.Data.SqlClient.SqlException E)
                {
                    Response.Write("Wishlist with that name already exists. Please choose another name.");
                    //SqlCommand cmd1 = new SqlCommand("deleteCustomer", conn);
                    //cmd1.CommandType = CommandType.StoredProcedure;
                    //cmd1.Parameters.Add(new SqlParameter("@username", username));
                    //cmd1.ExecuteNonQuery();

                }
            }

            conn.Close();
        }

        protected void addCC(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("AddCreditCard", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            try
            {
                string CCNum = CCnum.Text;
            DateTime CCexp = Convert.ToDateTime(CCdate.Text);
            string CCcode = CCcvv.Text;
            string username = (string)Session["username"];

            //pass parameters to the stored procedure
            
                cmd.Parameters.Add(new SqlParameter("@creditcardnumber", CCNum));
                cmd.Parameters.Add(new SqlParameter("@expirydate", CCexp));
                cmd.Parameters.Add(new SqlParameter("@cvv", CCcode));
                cmd.Parameters.Add(new SqlParameter("@customername", username));


            conn.Open();

             

            try
            {
                cmd.ExecuteNonQuery();
                Response.Write("\n\n Credit card successfully added.");
            }

            catch (System.Data.SqlClient.SqlException E)
            {
                Response.Write("Credit card already exists. Please re-check the number or add a new credit card.");
                SqlCommand cmd1 = new SqlCommand("deleteCC", conn);
                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.Parameters.Add(new SqlParameter("@username", username));
                cmd1.Parameters.Add(new SqlParameter("@creditcardnumber", CCNum));
                cmd1.ExecuteNonQuery();
                //1999-05-27 00:00:00
            }

          
        }



            catch (System.FormatException E)
            {
                Response.Write("Incorrect format for expiry date. Please use the following format: YYYY-MM-DD HH:MM:SS");
            }

            //catch(System.Data.SqlClient.SqlException E)
            //{
            //    Response.Write("Please make sure your cvv code consists of at most 4 characters.");
            //}

            conn.Close();
        }


        protected void addToWL(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addToWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = (string)Session["username"];
            string wishlist = WLAddname.Text;
            string prod = ProdAddWL.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@customername", username));
            cmd.Parameters.Add(new SqlParameter("@wishlistname", wishlist));
            cmd.Parameters.Add(new SqlParameter("@serial", prod));


            //Save the output from the procedure
            SqlParameter serialExists = cmd.Parameters.Add("@serialExists", SqlDbType.Bit);
            serialExists.Direction = ParameterDirection.Output;

            SqlParameter wlExists = cmd.Parameters.Add("@wlExists", SqlDbType.Bit);
            wlExists.Direction = ParameterDirection.Output;


            SqlParameter tupleExists = cmd.Parameters.Add("@tupleExists", SqlDbType.Bit);
            tupleExists.Direction = ParameterDirection.Output;



            //Executing the SQLCommand
            conn.Open();

            if (username == "" || wishlist == "" || prod == "")
            {
                Response.Write("ERROR: at least one of your entries is empty!");

            }

            else
            {
                try
                {
                    cmd.ExecuteNonQuery();
                    if (serialExists.Value.ToString().Equals("False"))
                        Response.Write("Serial does not exist in database");
                    else if (wlExists.Value.ToString().Equals("False"))
                        Response.Write("Wishlist name does not exist");
                    else if (tupleExists.Value.ToString().Equals("True"))
                        Response.Write("Item is already in wishlist");
                    else
                        Response.Write("\n\n Item successfully added to wishlist.");
                }

                catch (System.Data.SqlClient.SqlException E)
                {
                    Response.Write("Error: either the item already exists in wishlist, or you have entered an invalid item name or wishlist name.");
                    //SqlCommand cmd1 = new SqlCommand("deleteCustomer", conn);
                    //cmd1.CommandType = CommandType.StoredProcedure;
                    //cmd1.Parameters.Add(new SqlParameter("@username", username));
                    //cmd1.ExecuteNonQuery();

                }
            }

            conn.Close();
        }

        protected void remFromWL(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("removeFromWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = (string)Session["username"];
            string wishlist = WLRemname.Text;
            string prod = ProdRemWL.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@customername", username));
            cmd.Parameters.Add(new SqlParameter("@wishlistname", wishlist));
            cmd.Parameters.Add(new SqlParameter("@serial", prod));

            SqlParameter existsWL = cmd.Parameters.Add("@existsWL", SqlDbType.Bit);
            existsWL.Direction = ParameterDirection.Output;
            SqlParameter existsProdinWish = cmd.Parameters.Add("@existsProdWL", SqlDbType.Bit);
            existsProdinWish.Direction = ParameterDirection.Output;
            ////Save the output from the procedure
            //SqlParameter count = cmd.Parameters.Add("@count", SqlDbType.Int);
            //count.Direction = ParameterDirection.Output;

            //Executing the SQLCommand
            conn.Open();

            if (username == "" || wishlist == "" || prod == "")
            {
                Response.Write("ERROR: at least one of your entries is empty!");

            }

            else
            {

                try
                {
                    cmd.ExecuteNonQuery();

                    Response.Write("BELBEL");

                    if (existsWL.Value.ToString().Equals("True"))
                    {
                        if (existsProdinWish.Value.ToString().Equals("True"))
                        {
                            Response.Write("\n\n Item successfully removed wishlist.");
                        }

                        else if (existsProdinWish.Value.ToString().Equals("False"))
                        {
                            Response.Write("\n\n Such a product does not exist in this wishlist." +
                                "Try removing an item that is existing in this wishlist.");
                        }

                    }

                    else if (existsWL.Value.ToString().Equals("False"))
                    {
                        Response.Write("\n\n Such a wishlist does not exist. Try removing from an existing wishlist.");
                    }
                }

                catch (System.Data.SqlClient.SqlException E)
                {
                    Response.Write("Error.");
                    //SqlCommand cmd1 = new SqlCommand("deleteCustomer", conn);
                    //cmd1.CommandType = CommandType.StoredProcedure;
                    //cmd1.Parameters.Add(new SqlParameter("@username", username));
                    //cmd1.ExecuteNonQuery();

                }
            }
            conn.Close();
        }

        protected void addToCart(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addToCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = (string)Session["username"];
            string prod = ProdAddCart.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@customername", username));
            cmd.Parameters.Add(new SqlParameter("@serial", prod));


            ////Save the output from the procedure
            SqlParameter added = cmd.Parameters.Add("@alreadyadded", SqlDbType.Bit);
            added.Direction = ParameterDirection.Output;
            SqlParameter notav = cmd.Parameters.Add("@notavailable", SqlDbType.Bit);
            notav.Direction = ParameterDirection.Output;

            //Executing the SQLCommand
            conn.Open();
            if (username == "" || prod == "")
            {
                Response.Write("ERROR: at least one of your entries is empty!");

            }

            else
            {
                try
                {
                    cmd.ExecuteNonQuery();
                    if (notav.Value.ToString().Equals("True"))
                    {
                        Response.Write("\n\n Item unavailable.");

                    }

                    else if (added.Value.ToString().Equals("True"))
                    {
                        Response.Write("\n\n Item already in cart.");
                    }

                    else
                    {
                        Response.Write("\n\n Item successfully added to cart.");
                    }
                }

                catch (System.Data.SqlClient.SqlException E)
                {
                    Response.Write("Such an item does not exist in the database, or already exists in your cart.");
                    //SqlCommand cmd1 = new SqlCommand("deleteCustomer", conn);
                    //cmd1.CommandType = CommandType.StoredProcedure;
                    //cmd1.Parameters.Add(new SqlParameter("@username", username));
                    //cmd1.ExecuteNonQuery();

                }
            }
            conn.Close();
        }


        protected void remFromCart(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("removeFromCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = (string)Session["username"];
            string prod = ProdRemCart.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@customername", username));
            cmd.Parameters.Add(new SqlParameter("@serial", prod));
            ////Save the output from the procedure
            SqlParameter expro = cmd.Parameters.Add("@existproduct", SqlDbType.Bit);
            expro.Direction = ParameterDirection.Output;

            //Executing the SQLCommand
            conn.Open();
            if (username == "" || prod == "")
            {
                Response.Write("ERROR: at least one of your entries is empty!");

            }

            else
            {
                try
                {
                    cmd.ExecuteNonQuery();
                    if (expro.Value.ToString().Equals("True"))
                    {
                        Response.Write("\n\n Item successfully removed from cart.");

                    }

                    else
                    {
                        Response.Write("\n\n Product does not exist in cart. Cart intact. Try removing a product existing in the cart.");

                    }

                }

                catch (System.Data.SqlClient.SqlException E)
                {
                    Response.Write("Error.");
                    //SqlCommand cmd1 = new SqlCommand("deleteCustomer", conn);
                    //cmd1.CommandType = CommandType.StoredProcedure;
                    //cmd1.Parameters.Add(new SqlParameter("@username", username));
                    //cmd1.ExecuteNonQuery();

                }
            }
            conn.Close();

        }

        protected void make_order(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();
            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);
            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("iscartempty", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string username = (string)Session["username"];
            cmd.Parameters.Add(new SqlParameter("@username", username));
            ////Save the output from the procedure
            cmd.Parameters.Add("@count", SqlDbType.Int).Direction = ParameterDirection.Output;
            conn.Open();
            cmd.ExecuteNonQuery();
            int heh = int.Parse(cmd.Parameters["@count"].Value.ToString());
            conn.Close();

            if (heh==0)
            {
                Response.Write("ERROR: there is no products");

            }
            else
            {
                

                /*create a new SQL command which takes as parameters the name of the stored procedure and
                 the SQLconnection name*/
                SqlCommand cmd1 = new SqlCommand("makeOrder", conn);
                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.Parameters.Add(new SqlParameter("@customername", username));
                cmd1.Parameters.Add("@totalamount", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd1.Parameters.Add("@ordrnumber", SqlDbType.Int).Direction = ParameterDirection.Output;
                conn.Open();
                cmd1.ExecuteNonQuery();
                int orderid = int.Parse(cmd1.Parameters["@ordrnumber"].Value.ToString());
                decimal totalamount= decimal.Parse(cmd1.Parameters["@totalamount"].Value.ToString());
               // Response.Redirect("oredr.aspx");
                conn.Close();
                
                Session["amount"] =totalamount;
                Session["orderid"] =orderid;
                Response.Redirect("order.aspx");

            }

        }

        protected void Button10_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["Team23"].ToString();
            //create a new connection

            int order_no = int.Parse(TextBox1.Text);

            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("orderValid", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@order_no", order_no));

            SqlParameter exists = cmd.Parameters.Add("@exists", SqlDbType.Bit);
            exists.Direction = ParameterDirection.Output;

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            if (exists.Value.ToString().Equals("False"))
            {

                Response.Write("\n\n invalid order id.");
            }
            else
            {
                cmd = new SqlCommand("besela", conn);
                cmd.Parameters.Add(new SqlParameter("@order_no", order_no));
                cmd.CommandType = CommandType.StoredProcedure;

                exists = cmd.Parameters.Add("@exists", SqlDbType.Bit);
                exists.Direction = ParameterDirection.Output;

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (exists.Value.ToString().Equals("False"))
                {

                    Response.Write("\n\n incorrect order status.");
                }
                else
                {
                    cmd = new SqlCommand("cancelOrder", conn);
                    cmd.Parameters.Add(new SqlParameter("@orderid", order_no));
                    cmd.CommandType = CommandType.StoredProcedure;

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    Response.Write("\n\n order cancelled.");
                }


            }


        }
    }
}