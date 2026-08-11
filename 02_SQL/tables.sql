CREATE TABLE customers(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) ,
    phone VARCHAR(20) ,
    address VARCHAR(255) ,
    area VARCHAR(100),
    pincode INT ,
    registration_date DATE ,
    customer_segment VARCHAR(20) ,
    total_orders INT ,
    avg_order_value DECIMAL(10,2)

);

CREATE TABLE products(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(100),
    brand VARCHAR(100),
    price DECIMAL(10,2),
    mrp DECIMAL(10,2),
    margin_percentage DECIMAL(5,2),
    shelf_life_days INT,
    min_stock_level INT,
    max_stock_level INT
);

CREATE TABLE orders(
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    promised_delivery_time DATETIME,
    actual_delivery_time DATETIME,
    delivery_status VARCHAR(30),
    order_total DECIMAL(10,2),
    payment_method VARCHAR(30),
    delivery_partner_id INT,
    store_id INT,

    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

CREATE TABLE order_items(
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),

    PRIMARY KEY (order_id, product_id),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

CREATE TABLE delivery_performance(
    order_id INT PRIMARY KEY,
    delivery_partner_id INT,
    promised_time DATETIME,
    actual_time DATETIME,
    delivery_time_minutes INT,
    distance_km DECIMAL(5,2),
    delivery_status VARCHAR(30),
    reasons_if_delayed VARCHAR(255),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

CREATE TABLE customer_feedback(
    feedback_id INT PRIMARY KEY,
    order_id INT,
    customer_id INT,
    rating INT,
    feedback_text VARCHAR(500),
    feedback_category VARCHAR(100),
    sentiment VARCHAR(20),
    feedback_date DATE,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE marketing_performance (
    campaign_id INT PRIMARY KEY,
    campaign_name VARCHAR(100),
    campaign_date DATE,
    target_audience VARCHAR(50),
    channel VARCHAR(50),
    impressions INT,
    clicks INT,
    conversions INT,
    spend DECIMAL(10,2),
    revenue_generated DECIMAL(10,2),
    roas DECIMAL(5,2)
);

