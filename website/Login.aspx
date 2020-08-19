<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="M3v3.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Label">Login</asp:Label>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Label">Username</asp:Label>
            <br />
            <asp:TextBox ID="eUsername" runat="server"></asp:TextBox>

            <br />
            <br />

            <asp:Label ID="Label3" runat="server" Text="Label">Password</asp:Label>
            <br />
            <asp:TextBox ID="ePassword" runat="server"></asp:TextBox>

            <br />
            <br />

            <asp:Button ID="Button1" runat="server" Text="Login" OnClick="logFun" />

            <br />
            <br />
            <asp:Button ID="registration" runat="server" OnClick="registration_Click" Text="Register" />

        </div>
    </form>
</body>
</html>
