<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrationCustomer.aspx.cs" Inherits="M3v3.RegistrationCustomer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>


            <asp:Label ID="Label1" runat="server" Text="Label">Customer Registration</asp:Label>
        

            <br />
            <br />


            <asp:Label ID="Label2" runat="server" Text="Label">Customer Username</asp:Label>
            <br />
            <asp:TextBox ID="usernameC" runat="server"></asp:TextBox>


            <br />
            <br />


            <asp:Label ID="Label3" runat="server" Text="Label">Customer Password</asp:Label>
            <br />
            <asp:TextBox ID="passwordC" runat="server"></asp:TextBox>

            

            <br />
            <br />




            <asp:Label ID="Label4" runat="server" Text="Label">Customer First Name</asp:Label>
            <br />
            <asp:TextBox ID="firstNameC" runat="server"></asp:TextBox>

            

            <br />
            <br />




            <asp:Label ID="Label5" runat="server" Text="Label">Customer Last Name</asp:Label>
            <br />
            <asp:TextBox ID="lastNameC" runat="server"></asp:TextBox>
            

            <br />
            <br />



            <asp:Label ID="Label6" runat="server" Text="Label">Email</asp:Label>
             <br />
            <asp:TextBox ID="emailC" runat="server"></asp:TextBox>
            

            <br />
            <br />

             <asp:Button ID="reg" runat="server" Text="Register" OnClick ="regCus" />
            <br />
            <br />

            <asp:Label ID="Label7" runat="server" Text="Label">If you created an account, you may log in now.</asp:Label>
            <br />           
            <asp:Button ID="Button1" runat="server" Text="Login" OnClick ="logF"/>

        </div>
    </form>
</body>
</html>
