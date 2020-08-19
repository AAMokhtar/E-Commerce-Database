---------------------------------REGISTRATION------------------------------------------------------


--customer register
--DONE
create proc customerRegister
@username varchar(20) ,
@first_name varchar(20) ,
@last_name varchar(20) ,
@password varchar(20) , 
@email varchar(50)
--@company_name varchar(20),
--@bank _acc _no varchar(20)
as
insert into users
values(@username,@password,@first_name,@last_name,@email)
insert into customer
values(@username,0)

select * from users;
select * from customer;

go

----execution!
--exec customerRegister 'ahmed.ashraf', 'ahmed', 'ashraf', 'pass123', 'ahmed@yahoo.com';
--go


--vendor register
--DONE
create proc vendorRegister
@username varchar(20) ,
@first_name varchar(20),
@last_name varchar(20) ,
@password varchar(20) ,
@email varchar(50) , 
@company_name varchar(20) , 
@bank_acc_no varchar(20) 
as 
--ask about activated
insert into users
values(@username,@password,@first_name,@last_name,@email)
insert into vendor 
values(@username,0,@company_name,@bank_acc_no,null)--a default admin 

select * from users;
select * from vendor;
go

--execution!
--exec vendorRegister 'eslam.mahmod','eslam','mahmod','pass1234','hopa@gmail.com','Market','132132513';
--go
----//


--login
--done


create proc userlogin
@username varchar(20),
@password varchar(20),
@success bit output,
@type int output
as
declare
@cus varchar(20),
@ven varchar(20),
@ad varchar(20),
@del varchar(20),
@uexi varchar(20),@pexi varchar(20)
select @uexi=username,@pexi="password"
from users
where username=@username 

if @pexi<>@password
begin
  set @type = -1;
  set @success = 0;
end

--select @uexi,@pexi
else
begin 
select @ven=username
from vendor where username =@username 
select @del=username
from delivery_person where username =@username 
select @ad=username
from admins where username =@username 
select @cus=username
from customer where username =@username 
--select @cus,@ven,@del,@ad

if @cus is not null
begin
   set @success = 1;
   set @type=0
end
else if @ven is not null
begin
set @success = 1;
set @type=1
end

else if @del is not null
begin
set @success = 1;
set @type=3
end

else if @ad is not null
begin
set @success = 1;
set @type=2
end

else
begin
set @success = 0;
set @type = -1;
end
end 
go

--execution!
--declare @suc bit
--declare @typ int
--exec userLogin 'eslam.mahmod','pass123',@suc output, @typ output
--print @suc
--print @typ


--declare @suc bit
--declare @typ int
--exec userLogin 'eslam.mahmod','pass1234',@suc output, @typ output
--print @suc
--print @typ


--declare @suc bit
--declare @typ int
--exec userLogin 'ahmed.ashraf','pass123',@suc output, @typ output
--print @suc
--print @typ


--declare @suc bit
--declare @typ int
--exec userLogin 'ahmed.ashraf','pass',@suc output, @typ output
--print @suc
--print @typ
--go





create proc addAddress
--DONE
@username varchar(20) , 
@address varchar(50)
as 
insert into user_addresses--(address, username)
values(@username,@address)

go




----execution!
--exec addAddress 'ahmed.ashraf','nasr city';

--go

--DONE
create proc  addMobile
@username varchar(20) , 
@mobile_number varchar(11) 
as 
insert into user_mobile_numbers--(mobile_number, username)
values (@username,@mobile_number)

go

--execution!
--exec addMobile 'ahmed.ashraf','0111211122';
--exec addMobile 'ahmed.ashraf','0124262652';
--go

--////////////////////////////////////////



--------------------------------------AS A CUSTOMER------------------------------------------------

--QUESTION: AYWA HOW DOES AS A CUSTOMER MATTER?!
--QUESTION: show what about the product? currently (*)

--a

create proc showProducts AS 
SELECT DISTINCT product_name, product_description, price, final_price, color FROM Product;
go

--execution!
--exec showProducts;
--go

--b
create proc showProductsByPrice AS
SELECT DISTINCT product_name, product_description, price, color FROM Product where available = 1
ORDER BY price asc

go

--exection!
--exec showProductsByPrice;
--go


--c
create proc searchByName @text varchar(20) AS
SELECT DISTINCT product_name, product_description, price, final_price, color FROM Product 
WHERE product_name LIKE '%' + @text + '%';
go

--execution!
--exec searchByName 'blue';

--go
--d 
create proc addQuestion @serial int, @customer varchar(20), @Question varchar(50) AS
INSERT INTO Customer_Question_Product(serial_no, customer_name, question, answer) VALUES
(@serial, @customer, @Question, null);
go

--execution!
--exec addQuestion 1, 'ahmed.ashraf', 'size?';
--go


--e 
create proc addToCart @customername varchar(20), @serial int, @alreadyadded BIT OUTPUT, @notavailable BIT OUTPUT AS

if (exists (select * from product where serial_no = @serial and available = 1))
  begin

  if( exists(select * from CustomerAddstoCartProduct where serial_no = @serial AND customer_name = @customername))
     begin 
	 set @alreadyadded = 1;
	 end
  
  else 
     begin 
	 set @alreadyadded = 0;
	 INSERT INTO CustomerAddstoCartProduct(serial_no, customer_name) VALUES (@serial, @customername);

	 end
  end 

