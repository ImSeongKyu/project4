DROP TABLE overcontents CASCADE CONSTRAINTS; -- 자식 무시하고 삭제 가능
DROP TABLE overcontents;

CREATE TABLE overcontents(
        overcontentsno                            NUMBER(10)         NOT NULL         PRIMARY KEY,
        msadminno                              NUMBER(10)     NOT NULL , -- FK
        catenum                               NUMBER(10)         NOT NULL , -- FK
        title                                 VARCHAR2(30)         NOT NULL,
        content                               CLOB                  NOT NULL,
        recom                                 NUMBER(7)         DEFAULT 0         NOT NULL,
        cnt                                   NUMBER(7)         DEFAULT 0         NOT NULL,
        replycnt                              NUMBER(7)         DEFAULT 0         NOT NULL,
        passwd                                VARCHAR2(15)         NOT NULL,
        word                                  VARCHAR2(100)         NULL ,
        rdate                                 DATE               NOT NULL,
        file1                                   VARCHAR(100)          NULL,  -- 원본 파일명 image
        file1saved                            VARCHAR(100)          NULL,  -- 저장된 파일명, image
        thumb1                              VARCHAR(100)          NULL,   -- preview image
        size1                                 NUMBER(10)      DEFAULT 0 NULL,  -- 파일 사이즈
        price                                 NUMBER(10)      DEFAULT 0 NULL,  
        dc                                    NUMBER(10)      DEFAULT 0 NULL,  
        saleprice                            NUMBER(10)      DEFAULT 0 NULL,  
        point                                 NUMBER(10)      DEFAULT 0 NULL,  
        salecnt                               NUMBER(10)      DEFAULT 0 NULL,
        map                                   VARCHAR2(1000)            NULL,
        youtube                               VARCHAR2(1000)            NULL,
        FOREIGN KEY (msadminno) REFERENCES msadmin (msadminno),
        FOREIGN KEY (catenum) REFERENCES procate (catenum)
);

COMMENT ON TABLE overcontents is '컨텐츠 - 오버로딩';
COMMENT ON COLUMN overcontents.overcontentsno is '컨텐츠 번호';
COMMENT ON COLUMN overcontents.msadminno is '관리자 번호';
COMMENT ON COLUMN overcontents.catenum is '카테고리 번호';
COMMENT ON COLUMN overcontents.title is '제목';
COMMENT ON COLUMN overcontents.content is '내용';
COMMENT ON COLUMN overcontents.recom is '추천수';
COMMENT ON COLUMN overcontents.cnt is '조회수';
COMMENT ON COLUMN overcontents.replycnt is '댓글수';
COMMENT ON COLUMN overcontents.passwd is '패스워드';
COMMENT ON COLUMN overcontents.word is '검색어';
COMMENT ON COLUMN overcontents.rdate is '등록일';
COMMENT ON COLUMN overcontents.file1 is '메인 이미지';
COMMENT ON COLUMN overcontents.file1saved is '실제 저장된 메인 이미지';
COMMENT ON COLUMN overcontents.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN overcontents.size1 is '메인 이미지 크기';
COMMENT ON COLUMN overcontents.price is '정가';
COMMENT ON COLUMN overcontents.dc is '할인률';
COMMENT ON COLUMN overcontents.saleprice is '판매가';
COMMENT ON COLUMN overcontents.point is '포인트';
COMMENT ON COLUMN overcontents.salecnt is '수량';
COMMENT ON COLUMN overcontents.map is '지도';
COMMENT ON COLUMN overcontents.youtube is 'Youtube 영상';

DROP SEQUENCE overcontents_seq;

CREATE SEQUENCE overcontents_seq
  START WITH 1                -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
  CACHE 2                        -- 2번은 메모리에서만 계산
  NOCYCLE;                      -- 다시 1부터 생성되는 것을 방지

ALTER TABLE overcontents modify(title varchar2(60));

SELECT * FROM overcontents WHERE catenum=1 AND (UPPER(word) LIKE '%' || UPPER('채소류') || '%') AND(UPPER(word) LIKE '%' || UPPER('디저트') || '%');
SELECT * FROM overcontents WHERE catenum=1;


