 /*
    JOIN
    - 두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문
    - 조회 결과는 하나의 결과물(RESULT SET)으로 나옴
    
    - 관계형 데이터베이스는 최소한의 데이터로 각각의 테이블에 담고 있음
      (중복을 최소화하기 위해 최대한 쪼개서 관리)
      부서 데이터는 부서 테이블, 사원에 대한 데이터는 사원 테이블, 직급 테이블, ...
      
      만약 어떤 사원이 어떤 부서에 속해있는지 부서명과 같이 조회하고 싶다면?
      만약 어떤 사원이 어떤 직급인지 직급명과 같이 조회하고 싶다면?
      
      => 즉, 관계형 데이터베이스에서 SQL문을 이용한 테이블 간에 "관계"를 맺어 원하는 데이터를 조회하는 방법
      
      - 크게 "오라클 구문"과 "ANSI 구문"
      - ANSI(미국국립표준협회 == 산업표준을 제정하는 단체): 다른 DBMS에서도 사용 가능
 */
 /*
    1. 오라클 - 등가 조인(EQUAL JOIN) / ANSI - 내부 조인(INNER JOIN / NATURAL JOIN)
        - 연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회
            (일치하는 값이 없는 행은 조회 X)
        1) 오라클 전용 구문
            SELECT 컬럼, 컬럼, ..., 컬럼
            FROM 테이블1, 테이블2
            WHERE 테이블1.컬럼명 = 테이블2.컬럼명;
            
             - FROM절에 조회하고자 하는 테이블들을 콤마로(,) 구분하여 나열
             - WHERE 절에 매칭 시킬 컬럼명에 대한 조건 제시
             
        2) ANSI 표준 구문
            SELECT 컬럼, 컬럼, ..., 컬럼
            FROM 테이블1
            JOIN 테이블2 ON (테이블1.컬럼명 = 테이블2.컬럼명);
            
             - FROM 절에서 기준이 되는 테이블을 기술
             - JOIN 절에서 같이 조회하고자 하는 테이블을 기술 후 매칭 시킬 컬럼에 대한 조건을 기술(USING 구문과 ON 구문 사용)
             - 연결에 사용하려는 컬럼명이 같은 경우 ON 구문 대신에 USING(컬럼명) 구문 사용
 */
 -- 1) 연결할 두 컬럼명이 다른 경우
 -- 사번, 사원명, 부서코드, 부서명을 같이 조회
 -- 오라클 구문
 SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
 FROM EMPLOYEE, DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID;
 
 -- ANSI 표준 구문
 SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
 FROM EMPLOYEE
 JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
 
 -- 2) 연결할 두 컬럼명이 같은 경우
 -- 사번, 사원명, 직급코드, 직급명
 -- 오라클 구문
 -- 해결방법1) 테이블명을 이용하는 방법
 SELECT EMP_ID, EMP_NAME, JOB.JOB_CODE, JOB_NAME
 FROM EMPLOYEE, JOB
 WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
 
 -- 해결방법2) 테이블에 별칭을 부여해서 이용하는 방법
 SELECT EMP_ID, EMP_NAME, J.JOB_CODE, JOB_NAME
 FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE;
 
 -- ANSI 표준 구문
 -- 해결방법1) 테이블명 또는 별칭 이용
  SELECT EMP_ID, EMP_NAME, J.JOB_CODE, JOB_NAME
 FROM EMPLOYEE E
 JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);
 
 -- 해결방법2) JOIN USING(두 컬럼명이 일치할때만)
 SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
 FROM EMPLOYEE
 JOIN JOB USING(JOB_CODE);
 
 -- 자연조인(NATURAL JOIN): 각 테이블마다 동일한 컬럼이 한 개만 존재할 경우
 SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
 FROM EMPLOYEE
 NATURAL JOIN JOB; 

 
 -- 직급이 대리인 사원의 사번, 이름, 직급명, 급여를 조회
 -- 오라클 구문 (AND 사용시 JOIN 먼저 써야함 순서 중요)
 SELECT EMP_ID, EMP_NAME, JOB_NAME "직급명", SALARY "급여"
 FROM EMPLOYEE E , JOB J
 WHERE E.JOB_CODE = J.JOB_CODE AND JOB_NAME = '대리';
 
 -- 자연조인 구문
 SELECT EMP_ID, EMP_NAME, JOB_NAME "직급명", SALARY "급여"
 FROM EMPLOYEE
 NATURAL JOIN JOB
 WHERE JOB_NAME = '대리';
 
 -- ANSI 구문
 SELECT EMP_ID, EMP_NAME, JOB_NAME "직급명", SALARY "급여"
 FROM EMPLOYEE
 JOIN JOB USING(JOB_CODE)
 WHERE JOB_NAME = '대리';
 
 -- 실습문제 ---------------------------------------------------------
-- 1. 부서가 인사관리부인 사원들의 사번, 이름, 보너스 조회
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';