else
  begin
  set @notavailable = 1;
  end

 go

--execution!
--exec addToCart 'ahmed.ashraf', 1;
--exec addToCart 'ahmed.ashraf', 2;
--go

create proc removeFromCart @customername varchar(20), @serial int, @existproduct BIT OUTPUT AS 

if exists (select * from customerAddsToCartProduct where customer_name = @customername AND serial_no = @serial)
   begin
   set @existproduct = 1;
   end

else
  begin
  set @existproduct = 0;
  end
   
delete from CustomerAddstoCartProduct where customer_name = @customername and serial_no = @serial;
go

--execution!
--exec removeFromCart 'ahmed.ashraf', 2;
--go

--f 
create proc createWishlist @customername varchar(20), @name varchar(20) AS
INSERT INTO Wishlist(username, "name")VALUES (@customername, @name);
go

--execution!

--exec createWishlist 'ahmed.ashraf', 'fashion';
--go


--g
create proc addToWishlist 
@customername varchar(20), 
@wishlistname varchar(20), 
@serial int,
@wlExists bit output,
@serialExists bit output,
@tupleExists bit output
AS
if(not exists (select * from product where serial_no = @serial))
    set @serialExists = 0;
else if(not exists (select * from wishlist where name = @wishlistname and username = @customername))
    set @wlExists = 0;
else if(exists (select * from wishlist_product where username = @customername and wish_name = @wishlistname and
                 serial_no = @serial))
    set @tupleExists = 1;
else
INSERT INTO Wishlist_Product(username, wish_name, serial_no) VALUES (@customername, @wishlistname, @serial);
go
--execution!

--exec addToWishlist 'ahmed.ashraf', 'fashion', 1;
--exec addToWishlist 'ahmed.ashraf', 'fashion', 2;
--go


create proc removeFromWishlist  @customername varchar(20), @wishlistname varchar(20), @serial int, @exists bit OUTPUT AS

if exists (select * FROM wishlist_product where username = @customername AND serial_no = @serial AND  wish_name = @wishlistname)
begin
set @exists = 1;
end
else 
begin
set @exists = 0;
end

delete from Wishlist_Product where username = @customername AND wish_name = @wishlistname AND serial_no = @serial;
go

--execution!

--exec removeFromWishlist 'ahmed.ashraf', 'fashion', 1;
--go


--h 
create proc showWishlistProduct @customername varchar(20), @name varchar(20) AS
SELECT P.product_name, P.product_description, P.price, P.final_price, P.color FROM Wishlist_Product W 
inner join Product P on W.serial_no = P.serial_no
WHERE W.username = @customername;
go

--execution!

--exec showWishlistProduct 'ahmed.ashraf', 'fashion';
--go

--i
create proc viewMyCart @customer varchar(20) AS
SELECT P.product_name, P.product_description, P.price, P.final_price, P.color
FROM CustomerAddstoCartProduct cart 
inner join Product P on P.serial_no = cart.serial_no 
WHERE cart.customer_name = @customer;
go

--execution!

--exec viewMyCart 'ahmed.ashraf';
--go


--j 

---------------------ORDERS-------------------------
CREATE PROC calculatepriceOrder
@customername varchar(20),
@sum decimal(10,2) OUTPUT
AS
SELECT @sum = SUM(final_price) FROM CustomerAddstoCartProduct a  INNER JOIN product b ON a.serial_no = b.serial_no
where a.customer_name = @customername;
GO

--execution!

--declare @out decimal(10,2)
--exec calculatepriceOrder 'ahmed.ashraf', @out output
--print @out;



-------------------------
CREATE PROC productsinorder
@customername varchar(20),
@orderID int
AS


--nice syntax!
UPDATE product
    SET customer_username = @customername  WHERE serial_no IN (SELECT serial_no FROM CustomerAddstoCartProduct WHERE customer_name = @customername) -- removed temp table
UPDATE product
    SET customer_order_id = @orderID WHERE serial_no IN  (SELECT serial_no FROM CustomerAddstoCartProduct WHERE customer_name = @customername)
  
DELETE FROM CustomerAddstoCartProduct WHERE serial_no IN (SELECT serial_no FROM CustomerAddstoCartProduct WHERE customer_name = @customername) AND customer_name <>  @customername

SELECT * FROM CustomerAddstoCartProduct WHERE customer_name = @customername 

GO

--execution!

--INSERT INTO orders(order_date, total_amount,customer_name, order_status)
--    VALUES(CURRENT_TIMESTAMP, 100.00,'ahmed.ashraf', 'not processed');

--select * from product;
--select * from orders;

--exec productsinorder 'ahmed.ashraf', 1;

--select * from customerAddsToCartProduct



-------------------------
CREATE PROC emptyCart
@customername varchar(20)
AS

DELETE FROM CustomerAddstoCartProduct 
    WHERE customer_name = @customername

GO

--execution!

--exec emptyCart 'ahmed.ashraf';

--exec viewMyCart 'ahmed.ashraf';

-------------------------
--execution!

