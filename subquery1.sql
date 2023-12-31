-- SELECT COLUMN_LIST
-- FROM TABLE
-- WHERE 조건연산자 (SELECT COLUMN_LIST FROM TABLE WHERE 조건);.

-- = , <>(!=),>,>+,<,<= : 단일행 서브쿼리 연산자
-- 16+16
SELECT ename, comm
FROM emp
WHERE comm <(SELECT comm FROM emp WHERE ename='WARD');

-- 16*16
SELECT e1.ename, e2.comm
FROM emp e1, emp e2
WHERE e2.ename = 'WARD' AND e1.comm<e2.comm;

-- student, department 테이블을 이용하여  서진수 학생과 주전공이 동일한 학생들의 이름과 전공 조회
SELECT s1.NAME, d.dname
FROM student s JOIN department d ON s.deptno1=d.deptno
JOIN student s1
WHERE s.name='서진수' AND s.deptno1 = s1.deptno1;

SELECT s.name, d.dname
FROM student s JOIN department d ON s.deptno1=d.deptno
WHERE deptno1 = (SELECT deptno1 FROM student WHERE NAME='서진수');

-- professor, department 테이블을 이용하여 박원범 교수보다 나중에 입사한 사람의 이름과 입사일, 학과명 조회
SELECT p.NAME, p.hiredate, d.dname
FROM professor p JOIN department d ON p.deptno = d.deptno
WHERE hiredate>(SELECT hiredate FROM professor WHERE NAME = '박원범');

-- student 테이블에서 주전공이 201번인 학과의 평균 몸무게보다 몸무게가 많은 학생들의 이름과 몸무게 조회
-- subquery: 주전공이 201번인 학과의 평균 몸무게
SELECT name, weight
FROM student
WHERE weight > (SELECT AVG(weight) FROM student WHERE deptno1=201)
ORDER BY 2 DESC;

-- student 테이블에서 주전공이 전자공학인 학과의 평균 몸무게보다 몸무게가 많은 학생들의 이름과 몸무게 조회
SELECT name, weight
FROM student
WHERE weight >(SELECT AVG(weight)
					FROM student s JOIN department d ON s.deptno1=d.deptno
					WHERE d.dname='전자공학과')
ORDER BY 2 DESC;

-- gogak, gift 테이블을 이용하여 노트북을 받을 수 있는 고객의 이름, 포인트, 상품명 조회
-- subquery: 노트북의 최저 포인트
SELECT gNAME, POINT
FROM gogak
WHERE POINT >= (SELECT g_start FROM gift WHERE gname='노트북')
ORDER BY 2 desc;

-- emp, dept 테이블을 이용하여 NEWYORK에서 근무하는 직원목록 조회
SELECT *
FROM emp
WHERE deptno = (SELECT deptno FROM dept WHERE LOC='New York');

-- professor, student 테이블에서 박원범 교수가 담당하는 학생 목록 조회
-- subquery: 박원범 교수의 교수번호 조회
SELECT *
FROM student
WHERE profno = (SELECT profno FROM professor WHERE NAME ='박원범');

-- gogak, gift 테이블을 사용하여 안광훈 고객이 포인트로 받을 수 있는 상품 목록 조회
SELECT gname
FROM gift
WHERE g_start < (SELECT point FROM gogak WHERE gname='안광훈'); 

-- emp, dept 테이블을 이용하여 sales 부서를 제외한 나머지 부서에 속한 직원의 사번, 이름, 부서명 조회
-- subquery: sales 부서번호 조회
SELECT e.empno, e.ename, d.dname
FROM emp e JOIN dept d using(deptno)
WHERE deptno <> (SELECT deptno FROM dept WHERE dname='SALES')
ORDER BY 1; 

SELECT e.empno, e.ename, d.dname
FROM emp e JOIN dept d ON e.deptno=d.deptno
WHERE e.deptno NOT IN (SELECT deptno FROM dept WHERE dname='SALES')
ORDER BY 1; 

-- student, exam_01, hakjum 테이블을 이용하여 학점이 B미만인 학생의 학번, 이름, 점수 조회
-- subquery: hakjum 테이블에서 B등급의 min_point 구하기
SELECT s.studno, s.name, e.total
FROM student s JOIN exam_01 e ON s.studno=e.studno
WHERE total < (SELECT min_point FROM hakjum WHERE grade='B0')
ORDER BY 3 desc;

-- student, exam_01, hakjum 테이블을 이용하여 학점이 A0인 학생의 학번, 이름, 점수 조회
-- subquery: hakjum 테이블에서 A0 등급의 min_point와 max_point 구하기
SELECT s.studno, s.name, e.total
FROM student s JOIN exam_01 e USING(studno)
WHERE total BETWEEN
					(SELECT min_point FROM hakjum WHERE grade='A0') AND
					(SELECT max_point FROM hakjum WHERE grade='A0')
ORDER BY 3 DESC;

-- in, exitst, >any, <any, <all, >all: 다중행 서브쿼리 연산자
-- emp2, dept2 테이블을 이용하여 '포항본사'에서 근무하는 직원들의 사번, 이름, 직급, 부서명 조회
-- subquery: area가 '포항본사'인 dcode 조회
SELECT empno, NAME, position, dname
FROM emp2 e JOIN dept2 d ON e.deptno=d.dcode
WHERE dcode IN (SELECT dcode FROM dept2 WHERE AREA='포항본사');

