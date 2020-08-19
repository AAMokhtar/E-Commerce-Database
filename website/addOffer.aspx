<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addOffer.aspx.cs" Inherits="vendor.addOffer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:validationsummary id="valSummary" runat="server" />
            <asp:RangeValidator runat="server" ID="rangeAmount" ControlToValidate="txt_amount" Type="Integer"
                MinimumValue="0" MaximumValue="100" Text="Number for offer amount exceeded the range from 0% to 100%"/>
            <br />

            <asp:Label ID="lbl_amount" runat="server" Text="Offer Amount: "></asp:Label>
    
            <asp:TextBox ID="txt_amount" type="number" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="amountRequired" runat="server" ControlToValidate="txt_amount" 
                             ErrorMessage="Offer amount is required" ToolTip="Offer amount is required." >*</asp:RequiredFieldValidator>
    
            <br />
    
            <br />
    
            
            <asp:CompareValidator ID="dateMin" runat="server" ControlToValidate="txt_date" Operator="GreaterThanEqual"
                                        Type="Date" SetFocusOnError="true" ValueToCompare="<%# DateTime.Today.ToShortDateString() %>"
                                        Text="Expiry date should be equal or greater than current date">
                                    </asp:CompareValidator>
    
            <br />
            <asp:Label ID="lbl_date" runat="server" Text="Expiry Date: "></asp:Label>
            <asp:TextBox ID="txt_date" runat="server" TextMode="Date"></asp:TextBox>
            <asp:RequiredFieldValidator ID="dateRequired" runat="server" ControlToValidate="txt_date" 
                             ErrorMessage="Expiry date is required" ToolTip="Expiry Date is required." >*</asp:RequiredFieldValidator>
    
            <br />
    
            <br />
            <asp:Button ID="submitOffer" runat="server" Text="Add Offer" onclick="postOffer" Width="90px"/>

             <br />
             <br />
                
             <asp:HyperLink ID="goHome" runat="server" Text="Back to Home" NavigateUrl="~/vendorHome.aspx" />
        </div>
    </form>
</body>
</html>
