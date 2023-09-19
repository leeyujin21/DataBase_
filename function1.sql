------------------------------------------------------------
-- 문자열 함수
------------------------------------------------------------
-- concat : 문자열을 이을 때 사용
SELECT CONCAT(ename, '(', job,')') AS 'ename(job)'  FROM emp;

-- SMITH's sal is $800
SELECT CONCAT(ename,'''s sal is $', sal) as info FROM emp;

-- format : #, ###, ###.## 숫자형 데이터의 포맷 지정
SELECT FORMAT(250500.1254,2);
SELECT empno, ename sal FROM emp;
SELECT empno, ename, FORMAT(sal,0) FROM emp;

-- insert : 문자열 내의 지정된 위치에 특정 문자 수만큼 문자열을 변경한다.
SELECT INSERT('http://naver.com',8,5,'kosta');

-- student 테이블에서 주민번호 뒤에 7자리를 '*'로 변경
-- (학번, 이름, 주민번호, 학년)
SELECT studno, NAME, INSERT(jumin,7,7,'*******') FROM student;

-- gogak 테이블의 고객번호와 이름 조회(단, 이름은 가운데 글자를 *로 대체)
SELECT gno AS 고객번호 , INSERT(gname, 2,1,'*') AS 이름 FROM gogak;

-- instr: 문자열 내에서 특정 문자의 위치를 구한다.
SELECT INSTR('http://naver.com','n');


-- student 테이블의 tel에서 )의 위치 구하기
SELECT INSTR(tel,')') FROM student;

-- substr: 문자열 내에서 부분 문자열 추출
SELECT SUBSTR('http://naver.com',8,5);
SELECT SUBSTR('http://naver.com',8);

-- student 테이블에서 전화번호의 지역번호 구하기
SELECT SUBSTR(tel,1,INSTR(tel,')')-1) FROM student;

-- student 테이블에서 전화번호의 국번 구하기
SELECT SUBSTR(tel, INSTR(tel,')')+1,INSTR(tel,'-')-INSTR(tel,')')-1) AS 국번 FROM student;

-- student 테이블에서 주민번호 생년월일이 9월일 학생 조회
SELECT studno, NAME, jumin from student WHERE SUBSTR(jumin,3,2)='09';

-- length: 문자열의 바이트 수 구하기(영문한글자:1byte, 한글한글자:3byte)
SELECT LENGTH(tel) FROM student;

SELECT LENGTH(email) FROM professor;
SELECT INSTR(email,'@') FROM professor;
SELECT email, INSERT(email, INSTR(email, '@')+1, LENGTH(SUBSTR(email, INSTR(email,'@')+1)),'kosta.com') LENGTH FROM professor;

SELECT ename, LENGTH(ename) FROM emp;
SELECT NAME, LENGTH(NAME) FROM student;

-- char_length: 문자열의 글자수 구하기
SELECT ename, CHAR_LENGTH(ename) FROM emp;
SELECT NAME, CHAR_LENGTH(NAME) FROM student;

-- substring: = substr
SELECT SUBSTR('http://naver.com',8,5);
SELECT SUBSTRING('http://naver.com',8,5);

-- 소문자로 변경: LOWER, LCASE
SELECT ename, LOWER(ename) FROM emp;
SELECT ename, LCASE(ename) FROM emp;

-- 대문자로 변경: UPPER, UCASE
SELECT id, UPPER(id) FROM professor;
SELECT id, UCASE(id) FROM professor;

-- trim: 앞뒤 공백 제거
SELECT LENGTH('  test  '), LENGTH(TRIM('  test  '));
SELECT LENGTH('t e s t'), LENGTH(TRIM('t e s t'));

-- ltrim: 왼쪽 공백 제거
SELECT LENGTH('  test  '), LENGTH(LTRIM('  test  '));

-- rtrim: 오른쪽 공백 제거
SELECT LENGTH('  test  '), LENGTH(RTRIM('  test  '));

-- lpad: 왼쪽을 특정 문자로 채워넣기
SELECT sal, LPAD(ename, 20, '*') FROM emp;
SELECT sal, LPAD(ename, 20, '123456789') FROM emp;

-- rpad: 오른쪽을 특정 문자로 채워넣기
SELECT sal, RPAD(ename, 20, '*') FROM emp;

---------------------------------------------------------
-- 날짜함수 -
---------------------------------------------------------
-- curdate, current_date
SELECT CURDATE();
SELECT CURDATE(), CURRENT_DATE();

SELECT CURDATE()+1;

-- adddate, date_add: 연, 월, 일을 더하거나 뺀다
SELECT ADDDATE(CURDATE(), INTERVAL -1 YEAR); -- year, day, month
SELECT DATE_ADD(CURDATE(), INTERVAL -1 YEAR);

-- emp 테이블에서 각 직원의 입사일과 10년 기념일을 조회
SELECT hiredate, ADDDATE(hiredate, INTERVAL +10 YEAR) AS 10anniversary FROM emp;
SELECT hiredate, ADDDATE(hiredate, 2) FROM emp;

-- curtime(), current_time
SELECT CURTIME(), CURRENT_TIME();
SELECT CURTIME(), ADDTIME(CURTIME(),'1:10:5'); -- 1hour 10minutes 5seconds

-- now() : 현재 날짜 & 시간
SELECT NOW();
SELECT NOW(), ADDTIME(NOW(), '2 1:10:5'); -- add 2days 1hour 10minutes 5seconds

-- datediff: 날짜 간격 계산
SELECT hiredate, DATEDIFF(CURDATE(), hiredate) FROM emp;
SELECT DATEDIFF(CURDATE(), '1972-04-03') as 일수 FROM emp;

-- date_format
SELECT DATE_FORMAT('2017-06-15', "%M %D %Y");
SELECT DATE_FORMAT(NOW(), "%M %d %y %h %i %s");
-- 월: %M(September), %b(Sep), %m(09), %c(9)
-- 연: %Y(2023), %y(23)
-- 일: %d(05), %e(5)
-- 요일: %W(Tuesday), %a(Tue)
-- 시간: %H(13), %l(1)
-- %r: hh:mm:ss AM, PM
-- 분: %i
-- 초: %s

-- date_sub: 날짜 빼기
SELECT CURDATE(), DATE_SUB(CURDATE(), INTERVAL 10 DAY);
SELECT CURDATE(), ADDDATE(CURDATE(), INTERVAL -10 DAY);

-- day, dayofmonth: 날짜에서 일 추출
SELECT hiredate, DAY(hiredate) FROM emp;
SELECT hiredate, DAYOFMONTH(hiredate) FROM emp;

SELECT hiredate, YEAR(hiredate) FROM emp;
SELECT hiredate, MONTH(hiredate) FROM emp;

SELECT NOW(), HOUR(NOW());
SELECT NOW(), MINUTE(NOW());
SELECT NOW(), SECOND(NOW());

-- dayname, datofweek(숫자로 표시): 날짜에서 요일 추출
SELECT hiredate, DAYNAME(hiredate), dayofweek(hiredate) FROM emp;
SELECT CURDATE(), DAYOFWEEK(CURDATE()) FROM emp; -- 일요일:1, 월요일:2,...

-- extract
SELECT CURDATE(), EXTRACT(MONTH FROM CURDATE()) AS MONTH;
SELECT CURDATE(), EXTRACT(YEAR FROM CURDATE()) AS YEAR;
SELECT CURDATE(), EXTRACT(DAY FROM CURDATE()) AS DAY;
SELECT CURDATE(), EXTRACT(WEEK FROM CURDATE()) AS WEEK;
SELECT CURDATE(), EXTRACT(QUARTER FROM CURDATE()) AS QUARTER; -- 분기
SELECT CURDATE(), EXTRACT(YEAR_MONTH FROM NOW()) AS "YEAR_MONTH";
SELECT NOW(), EXTRACT(HOUR FROM NOW()) AS HOUR;
SELECT NOW(), EXTRACT(MINUTE FROM NOW()) AS MINUTE;
SELECT NOW(), EXTRACT(SECOND FROM NOW()) AS SECOND;

-- TIME_TO_SEC: 시간을 초로 변환
SELECT CURTIME(), TIME_TO_SEC(CURTIME());

-- TIMEDIFF
SELECT CURTIME(), TIMEDIFF(CURTIME(), '08:48:27');
SELECT TIME_TO_SEC(TIMEDIFF(CURTIME(), '08:48:27'));

--------------------------------------------------------
-- 숫자 함수
--------------------------------------------------------

-- count: 조건에 만족하는 레코드(행) 수
SELECT COUNT(*) FROM emp;
SELECT COUNT(comm) FROM emp; -- 컬럼명을 매개변수로 사용시 null인 레코드는 제외

SELECT COUNT(*) FROM emp WHERE deptno=10;

-- sum
SELECT SUM(sal) FROM emp;
SELECT SUM(sal) FROM emp WHERE deptno=10;

-- avg
SELECT SUM(sal), COUNT(*), SUM(sal)/COUNT(*), AVG(sal) FROM emp;
SELECT SUM(comm), COUNT(comm), COUNT(*), SUM(comm)/COUNT(*), SUM(comm)/COUNT(comm), AVG(comm) FROM emp;
SELECT SUM(comm), SUM(comm)/COUNT(*), AVG(IFNULL(comm,0)) FROM emp;

-- max
SELECT ename, MAX(sal) FROM emp;

-- min
SELECT ename, MIN(sal) FROM emp;

-- professor 테이블에서 각 교수들의 연봉을 조회하시오
-- 교수번호, 이름, 월급여, 보너스, 연봉
SELECT profno AS 교수번호, NAME AS 이름, pay AS 월급여, bonus AS 보너스, pay*12+IFNULL(bonus,0) AS 연봉 FROM professor;

-- group by
SELECT deptno, job, COUNT(*), SUM(sal) FROM emp
GROUP BY deptno, job;

-- student 테이블에서 메인 학과별 학생 수 조회
SELECT deptno1 메인학과, COUNT(*) AS 학생수 FROM student
GROUP BY deptno1;

-- student 테이블에서 학년별 평균 키 조회
SELECT grade, FORMAT(AVG(height),1) FROM student GROUP BY grade;

SELECT deptno, MAX(sal) FROM emp GROUP BY deptno;

-- GROUP BY에 대한 조건은 WHERE 말고 HAVING을 쓴다
-- emp 테이블에서 평균 급여가 2000이상인 부서의 부서번호와 평균급여 조회
SELECT deptno, AVG(sal) FROM emp
GROUP BY deptno 
HAVING AVG(sal)>=2000;

-- student 테이블에서 각학과와 학년별 평균 몸무게, 최대/최소 몸무게를 조회하시오
SELECT deptno1 학과, grade 학년,COUNT(*), AVG(weight) 평균몸무게, MAX(weight) 최대몸무게, MIN(weight)최소몸무게
FROM student
GROUP BY deptno1, grade
HAVING AVG(weight)>=50
ORDER BY deptno1, grade;


