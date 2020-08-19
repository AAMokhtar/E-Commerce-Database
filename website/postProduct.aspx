<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="postProduct.aspx.cs" Inherits="vendor.postProduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:validationsummary id="valSummary" runat="server"/>
            <asp:Label ID="lbl_name" runat="server" Text="Product Name: "></asp:Label>
               <br />
               <asp:TextBox ID="txt_name" runat="server" MaxLength="20"></asp:TextBox>
               <asp:RequiredFieldValidator ID="nameRequired" runat="server" ControlToValidate="txt_name" 
                             ErrorMessage="Product name is required" ToolTip="Product name is required." >*</asp:RequiredFieldValidator>
               <br />

               <asp:Label ID="lbl_category" runat="server" Text="Category: "></asp:Label>
               <br />
               <asp:TextBox ID="txt_category" runat="server" MaxLength="20"></asp:TextBox>
               <asp:RequiredFieldValidator ID="categoryRequired" runat="server" ControlToValidate="txt_category" 
                             ErrorMessage="Category is required" ToolTip="Category is required." >*</asp:RequiredFieldValidator>
               <br />

               <asp:Label ID="lbl_description" runat="server" Text="Description: "></asp:Label>
               <br />
               <asp:TextBox ID="txt_description" runat="server"></asp:TextBox>
               <asp:RequiredFieldValidator ID="descriptionRequired" runat="server" ControlToValidate="txt_description" 
                             ErrorMessage="Description is required" ToolTip="Description is required." >*</asp:RequiredFieldValidator>
               <br />

               <asp:Label ID="lbl_price" runat="server" Text="Price: "></asp:Label>
               <br />
               <asp:TextBox ID="txt_price" runat="server" type="number" step="0.01"></asp:TextBox>
               <asp:RequiredFieldValidator ID="priceRequired" runat="server" ControlToValidate="txt_price" 
                             ErrorMessage="Price is required" ToolTip="Price is required." >*</asp:RequiredFieldValidator>
               <br />

               <asp:Label ID="lbl_color" runat="server" Text="Color: "></asp:Label>
               <br />
               <asp:TextBox ID="txt_color" runat="server" MaxLength="20"></asp:TextBox>
               <asp:RequiredFieldValidator ID="colorRequired" runat="server" ControlToValidate="txt_color" 
                             ErrorMessage="Color is required" ToolTip="Color is required." >*</asp:RequiredFieldValidator>
               <br />

               <br />

               <asp:Button ID="post_product" runat="server" Text="Post Product" onclick="addProduct" Width="200px"/>
               
               <br />
               <br />
                
               <asp:HyperLink ID="goHome" runat="server" Text="Back to Home" NavigateUrl="~/vendorHome.aspx" />
        </div>
    </form>
</body>
</html>
