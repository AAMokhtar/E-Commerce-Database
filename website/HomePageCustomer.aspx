<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePageCustomer.aspx.cs" Inherits="M3v3.HomePageCustomer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label2" runat="server" Text="Label">WELCOME, CUSTOMER!</asp:Label>
            <br />
            <br />
             <br />

            <asp:Label ID="Label4" runat="server" Text="Label">SECTION I: ADDING TO YOUR INFO</asp:Label>
            <!--adding the phone nb-->
                <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="Label">ADD TELEPHONE NUMBER</asp:Label>
            <br />
            <asp:TextBox ID="addTel" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqTel" runat="server" ControlToValidate="addTel" 
                 ErrorMessage="Telephone is required" ValidationGroup="Telephone"></asp:RequiredFieldValidator>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Add" OnClick ="addTelephone" ValidationGroup="Telephone"/>

           
             <br />
             <br />
             <br />

            <!--add a credit card-->

            <asp:Label ID="Label5" runat="server" Text="Label">Add credit card(s)</asp:Label>
                <br />
            <br />
            <asp:Label ID="Label6" runat="server" Text="Label">Number</asp:Label>
            <asp:TextBox ID="CCnum" runat="server" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqCCNum" runat="server" ControlToValidate="CCnum" 
                 ErrorMessage="Credit card number is required" ValidationGroup="CCNum"></asp:RequiredFieldValidator>
            <br />
            <asp:Label ID="Label7" runat="server" Text="Label">Expiry date</asp:Label>
            <asp:TextBox ID="CCdate" runat="server" TextMode="Date"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CCdate" 
                 ErrorMessage="Expiry date is required" ValidationGroup="CCNum"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="dateMin" runat="server" ControlToValidate="CCdate" Operator="GreaterThanEqual"
                                        Type="Date" SetFocusOnError="true" ValueToCompare="<%# DateTime.Today.ToShortDateString() %>"
                                        Text="Expiry date should be equal or greater than current date">
                                    </asp:CompareValidator>
    
            <br />
            <asp:Label ID="Label8" runat="server" Text="Label">CVV Code</asp:Label>
            <asp:TextBox ID="CCcvv" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqCVV" runat="server" ControlToValidate="CCcvv" 
                 ErrorMessage="CVV is required" ValidationGroup="CCNum"></asp:RequiredFieldValidator>
            <br />
            <br />

            <asp:Button ID="Button5" runat="server" Text="Add" OnClick ="addCC" ValidationGroup="CCNum" />
               



            <br />
            <br />
             <br />
       


             <!--create a wishlist-->
            <asp:Label ID="Label3" runat="server" Text="Label">CREATE A NEW WISHLIST</asp:Label>
             <br />
            <asp:TextBox ID="WLNAME" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqWL" runat="server" ControlToValidate="WLNAME" 
                 ErrorMessage="Wishlist name is required" ValidationGroup="createWL"></asp:RequiredFieldValidator>
             <br />
            <asp:Button ID="Button3" runat="server" Text="Create" OnClick ="createWL" ValidationGroup="createWL" />



            <br />
            <br />
             <br />
            <br />
            <br />
             <br />
            



            <asp:Label ID="Label9" runat="server" Text="Label">SECTION II: CHECKING OUT PRODUCTS</asp:Label>
            <!--view all products-->
            <br />
            <br />
            <asp:Button ID="Button2" runat="server" Text="View All Products"  OnClick ="displayProducts"/>

            

             <br />
            <br />
             <br />
            <br />
            <br />
             <br />
            

            <asp:Label ID="Label10" runat="server" Text="Label">SECTION III: ADDING OR REMOVING PRODUCTS FROM YOUR CART OR WISHLIST</asp:Label>
            <br />
       
            <br />
             <!--alter a wishlist-->
            <asp:Label ID="Label11" runat="server" Text="Label">Add Item to Wishlist</asp:Label>
            <br />
            <asp:Label ID="Label13" runat="server" Text="Label">Wishlist Name</asp:Label>
            <asp:TextBox ID="WLAddname" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqWLName" runat="server" ControlToValidate="WLAddname" 
                 ErrorMessage="Wishlist name is required" ValidationGroup="addToWL"></asp:RequiredFieldValidator>
            <br />
            <asp:Label ID="Label14" runat="server" Text="Label">Product Serial Number</asp:Label>
            <asp:TextBox ID="ProdAddWL" runat="server" Type="number"></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqSerial" runat="server" ControlToValidate="ProdAddWL" 
                 ErrorMessage="Serial number is required" ValidationGroup="addToWL"></asp:RequiredFieldValidator>
            <br />
            <asp:Button ID="Button4" runat="server" Text="Add" OnClick ="addToWL" ValidationGroup="addToWL" />


            <br />
            <br />
            <br />

            <asp:Label ID="Label12" runat="server" Text="Label">Remove Item From Wishlist</asp:Label>
            <br />
            <asp:Label ID="Label15" runat="server" Text="Label">Wishlist Name</asp:Label>
            <asp:TextBox ID="WLRemname" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqWLRem" runat="server" ControlToValidate="WLRemname" 
                 ErrorMessage="Wishlist name is required" ValidationGroup="remWL"></asp:RequiredFieldValidator>
            <br />
            <asp:Label ID="Label16" runat="server" Text="Label">Product Serial Number</asp:Label>
            <asp:TextBox ID="ProdRemWL" runat="server" Type="number"></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqSerialNo" runat="server" ControlToValidate="ProdRemWL" 
                 ErrorMessage="Serial is required" ValidationGroup="remWL"></asp:RequiredFieldValidator>
            <br />
            <asp:Button ID="Button7" runat="server" Text="Remove" OnClick ="remFromWL" ValidationGroup="remWL" />
            

            <br />
            <br />
            <br />

             <!--add or remove products from cart-->
            <asp:Label ID="Label17" runat="server" Text="Label">Add Product To Cart</asp:Label>
            <br />
            <asp:Label ID="Label18" runat="server" Text="Label">Product Serial No</asp:Label>
            <asp:TextBox ID="ProdAddCart" runat="server" Type="number"></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqSerialNum" runat="server" ControlToValidate="ProdAddCart" 
                 ErrorMessage="Serial number is required" ValidationGroup="addProd"></asp:RequiredFieldValidator>
            <br  />
            <asp:Button ID="Button6" runat="server" Text="Add" OnClick ="addToCart" style="height: 29px" ValidationGroup="addProd" />

            <br />
            <br />
            <br />

            <asp:Label ID="Label19" runat="server" Text="Label">Remove Product From Cart</asp:Label>
            <br />
            <asp:Label ID="Label20" runat="server" Text="Label">Product Serial No</asp:Label>
            <asp:TextBox ID="ProdRemCart" runat="server" Type="number" ValidationGroup="RemoveCart"></asp:TextBox>
             <asp:RequiredFieldValidator ID="reqRemoveProd" runat="server" ControlToValidate="ProdRemCart" 
                 ErrorMessage="Serial number is required" ValidationGroup="RemoveCart"></asp:RequiredFieldValidator> 
            <br  />
            <asp:Button ID="Button8" runat="server" Text="Remove" OnClick ="remFromCart" ValidationGroup="RemoveCart"/>
            <br />
            <br />
            <br />
            SECTION IV: MAKING ORDER<br />
            <asp:Button ID="Button9" runat="server" OnClick="make_order" Text="make order" />
            <br />
            <br />
            SECTION V:CANCELING AN ORDER:<br />
            <asp:TextBox ID="TextBox1" runat="server" Type="number" style="margin-bottom: 0px"
                 ValidationGroup="CancelOrder"></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqCancelOrder" runat="server" ControlToValidate="TextBox1" 
                 ErrorMessage="Order id is required" ValidationGroup="CancelOrder"></asp:RequiredFieldValidator> 
            <br />
            <asp:Button ID="Button10" runat="server" Text="cancel" OnClick="Button10_Click" ValidationGroup="CancelOrder"/>
            <br />











        </div>
    </form>
</body>
</html>