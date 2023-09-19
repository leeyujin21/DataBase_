DROP TABLE article;
DROP TABLE user;

CREATE TABLE user(
	id VARCHAR(100),
	NAME VARCHAR(100)
);

CREATE TABLE article(
	num INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(500),
	content VARCHAR(1000),
	writer VARCHAR(100)
);

ALTER TABLE user ADD CONSTRAINT user_pk PRIMARY KEY(id);
ALTER TABLE article ADD CONSTRAINT article_user_fk FOREIGN KEY(writer) REFERENCES user(id);

INSERT INTO article VALUES(NULL, '제목', '내용','hong'); -- error: 'hong'이 user 테이블에 없어서(외래키 제약 조건 위배)
INSERT INTO article VALUES(NULL, '제목', '내용', NULL); -- 단, null 값은 가능

INSERT INTO user VALUES('hong', '홍길동');
INSERT INTO article VALUES(NULL, '제목', '내용', 'hong'); -- success 

DELETE FROM user WHERE id='hong'; -- hong 데이터를 article 테이블에서 참조하고 있어서 삭제 불가
UPDATE user SET id = 'kong' WHERE id = 'hong'; -- hong 데이터를 article 테이블에서 참조하고 있어서 변경 불가
UPDATE user SET NAME = '홍홍' WHERE id = 'hong'; -- success

ALTER TABLE article DROP CONSTRAINT article_user_fk; -- 외래키 제약조건 삭제
INSERT INTO article VALUES(NULL, '송제목', '송내용','song'); -- success: 외래키 제약 조건 삭제해서

ALTER article ADD CONSTRAINT article_user_fk FOREIGN KEY(writer) REFERENCES user(id) ON DELETE CASCADE; -- error: 제약 조건 위배되는 데이터가 있어서(song)
UPDATE article SET writer='hong' WHERE writer<>'hong';

ALTER article ADD CONSTRAINT article_user_fk FOREIGN KEY(writer) REFERENCES user(id) ON DELETE CASCADE;
DELETE FROM user WHERE id = 'hong'; -- success: ON DELETE CASCADE에 의해 참조하는 데이터도 같이 삭제

----------------------------------------------------------
-- 제약조건 약식
----------------------------------------------------------
CREATE TABLE user(
	id VARCHAR(100) PRIMARY KEY,
	NAME VARCHAR(100)
);

CREATE TABLE user(
	id VARCHAR(100),
	NAME VARCHAR(100),
	PRIMARY KEY(id)
);

CREATE TABLE article(
	num INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(500),
	content VARCHAR(1000),
	writer VARCHAR(100) REFERENCES user(id)
);

CREATE TABLE article(
	num INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(500),
	content VARCHAR(1000),
	writer VARCHAR(100),
	PRIMARY KEY(num),
	FOREIGN KEY(writer) REFERENCES user(id)
);

CREATE TABLE tcons(
	NO INT AUTO_INCREMENT,
	NAME VARCHAR(20) NOT NULL,
	jumin VARCHAR(13) NOT NULL UNIQUE,
	AREA INT,
	deptno VARCHAR(6)
);

ALTER tcons ADD CONSTRAINT tcons_no_pk PRIMARY KEY(NO);
ALTER tcons ADD CONSTRAINT tcons_deptno_fk FOREIGN KEY(deptno) REFERENCES dept2(dcode);