-- 2. DEPARTMENT와 LOCATION을 참고해서 전체 부서의 부서코드, 부서명, 지역코드, 지역명 조회
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT 
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- 3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;

-- 4. 부서가 총무부가 아닌 사원들의 사원명, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE 
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE <> '총무부';

/*
    2. 오라클 - 포괄 조인 / ANSI - 외부 조인(OUTER JOIN)
        - 두 테이블 간의 JOIN 시 일치하지 않는 행도 포함시켜서 조회가 가능
        - 단, 반드시 기준이 되는 테이블(컬럼)을 지정해야 한다.
            (LEFT, RIGHT, FULL, (+))
*/
-- 사원명, 부서명, 급여, 연봉 조회
-- 부서 배치가 아직 안된 사원 2명에 대한 정보는 조회 X(부서가 NULL인 사람은 제외하고 21명)
SELECT EMP_NAME "사원명", DEPT_TITLE "부서명", SALARY "급여", SALARY*12 "연봉"
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 1) LEFT [OUTER] JOIN : 두 테이블 중 왼편에 기술된 테이블을 기준으로 JOIN
-- 부서 배치를 받지 않았던 2명의 사원 정보도 조회됨(부서가 NULL인 사람도 포함하여 23명)
-- ANSI
SELECT EMP_NAME "사원명", DEPT_TITLE "부서명", SALARY "급여", SALARY*12 "연봉"
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 오라클
SELECT EMP_NAME "사원명", DEPT_TITLE "부서명", SALARY "급여", SALARY*12 "연봉"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- 기준으로 삼고자하는 테이블의 반대편 테이블의 컬럼 뒤에 (+) 붙이기

-- 2) RIGHT [OUTER] JOIN : 두 테이블 중 오른쪽에 기술된 테이블을 기준으로 JOIN
-- ANSI
SELECT EMP_NAME "사원명", DEPT_TITLE "부서명", SALARY "급여", SALARY*12 "연봉"
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 오라클
SELECT EMP_NAME "사원명", DEPT_TITLE "부서명", SALARY "급여", SALARY*12 "연봉"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [OUTER] JOIN: 두 테이블이 가진 모든 행을 조회할 수 있음
-- ANSI
SELECT EMP_NAME "사원명", DEPT_TITLE "부서명", SALARY "급여", SALARY*12 "연봉"
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 오라클 (에러 발생! 오라클 구문으로는 FULL JOIN 안됨)
SELECT EMP_NAME "사원명", DEPT_TITLE "부서명", SALARY "급여", SALARY*12 "연봉"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);

/*
    3. 비등가 조인(NON EQUAL JOIN)
    매칭시킬 컬럼에 대한 조건 작성시 '='(등호)를 사용하지 않는 조인문
    값의 범위에 포함되는 행들을 연결하는 방식
    ANSI 구문으로는 JOIN ON으로만 사용가능! (USING 사용 불가)
*/
-- 사원명, 급여, 급여레벨 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT SAL_LEVEL, MIN_SAL, MAX_SAL
FROM SAL_GRADE;

-- ANSI
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

-- 오라클
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

/*
    4. 자체 조인(SELF JOIN)
    - 같은 테이블을 다시 한번 조인하는 경우 (자기 자신과 조인)
*/
-- 사번, 사원명, 사원부서코드, 사수사번, 사수명, 사수부서코드 조회
SELECT E.EMP_ID 사번, E.EMP_NAME 사원명, E.DEPT_CODE 부서코드,
       M.EMP_ID 사수사번, M.EMP_NAME 사수명, M.DEPT_CODE 사수부서코드
FROM EMPLOYEE E, EMPLOYEE M 
WHERE E.MANAGER_ID = M.EMP_ID(+);

-- ANSI
SELECT E.EMP_ID 사번, E.EMP_NAME 사원명, E.DEPT_CODE 부서코드,
       M.EMP_ID 사수사번, M.EMP_NAME 사수명, M.DEPT_CODE 사수부서코드
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

/*
    5. 카테시안곱(CARTESIAN PRODUCT) / 교차 조인(CROSS JOIN)
    - 조인되는 모든 테이블의 각 행들이 서로서로 모두 매핑된 데이터가 검색된다. (곱집합)
    - 두 테이블의 행들이 모두 곱해진 행들의 조합이 출력
        -> 방대한 데이터 출력 -> 과부하의 위험
*/
-- ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE 
CROSS JOIN DEPARTMENT;

-- 오라클
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT;

/*
    6. 다중 JOIN
    - 여러 개의 테이블을 조인하는 경우
*/
-- 사번, 사원명, 부서명, 직급명 조회
-- ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);

-- 오라클
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT , JOB J
WHERE DEPT_CODE = DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

-- 사번, 사원명, 부서명, 지역명 조회
-- ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- 오라클
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE;

