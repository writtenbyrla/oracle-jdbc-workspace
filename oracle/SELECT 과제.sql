-- 1.영문학과 학생들의 학번, 이름, 입학년도(입학년도 오름차순)
SELECT STUDENT_NO "학번", STUDENT_NAME "이름", TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') "입학년도"
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE S.DEPARTMENT_NO = '002'
ORDER BY "입학년도";

-- 2. 이름이 세 글자가 아닌 교수 
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) <> 3;

-- 3. 남자 교수 이름, 나이 출력(나이 오름차순)
SELECT 
    PROFESSOR_NAME "교수이름",
    CASE
        WHEN  (TO_CHAR(SYSDATE, 'MMDD')) >= SUBSTR(PROFESSOR_SSN, 3, 4)
        THEN (TO_CHAR(SYSDATE, 'YY')+2000) - (SUBSTR(PROFESSOR_SSN, 1, 2)+1900)-1
    
        WHEN (TO_CHAR(SYSDATE, 'MMDD')) < SUBSTR(PROFESSOR_SSN, 3, 4)
        THEN (TO_CHAR(SYSDATE, 'YY')+2000) - (SUBSTR(PROFESSOR_SSN, 1, 2)+1900)
        END 나이
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = 1
ORDER BY 2;

-- 4. 교수 성 제외 이름 출력
SELECT SUBSTR(PROFESSOR_NAME, 2) "이름"
FROM TB_PROFESSOR;

-- 5. 재수생 입학자(19살 입학 제외)
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
MINUS
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE 
    (SUBSTR (STUDENT_NO,1,1)='A'
    AND ((TO_CHAR(ENTRANCE_DATE, 'YY')+2000) - (SUBSTR(STUDENT_SSN, 1, 2)+1900)) = 19)
    OR
    (SUBSTR(STUDENT_NO,1,1)='9'
    AND ((TO_CHAR(ENTRANCE_DATE, 'YY')) - (SUBSTR(STUDENT_SSN, 1, 2))) = 19);

-- 6. 2020년 크리스마스는 무슨 요일?
SELECT TO_CHAR(TO_DATE(20201225, 'YYYYMMDD'), 'DAY') 요일 FROM DUAL;

-- 7. 
SELECT
    TO_DATE('99/10/11', 'YY/MM/DD'),
    TO_DATE('49/10/11', 'YY/MM/DD'),
    TO_DATE('99/10/11', 'RR/MM/DD'),
    TO_DATE('49/10/11', 'RR/MM/DD')
FROM DUAL;

-- 8. 2000년도 이전 학번 받은 학생의 학번과 이름
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO, 1, 1) <> 'A';

-- 9. 학번이 A517178인 한아름 학생의 평점(소수점 이하 한 자리까지 반올림)
SELECT ROUND(AVG(NVL(POINT,0)), 1) 평점
FROM TB_GRADE
JOIN TB_STUDENT USING(STUDENT_NO)
WHERE STUDENT_NO = 'A517178';

-- 10. 학과별 학생수
SELECT DEPARTMENT_NO 학과번호, COUNT(*) 학생수
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;
 
-- 11. 지도 교수 배정받지 못한 학생의 수
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12. 학번이 A112113인 학생의 년도 별 평점(반올림 소수점 이하)
SELECT SUBSTR(TERM_NO, 1, 4) 년도, ROUND(AVG(NVL(POINT,0)), 1) "년도 별 평점"
FROM TB_GRADE
JOIN TB_STUDENT USING(STUDENT_NO)
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4)
ORDER BY 1;

-- 13. 학과 별 휴학생 수
SELECT DEPARTMENT_NO "학과코드명", COUNT(*)
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
GROUP BY DEPARTMENT_NO
ORDER BY 1;

--14. 동명이인 학생
SELECT STUDENT_NAME 동일이름, COUNT(*) "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) <> 1
ORDER BY 1;

--15. 학번이 A112113 학생의 년도, 학기별 평점과 년도 별 누적 평점, 총 평점
SELECT SUBSTR(TERM_NO, 1, 4) 년도, NVL(SUBSTR(TERM_NO, 5, 2),' ') 학기, ROUND(AVG(NVL(POINT,0)), 1) 평균
FROM TB_GRADE
JOIN TB_STUDENT USING(STUDENT_NO)
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2))
ORDER BY 1, SUBSTR(TERM_NO, 5, 2) NULLS LAST;
