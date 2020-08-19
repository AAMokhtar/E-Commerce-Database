<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="vendorHome.aspx.cs" Inherits="vendor.vendorHome1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="post_product" runat="server" Text="Post Product" onclick="openPostProduct" Width="200px"/>
            <asp:Button ID="view_product" runat="server" Text="View Products" onclick="openViewProducts" Width="200px"/>
            <asp:Button ID="edit_product" runat="server" Text="Edit Product" onclick="openEditProduct" Width="200px"/>
            <asp:Button ID="add_offer" runat="server" Text="Add Offer" onclick="openAddOffer" Width="200px"/>
            <asp:Button ID="view_offers" runat="server" Text="View Offers" onclick="openViewOffers" Width="200px"/>
            <asp:Button ID="apply_offer" runat="server" Text="Apply Offer" onclick="openApplyOffer" Width="200px"/>
            <asp:Button ID="remove_offer" runat="server" Text="Remove Expired Offers" onclick="openRemoveOffer" Width="200px"/>
            
            <br />
            <br />

            <asp:LinkButton ID="logout" runat="server" Text="Logout" onClick="callLogout"/>
        
        </div>
    </form>
</body>
</html>
