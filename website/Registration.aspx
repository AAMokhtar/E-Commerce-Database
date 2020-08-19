<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="M3v3.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="Register as a..."></asp:Label>
            <br />
            <br />
            <asp:Button ID="VendBut" runat="server" Text="Vendor" onclick="registerVendor"/>

            <asp:Button ID="CusBut" runat="server" Text="Customer" onclick="registerCustomer"/>


            <br />
            <br />

            <br />
            <asp:Label ID="Label2" runat="server" Text="Label">Or login if you have an account!</asp:Label>
            <asp:Button ID="Button1" runat="server" Text="Login"  onclick ="logF"/>

        </div>
    </form>
</body>
</html>
