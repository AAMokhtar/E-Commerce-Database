<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="applyOffer.aspx.cs" Inherits="vendor.applyOffer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:validationsummary id="valSummary" runat="server"/>
            <br />
               <asp:Label ID="lbl_offer" runat="server" Text="Offer ID: "></asp:Label>
               <br />
               <asp:TextBox ID="txt_offer" runat="server" type="number" max="2147483647"></asp:TextBox>
               <asp:RequiredFieldValidator ID="offerRequired" runat="server" ControlToValidate="txt_offer" 
                             ErrorMessage="Offer ID is required" ToolTip="Offer ID is required." >*</asp:RequiredFieldValidator>
               <br />

               <asp:Label ID="lbl_serial" runat="server" Text="Serial Number: "></asp:Label>
               <br />
               <asp:TextBox ID="txt_serial" runat="server" type="number" max="2147483647"></asp:TextBox>
               <asp:RequiredFieldValidator ID="serialRequired" runat="server" ControlToValidate="txt_serial" 
                             ErrorMessage="Serial is required" ToolTip="Serial is required." >*</asp:RequiredFieldValidator>
               <br />
               <br />

               <asp:Button ID="submitOffer" runat="server" Text="Apply Offer" onclick="putOffer" Width="200px"/>
               
               <br />
               <br />
                
               <asp:HyperLink ID="goHome" runat="server" Text="Back to Home" NavigateUrl="~/vendorHome.aspx" />
        </div>
    </form>
</body>
</html>