--exec emptyCart 'ahmed.ashraf';

--exec viewMyCart 'ahmed.ashraf';

-------------------------
CREATE PROC makeOrder
@customername varchar(20),
@totalamount DECIMAL(10,2) output,
@ordrnumber int output
AS

DECLARE @total DECIMAL(10,2)
DECLARE @order_no INT
DECLARE @orderDate DATETIME


EXEC calculatepriceOrder
@customername = @customername,
 @sum = @total OUTPUT;

SET @orderDate = CURRENT_TIMESTAMP
INSERT INTO orders(order_date, total_amount,customer_name, order_status)
    VALUES(@orderDate, @total, @customername, 'not processed');

SELECT @order_no = order_no FROM orders WHERE customer_name = @customername AND order_date = @orderDate;
--///////
set @ordrnumber=@order_no
set @totalamount=@total
--///////
EXEC productsinorder
@customername = @customername,
@orderID = @order_no;

UPDATE product 
    SET available = 0 WHERE ​customer_order_id = @order_no;

EXEC emptyCart
@customername = @customername
GO


--execution!

--exec makeOrder 'ahmed.ashraf'
--go

-------------------------

--execution!

--exec makeOrder 'ahmed.ashraf'
--go

-------------------------

CREATE PROC cancelOrder 
@orderid int
AS

DECLARE @customer varchar(20);
SELECT @customer = customer_name FROM orders WHERE order_no = @orderid;

DECLARE @cash DECIMAL(10,3);
SELECT @cash = cash_amount FROM orders WHERE order_no = @orderid;
IF(@cash IS NULL)BEGIN  SET @cash = 0.000 END;

DECLARE @credit DECIMAL(10,3);
SELECT @credit = credit_amount FROM orders WHERE order_no = @orderid;
IF(@credit IS NULL)BEGIN  SET @credit = 0.000 END;

DECLARE @total DECIMAL(10,3);
SELECT @total = total_amount FROM orders WHERE order_no = @orderid;
IF(@total IS NULL)BEGIN SET @total = 0.000 END;

DECLARE @totalToGC DECIMAL(10,3);
SET @totalToGC = (@total - @cash - @credit);

DECLARE @GC VARCHAR(10)
SELECT @GC = gift_Card_code_used FROM orders WHERE order_no = @orderid;

IF(EXISTS (SELECT * FROM orders WHERE order_no = @orderid AND (order_status = 'not processed' OR order_status = 'in process')))
BEGIN

    UPDATE product
        SET available = 1, customer_username = NULL, customer_order_id = NULL
        WHERE ​customer_order_id = @orderid

    DELETE FROM orders WHERE order_no = @orderid

    IF(@GC IS NOT NULL)
    BEGIN

        IF(EXISTS(SELECT * FROM giftcard WHERE code = @GC AND "expiry_date" > CURRENT_TIMESTAMP))
        BEGIN
        UPDATE customer
        SET points = points + @totalToGC WHERE username = @customer;

        UPDATE Admin_Customer_Giftcard
        SET remaining_points​ = remaining_points​ + @totalToGC WHERE code = @GC;
        
        END
    END
    ELSE
    BEGIN

    UPDATE customer
        SET points = points + @totalToGC WHERE username = @customer;

    END
END

GO
-------------------------
CREATE PROC returnProduct
@serialno int,
@orderid int
AS

DECLARE @PPrice DECIMAL(10,3)
SELECT @PPrice = final_price FROM product WHERE serial_no = @serialno;

DECLARE @customer varchar(20);
SELECT @customer = customer_name FROM orders WHERE order_no = @orderid;

DECLARE @cash DECIMAL(10,3);
SELECT @cash = cash_amount FROM orders WHERE order_no = @orderid;
IF(@cash IS NULL)BEGIN  SET @cash = 0.000 END;

DECLARE @credit DECIMAL(10,3);
SELECT @credit = credit_amount FROM orders WHERE order_no = @orderid;
IF(@credit IS NULL)BEGIN  SET @credit = 0.000 END;

DECLARE @total DECIMAL(10,3);
SELECT @total = total_amount FROM orders WHERE order_no = @orderid;
IF(@total IS NULL)BEGIN SET @total = 0.000 END;

DECLARE @totalToGC DECIMAL(10,3);
SET @totalToGC = (@total - @cash - @credit);

DECLARE @GC VARCHAR(10)
SELECT @GC = gift_Card_code_used FROM orders WHERE order_no = @orderid;

IF(EXISTS (SELECT * FROM orders WHERE order_no = @orderid))
BEGIN 

    IF(@GC IS NOT NULL)
    BEGIN
    
        IF(EXISTS(SELECT * FROM giftcard WHERE code = @GC AND "expiry_date" > CURRENT_TIMESTAMP))
        BEGIN

            IF(@totalToGC >= @PPrice)
            BEGIN

            UPDATE customer
            SET points = points + @PPrice WHERE username = @customer;

            UPDATE Admin_Customer_Giftcard
            SET remaining_points​ = remaining_points​ + @PPrice WHERE code = @GC;

            END

            ELSE
            BEGIN

            UPDATE customer
            SET points = points + @totalToGC WHERE username = @customer;

            UPDATE Admin_Customer_Giftcard
            SET remaining_points​ = remaining_points​ + @totalToGC WHERE code = @GC;

            END

        END

    END
    ELSE
    BEGIN

        IF(@totalToGC >= @PPrice)
        BEGIN

        UPDATE customer
        SET points = points + @PPrice WHERE username = @customer;

        END

        ELSE
        BEGIN

        UPDATE customer
        SET points = points + @totalToGC WHERE username = @customer;

        END

    END

    UPDATE orders
    SET total_amount = total_amount - @PPrice WHERE order_no = @orderid;

    UPDATE product
        SET available = 1, customer_username = NULL, customer_order_id = NULL  WHERE ​customer_order_id = @orderid

