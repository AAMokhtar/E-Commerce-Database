using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace vendor
{
    public partial class vendorHome1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void openPostProduct(object sender, EventArgs e)
        {
            Response.Redirect("postProduct.aspx", true);
        }

        protected void openViewProducts(object sender, EventArgs e)
        {
            Response.Redirect("viewProducts.aspx", true);
        }

        protected void openEditProduct(object sender, EventArgs e)
        {
            Response.Redirect("editProduct.aspx", true);
        }

        protected void openAddOffer(object sender, EventArgs e)
        {
            Response.Redirect("addOffer.aspx", true);
        }

        protected void openViewOffers(object sender, EventArgs e)
        {
            Response.Redirect("viewOffers.aspx");
        }
        protected void openApplyOffer(object sender, EventArgs e)
        {
            Response.Redirect("applyOffer.aspx", true);
        }

        protected void openRemoveOffer(object sender, EventArgs e)
        {
            Response.Redirect("removeOffer.aspx", true);
        }

        protected void callLogout(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Clear();
            Response.Redirect("Login.aspx", true);
        }
    }
}