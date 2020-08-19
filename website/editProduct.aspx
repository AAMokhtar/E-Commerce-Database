<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="editProduct.aspx.cs" Inherits="vendor.editProduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:validationsummary id="valSummary" runat="server" />

            <asp:Label ID="lbl_serial" runat="server" Text="Serial Number: "></asp:Label>
               <br />
               <asp:TextBox ID="txt_serial" type="number" runat="server" max="2147483647"></asp:TextBox>
               <asp:RequiredFieldValidator ID="serialRequired" runat="server" ControlToValidate="txt_serial" 
                             ErrorMessage="Serial is required" ToolTip="Serial is required." >*</asp:RequiredFieldValidator>
               <br />
               <br />
               <br />
                
               <asp:Label ID="lbl_name" runat="server" Text="Product Name: "></asp:Label>
               <br />
               <asp:TextBox ID="txt_name" runat="server" MaxLength="20"></asp:TextBox>
              

               <br />

              

          
               <asp:Label ID="lbl_category" runat="server" Text="Category: "></asp:Label>
               <br />
               <asp:TextBox ID="txt_category" runat="server" MaxLength="20"></asp:TextBox>
              
               
               <br />



               <asp:Label ID="lbl_description" runat="server" Text="Description: "></asp:Label>
               <br />
               <asp:TextBox ID="txt_description" runat="server"></asp:TextBox>
               

               <br />

             

               <asp:Label ID="lbl_price" runat="server" Text="Price: "></asp:Label>
               <br />
               <asp:TextBox ID="txt_price" runat="server" type="number" step="0.01"></asp:TextBox>
               
               <br />

              

               <asp:Label ID="lbl_color" runat="server" Text="Color: "></asp:Label>
               <br />
               <asp:TextBox ID="txt_color" runat="server" MaxLength="20"></asp:TextBox>
              
               <br />
               <br />

               <asp:Button ID="edit" runat="server" Text="Update Product" onclick="updateProduct" Width="200px" />

               <br />
               <br />

                
               <asp:HyperLink ID="goHome" runat="server" Text="Back to Home" NavigateUrl="~/vendorHome.aspx" />
        </div>
    </form>
</body>
</html>