END

GO
-------------------------
--moataz's part
CREATE PROC ShowproductsIbought
@customername varchar(20)
AS
SELECT * FROM product WHERE customer_username = @customername
GO

create proc rate
@serialno int ,
@rate DECIMAL(30,20) ,
@customername varchar(20) 
as
update  product
set rate=@rate,customer_username=@customername
where @serialno=serial_no
go
--////////////////////////////////////////////////////////////////////////////////////////
create proc  SpecifyAmount
 @customername varchar(20), 
 @orderID int,
 @cash DECIMAL(30,20),
 @credit DECIMAL(30,20)
 as
 declare 
 @amount DECIMAL(30,20),
 @payedbyuser DECIMAL(30,20),
 @points decimal(30,20),
 @usedpoints decimal(30,20)
 --////////////////
 select @amount=total_amount
 from orders where order_no=@orderID
 --///////////////
 select @points=CONVERT(DECIMAL(30,20), points)
 from Customer where @customername=username
 --///////////////
--Orders(order_no, order_date, total_amount, cash_amount, credit_amount, payment_type,order_status, remaining_days, time_limit, customer_name, delivery_id, creditCard_number)
if @cash=0
begin
update orders
 set payment_type ='credit' where @orderID=order_no
end
else
begin
update orders
set payment_type ='cash' where @orderID=order_no
end
--////////////////
set @payedbyuser = @cash+@credit
--//////////////
 if @payedbyuser = @amount--cash and credit are enough
 begin
 update orders
 set cash_amount = @cash where @orderID=order_no
 update orders
 set credit_amount=@credit where @orderID=order_no
 end
 --////////////////////cash and credit are not benough
else 
begin
if @payedbyuser+@points>=@amount--//points can pay the rest
begin
set @usedpoints=@amount-@payedbyuser
update customer
set points=cast(@points-@usedpoints as int) where @customername=username
update orders 
set cash_amount = @cash where @orderID=order_no
update orders
set credit_amount=@credit where @orderID=order_no
end
end
go 

--exec SpecifyAmount 'ahmed.ashraf',1,10.0,0
--go--////////////////////////////////////////////////////////////////////////////////////
create proc AddCreditCard 
 @creditcardnumber varchar(20), 
 @expirydate date , 
 @cvv smallint,
 @customername varchar(20)
 as
 insert into credit_card
 values(@creditcardnumber,@expirydate,@cvv)
 insert into customer_creditCard
 values(@customername,@creditcardnumber)
 go
 --exec AddCreditCard '4444-5555-6666-8888','10/19/2028','232','ahmed.ashraf'
 --go
 --/////////////////////////////////////////////////////////////////////
 --done
create proc ChooseCreditCard
 @creditcard varchar(20), 
 @orderid int
 as
 update Orders 
 set creditCard_number=@creditcard where order_no=@orderid
 go
 --select * from credit_card
 --select * from customer_creditCard
 --exec ChooseCreditCard '4444-5555-6666-8888' ,1
 ----select * from orders
 --go
 --//////////////////////////////////////////////////////
 create proc vewDeliveryTypes
as
select type,time_duration,fees
from Delivery
go
--exec vewDeliveryTypes
--go

