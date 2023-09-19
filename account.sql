-- ACCOUNT 계좌 테이블 생성
CREATE TABLE ACCOUNT(
	id VARCHAR(100) PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	balance INT DEFAULT 0 CHECK(balance>=0),
	grade VARCHAR(100)
);

-- account 계좌 생성
INSERT INTO account VALUES ('10001', '홍길동', 100000, 'VIP');
INSERT INTO account VALUES ('10002', '하길동', 100000, 'GOLD');


—- deposit 입금
UPDATE account SET balance=balance+10000 WHERE id='10001';

—- withdraq 출금
UPDATE account SET balance=balance-5000 WHERE id='10001';

—- 계좌 조회
SELECT * FROM account WHERE id='10001';

—- 모든 계좌 조회
SELECT * FROM ACCOUNT;

CREATE USER kosta IDENTIFIED BY '1234';
