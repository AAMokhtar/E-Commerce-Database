---------------------SCHEMA-----------------------
CREATE TABLE users(
    username VARCHAR(20) NOT NULL,
    "password" VARCHAR(20) DEFAULT '1234',
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    email VARCHAR(50),

    PRIMARY KEY(username),
    
    CONSTRAINT diff UNIQUE (email) --emails must be different
)

CREATE TABLE user_mobile_numbers(
    username VARCHAR(20) NOT NULL,
    mobile_number VARCHAR(11) NOT NULL, --to not disregard the 0 in the beginning

    PRIMARY KEY(username,mobile_number),

    FOREIGN KEY (username) REFERENCES users(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION,

    CONSTRAINT mbDigits CHECK (mobile_number NOT LIKE '%[^0-9]%') --[^1-3]
)

CREATE TABLE user_addresses(
    username VARCHAR(20) NOT NULL,
    "address" VARCHAR(50) NOT NULL,

    PRIMARY KEY(username,"address"),

    FOREIGN KEY (username) REFERENCES users(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
)

CREATE TABLE customer(
    username VARCHAR(20) NOT NULL,
    points INT DEFAULT 0,

    PRIMARY KEY(username),

    FOREIGN KEY (username) REFERENCES users(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
)




CREATE TABLE admins(
    username VARCHAR(20) NOT NULL,

    PRIMARY KEY(username),

    FOREIGN KEY (username) REFERENCES users(username)  --do i need to cascade? please god no.
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
)

CREATE TABLE giftcard(
    code VARCHAR(10) NOT NULL, 
    "expiry_date" DATETIME,
    amount INT,
    username VARCHAR(20) , 

    PRIMARY KEY(code),

    FOREIGN KEY (username) REFERENCES admins(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
)

CREATE TABLE vendor(
    username VARCHAR(20) NOT NULL,
    activated BIT Default 0, ------------------------------ modified
    company_name VARCHAR(20),
    bank_acc_no VARCHAR(15),
    admin_username VARCHAR(20),

    PRIMARY KEY(username),

    FOREIGN KEY (username) REFERENCES users(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION,

    FOREIGN KEY (admin_username) REFERENCES admins(username) 
	ON UPDATE NO ACTION 
    ON DELETE NO ACTION
)

CREATE TABLE delivery_person(
    username VARCHAR(20) NOT NULL,
    is_activated BIT,

    PRIMARY KEY(username),

    FOREIGN KEY (username) REFERENCES users(username) 
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
)

CREATE TABLE credit_card(
    "number" VARCHAR(20) NOT NULL,
    "expiry_date" DATETIME,
    cvv_code varchar(4),

    PRIMARY KEY("number")
)

CREATE TABLE delivery(
    id INT IDENTITY NOT NULL,
	"type" varchar(20),
    time_duration INT,
    fees DECIMAL(30,20),
    username VARCHAR(20), 

    PRIMARY KEY(id),

    FOREIGN KEY (username) REFERENCES admins(username)
	ON UPDATE NO ACTION 
    ON DELETE NO ACTION
)

CREATE TABLE orders(
    order_no INT IDENTITY NOT NULL,
    order_date DATETIME,
    total_amount DECIMAL(30,20),
    cash_amount DECIMAL(30,20),
    credit_amount DECIMAL(30,20),
    payment_type VARCHAR(20),
    order_status VARCHAR(20),
    remaining_days INT,
    time_limit DATETIME, --why datetime?
	gift_card_code_used VARCHAR(10),
    customer_name VARCHAR(20) NOT NULL, --can the customer be null?
    delivery_id INT,
    creditCard_number VARCHAR(20),

    PRIMARY KEY(order_no),

    FOREIGN KEY (customer_name) REFERENCES customer(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION,

    FOREIGN KEY (delivery_id) REFERENCES delivery(id),

    FOREIGN KEY (creditCard_number) REFERENCES credit_card("number"),

	FOREIGN KEY (gift_card_code_used) REFERENCES giftcard(code) on update cascade on delete set null
)

CREATE TABLE product(
    serial_no INT IDENTITY NOT NULL, 
    product_name VARCHAR(50),
    category VARCHAR(30),
    product_description VARCHAR(200), 
	price decimal(30,20),
    final_price DECIMAL(30,20),
    color VARCHAR(20),
    available BIT DEFAULT 1,
    rate DECIMAL(30,20),
    vendor_username VARCHAR(20) NOT NULL, 
    customer_username VARCHAR(20),
    customer_order_id INT,

    PRIMARY KEY(serial_no),

    CONSTRAINT k1 FOREIGN KEY (vendor_username) REFERENCES vendor(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION,

    CONSTRAINT k2 FOREIGN KEY (customer_username) REFERENCES customer(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION,

    CONSTRAINT k3 FOREIGN KEY (customer_order_id) REFERENCES orders(order_no) on update cascade on delete set null, --check this
)

CREATE TABLE customerAddsToCartProduct(
    serial_no INT NOT NULL,
    customer_name VARCHAR(20) NOT NULL,

    PRIMARY KEY(serial_no,customer_name),

    FOREIGN KEY (serial_no) REFERENCES product(serial_no)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    FOREIGN KEY (customer_name) REFERENCES customer(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
)

CREATE TABLE todays_deals(
    deal_id INT IDENTITY NOT NULL,
    deal_amount INT,
    "expiry_date" DATETIME,
    admin_username VARCHAR(20) NOT NULL,

    PRIMARY KEY(deal_id),

    FOREIGN KEY (admin_username) REFERENCES admins(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION,

    CONSTRAINT dealP CHECK (deal_amount >= 0 AND deal_amount <= 100)
)

CREATE TABLE todays_deals_product(
    deal_id INT NOT NULL,
    serial_no INT NOT NULL,

    PRIMARY KEY(deal_id,serial_no),

    FOREIGN KEY (deal_id) REFERENCES todays_deals(deal_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    FOREIGN KEY (serial_no) REFERENCES product(serial_no)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)

CREATE TABLE offer(
    offer_id INT IDENTITY NOT NULL,
    offer_amount INT,
    "expiry_date" DATETIME,

    PRIMARY KEY(offer_id),

    CONSTRAINT offerP CHECK (offer_amount >= 0 AND offer_amount <= 100)
)

CREATE TABLE offersOnProduct(
    offer_id INT NOT NULL,
    serial_no INT NOT NULL,

    PRIMARY KEY(offer_id,serial_no),

    FOREIGN KEY (offer_id) REFERENCES offer(offer_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    FOREIGN KEY (serial_no) REFERENCES product(serial_no)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)

CREATE TABLE customer_question_product(
    serial_no INT NOT NULL,
    customer_name VARCHAR(20) NOT NULL,
    question VARCHAR(100),
    answer VARCHAR(200),

    PRIMARY KEY(serial_no,customer_name),

    FOREIGN KEY (serial_no) REFERENCES product(serial_no)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    FOREIGN KEY (customer_name) REFERENCES customer(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
)

CREATE TABLE wishlist(
    username VARCHAR(20) NOT NULL,
    "name" VARCHAR(20) NOT NULL,

    PRIMARY KEY(username,"name"),

    FOREIGN KEY (username) REFERENCES customer(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
)



CREATE TABLE wishlist_product(
    username VARCHAR(20) NOT NULL,
    wish_name VARCHAR(20) NOT NULL,
    serial_no INT NOT NULL,

    PRIMARY KEY(username,wish_name,serial_no),
    
    FOREIGN KEY (username,wish_name) REFERENCES wishlist(username,"name")
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION,

    FOREIGN KEY (serial_no) REFERENCES product(serial_no)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
)

CREATE TABLE admin_customer_giftcard(
    code VARCHAR(10) NOT NULL,
    customer_name VARCHAR(20) NOT NULL,
    admin_username VARCHAR(20) NOT NULL,
	remaining_points int,

    PRIMARY KEY (code, customer_name, admin_username),

    FOREIGN KEY (code) REFERENCES giftcard(code)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    FOREIGN KEY (customer_name) REFERENCES customer(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION,

    FOREIGN KEY (admin_username) REFERENCES admins(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
)

CREATE TABLE admin_delivery_order(
    delivery_username VARCHAR(20) NOT NULL,
    order_no INT NOT NULL,
    admin_username VARCHAR(20) NOT NULL,
    delivery_window VARCHAR(50),

    PRIMARY KEY (delivery_username, order_no),

    FOREIGN KEY (delivery_username) REFERENCES delivery_person(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION,

    FOREIGN KEY (order_no) REFERENCES orders(order_no)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    FOREIGN KEY (admin_username) REFERENCES admins(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION
)

CREATE TABLE customer_creditCard(
    customer_name VARCHAR(20) NOT NULL,
    cc_number  VARCHAR(20) NOT NULL,

    PRIMARY KEY (customer_name, cc_number),

    FOREIGN KEY (customer_name) REFERENCES customer(username)
    ON UPDATE NO ACTION 
    ON DELETE NO ACTION,

    FOREIGN KEY (cc_number) REFERENCES credit_card("number")
    ON UPDATE CASCADE
    ON DELETE CASCADE
)
GO