--////////////////////////////////////////////////////
--done
create proc specifydeliverytype
@orderID int,
@deliveryID int
as
declare @remainingdays int
select @remainingdays=cast(time_duration as int)
from delivery
where id=@deliveryID
update orders
set delivery_id=@deliveryID
where order_no=@orderID
update orders
set remaining_days=@remainingdays
where order_no=@orderID
go
--exec specifydeliverytype 1 , 1
--go
--/////////////////////////////////////////////////////////////////////////////
--done
create proc trackRemainingDays
@orderid int, 
@customername varchar(20),
@remainingdays int output--ASK
as
declare @orderdate datetime
declare @remainold int--ask
declare @delid int
select @delid=delivery_id
from orders 
where order_no=@orderid
--////////////////////////
select @remainold=time_duration
from delivery
where
id=@delid 
--//////////////////////////////
select @orderdate=order_date
from orders
where
order_no=@orderid and @customername=customer_name
--////////////////
--print @remainold
--print datediff(day,@orderdate,getdate())
set @remainingdays=@remainold-datediff(day,@orderdate,getdate())
update orders
set remaining_days=@remainingdays
where order_no=@orderID and @customername=customer_name
--print @remainingdays
go
--select datediff(day,'2008-11-11 13:23:44',getdate())
----///////////////////////////
--declare @w int
--exec trackRemainingDays 1 ,'ahmed.ashraf',@w output
----print @w
--go
--///////////////////////////////////////////////////////////////////////////
create proc maxbascat
@username varchar(20)
as
select top 3 p.serial_no from(
Select Top 3 p.serial_no
			From 
(select top 3 po.category 
from
product po inner join
customerAddsToCartProduct ca
on po.serial_no=ca.serial_no
where ca.customer_name=@username
group by po.category
order by count(po.category) desc) maxcat
inner join product p on p.category=maxcat.category
inner join wishlist_product wp on p.serial_no=wp.serial_no
group by p.serial_no
order by count(p.serial_no)desc)  maxproducts
inner join product p 
on p.serial_no=maxproducts.serial_no
go
--exec maxbascat 'ammar.yasser'
----//////////////////////////////
--go
create proc maxprosimu
@username varchar(20)
as
select top 3 wp.serial_no
from(
select top 3 c2.customer_name from
CustomerAddstoCartProduct c1 inner join CustomerAddstoCartProduct c2 on
c1.serial_no=c2.serial_no
where c1.customer_name =@username and c1.customer_name!=c2.customer_name
group by c2.customer_name
order by count(c2.serial_no) desc) mostsimilar
inner join Wishlist_Product wp on wp.username=mostsimilar.customer_name
group by wp.serial_no
order by count(wp.serial_no) desc
go

--exec  maxprosimu 'ammar.yasser'
--go


create proc recommend
@username varchar(20)
as
create table final(serial_no INT)

insert into final exec maxprosimu @username
insert into final exec maxbascat @username

select p.* from product p
inner join final f
on p.serial_no=f.serial_no
drop table final
go
--exec recommend 'ammar.yasser'








-------------------------
----------------------------------------------------------------------ADMIN----------------------------------------------------------
CREATE PROC activateVendors
@admin_username VARCHAR(20),
@vendor_username VARCHAR(20)
AS
UPDATE vendor 
    SET activated = 1, admin_username = @admin_username 
    WHERE username = @vendor_username AND activated <> 1 ------------------modified

GO 
-------------------------
CREATE PROC inviteDeliveryPerson
@delivery_username VARCHAR(20),
@delivery_email VARCHAR(50)
AS
INSERT INTO users(username,first_name,last_name,email)
    VALUES(@delivery_username, null, null, @delivery_email)
INSERT INTO delivery_person
    VALUES(@delivery_username,0)
GO
-------------------------
CREATE PROC reviewOrders
AS
SELECT * FROM orders
GO
-------------------------
CREATE PROC updateOrderStatusInProcess
@order_no INT
AS
UPDATE orders
    SET order_status = 'in process'
    WHERE order_no = @order_no
GO
-------------------------
CREATE PROC addDelivery
@delivery_type VARCHAR(20),
@time_duration INT,
@fees DECIMAL(5,3),
@admin_username VARCHAR(20)
AS
INSERT INTO delivery
    VALUES(@delivery_type,@time_duration,@fees,@admin_username) -- removed null
GO
-------------------------
CREATE PROC assignOrderToDelivery
@delivery_username VARCHAR(20),
@order_no INT,
@admin_username VARCHAR(20)
AS
INSERT INTO admin_delivery_order
    VALUES(@delivery_username, @order_no, @admin_username, null)  
GO
-------------------------
CREATE PROC createTodaysDeal
@deal_amount INT,
@admin_username VARCHAR(20),
@expiry_date DATETIME
AS
INSERT INTO todays_deals(deal_amount, "expiry_date", admin_username)
    VALUES(@deal_amount, @expiry_date, @admin_username)

GO
-------------------------
CREATE PROC addTodaysDealOnProduct -------------------modified
@deal_id INT,
@serial_no INT
AS
INSERT INTO todays_deals_product
    VALUES(@deal_id, @serial_no)

    DECLARE @amount INT 
    SELECT @amount = deal_amount FROM todays_deals WHERE deal_id = @deal_id

    UPDATE product
        SET final_price = price - (price*(@amount/100.00)) WHERE serial_no = @serial_no
GO
-------------------------
CREATE PROC checkTodaysDealOnProduct
@serial_no INT,
@activeDeal BIT OUTPUT
AS
select @activeDeal = case
  when exists (
    select * from todays_deals_product
      where serial_no = @serial_no) then 1
  else 0 end
GO
-------------------------
CREATE PROC removeExpiredDeal
@deal_id INT
AS
DELETE FROM todays_deals WHERE
    deal_id = @deal_id AND "expiry_date" < CURRENT_TIMESTAMP
GO
-------------------------
CREATE PROC createGiftCard
@code VARCHAR(10),
@expiry_date DATETIME,
@amount INT,
@admin_username VARCHAR(20)
AS
INSERT INTO giftcard 
   VALUES(@code, @expiry_date, @amount, @admin_username)
GO
-------------------------
CREATE PROC removeExpiredGiftCard
@code VARCHAR(10)
AS

