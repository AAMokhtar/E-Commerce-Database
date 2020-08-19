<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="viewOffers.aspx.cs" Inherits="vendor.viewOffers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table width="100%" align="center" cellpadding="2" cellspacing="2" border="0" bgcolor="#EAEAEA" >
                    <tr align="left" style="background-color:#004080;color:White;" >
                        <td> offer_id </td>                        
                        <td> amount </td>            
                        <td> expiry_date </td> 
                    </tr>

                <%=getOffers()%>

                </table>
                  
                <br />
                <br />
                
                <asp:HyperLink ID="goHome" runat="server" Text="Back to Home" NavigateUrl="~/vendorHome.aspx" />
        </div>
    </form>
</body>
</html>