-- emp2 테이블을 이용하여 '과장'직급의 최소연봉자보다 연봉이 높은 직원의 사번, 이름, 연봉 조회
SELECT empno, NAME, POSITION, pay
FROM emp2
WHERE pay>ANY(SELECT pay FROM emp2 WHERE POSITION='과장');

SELECT empno, NAME, POSITION, pay
FROM emp2
WHERE pay>(SELECT MIN(pay) FROM emp2 WHERE POSITION='과장');

-- 각 학년별 키가 가장 큰 학생의 이름과 학년 조회
SELECT NAME, grade
FROM student
WHERE (grade, height) IN (SELECT grade, MAX(height)
									FROM student
									GROUP BY grade)
ORDER BY 2;

-- student 테이블에서 2학년 학생들 중 몸무게가 가장 적게 나가는 학생보다 적은 학생의 이름, 학년, 몸무게 조회
SELECT NAME, grade, weight
FROM student
WHERE weight < ALL(SELECT weight FROM student WHERE grade=2);

-- emp2 테이블에서 본인이 속한 부서의 평균 연봉보다 적게 받는 직원의 이름, 연봉, 부서명 조회
SELECT e1.name, e1.pay, d.dname
FROM emp2 e1 JOIN dept2 d ON e1.deptno=d.dcode
WHERE e1.pay<(SELECT AVG(pay) FROM emp2 WHERE deptno=e1.deptno);

-- emp2, dept2 테이블에서 각 부서별 평균 연봉을 구하고 그 중에서 평균연봉이 가장 적은 평균
-- 연봉보다 믾이 받는 직원들의 직원명, 부서명, 연봉 조회
-- subquery: 부서별 평균연봉
SELECT e.name, d.dname, e.pay
FROM emp2 e JOIN dept2 d ON e.deptno=d.dcode
WHERE pay > ANY(SELECT AVG(pay) FROM emp2 GROUP BY deptno);

-- professor, department 테이블에서 각 학과별 입사일이 가장 오래된 교수의 교수번호, 이름, 입사일, 학과명 조회
SELECT p.profno, p.name, p.hiredate, d.dname
FROM professor p JOIN department d USING(deptno)
WHERE (deptno, hiredate) IN (SELECT deptno, MIN(hiredate) FROM professor group by deptno)
ORDER BY 3;

-- emp2 테이블에서 직급별 최대연봉을 받는 직원의 이름과 직급,연봉 조회
SELECT NAME, POSITION, pay
FROM emp2
WHERE pay IN (SELECT MAX(pay) FROM emp2 GROUP BY POSITION);

SELECT NAME, POSITION, pay
FROM emp2
WHERE (POSITION, pay) IN(SELECT POSITION, MAX(pay)
									FROM emp2
									GROUP BY POSITION)
ORDER BY 3 desc;
									
-- student, exam_01 테이블에서 같은학과 같은학년인 학생의 평균점수보다 점수가 높은 학생의
-- 학번, 이름, 학과, 학년, 점수 조회
SELECT s1.deptno1,s1.studno, s1.NAME, d.dname, s1.grade, e1.total
FROM student s1 JOIN exam_01 e1 USING(studno)
JOIN department d ON s1.deptno1=d.deptno
WHERE e1.total>=
	(SELECT AVG(total)
		FROM student s2 JOIN exam_01 e2 USING(studno)
		WHERE s2.deptno1=s1.deptno1 AND s2.grade=s1.grade)
ORDER BY s1.deptno1, s1.grade;

SELECT deptno1, grade, AVG(total)
FROM student s2 JOIN exam_01 e2 USING(studno)
GROUP BY deptno1, grade;

-- emp2 테이블에서 직원들 중 자신의 직급의 평균연봉과 같거나 많이 받는 사람들의 이름, 직급, 연봉 조회
-- 단, 직급이 없으면 조회하지 않는다.
SELECT e1.NAME, e1.POSITION, e1.pay
FROM emp2 e1
WHERE (e1.position IS NOT NULL AND trim(e1.position)<>'')
	and e1.pay >= (SELECT AVG(e2.pay) FROM emp2 e2 WHERE e2.position=e1.position);
	
-- student, professor 테이블에서 담당학생이 있는 교수들의 교수번호, 교수명 조회
SELECT DISTINCT s.profno, p.name
FROM student s JOIN professor p USING(profno)
WHERE profno IS NOT NULL;

SELECT p.profno, p.name
FROM professor p
WHERE EXISTS(SELECT * FROM student WHERE profno=p.profno);

SELECT 
FROM (SELECT DISTINCT profno FROM student) e JOIN professor p USING(profno)

-- student, professor 테이블에서 담당학생이 없는 교수들의 교수번호, 교수명 조회
SELECT p.profno, p.name
FROM professor p
WHERE NOT EXISTS(SELECT * FROM student WHERE profno=p.profno);

-- emp, dept 테이블에서 직원이 한 명도 소속되지 않은 부서의 부서번호와 부서명 조회
INSERT INTO dept VALUES(50, 'MARKETING', 'HONGKONG');
SELECT deptno, dname
FROM dept d
WHERE NOT EXISTS (SELECT * FROM emp WHERE deptno=d.deptno);

-- limit
SELECT *
FROM emp
ORDER BY sal DESC
LIMIT 5;

SELECT *
FROM emp
ORDER BY sal DESC
LIMIT 5,5;