IF(EXISTS(SELECT * FROM giftcard WHERE @code = @code AND "expiry_date" < CURRENT_TIMESTAMP ))

    DELETE FROM giftcard WHERE
        @code = @code AND "expiry_date" < CURRENT_TIMESTAMP

    DECLARE @amount INT
    SELECT @amount = remaining_points  FROM admin_customer_giftcard WHERE code = @code
   
    UPDATE customer
        SET points = points - @amount WHERE username = (SELECT customer_name FROM admin_customer_giftcard WHERE code = @code)

    DELETE FROM admin_customer_giftcard WHERE code = @code

GO
-------------------------
CREATE PROC checkGiftCardOnCustomer
@code VARCHAR(10),
@activeGiftCard BIT OUTPUT
AS
select @activeGiftCard = case
  when exists (
    select * from admin_customer_giftcard
      where code = @code) then 1
  else 0 end
GO
-------------------------
CREATE PROC giveGiftCardToCustomer
@code VARCHAR(10),
@customer_name VARCHAR(20),
@admin_username VARCHAR(20)
AS

DECLARE @cardHasCustomer BIT
DECLARE @expired BIT

DECLARE @amount INT
SELECT @amount = amount FROM giftcard WHERE code = @code 

select @expired = case
  when exists (
    select * from giftcard
      where code = @code AND "expiry_date" < CURRENT_TIMESTAMP) then 1
  else 0 end

IF(@expired = 1)
    BEGIN
    EXEC removeExpiredGiftCard
    @code = @code
    END
    ELSE
        BEGIN
        -- EXEC checkGiftCardOnCustomer
        -- @code = @code,
        -- @activeGiftCard =  @cardHasCustomer OUTPUT 

        INSERT INTO admin_customer_giftcard 
        VALUES(@code, @customer_name, @admin_username,@amount);

        UPDATE customer
        SET points = points + @amount 
        WHERE username = @customer_name

        END

GO

----------------DELIVERY PERSONNEL------------------
CREATE PROC acceptAdminInvitation
@delivery_username VARCHAR(20)
AS
UPDATE delivery_person
    SET is_activated = 1 WHERE username = @delivery_username
GO
-------------------------
CREATE PROC deliveryPersonUpdateInfo
@username VARCHAR(20),
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50)
AS 
UPDATE users
    SET first_name = @first_name,
    last_name = @last_name,"password" = @password,
    email = @email WHERE username = @username
GO
-------------------------
CREATE PROC viewmyorders
@deliveryperson varchar(20)
AS
SELECT o.* FROM orders o INNER JOIN admin_delivery_order ado ON o.order_no = ado.order_no 
WHERE @deliveryperson = delivery_username
GO
-------------------------
CREATE PROC specifyDeliveryWindow
@delivery_username VARCHAR(20),
@order_no INT,
@delivery_window VARCHAR(50)
AS
UPDATE admin_delivery_order
    SET delivery_window = @delivery_window
    WHERE delivery_username = @delivery_username AND 
    order_no = @order_no
GO
-------------------------
CREATE PROC updateOrderStatusOutforDelivery
@order_no INT
AS
UPDATE orders
    SET order_status = 'out for delivery'
    WHERE order_no = @order_no
GO
-------------------------
CREATE PROC updateOrderStatusDelivered
@order_no INT
AS
UPDATE orders
    SET order_status = 'delivered'
    WHERE order_no = @order_no
GO


-----------------------------VENDOR----------------------------------------------------------------------------------------------

/*
*vendor procedures
*/

--procedure that checks if a vendor is activated

create proc isActivated
@vendorUsername varchar(20),
@isActivated bit output
as
select @isActivated = activated
from vendor
where username = @vendorUsername
GO

--procedure that allows activated vendors to post a new product
create proc postProduct
@vendorUsername varchar(20),
@product_name varchar(20),
@category varchar(20),
@product_description text,
@price decimal(10,2),
@color varchar(20)
as
if (@vendorUsername is null)
print 'Vendor username not entered'
else
declare @isActivated bit
exec isActivated @vendorUsername, @isActivated output
if (@isActivated = 1) --check if vendor is activated
if (@product_name is null)
print 'Product name cannot be null'
else if  (@category is null)
print 'Category cannot be null'
else if (@product_description is null)
print 'Product description cannot be null'
else if (@price is null)
print 'Price cannot be null'
else if (@color is null)
print 'Color cannot be null'
else
insert into product(product_name, category, product_description, price, final_price, color, available, vendor_username)
values (@product_name, @category, @product_description, @price, @price, @color, 1, @vendorUsername)
else
print 'Unactivated vendors cannot add products or there is no such vendor!'

GO

--update vendor
--set activated = 1 where "username" = 'eslam.mahmod';

--update vendor
--set admin_username = 'hana.aly' where "username" = 'eslam.mahmod';

--execution!

--exec postProduct 'eslam.mahmod','pencil','stationary', 'HB0.7', 10, 'red'
--select * from product;

--go




--procedure that allows activated vendors to view their products
create proc vendorviewProducts
@vendorname varchar(20)
as
if (@vendorname is null)
print 'Vendor username not entered'
else
declare @isActivated bit
exec isActivated @vendorname, @isActivated output
if (@isActivated = 1) --check if vendor is activated
select *
from product
where vendor_username = @vendorname

GO


----execution!
--exec vendorviewProducts 'eslam.mahmod';

--go