-- 등록 화면 유형 1: 커뮤니티(공지사항, 게시판, 자료실, 갤러리,  Q/A...)글 등록
INSERT INTO overcontents(overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(overcontents_seq.nextval, 1, 1, '청계천 매화 거리', '제기동역에서 가까움 명품 산책로', 0, 0, 0, '123',
       '산책', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

-- 유형 1 전체 목록
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1
FROM overcontents
ORDER BY overcontentsno DESC;

-- 유형 2 카테고리별 목록
INSERT INTO overcontents(overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(overcontents_seq.nextval, 1, 2, '대행사', '흙수저와 금수저의 성공 스토리', 0, 0, 0, '123',
       '드라마,K드라마,넷플릭스', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);
            
INSERT INTO overcontents(overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(overcontents_seq.nextval, 1, 2, '더글로리', '학폭의 결말', 0, 0, 0, '123',
       '드라마,K드라마,넷플릭스', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

INSERT INTO overcontents(overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(overcontents_seq.nextval, 1, 2, '더글로리', '학폭의 결말', 0, 0, 0, '123',
       '드라마,K드라마,넷플릭스', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

COMMIT;

-- 1번 catenum 만 출력
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM overcontents
WHERE catenum=1
ORDER BY overcontentsno DESC;

-- 2번 catenum 만 출력
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM overcontents
WHERE catenum=2
ORDER BY overcontentsno ASC;

-- 3번 catenum 만 출력
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM overcontents
WHERE catenum=3
ORDER BY overcontentsno ASC;

-- 모든 레코드 삭제
DELETE FROM overcontents;
commit;

-- 삭제
DELETE FROM overcontents
WHERE overcontentsno = 25;
commit;

DELETE FROM overcontents
WHERE catenum=12 AND overcontentsno <= 41;

commit;


-- ----------------------------------------------------------------------------------------------------
-- 검색, catenum별 검색 목록
-- ----------------------------------------------------------------------------------------------------
-- 모든글
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, word, rdate,
       file1, file1saved, thumb1, size1, map, youtube
FROM overcontents
ORDER BY overcontentsno ASC;

-- 카테고리별 목록
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, word, rdate,
       file1, file1saved, thumb1, size1, map, youtube
FROM overcontents
WHERE catenum=2
ORDER BY overcontentsno ASC;

-- 1) 검색
-- ① catenum별 검색 목록
-- word 컬럼의 존재 이유: 검색 정확도를 높이기 위하여 중요 단어를 명시
-- 글에 'swiss'라는 단어만 등장하면 한글로 '스위스'는 검색 안됨.
-- 이런 문제를 방지하기위해 'swiss,스위스,스의스,수의스,유럽' 검색어가 들어간 word 컬럼을 추가함.
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM overcontents
WHERE catenum=8 AND word LIKE '%부대찌게%'
ORDER BY overcontentsno DESC;

-- title, content, word column search
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM overcontents
WHERE catenum=8 AND (title LIKE '%부대찌게%' OR content LIKE '%부대찌게%' OR word LIKE '%부대찌게%')
ORDER BY overcontentsno DESC;

-- ② 검색 레코드 갯수
-- 전체 레코드 갯수, 집계 함수
SELECT COUNT(*)
FROM overcontents
WHERE catenum=8;

  COUNT(*)  <- 컬럼명
----------
         5
         
SELECT COUNT(*) as cnt -- 함수 사용시는 컬럼 별명을 선언하는 것을 권장
FROM overcontents
WHERE catenum=8;

       CNT <- 컬럼명
----------
         5

-- catenum 별 검색된 레코드 갯수
SELECT COUNT(*) as cnt
FROM overcontents
WHERE catenum=8 AND word LIKE '%부대찌게%';

SELECT COUNT(*) as cnt
FROM overcontents
WHERE catenum=8 AND (title LIKE '%부대찌게%' OR content LIKE '%부대찌게%' OR word LIKE '%부대찌게%');

-- SUBSTR(컬럼명, 시작 index(1부터 시작), 길이), 부분 문자열 추출
SELECT overcontentsno, SUBSTR(title, 1, 4) as title
FROM overcontents
WHERE catenum=8 AND (content LIKE '%부대%');

-- SQL은 대소문자를 구분하지 않으나 WHERE문에 명시하는 값은 대소문자를 구분하여 검색
SELECT overcontentsno, title, word
FROM overcontents
WHERE catenum=8 AND (word LIKE '%FOOD%');

SELECT overcontentsno, title, word
FROM overcontents
WHERE catenum=8 AND (word LIKE '%food%'); 

SELECT overcontentsno, title, word
FROM overcontents
WHERE catenum=8 AND (LOWER(word) LIKE '%food%'); -- 대소문자를 일치 시켜서 검색

SELECT overcontentsno, title, word
FROM overcontents
WHERE catenum=8 AND (UPPER(word) LIKE '%' || UPPER('FOOD') || '%'); -- 대소문자를 일치 시켜서 검색 ★

SELECT overcontentsno, title, word
FROM overcontents
WHERE catenum=8 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- 대소문자를 일치 시켜서 검색

SELECT overcontentsno || '. ' || title || ' 태그: ' || word as title -- 컬럼의 결합, ||
FROM overcontents
WHERE catenum=8 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- 대소문자를 일치 시켜서 검색


SELECT UPPER('한글') FROM dual; -- dual: 오라클에서 SQL 형식을 맞추기위한 시스템 테이블

-- ----------------------------------------------------------------------------------------------------
-- 검색 + 페이징 + 메인 이미지
-- ----------------------------------------------------------------------------------------------------
-- step 1
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM overcontents
WHERE catenum=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
ORDER BY overcontentsno DESC;

-- step 2
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, rownum as r
FROM (
          SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                     file1, file1saved, thumb1, size1, map, youtube
          FROM overcontents
          WHERE catenum=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
          ORDER BY overcontentsno DESC
);

-- step 3, 1 page
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM overcontents
                     WHERE catenum=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
                     ORDER BY overcontentsno DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- step 3, 2 page
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM overcontents
                     WHERE catenum=1 AND (title LIKE '%단풍%' OR content LIKE '%단풍%' OR word LIKE '%단풍%')
                     ORDER BY overcontentsno DESC
           )          
)
WHERE r >= 4 AND r <= 6;

-- 대소문자를 처리하는 페이징 쿼리
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM overcontents
                     WHERE catenum=1 AND (UPPER(title) LIKE '%' || UPPER('단풍') || '%' 
                                         OR UPPER(content) LIKE '%' || UPPER('단풍') || '%' 
                                         OR UPPER(word) LIKE '%' || UPPER('단풍') || '%')
                     ORDER BY overcontentsno DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- ----------------------------------------------------------------------------
-- 조회
-- ----------------------------------------------------------------------------
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM overcontents
WHERE overcontentsno = 1;

-- ----------------------------------------------------------------------------
-- 다음 지도, MAP, 먼저 레코드가 등록되어 있어야함.
-- map                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- MAP 등록/수정
UPDATE overcontents SET map='카페산 지도 스크립트' WHERE overcontentsno=1;

-- MAP 삭제
UPDATE overcontents SET map='' WHERE overcontentsno=1;

commit;

-- ----------------------------------------------------------------------------
-- Youtube, 먼저 레코드가 등록되어 있어야함.
-- youtube                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- youtube 등록/수정
UPDATE overcontents SET youtube='Youtube 스크립트' WHERE overcontentsno=1;

-- youtube 삭제
UPDATE overcontents SET youtube='' WHERE overcontentsno=1;

commit;

-- 패스워드 검사, id="password_check"
SELECT COUNT(*) as cnt 
FROM overcontents
WHERE overcontentsno=1 AND passwd='123';

-- 텍스트 수정: 예외 컬럼: 추천수, 조회수, 댓글 수
UPDATE overcontents
SET title='기차를 타고', content='계획없이 여행 출발',  word='나,기차,생각' 
WHERE overcontentsno = 2;

-- ERROR, " 사용 에러
UPDATE overcontents
SET title='기차를 타고', content="계획없이 '여행' 출발",  word='나,기차,생각'
WHERE overcontentsno = 1;

-- ERROR, \' 에러
UPDATE overcontents
SET title='기차를 타고', content='계획없이 \'여행\' 출발',  word='나,기차,생각'
WHERE overcontentsno = 1;

-- SUCCESS, '' 한번 ' 출력됨.
UPDATE overcontents
SET title='기차를 타고', content='계획없이 ''여행'' 출발',  word='나,기차,생각'
WHERE overcontentsno = 1;

-- SUCCESS
UPDATE overcontents
SET title='기차를 타고', content='계획없이 "여행" 출발',  word='나,기차,생각'
WHERE overcontentsno = 1;

commit;

-- 파일 수정
UPDATE overcontents
SET file1='train.jpg', file1saved='train.jpg', thumb1='train_t.jpg', size1=5000
WHERE overcontentsno = 1;

-- 삭제
DELETE FROM overcontents
WHERE overcontentsno = 42;

commit;

DELETE FROM overcontents
WHERE overcontentsno >= 7;

commit;

-- 추천
UPDATE overcontents
SET recom = recom + 1
WHERE overcontentsno = 1;

-- catenum FK 특정 그룹에 속한 레코드 갯수 산출
SELECT COUNT(*) as cnt 
FROM overcontents 
WHERE catenum=1;

-- msadminno FK 특정 관리자에 속한 레코드 갯수 산출
SELECT COUNT(*) as cnt 
FROM overcontents 
WHERE msadminno=1;

-- catenum FK 특정 그룹에 속한 레코드 모두 삭제
DELETE FROM overcontents
WHERE catenum=1;

-- msadminno FK 특정 관리자에 속한 레코드 모두 삭제
DELETE FROM overcontents
WHERE msadminno=1;

commit;

-- 다수의 카테고리에 속한 레코드 갯수 산출: IN
SELECT COUNT(*) as cnt
FROM overcontents
WHERE catenum IN(1,2,3);

-- 다수의 카테고리에 속한 레코드 모두 삭제: IN
SELECT overcontentsno, msadminno, catenum, title
FROM overcontents
WHERE catenum IN(1,2,3);

overcontentsNO    msadminNO     catenum TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           인터스텔라                                                                                                                                                                                                                                                                                                  
         4             1                   2           드라마                                                                                                                                                                                                                                                                                                      
         5             1                   3           컨저링                                                                                                                                                                                                                                                                                                      
         6             1                   1           마션       
         
SELECT overcontentsno, msadminno, catenum, title
FROM overcontents
WHERE catenum IN('1','2','3');

overcontentsNO    msadminNO     catenum TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           인터스텔라                                                                                                                                                                                                                                                                                                  
         4             1                   2           드라마                                                                                                                                                                                                                                                                                                      
         5             1                   3           컨저링                                                                                                                                                                                                                                                                                                      
         6             1                   1           마션       

-- ----------------------------------------------------------------------------------------------------
-- procate + overcontents INNER JOIN
-- ----------------------------------------------------------------------------------------------------
-- 모든글
SELECT c.name,
       t.overcontentsno, t.msadminno, t.catenum, t.title, t.content, t.recom, t.cnt, t.replycnt, t.word, t.rdate,
       t.file1, t.file1saved, t.thumb1, t.size1, t.map, t.youtube
FROM procate c, overcontents t
WHERE c.catenum = t.catenum
ORDER BY t.overcontentsno DESC;

-- overcontents, msadmin INNER JOIN
SELECT t.overcontentsno, t.msadminno, t.catenum, t.title, t.content, t.recom, t.cnt, t.replycnt, t.word, t.rdate,
       t.file1, t.file1saved, t.thumb1, t.size1, t.map, t.youtube,
       a.mname
FROM msadmin a, overcontents t
WHERE a.msadminno = t.msadminno
ORDER BY t.overcontentsno DESC;

SELECT t.overcontentsno, t.msadminno, t.catenum, t.title, t.content, t.recom, t.cnt, t.replycnt, t.word, t.rdate,
       t.file1, t.file1saved, t.thumb1, t.size1, t.map, t.youtube,
       a.mname
FROM msadmin a INNER JOIN overcontents t ON a.msadminno = t.msadminno
ORDER BY t.overcontentsno DESC;

-- ----------------------------------------------------------------------------------------------------
-- View + paging
-- ----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW vovercontents
AS
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, word, rdate,
        file1, file1saved, thumb1, size1, map, youtube
FROM overcontents
ORDER BY overcontentsno DESC;
                     
-- 1 page
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
       file1, file1saved, thumb1, size1, map, youtube, r
FROM (
     SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
            file1, file1saved, thumb1, size1, map, youtube, rownum as r
     FROM vovercontents -- View
     WHERE catenum=14 AND (title LIKE '%야경%' OR content LIKE '%야경%' OR word LIKE '%야경%')
)
WHERE r >= 1 AND r <= 3;

-- 2 page
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
       file1, file1saved, thumb1, size1, map, youtube, r
FROM (
     SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
            file1, file1saved, thumb1, size1, map, youtube, rownum as r
     FROM vovercontents -- View
     WHERE catenum=14 AND (title LIKE '%야경%' OR content LIKE '%야경%' OR word LIKE '%야경%')
)
WHERE r >= 4 AND r <= 6;


-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 좋아요(recom) 기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT overcontentsno, msadminno, catenum, title, thumb1, r
FROM (
           SELECT overcontentsno, msadminno, catenum, title, thumb1, rownum as r
           FROM (
                     SELECT overcontentsno, msadminno, catenum, title, thumb1
                     FROM overcontents
                     WHERE catenum=1
                     ORDER BY recom DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 평점(score) 기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM overcontents
                     WHERE catenum=1
                     ORDER BY score DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 최신 상품 기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM overcontents
                     WHERE catenum=1
                     ORDER BY rdate DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 조회수 높은 상품기준, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM overcontents
                     WHERE catenum=1
                     ORDER BY cnt DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 낮은 가격 상품 추천, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM overcontents
                     WHERE catenum=1
                     ORDER BY price ASC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- 관심 카테고리의 높은 가격 상품 추천, 1번 회원이 1번 카테고리를 추천 받는 경우, 추천 상품이 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT overcontentsno, msadminno, catenum, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM overcontents
                     WHERE catenum=1
                     ORDER BY price DESC
           )          
)
WHERE r >= 1 AND r <= 7;