
/*
B)bbbb                           l)L                 x  x  
B)   bb                           l)              x        x 
B)bbbb   e)EEEEE  s)SSSS e)EEEEE  l)  a)AAAA     x          x
B)   bb  e)EEEE  s)SSSS  e)EEEE   l)   a)AAA     x          x
B)    bb e)           s) e)       l)  a)   A      x        x
B)bbbbb   e)EEEE s)SSSS   e)EEEE l)LL  a)AAAA        x  x
*/

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin
{
    public partial class HomePageAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            errorUpdateorder.Text = "";
            errorActivateVendor.Text = "";
            errorAddDeal.Text = "";
            errorRemoveDeal.Text = "";
            errorDealProduct.Text = "";
            errorPhone.Text = "";

        }
        //---------------------------------------------------------------------->>>
        protected void LoadOrders() //get orders table
        {

        //connection
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Team23"].ToString());
        SqlCommand cmd = new SqlCommand("reviewOrders", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        conn.Open();

        //read records
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        while (rdr.Read())
        {
            
            Label orderNum = new Label();
            orderNum.Text = "Number: " + rdr.GetSqlInt32(rdr.GetOrdinal("order_no")) + ",";
            Form1.Controls.Add(orderNum);

            Label date = new Label();
            date.Text = " Date: " + (rdr.IsDBNull(1) ? "null" : rdr.GetDateTime(rdr.GetOrdinal("order_date")) + "") + ",";
            Form1.Controls.Add(date);

            Label total_amount = new Label();
            total_amount.Text = " total amount: " + (rdr.IsDBNull(2) ? "null" : rdr.GetDecimal(rdr.GetOrdinal("total_amount")) + "") + ",";
            Form1.Controls.Add(total_amount);

            Label cash_amount = new Label();
            cash_amount.Text = " cash amount: " + (rdr.IsDBNull(3) ? "null" : rdr.GetDecimal(rdr.GetOrdinal("cash_amount")) + "") + ",";
            Form1.Controls.Add(cash_amount);

            Label credit_amount = new Label();
            credit_amount.Text = " credit amount: " + (rdr.IsDBNull(4) ? "null" : rdr.GetDecimal(rdr.GetOrdinal("credit_amount")) + "") + ",";
            Form1.Controls.Add(credit_amount);

            Label payment_type = new Label();
            payment_type.Text = " payment type: " + (rdr.IsDBNull(5) ? "null" : rdr.GetString(rdr.GetOrdinal("payment_type"))) + ",";
            Form1.Controls.Add(payment_type);

            Label order_status = new Label();
            order_status.Text = " order status: " + (rdr.IsDBNull(6) ? "null" : rdr.GetString(rdr.GetOrdinal("order_status"))) + ",";
            Form1.Controls.Add(order_status);

            Label remaining_days = new Label();
            remaining_days.Text = " remaining days: " + (rdr.IsDBNull(7) ? "null" : rdr.GetInt32(rdr.GetOrdinal("remaining_days")) + "") + ",";
            Form1.Controls.Add(remaining_days);

            Label time_limit = new Label();
            time_limit.Text = " time limit: " + (rdr.IsDBNull(8) ? "null" : rdr.GetString(rdr.GetOrdinal("time_limit"))) + ",";
            Form1.Controls.Add(time_limit);

            Label gift_card_code_used = new Label();
            gift_card_code_used.Text = " giftcard: " + (rdr.IsDBNull(9) ? "null" : rdr.GetString(rdr.GetOrdinal("gift_card_code_used"))) + ",";
            Form1.Controls.Add(gift_card_code_used);

            Label customer_name = new Label();
            customer_name.Text = " customer name: " + rdr.GetString(rdr.GetOrdinal("customer_name")) + ",";
            Form1.Controls.Add(customer_name);

            Label delivery_id = new Label();
            delivery_id.Text = " delivery id: " + (rdr.IsDBNull(11) ? "null" : rdr.GetInt32(rdr.GetOrdinal("delivery_id")) + "") + ",";
            Form1.Controls.Add(delivery_id);

            Label creditCard_number = new Label();
            creditCard_number.Text = " credit card: " + (rdr.IsDBNull(12) ? "null" : rdr.GetString(rdr.GetOrdinal("creditCard_number")));

            Form1.Controls.Add(creditCard_number);

            Label divider = new Label();

            Form1.Controls.Add(new LiteralControl("<br />"));

            divider.Text = "----------------------------------------------------------------------------------------------------------------------------------------------------";

            Form1.Controls.Add(divider);
            Form1.Controls.Add(new LiteralControl("<br />"));

         }

        }
        //---------------------------------------------------------------------->>>
        protected void LoadVendors() //get vendors table
        {

            //connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Team23"].ToString());
            SqlCommand cmd = new SqlCommand("LoadVendors", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            conn.Open();

            //read records
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
               
                Label username = new Label();
                username.Text = "Username: " + rdr.GetString(rdr.GetOrdinal("username")) + ",";
                Form1.Controls.Add(username);

                Label activated = new Label();
                activated.Text = " activated: " + (rdr.IsDBNull(1) ? "null" : rdr.GetBoolean(rdr.GetOrdinal("activated")) + "") + ",";
                Form1.Controls.Add(activated);

                Label company_name = new Label();
                company_name.Text = " company name: " + (rdr.IsDBNull(2) ? "null" : rdr.GetString(rdr.GetOrdinal("company_name"))) + ",";
                Form1.Controls.Add(company_name);

                Label bank_acc_no = new Label();
                bank_acc_no.Text = " bank acc no : " + (rdr.IsDBNull(3) ? "null" : rdr.GetString(rdr.GetOrdinal("bank_acc_no"))) + ",";
                Form1.Controls.Add(bank_acc_no);
          
                Label admin_username = new Label();
                admin_username.Text = "admin username: " + (rdr.IsDBNull(4) ? "null" : rdr.GetString(rdr.GetOrdinal("admin_username"))) + ",";
                Form1.Controls.Add(admin_username);

                Label divider = new Label();

                Form1.Controls.Add(new LiteralControl("<br />"));

                divider.Text = "----------------------------------------------------------------------------------------------------------------------------------------------------";

                Form1.Controls.Add(divider);
                Form1.Controls.Add(new LiteralControl("<br />"));

            }

        }
        //---------------------------------------------------------------------->>>
        protected void LoadTodaysDeals() //you get the idea
        {

            //connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Team23"].ToString());
            SqlCommand cmd = new SqlCommand("LoadTodaysDeals", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            conn.Open();

            //read records
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {

                Label deal_id = new Label();
                deal_id.Text = "id: " + rdr.GetSqlInt32(rdr.GetOrdinal("deal_id")) + ",";
                Form1.Controls.Add(deal_id);

                Label deal_amount = new Label();
                deal_amount.Text = " amount(%): " + (rdr.IsDBNull(1) ? "null" : rdr.GetInt32(rdr.GetOrdinal("deal_amount")) + "") + ",";
                Form1.Controls.Add(deal_amount);

                Label expiry_date = new Label();
                expiry_date.Text = " expiry date: " + (rdr.IsDBNull(2) ? "null" : rdr.GetDateTime(rdr.GetOrdinal("expiry_date")) + "") + ",";
                Form1.Controls.Add(expiry_date);

                Label admin_username = new Label();
                admin_username.Text = " admin username: " + rdr.GetString(rdr.GetOrdinal("admin_username")) + ",";
                Form1.Controls.Add(admin_username);
  
                Label divider = new Label();

                Form1.Controls.Add(new LiteralControl("<br />"));

                divider.Text = "----------------------------------------------------------------------------------------------------------------------------------------------------";

                Form1.Controls.Add(divider);
                Form1.Controls.Add(new LiteralControl("<br />"));

            }

        }
        //---------------------------------------------------------------------->>>

        protected void LoadProducts()
        {

            //connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Team23"].ToString());
            SqlCommand cmd = new SqlCommand("LoadProducts", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            conn.Open();

            //read records
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                //Get the value of the attribute name in the Company table

                Label serial_no = new Label();
                serial_no.Text = "serial no: " + rdr.GetSqlInt32(rdr.GetOrdinal("serial_no")) + ",";
                Form1.Controls.Add(serial_no);

                Label product_name = new Label();
                product_name.Text = " product name: " + (rdr.IsDBNull(1) ? "null" : rdr.GetString(rdr.GetOrdinal("product_name"))) + ",";
                Form1.Controls.Add(product_name);

                Label category = new Label();
                category.Text = " category: " + (rdr.IsDBNull(2) ? "null" : rdr.GetString(rdr.GetOrdinal("category"))) + ",";
                Form1.Controls.Add(category);

                Label product_description = new Label();
                product_description.Text = " description: " + (rdr.IsDBNull(3) ? "null" : rdr.GetString(rdr.GetOrdinal("product_description"))) + ",";
                Form1.Controls.Add(product_description);

                Label price = new Label();
                price.Text = " price: " + (rdr.IsDBNull(4) ? "null" : rdr.GetDecimal(rdr.GetOrdinal("price"))+"") + ",";
                Form1.Controls.Add(price);

                Label final_price = new Label();
                final_price.Text = " final price: " + (rdr.IsDBNull(5) ? "null" : rdr.GetDecimal(rdr.GetOrdinal("final_price")) + "") + ",";
                Form1.Controls.Add(final_price);

                Label color = new Label();
                color.Text = " color: " + (rdr.IsDBNull(6) ? "null" : rdr.GetString(rdr.GetOrdinal("color"))) + ",";
                Form1.Controls.Add(color);

                Label available = new Label();
                available.Text = " available: " + (rdr.IsDBNull(7) ? "null" : rdr.GetBoolean(rdr.GetOrdinal("available"))+"") + ",";
                Form1.Controls.Add(available);

                Label rate = new Label();
                rate.Text = " rating: " + (rdr.IsDBNull(8) ? "null" : rdr.GetDecimal(rdr.GetOrdinal("rate")) + "") + ",";
                Form1.Controls.Add(rate);

                Label vendor_username = new Label();
                rate.Text = " vendor username: " + (rdr.IsDBNull(9) ? "null" : rdr.GetString(rdr.GetOrdinal("vendor_username")) + "") +",";
                Form1.Controls.Add(vendor_username);

                Label customer_username = new Label();
                customer_username.Text = " customer username: " + (rdr.IsDBNull(10) ? "null" : rdr.GetString(rdr.GetOrdinal("customer_username")) + "") + ",";
                Form1.Controls.Add(customer_username);

                Label customer_order_id = new Label();
                customer_order_id.Text = " order id: " + (rdr.IsDBNull(11) ? "null" : rdr.GetInt32(rdr.GetOrdinal("customer_order_id")) + "") + ",";
                Form1.Controls.Add(customer_order_id);

                Label divider = new Label();

                Form1.Controls.Add(new LiteralControl("<br />"));

                divider.Text = "----------------------------------------------------------------------------------------------------------------------------------------------------";

                Form1.Controls.Add(divider);
                Form1.Controls.Add(new LiteralControl("<br />"));

            }

        }
        //---------------------------------------------------------------------->>>

        protected void LoadTodaysDealsOnProduct()
        {

            //connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Team23"].ToString());
            SqlCommand cmd = new SqlCommand("LoadTodaysDealsOnProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            conn.Open();


            //read records
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr.Read())
            {

                Label deal_id = new Label();
                deal_id.Text = "deal_id: " + rdr.GetSqlInt32(rdr.GetOrdinal("deal_id")) + ",";
                Form1.Controls.Add(deal_id);
   
                Label serial_no = new Label();
                serial_no.Text = " serial no: " + (rdr.IsDBNull(1) ? "null" : rdr.GetInt32(rdr.GetOrdinal("serial_no")) + "") + ",";
                Form1.Controls.Add(serial_no);

               
                Label divider = new Label();

                Form1.Controls.Add(new LiteralControl("<br />"));

                divider.Text = "----------------------------------------------------------------------------------------------------------------------------------------------------";

                Form1.Controls.Add(divider);
                Form1.Controls.Add(new LiteralControl("<br />"));

            }

        }
        //---------------------------------------------------------------------->>>
        protected void LoadPhoneNums()
        {
            // Session["username"] = "nada.sharaf";

            //connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Team23"].ToString());
            SqlCommand cmd = new SqlCommand("LoadPhoneNums", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", Session["username"]));

            conn.Open();


            //read records
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr.Read())
            {
                //Get the value of the attribute name in the Company table

                Label mobile_number = new Label();
                mobile_number.Text = "mobile number: " + rdr.GetString(rdr.GetOrdinal("mobile_number"));
                Form1.Controls.Add(mobile_number);

                Label divider = new Label();

                Form1.Controls.Add(new LiteralControl("<br />"));

                divider.Text = "----------------------------------------------------------------------------------------------------------------------------------------------------";

                Form1.Controls.Add(divider);
                Form1.Controls.Add(new LiteralControl("<br />"));

            }

        }
        //---------------------------------------------------------------------->>>

        protected void updateorder_Click(object sender, EventArgs e) //update order status to "in process"
        {
            //connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Team23"].ToString());


            //To read the input from the user
            String textbox = updateordertext.Text;

            //digits only
            int orderNum = -1;
            int i;
            for (i = 0; i < textbox.Length; i++) if (textbox[i] < '0' || textbox[i] > '9') break;
            
            if (i == textbox.Length && textbox.Length > 0)
                orderNum = int.Parse(textbox);

            SqlCommand cmd = new SqlCommand("orderValid", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@order_no", orderNum));

            //Save the output from the procedure
            SqlParameter exists = cmd.Parameters.Add("@exists", SqlDbType.Bit);
            exists.Direction = ParameterDirection.Output;

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            if (exists.Value.ToString().Equals("False")) 
            {
               
                errorUpdateorder.Text =  "invalid order id";
            }
            else
            {

                cmd = new SqlCommand("orderInProcess", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@order_no", orderNum));

                //Save the output from the procedure
                exists = cmd.Parameters.Add("@exists", SqlDbType.Bit);
                exists.Direction = ParameterDirection.Output;

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (exists.Value.ToString().Equals("True"))
                {
                    errorUpdateorder.Text = "order is already in process";
                }
                else
                {

                    cmd = new SqlCommand("updateOrderStatusInProcess", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@order_no", orderNum));

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    errorUpdateorder.Text = "update successful";

                }

            }

            RadioButtonList1_SelectedIndexChanged(sender, e); //restore table
        }
        //----------------------------------------------------------------------
        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e) //table selector
        {

            switch (tableSelector.SelectedIndex) {

                case 0: LoadVendors(); break;

                case 1: LoadOrders(); break;

                case 2: LoadTodaysDeals(); break;

                case 3: LoadProducts(); break;

                case 4: LoadTodaysDealsOnProduct();break;

                case 5: LoadPhoneNums(); break;

                default: break;
            }

        }
        //----------------------------------------------------------------------
        protected void ActivateBtn_Click(object sender, EventArgs e) //activate vendors
        {
            //connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Team23"].ToString());


            //To read the input from the user
            String textbox = ActivateTxt.Text;

            SqlCommand cmd = new SqlCommand("vendorValid", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", textbox));

            //Save the output from the procedure
            SqlParameter exists = cmd.Parameters.Add("@exists", SqlDbType.Bit);
            exists.Direction = ParameterDirection.Output;

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            if (exists.Value.ToString().Equals("False"))
            {
                errorActivateVendor.Text = "invalid vendor username";
            }
            else
            {
                cmd = new SqlCommand("isActivated", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@vendorUsername", textbox));

                exists = cmd.Parameters.Add("@isActivated", SqlDbType.Bit);
                exists.Direction = ParameterDirection.Output;

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (exists.Value.ToString().Equals("True"))
                {
                    errorActivateVendor.Text = "vendor is already activated";
                }
                else
                {
                    //Session["username"] = "nada.sharaf";

                    cmd = new SqlCommand("activateVendors", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@vendor_username", textbox));
                    cmd.Parameters.Add(new SqlParameter("@admin_username", Session["username"]));

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    errorActivateVendor.Text = "vendor successfully activated";

                }


            }

            RadioButtonList1_SelectedIndexChanged(sender, e); //restore tables
        }
        //----------------------------------------------------------------------
        protected void AddDeal_Click(object sender, EventArgs e) //create today's deal
        {
            //connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Team23"].ToString());


            //To read the input from the user
            String textbox = dealamounttxt.Text;

            //digits only
            int dealAmount = -1;
            int i;
            for (i = 0; i < textbox.Length; i++) if (textbox[i] < '0' || textbox[i] > '9') break;

            if (i == textbox.Length && textbox.Length > 0)
                dealAmount = int.Parse(textbox);

            //1-100
            if(dealAmount < 0 || dealAmount > 100)
            {
                errorAddDeal.Text = "deal amount should be between 1 and 100";
            }
            else
            {
    
                if(expiryDate.Text.Equals(""))
                {
                    errorAddDeal.Text = "please choose an expiry date from the calendar below";
                }
                else
                {
                     DateTime chosenDate = Convert.ToDateTime(expiryDate.Text);
                     DateTime currentDate = System.DateTime.Now;

                    if (chosenDate <= currentDate)
                    {
                        errorAddDeal.Text = "expiry date cannot be in the past";
                    }
                    else
                    {
                        //Session["username"] = "nada.sharaf";
                        SqlCommand cmd = new SqlCommand("createTodaysDeal", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@deal_amount", dealAmount));
                        cmd.Parameters.Add(new SqlParameter("@admin_username", Session["username"]));
                        cmd.Parameters.Add(new SqlParameter("@expiry_date", chosenDate));

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();

                        errorAddDeal.Text = "deal successfully added";

                    }
                }
                
            }

            RadioButtonList1_SelectedIndexChanged(sender, e); //restore table
        }
        //----------------------------------------------------------------------
        protected void Calendar1_SelectionChanged1(object sender, EventArgs e) //calendar
        {
            expiryDate.Text = Calendar1.SelectedDate.ToString();
            RadioButtonList1_SelectedIndexChanged(sender, e);  
        }
        //----------------------------------------------------------------------
        protected void RemoveDealBtn_Click(object sender, EventArgs e) //remove today's deal
        {
            //connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Team23"].ToString());


            //To read the input from the user
            String textbox = DealIdTxt.Text;

            //digits only
            int id = -1;
            int i;
            for (i = 0; i < textbox.Length; i++) if (textbox[i] < '0' || textbox[i] > '9') break;

            if (i == textbox.Length && textbox.Length > 0)
                id = int.Parse(textbox);

            SqlCommand cmd = new SqlCommand("dealValid", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@deal_id", id));

            SqlParameter exists = cmd.Parameters.Add("@exists", SqlDbType.Bit);
            exists.Direction = ParameterDirection.Output;

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            if (exists.Value.ToString().Equals("False"))
            {
                errorRemoveDeal.Text = "input id does not match any deal";
            }
            else
            {

                cmd = new SqlCommand("dealExpired", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@deal_id", id));

                exists = cmd.Parameters.Add("@exists", SqlDbType.Bit);
                exists.Direction = ParameterDirection.Output;

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (exists.Value.ToString().Equals("False"))
                {
                    errorRemoveDeal.Text = "the deal has not yet expired";
                }
                else
                {

                    cmd = new SqlCommand("removeExpiredDeal", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@deal_id", id));

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    errorRemoveDeal.Text = "deal removed successfuly";

                }
            }

            RadioButtonList1_SelectedIndexChanged(sender, e); //restore table
        }
        //----------------------------------------------------------------------
        protected void DealProductBtn_Click(object sender, EventArgs e) //add deal on product
        {
            //connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Team23"].ToString());

            //To read the input from the user
            String textbox = DealProductDealTxt.Text;

            //digits only
            int id = -1;
            int i;
            for (i = 0; i < textbox.Length; i++) if (textbox[i] < '0' || textbox[i] > '9') break;

            if (i == textbox.Length && textbox.Length > 0)
                id = int.Parse(textbox);

            SqlCommand cmd = new SqlCommand("dealValid", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@deal_id", id));

            //Save the output from the procedure
            SqlParameter exists = cmd.Parameters.Add("@exists", SqlDbType.Bit);
            exists.Direction = ParameterDirection.Output;

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            if (exists.Value.ToString().Equals("False"))
            {
                errorDealProduct.Text = "input id does not match any deal";
            }
            else
            {
                //read second input
                String textbox2 = DealProductProductTxt.Text;

                //digits only
                int sn = -1;
                
                for (i = 0; i < textbox2.Length; i++) if (textbox2[i] < '0' || textbox2[i] > '9') break;

                if (i == textbox2.Length && textbox2.Length > 0)
                    sn = int.Parse(textbox2);

                cmd = new SqlCommand("ProductValid", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@serial_no", sn));

                //Save the output from the procedure
                exists = cmd.Parameters.Add("@exists", SqlDbType.Bit);
                exists.Direction = ParameterDirection.Output;

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (exists.Value.ToString().Equals("False"))
                {
                    errorDealProduct.Text = "product does not exist";
                }
                else
                {

                    cmd = new SqlCommand("checkTodaysDealOnProduct", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@serial_no", sn));

                    //Save the output from the procedure
                    exists = cmd.Parameters.Add("@activeDeal", SqlDbType.Bit);
                    exists.Direction = ParameterDirection.Output;

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    if (exists.Value.ToString().Equals("True"))
                    {
                        errorDealProduct.Text = "product has an active deal on it";
                    }
                    else
                    {

                        cmd = new SqlCommand("dealExpired", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@deal_id", id));

                        //Save the output from the procedure
                        exists = cmd.Parameters.Add("@exists", SqlDbType.Bit);
                        exists.Direction = ParameterDirection.Output;

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();

                        if (exists.Value.ToString().Equals("True"))
                        {
                            errorDealProduct.Text = "deal expired";
                        }
                        else
                        {

                            cmd = new SqlCommand("addTodaysDealOnProduct", conn);
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.Add(new SqlParameter("@deal_id", id));
                            cmd.Parameters.Add(new SqlParameter("@serial_no", sn));

                            conn.Open();
                            cmd.ExecuteNonQuery();
                            conn.Close();

                            errorDealProduct.Text = "deal added successfully";
                        }

                    }
                }

            }

            RadioButtonList1_SelectedIndexChanged(sender, e); //restore table
        }
        //----------------------------------------------------------------------
        protected void phoneNumBtn_Click(object sender, EventArgs e) //add phone number
        {
            //Session["username"] = "nada.sharaf";

            //connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Team23"].ToString());


            //To read the input from the user
            String textbox = phoneNumTxt.Text;

            //digits with length 10-11
            int i;
            for (i = 0; i < textbox.Length; i++) if (textbox[i] < '0' || textbox[i] > '9') break;

            if (i == textbox.Length && textbox.Length > 9 && textbox.Length < 12)
            {

                SqlCommand cmd = new SqlCommand("phoneNumValid", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@username", Session["username"]));
                cmd.Parameters.Add(new SqlParameter("@mobile_number", textbox));

                //Save the output from the procedure
                SqlParameter exists = cmd.Parameters.Add("@exists", SqlDbType.Bit);
                exists.Direction = ParameterDirection.Output;

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                if (exists.Value.ToString().Equals("True"))
                {
                    errorPhone.Text = "phone number already exists";
                }
                else
                {

                    cmd = new SqlCommand("addMobile", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@username", Session["username"]));
                    cmd.Parameters.Add(new SqlParameter("@mobile_number", textbox));

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    errorPhone.Text = "phone number added successfully";

                }

            }
            else
            {
                errorPhone.Text = "enter a valid phone number";
            }

            RadioButtonList1_SelectedIndexChanged(sender, e); //restore table


        }

        protected void Button1_Click(object sender, EventArgs e) //logout
        {
            Session.Abandon();
            Session.Clear();
            Response.Redirect("Login.aspx", true);
        }
    }
}