--procedure that checks if the product has an active offer (offer was applied to a product from before).
create proc checkOfferonProduct
@serial int,
@activeOffer bit output
as
if (@serial is null)
print 'Serial number not entered'

else
begin
--create table datesApplicable(dada datetime);
--insert into datesApplicable 
--select offer_id from offer where "expiry_date" > CURRENT_TIMESTAMP;

if (exists (select offer_id from offersOnProduct where serial_no = @serial))

set @activeOffer = 1

else
set @activeOffer = 0

end

GO


--execution!





--procedure that removes a given offer if it expired
--done!

create proc EditProduct
@vendorname varchar(20),
@serialnumber int,
@product_name varchar(20),
@category varchar(20),
@product_description text,
@price decimal(10,2),
@color varchar(20),
@updated bit output
as
if (@vendorname is null)
print 'Vendor username not entered'
else
declare @isActivated bit
exec isActivated @vendorname, @isActivated output
if (@isActivated = 1) --check if vendor is activated

if (exists (select * from product where serial_no = @serialnumber))
set @updated = 1

if (@product_name is not null)
update product
set product_name = @product_name where vendor_username = @vendorname  AND serial_no = @serialnumber

if  (@category is not null)
update product
set category = @category where vendor_username = @vendorname  AND serial_no = @serialnumber

if (@product_description is not null)
update product
set product_description = @product_description where vendor_username = @vendorname  AND serial_no = @serialnumber

if (@price is not null)
begin
update product
set price = @price where vendor_username = @vendorname  AND serial_no = @serialnumber

--update the final price accordingly

declare @activeOffer bit;
exec checkOfferonProduct @serialnumber, @activeOffer output;

if (@activeOffer = 1) --if the product has an active offer
begin

    declare @amount int;

    select @amount = o1.offer_amount
    from offer o1
    where o1.offer_id = (select o2.offer_id
                        from offersOnProduct o2
                        where serial_no = @serialnumber)
    update product
    set final_price = (price - price*(@amount/100.00)) where vendor_username = @vendorname  AND serial_no = @serialnumber;
end
else --if the product doesn't have any active offers
    update product
    set final_price = price where vendor_username = @vendorname  AND serial_no = @serialnumber;

end

if (@color is not null)
update product
set color = @color where vendor_username = @vendorname AND serial_no = @serialnumber



GO


----execution!

--exec EditProduct 'eslam.mahmod',5,null,null,null,null,'blue'

--go




create proc deleteProduct
@vendorname varchar(20),
@serialnumber int
as
if (@vendorname is null)
print 'Vendor username not entered'
else
declare @isActivated bit
exec isActivated @vendorname, @isActivated output
if (@isActivated = 1) --check if vendor is activated
if (@serialnumber is null)
print 'Serial number not entered'
else
delete from product
where serial_no = @serialnumber

GO

----execution!
--exec deleteProduct 'eslam.mahmod', 5;
--select * from product;


--go



create proc viewQuestions
@vendorname varchar(20)
as
if (@vendorname is null)
print 'Vendor username not entered'
else
declare @isActivated bit
exec isActivated @vendorname, @isActivated output
if (@isActivated = 1) --check if vendor is activated
select *
from Customer_Question_Product
where serial_no in (select serial_no
   from product
where vendor_username = @vendorname)
else
print 'Unactivated vendors cannot view questions'

GO


--execution!
--exec viewQuestions 'hadeel.adel';



--go

create proc answerQuestions
@vendorname varchar(20),
@serialno int,
@customername varchar(20),
@answer text
as
if (@vendorname is null)
print 'Vendor username not entered'
else
declare @isActivated bit
exec isActivated @vendorname, @isActivated output
if (@isActivated = 1) --check if vendor is activated
if (@serialno is null)
print 'Serial number not entered'
else if (@customername is null)
print 'Customer name not entered'
else if (@answer is null)
print 'Answer not entered'
else
update Customer_Question_Product
set answer = @answer
where serial_no = @serialno and customer_name = @customername
GO

--execution!
--exec answerQuestions 'hadeel.adel', 1, 'ahmed.ashraf', '40';
--select * from customer_question_product;
--go

--procedure that adds an offer to the offer table
create proc addOffer
@offeramount int,
@expiry_date datetime
as
if (@offeramount is null)
print 'Offer amount not entered'
else if (@expiry_date is null)
print 'Expiry date not entered'
else
insert into offer (offer_amount, "expiry_date")
values (@offeramount, @expiry_date)

GO

--execution!
--exec addoffer 50, '2/1/2018'
--exec addoffer 40, '3/1/2030'

--select * from offer

--exec addOffer 50, '11/10/2019'

--select * from offer;
--select * from offersOnProduct;

--insert into offersOnProduct values (5,3)
--insert into offersOnProduct values (6,3)

--declare @o bit
--exec checkOfferonProduct 3, @o output
--print @o

create proc checkandremoveExpiredoffer
@offerid int,
@removed bit output,
@inDb bit output
as
if (@offerid is null)
print 'Offer id not entered'


else

if(exists (select * from offer where offer_id = @offerid))
    set @inDb = 1;

declare @exp datetime
select @exp = "expiry_date" from offer where offer_id = @offerid;

