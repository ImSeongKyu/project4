/**********************************/
/* Table Name: 회원 */
/**********************************/
DROP TABLE THEMEMBER;
CREATE TABLE THEMEMBER(
		THEMEMBERNO                   		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		ID                        		    VARCHAR2(30)		 NOT NULL,
		PASSWD                        		VARCHAR2(60)		 NOT NULL,
		MNAME                         		VARCHAR2(30)		 NOT NULL,
		TEL                           		VARCHAR2(14)		 NOT NULL,
		ZIPCODE                       		VARCHAR2(10)		 NULL ,
		ADDRESS1                      		VARCHAR2(80)		 NULL ,
		ADDRESS2                      		VARCHAR2(50)		 NULL ,
		MDATE                         		DATE		 NOT NULL,
		GRADE                         		NUMBER(2)		 NOT NULL
);

COMMENT ON TABLE THEMEMBER is '회원';
COMMENT ON COLUMN THEMEMBER.THEMEMBERNO is '회원 번호';
COMMENT ON COLUMN THEMEMBER.ID is '아이디';
COMMENT ON COLUMN THEMEMBER.PASSWD is '패스워드';
COMMENT ON COLUMN THEMEMBER.MNAME is '성명';
COMMENT ON COLUMN THEMEMBER.TEL is '전화번호';
COMMENT ON COLUMN THEMEMBER.ZIPCODE is '우편번호';
COMMENT ON COLUMN THEMEMBER.ADDRESS1 is '주소1';
COMMENT ON COLUMN THEMEMBER.ADDRESS2 is '주소2';
COMMENT ON COLUMN THEMEMBER.MDATE is '가입일';
COMMENT ON COLUMN THEMEMBER.GRADE is '등급';

DROP SEQUENCE themember_seq;
CREATE SEQUENCE themember_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
 
COMMIT;
INSERT INTO themember(thememberno, id, passwd, mname, tel, zipcode,
                                 address1, address2, mdate, grade)
VALUES (themember_seq.nextval, 'qnaadmin', '1234', '질문답변관리자', '000-0000-0000', '12345',
             '서울시 종로구', '관철동', sysdate, 1);
 
INSERT INTO themember(thememberno, id, passwd, mname, tel, zipcode,
                                address1, address2, mdate, grade)
VALUES (themember_seq.nextval, 'crm', '1234', '고객관리자', '000-0000-0000', '12345',
             '서울시 종로구', '관철동', sysdate, 1);

