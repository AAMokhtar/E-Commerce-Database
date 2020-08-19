<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="viewProducts.aspx.cs" Inherits="vendor.viewProducts" %>

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
                        <td> serial_no </td>                        
                        <td> product_name </td>            
                        <td> category </td> 
                        <td> product_description </td>
                        <td> price </td>
                        <td> final_price </td>
                        <td> color </td>
                        <td> available </td>
                        <td> rate </td>
                        <td> customer_username </td>
                        <td> vendor_username </td>
                        <td> customer_order_id </td>
                    </tr>

                <%=getProducts()%>

                </table>
                  
                <br />
                <br />
                
                <asp:HyperLink ID="goHome" runat="server" Text="Back to Home" NavigateUrl="~/vendorHome.aspx" />
        </div>
    </form>
</body>
</html>