if(CURRENT_TIMESTAMP >= @exp)
begin
update product 
set final_price = price where serial_no IN (select serial_no from offersOnProduct where offer_id = @offerid);

delete from offer where offer_id = @offerid;
set @removed = 1;
end
else
set @removed = 0;
go

--execution!
--select * from offer
--select * from offersOnProduct
--exec checkandremoveExpiredoffer 5


--procedure that puts the offer and its product in the offersOnProduct
create proc applyOffer
@vendorname varchar(20),
@offerid int,
@serial int,
@applied bit output
as
if (@vendorname is null)
print 'Vendor username not entered'

else

      if (@offerid is null OR @serial is null )
      print 'incomplete inputs'

      else

	  declare @hasOffer bit
	  exec checkOfferonProduct @serial, @hasoffer OUTPUT

	  declare @amt int
	  declare @dt datetime 

	  select @amt = offer_amount from offer where offer_id = @offerid;
	  select @dt = "expiry_date" from offer where offer_id = @offerid;

	  
	  if(@hasOffer=0)
	  begin
      update product 
	  set final_price = (price - price*(@amt/100.00)) where serial_no = @serial;

      insert into offersOnProduct values (@offerid, @serial);
      set @applied = 1;
	  end
	 

	  else if(@hasOffer=1)
      begin
	  print('Sorry, the product currently has an active offer.');
      set @applied = 0;
      end

	  else
	  print('error');

GO

--execution
--select * from offer
--select * from offersOnProduct
--select * from product

--delete from offersonproduct where offer_id = 6

--exec addOffer 50, '11/10/2019'
--exec applyOffer 'hadeel.adel', 6, 1
--exec checkandremoveExpiredoffer 6

----------------------------------NEW PROCEDURES------------------------------------------------
create proc deleteCustomer @username varchar(20)
AS
delete from customer WHERE username = @username;
go
-------------------

create proc deleteVendor @username varchar(20)
AS
delete from vendor WHERE username = @username;
go
-------------------

create proc deleteCC @username varchar(20), @creditcardnumber varchar(20)
AS
delete from customer_creditCard where customer_name = @username AND cc_number = @creditcardnumber;
go
-------------------

CREATE PROC orderValid
@order_no INT,
@exists BIT OUTPUT
AS
select @exists = case
  when exists (
    select * from orders
      where order_no = @order_no) then 1
  else 0 end
GO
-------------------

CREATE PROC vendorValid
@username varchar(20),
@exists BIT OUTPUT
AS
select @exists = case
  when exists (
    select * from vendor
      where username = @username) then 1
  else 0 end
GO
-------------------

CREATE PROC dealValid
@deal_id INT,
@exists BIT OUTPUT
AS
select @exists = case
  when exists (
    select * from todays_deals
      where deal_id = @deal_id) then 1
  else 0 end
GO
-------------------

CREATE PROC ProductValid
@serial_no INT,
@exists BIT OUTPUT
AS
select @exists = case
  when exists (
    select * from product
      where serial_no = @serial_no) then 1
  else 0 end
GO
-------------------

CREATE PROC phoneNumValid
@username varchar(20),
@mobile_number VARCHAR(11),
@exists BIT OUTPUT

AS
select @exists = case
  when exists (
    select * from user_mobile_numbers
      where username = @username AND mobile_number = @mobile_number) then 1
  else 0 end
GO
-------------------

CREATE PROC dealExpired
@deal_id INT,
@exists BIT OUTPUT
AS
select @exists = case
  when exists (
    select * from todays_deals
      where deal_id = @deal_id AND "expiry_date" <= CURRENT_TIMESTAMP) then 1
  else 0 end
GO
-------------------

CREATE PROC orderInProcess
@order_no INT,
@exists BIT OUTPUT
AS
select @exists = case
  when exists (
    select * from orders
      where order_no = @order_no AND order_status = 'in process') then 1
  else 0 end
GO
-------------------

CREATE PROC LoadVendors
AS
select * from vendor
GO
-------------------

CREATE PROC LoadTodaysDeals
AS
select * from todays_deals
GO
-------------------

CREATE PROC LoadProducts
AS
select * from product
GO
-------------------

CREATE PROC LoadTodaysDealsOnProduct
AS
select * from todays_deals_product
GO
-------------------

CREATE PROC LoadPhoneNums
@username varchar(20)
AS
select mobile_number from user_mobile_numbers where username = @username
GO
-------------------

create proc viewOffers
as
select *
from offer

GO
-------------------

CREATE PROC besela
@order_no INT,
@exists BIT OUTPUT
AS
select @exists = case
  when exists (
    select * from orders
      where order_no = @order_no AND (order_status = 'in process' or order_status='not processed' )) then 1
  else 0 end
GO
-------------------

create proc ccexists 
@username varchar(20),
@ccnum varchar(50),
@count int output
as
select @count=count(cc_number) from customer_creditCard
where customer_name=@username and cc_number=@ccnum;
if @count > 0
begin
set @count=1
end
else
begin
set @count=0
end
print @count
GO
-------------------

create proc iscartempty 
@username varchar(20),
@count int output
as 
select @count=count(serial_no) from customerAddsToCartProduct
where @username=customer_name
-------------------





