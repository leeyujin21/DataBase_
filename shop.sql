CREATE TABLE goods(
	code VARCHAR(100) PRIMARY KEY,
	NAME VARCHAR(100),
	price INT,
	stock INT,
	category VARCHAR(100)
);
 
CREATE TABLE orders( 
    no INT PRIMARY KEY,
    customer VARCHAR(100),
    productcode VARCHAR(100) REFERENCES goods(CODE),
    amount INT,
    iscanceled BOOLEAN
);
