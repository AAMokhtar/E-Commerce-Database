<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="order.aspx.cs" Inherits="M3v3.oredr" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            YOUR ORDER INFO:<br />
            <br />
        </div>
        <p>
            <asp:Label ID="order" runat="server" Text="order id : "></asp:Label>
        </p>
        <asp:Label ID="cost" runat="server" Text="total cost in LE: "></asp:Label>
        <br />
        
        <br />
        PAYMENT METHOD<br />
&nbsp;<asp:DropDownList ID="D1" runat="server">
            <asp:ListItem>cash</asp:ListItem>
            <asp:ListItem>credit</asp:ListItem>
            <asp:ListItem></asp:ListItem>
        </asp:DropDownList>
        <br />
        ENTER THE AMOUNT OF MONY USED FROM YOUR METHOD:<br />
        <asp:TextBox ID="amount" runat="server" ></asp:TextBox>
        <br />
        <br />
        IN CASE OF CREDIT CARD PLESE ENTER ITS NUMBER:<br />
        <asp:TextBox ID="ccnum" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="update" runat="server" Text="update info" OnClick="update_Click" />
        <br />
        
    </form>
</body>
</html>
