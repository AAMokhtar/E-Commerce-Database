
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePageAdmin.aspx.cs" Inherits="Admin.HomePageAdmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            height: 465px;
            width: 903px;
        }

        #updateorderdiv{
            float: left;
        }
        .auto-style1 {
            text-align: center;
        }
    
        #ActivateDiv{
            float: left;
        }
            
        #CreateDealDiv{
            float: left;
        }
            
        #ActivateDiv1{
            float: left;
        }
            
        #ActivateDiv2{
            float: left;
        }

        #tableSelector{
            float: left;
            margin-right: 22px;
        }
                    
        #CreateDealDiv{
            float: left;
        }

         #RemoveDealDiv{
            float: left;
        }
            
         #DealOnProductDiv{
            float: left;
        }
            
         #addPhoneDiv{
            float: left;
        }

         #LObtn{
            float: right;
            margin-right: 16px;
            margin-top: 10px;
        }
            
        </style>
</head>
<body>
   
    
   <form id="Form1" runat="server">
        <div style="height: 150px">
            <div style="height: 133px; width: 150px; margin-right: 18px; " id="updateorderdiv" class="auto-style1">
                update order status to &quot;in process&quot;<br />
                <asp:TextBox ID="updateordertext" runat="server">order number</asp:TextBox>
                <br />
                <br />
                <asp:Button ID="updateorder" runat="server" OnClick="updateorder_Click" Text="Update" />
                <br />
                <asp:Label ID="errorUpdateorder" runat="server"></asp:Label>
            </div>
            <div style="height: 133px; width: 150px; margin-right: 18px;" id="ActivateDiv" class="auto-style1">
                activate vendor<br />
                <br />
                <asp:TextBox ID="ActivateTxt" runat="server" >vendor username</asp:TextBox>
                <br />
                <br />
                <asp:Button ID="ActivateBtn" runat="server" OnClick="ActivateBtn_Click" Text="Activate" />
                <br />
                <asp:Label ID="errorActivateVendor" runat="server"></asp:Label>
            </div>
            <div style="height: 133px; width: 155px; margin-right: 18px;" id="CreateDealDiv" class="auto-style1">
                create today&#39;s deal<br />
                <asp:TextBox ID="dealamounttxt" runat="server">deal amount</asp:TextBox>
                <br />
                <asp:TextBox ID="expiryDate" runat="server" ReadOnly="True"></asp:TextBox>
                <br />
                <br />
                <asp:Button ID="AddDeal" runat="server" OnClick="AddDeal_Click" Text="Add" />
                <br />
                <asp:Label ID="errorAddDeal" runat="server"></asp:Label>
            </div>
            <div style="height: 133px; width: 155px; margin-right: 18px;" id="RemoveDealDiv" class="auto-style1">
                remove expired deal<br />
                <br />
                <asp:TextBox ID="DealIdTxt" runat="server">deal id</asp:TextBox>
                <br />
                <br />
                <asp:Button ID="RemoveDealBtn" runat="server" OnClick="RemoveDealBtn_Click" Text="Remove" />
                <br />
                <asp:Label ID="errorRemoveDeal" runat="server"></asp:Label>
            </div>
            <div style="height: 133px; width: 155px; margin-right: 18px;" id="DealOnProductDiv" class="auto-style1">
                add today&#39;s deal on product<br />
                <asp:TextBox ID="DealProductDealTxt" runat="server">deal id</asp:TextBox>
                <br />
                <asp:TextBox ID="DealProductProductTxt" runat="server">serial number</asp:TextBox>
                <br />
                <asp:Button ID="DealProductBtn" runat="server" OnClick="DealProductBtn_Click" Text="Add" />
                <br />
                <asp:Label ID="errorDealProduct" runat="server"></asp:Label>
            </div>
            <div style="height: 133px; width: 155px; margin-right: 18px;" id="addPhoneDiv" class="auto-style1">
                add phone number<br />
                <br />
                <asp:TextBox ID="phoneNumTxt" runat="server">phone number</asp:TextBox>
                <br />
                <br />
                <asp:Button ID="phoneNumBtn" runat="server" OnClick="phoneNumBtn_Click" Text="Add" />
                <br />
                <asp:Label ID="errorPhone" runat="server"></asp:Label>
            </div>
            <asp:Button ID="LObtn" runat="server" OnClick="Button1_Click" Text="Logout" />
        </div>

        <hr />
         <asp:RadioButtonList ID="tableSelector" runat="server" Height="59px" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" AutoPostBack="True">
             <asp:ListItem>Vendors</asp:ListItem>
             <asp:ListItem>Orders</asp:ListItem>
             <asp:ListItem>Today&#39;s deals</asp:ListItem>
             <asp:ListItem>Products</asp:ListItem>
             <asp:ListItem>Today&#39;s deal on product </asp:ListItem>
             <asp:ListItem>My phone numbers</asp:ListItem>
         </asp:RadioButtonList>
         <asp:Calendar ID="Calendar1" runat="server" Height="86px" Width="301px" BackColor="White" BorderColor="Black" DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black" NextPrevFormat="FullMonth" OnSelectionChanged="Calendar1_SelectionChanged1" TitleFormat="Month">
             <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" ForeColor="#333333" Height="10pt" />
             <DayStyle Width="14%" />
             <NextPrevStyle Font-Size="8pt" ForeColor="White" />
             <OtherMonthDayStyle ForeColor="#999999" />
             <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
             <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="1%" />
             <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White" Height="14pt" />
             <TodayDayStyle BackColor="#CCCC99" />
        </asp:Calendar>
       <hr />

    </form>
</body>
</html>
