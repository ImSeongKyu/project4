
/**********************************/
/* Table Name: 관리자 */
/**********************************/
DROP TABLE msadmin;

CREATE TABLE msadmin(
		msadminno                     		NUMBER(5)		 NOT NULL,
		id                            		VARCHAR2(20)		 NOT NULL	UNIQUE,
		passwd                        		VARCHAR2(15)		 NOT NULL,
		mname                         		VARCHAR2(20)		 NOT NULL,
		mdate                         		DATE		 NOT NULL,
		grade                         		NUMBER(2)		 NOT NULL,
		PRIMARY KEY (msadminno)              
);

COMMENT ON TABLE msadmin is '관리자';
COMMENT ON COLUMN msadmin.msadminno is '관리자 번호';
COMMENT ON COLUMN msadmin.id is '아이디';
COMMENT ON COLUMN msadmin.passwd is '패스워드';
COMMENT ON COLUMN msadmin.mname is '성명';
COMMENT ON COLUMN msadmin.mdate is '가입일';
COMMENT ON COLUMN msadmin.grade is '등급';

DROP SEQUENCE msadmin_seq;

CREATE SEQUENCE msadmin_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1            -- 증가값
  MAXVALUE 99999            -- 최대값: 99999 --> NUMBER(5) 대응
  CACHE 2                   -- 2번은 메모리에서만 계산
  NOCYCLE;                  -- 다시 1부터 생성되는 것을 방지

-- CREATE
INSERT INTO msadmin(msadminno, id, passwd, mname, mdate, grade)
VALUES(msadmin_seq.nextval, 'admin1', '69017000', '관리자1', sysdate, 1);

INSERT INTO msadmin(msadminno, id, passwd, mname, mdate, grade)
VALUES(msadmin_seq.nextval, 'admin2', '1234', '관리자2', sysdate, 1);

INSERT INTO msadmin(msadminno, id, passwd, mname, mdate, grade)
VALUES(msadmin_seq.nextval, 'admin3', '1234', '관리자3', sysdate, 1);

commit;

-- READ: List
SELECT msadminno, id, passwd, mname, mdate, grade FROM msadmin ORDER BY msadminno ASC;

-- READ         
SELECT msadminno, id, passwd, mname, mdate, grade 
FROM msadmin
WHERE msadminno=1;


-- READ by id
SELECT msadminno, id, passwd, mname, mdate, grade 
FROM msadmin
WHERE id='admin1';

-- UPDATE
UPDATE admin
SET passwd='1234', mname='관리자1', mdate=sysdate, grade=1
WHERE msadminno=1;

COMMIT;

-- DELETE
DELETE FROM msadmin WHERE msadminno=3;
         
-- 로그인, 1: 로그인 성공, 0: 로그인 실패
SELECT COUNT(*) as cnt
FROM msadmin
WHERE id='admin1' AND passwd='1234'; 

         