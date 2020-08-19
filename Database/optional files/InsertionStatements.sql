INSERT INTO Users (username, first_name, last_name, "password", email) VALUES('hana.aly','hana','aly', 'pass1', 'hana.ali@guc.edu.eg');
INSERT INTO Users (username, first_name, last_name, "password", email) VALUES('ammar.yasser','ammar','yasser', 'pass4', 'ammar.yasser@guc.edu.eg');
INSERT INTO Users (username, first_name, last_name, "password", email) VALUES('nada.sharaf','nada','sharaf', 'pass7', 'nada.sharaf@guc.edu.eg');
INSERT INTO Users (username, first_name, last_name, "password", email) VALUES('hadeel.adel','hadeel','adel', 'pass13', 'hadeel.adel@guc.edu.eg');
INSERT INTO Users (username, first_name, last_name, "password", email) VALUES('mohamed.tamer','mohamed','tamer', 'pass16', 'mohamed.tamer@guc.edu.eg');

INSERT INTO Admins (username) VALUES('hana.aly');
INSERT INTO Admins (username) VALUES('nada.sharaf');

INSERT INTO Customer (username, points) VALUES('ammar.yasser',15);

INSERT INTO user_mobile_numbers (username,mobile_number) VALUES('hana.aly','01111111111');
INSERT INTO user_mobile_numbers (username,mobile_number) VALUES('hana.aly','1211555411');

INSERT INTO Vendor (username,activated, company_name, bank_acc_no, admin_username) VALUES('hadeel.adel',1,'Dello','47449349234','hana.aly');

INSERT INTO delivery_person (is_activated, username) VALUES(1,'mohamed.tamer');

INSERT INTO user_addresses ("address", username) VALUES('New Cairo','hana.aly');
INSERT INTO user_addresses ("address", username) VALUES('Heliopolis','hana.aly');

INSERT INTO credit_card (number, "expiry_date",cvv_code) VALUES('4444-5555-6666-8888','2028-10-19',232);

INSERT INTO customer_creditCard (customer_name,cc_number) VALUES('ammar.yasser','4444-5555-6666-8888');

INSERT INTO delivery ("type", time_duration,fees) VALUES('pick-up', 7, 10);
INSERT INTO delivery ("type", time_duration,fees) VALUES('regular', 14, 30);
INSERT INTO delivery ("type", time_duration,fees) VALUES('speedy', 1, 50);

INSERT INTO todays_deals (deal_amount,"expiry_date",admin_username) VALUES(30, '2019-11-30','hana.aly');
INSERT INTO todays_deals (deal_amount,"expiry_date",admin_username) VALUES(40, '2019-11-18','hana.aly');
INSERT INTO todays_deals (deal_amount,"expiry_date",admin_username) VALUES(50, '2019-12-12','hana.aly');


INSERT INTO Offer (offer_amount,"expiry_date") VALUES (50,'2019-11-30');

INSERT INTO Wishlist(username, "name") VALUES('ammar.yasser', 'fashion');

INSERT INTO Giftcard (code, "expiry_date", amount) VALUES('G101','2019-11-18',100);


--SET IDENTITY_INSERT Product ON;
INSERT INTO Product (product_name, category, product_description, price, final_price,color,
available, rate, vendor_username) VALUES('Bag', 'Fashion','backbag',100,100,'yellow',1,0,'hadeel.adel');
INSERT INTO Product (product_name, category, product_description, price, final_price,color,
available, rate, vendor_username) VALUES('Blue pen', 'stationary','useful pen',10,10,'Blue',1,0,'hadeel.adel');
INSERT INTO Product (product_name, category, product_description, price, final_price,color,
available, rate, vendor_username) VALUES('Blue pen', 'stationary','useful pen',10,10,'Blue',0,0,'hadeel.adel');
INSERT INTO Product (product_name, category, product_description, price, final_price,color,
available, rate, vendor_username) VALUES('Red pen', 'stationary','useful pen',10,10,'Red',0,0,'hadeel.adel');
--SET IDENTITY_INSERT Product OFF;


INSERT INTO CustomerAddsToCartProduct (serial_no, customer_name) VALUES(1, 'ammar.yasser');


INSERT INTO wishlist_product(username, wish_name, serial_no) VALUES('ammar.yasser', 'fashion', 4);
INSERT INTO wishlist_product(username, wish_name, serial_no) VALUES('ammar.yasser', 'fashion', 2);



--first screwed up test case
--INSERT INTO Users (username, first_name, last_name, "password", email) VALUES('sama.walid','sama','walid', 'pass16', 'sama.walid@guc.edu.eg');
--INSERT INTO Admins (username) VALUES('sama.walid');
--INSERT INTO todays_deals (deal_amount,"expiry_date",admin_username) VALUES(10, '2019-11-12','sama.walid');
--This test case is an foreign key integrity violation (Without the first 2 statements which were not in the original test cases)

--second screwed up test case
--This test case is an foreign key integrity violation 


