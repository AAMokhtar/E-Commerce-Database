<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegistrationVendor.aspx.cs" Inherits="M3v3.RegistrationVendor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:Label ID="Label1" runat="server" Text="Label">Vendor Registration</asp:Label>
        

            <br />
            <br />


            <asp:Label ID="Label2" runat="server" Text="Label">Vendor Username</asp:Label>
            <br />
            <asp:TextBox ID="usernameV" runat="server"></asp:TextBox>


            <br />
            <br />


            <asp:Label ID="Label3" runat="server" Text="Label">Vendor Password</asp:Label>
            <br />
            <asp:TextBox ID="passwordV" runat="server"></asp:TextBox>

            

            <br />
            <br />




            <asp:Label ID="Label4" runat="server" Text="Label">Vendor First Name</asp:Label>
            <br />
            <asp:TextBox ID="firstNameV" runat="server"></asp:TextBox>

            

            <br />
            <br />




            <asp:Label ID="Label5" runat="server" Text="Label">Vendor Last Name</asp:Label>
            <br />
            <asp:TextBox ID="lastNameV" runat="server"></asp:TextBox>
            

            <br />
            <br />



            <asp:Label ID="Label6" runat="server" Text="Label">Email</asp:Label>
             <br />
            <asp:TextBox ID="emailV" runat="server"></asp:TextBox>
            

            <br />
            <br />



            <asp:Label ID="Label7" runat="server" Text="Label">Company</asp:Label>
             <br />
            <asp:TextBox ID="companyV" runat="server"></asp:TextBox>
            

            <br />
            <br />



            <asp:Label ID="Label8" runat="server" Text="Label">Bank Account Number</asp:Label>
             <br />
            <asp:TextBox ID="BankNumV" runat="server"></asp:TextBox>


            
            <br />
            <br />


            <asp:Button ID="reg" runat="server" Text="Register" OnClick ="regVen" />

            <br />
            <br />
            <asp:Label ID="Label9" runat="server" Text="Label">If you created an account, you may log in now.</asp:Label>
           <br />
            <asp:Button ID="Button1" runat="server" Text="Login" OnClick ="logF"/>
        </div>
    </form>
</body>
</html>