-- 사번, 사원명, 부서명, 직급명, 지역명, 국가명, 급여등급 조회
-- ANSI
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_TITLE 부서명, JOB_NAME 직급명, LOCAL_NAME 지역명, NATIONAL_NAME 국가명, SAL_LEVEL 급여등급
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

-- 오라클 구문
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_TITLE 부서명, JOB_NAME 직급명,
    LOCAL_NAME 지역명, NATIONAL_NAME 국가명, SAL_LEVEL 급여등급
FROM EMPLOYEE E, DEPARTMENT, JOB J, LOCATION L, NATIONAL N, SAL_GRADE
WHERE DEPT_CODE = DEPT_ID 
    AND E.JOB_CODE = J.JOB_CODE 
    AND LOCATION_ID = LOCAL_CODE 
    AND L.NATIONAL_CODE = N.NATIONAL_CODE 
    AND SALARY BETWEEN MIN_SAL AND MAX_SAL;
    
-- 종합 실습 문제 --------------------------------------------------------------------------
-- 1. 직급이 대리이면서 ASIA 지역에서 근무하는 직원들의 사번, 직원명, 직급명, 부서명, 근무지역, 급여를 조회
-- ANSI
SELECT EMP_ID 사번, EMP_NAME 직원명 , JOB_NAME 직급명, DEPT_TITLE 부서명, LOCAL_NAME 근무지역, SALARY 급여
FROM EMPLOYEE E
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE JOB_NAME = '대리' AND LOCAL_NAME LIKE ('ASIA%');

-- 오라클
SELECT EMP_ID 사번, EMP_NAME 직원명 , JOB_NAME 직급명, DEPT_TITLE 부서명, LOCAL_NAME 근무지역, SALARY 급여
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE 
    AND E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE 
    AND (JOB_NAME = '대리' AND LOCAL_NAME LIKE ('ASIA%'));

-- 2. 70년대생 이면서 여자이고, 성이 전 씨인 직원들의 직원명, 주민번호, 부서명, 직급명을 조회
-- ANSI
SELECT EMP_NAME 직원명, EMP_NO 주민번호, DEPT_TITLE 부서명, JOB_NAME 직급명
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SUBSTR(EMP_NO, 1, 1) = '7'
    AND SUBSTR(EMP_NO, 8, 1) = '2'
    AND EMP_NAME LIKE '전%';
    
-- 오라클
SELECT EMP_NAME 직원명, EMP_NO 주민번호, DEPT_TITLE 부서명, JOB_NAME 직급명
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_CODE = J.JOB_CODE 
    AND E.DEPT_CODE = D.DEPT_ID
    AND SUBSTR(EMP_NO, 1, 1) = '7'
    AND SUBSTR(EMP_NO, 8, 1) = '2'
    AND EMP_NAME LIKE '전%';

-- 3. 보너스를 받는 직원들의 직원명, 보너스, 연봉, 부서명, 근무지역 조회(부서 코드가 없는 사원도 출력될 수 있게)
SELECT EMP_NAME 직원명, BONUS 보너스, TO_CHAR(SALARY*12,'999,999,999') 연봉, DEPT_TITLE 부서명, LOCAL_NAME 근무지역
FROM EMPLOYEE
LEFT JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE BONUS IS NOT NULL;

-- 4. 한국과 일본에서 근무하는 직원들의 직원명, 부서명, 근무지역, 근무국가 조회
SELECT EMP_NAME 직원명, DEPT_TITLE 부서명, LOCAL_NAME 근무지역, NATIONAL_NAME 근무국가
FROM EMPLOYEE
JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '한국' OR NATIONAL_NAME = '일본';

-- 5. 각 부서별 평균 급여 조회하여 부서명, 평균 급여(정수 처리) 조회
SELECT NVL(DEPT_TITLE, '부서없음') 부서명, TO_CHAR(CEIL(AVG(NVL(SALARY,0))),'999,999,999') "평균 급여"
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
ORDER BY DEPT_TITLE NULLS LAST;

-- 6. 각 부서별 총 급여의 합이 1000만원 이상인 부서명, 급여의 합 조회
SELECT DEPT_TITLE 부서명 , SUM(SALARY) "급여의 합"
FROM DEPARTMENT
JOIN EMPLOYEE ON (DEPT_ID = DEPT_CODE)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;

-- 7. 사번, 직원명, 직급명, 급여등급, 구분 조회
SELECT EMP_ID 사번, EMP_NAME 직원명, JOB_NAME 직급명, SAL_LEVEL 급여등급,
    CASE
    WHEN SAL_LEVEL IN ('S1', 'S2') THEN '고급'
    WHEN SAL_LEVEL IN ('S3', 'S4') THEN '중급'
    WHEN SAL_LEVEL IN ('S5', 'S6') THEN '초급'
    END "구분"
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

-- 8. 보너스를 받지 않는 직원들 중 직급코드가 J4 또는 J7인 직원들의 직원명, 직급명, 급여 조회
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE BONUS IS NULL AND JOB_CODE IN ('J4', 'J7');
