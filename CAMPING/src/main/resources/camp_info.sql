DROP TABLE CAMP_INFO;

CREATE TABLE CAMP_INFO (
	idx	int	PRIMARY KEY auto_increment,
	firstImageUrl	text	,
	zipcode	char(6)	,
	address1	text	,
	address2	text	,
	facltNm	text	,
	lineIntro	text	,
	intro	text	,
	featureNm	text	,
	lctCl	text	,
	doNm	text	,
	sigunguNm	text	,
	allar	int	,
	gnrlSiteCo	int	,
	autoSiteCo	int	,
	glampSiteCo	int	,
	caravSiteCo	int	,
	indvdlCaravSiteCo	int	,
	glampInnerFclty	int	,
	caravInnerFclty	int	,
	trlerAcmpnyAt	char(1)	,
	caravAcmpnyAt	char(1)	,
	eqpmnLendCl	text	,
	sbrsCl	text	,
	sbrsEtc	text	,
	posblFcltyCl	text	,
	posblFcltyEtc	text	,
	themaEnvrnCl	text	,
	animalCmgCl	char(1)	,
	toiletCo	int	,
	swrmCo	int	,
	wtrplCo	int	,
	brazierCl	int	,
	siteBottomCl1	int	,
	siteBottomCl2	int	,
	siteBottomCl3	int	,
	siteBottomCl4	int	,
	siteBottomCl5	int	,
	homepage	text	,
	resveUrl	text	,
	tel	varchar(15)	,
	induty	text	,
	mapX	double	,
	mapY	double	
);

select * from CAMP_INFO;

CREATE TABLE `CAMP_MEMBER` (
	`mb_nick`	varchar(30)	NOT NULL,
	`gr_grade`	int	NOT NULL,
	`mb_idx`	int PRIMARY KEY auto_increment,
	`mb_name`	varchar(15)	NOT NULL,
	`mb_ID`	varchar(12)	NOT NULL,
	`mb_password`	varchar(41)	NOT NULL,
	`mb_email`	varchar(30)	NOT NULL,
	`mb_grade`	int	NOT NULL,
	`mb_tel`	varchar(13)	NOT NULL,
	`mb_birth`	timeStamp	NOT NULL,
	`mb_address1`	varchar(200)	NOT NULL,
	`mb_address2`	varchar(300)	NOT NULL,
	`mb_use`	int	NOT NULL
);
select * from CAMP_MEMBER;
desc CAMP_MEMBER;
drop table camp_member;
alter table CAMP_MEMBER drop primary key;

CREATE TABLE `CAMP_NOTICE` (
	`mb_nick`	varchar(30)	NOT NULL,
	`nt_idx`	int PRIMARY KEY auto_increment,
	`nt_grade`	int	NOT NULL,
	`nt_title`	varchar(100)	NOT NULL,
	`nt_content`	text	NOT NULL,
	`nt_regDate`	timeStamp	NOT NULL,
	`nt_modiDate`	timeStamp	NOT NULL,
	`nt_hit`	int	NOT NULL
);
select * from CAMP_NOTICE;
alter table CAMP_NOTICE drop primary key;

CREATE TABLE `CAMP_REVIEW` (
	`rv_idx`	int PRIMARY KEY auto_increment,
	`mb_nick`	varchar(30)	NOT NULL,
	`rv_title`	varchar(100)	NOT NULL,
	`rv_content`	text	NOT NULL,
	`rv_regDate`	timeStamp	NOT NULL,
	`rv_modiDate`	timeStamp	NOT NULL,
	`rv_hit`	int	NOT NULL
);
select * from CAMP_REVIEW;

CREATE TABLE `CAMP_QUESTION` (
	`q_idx`	int PRIMARY KEY auto_increment,
	`q_title`	varchar(100)	NOT NULL,
	`q_content`	text	NOT NULL,
	`mb_nick`	varchar(30)	NOT NULL,
	`q_regDate`	timeStamp	NOT NULL,
	`q_modiDate`	timeStamp	NOT NULL,
	`q_hit`	int	NOT NULL
);
select * from CAMP_QUESTION;

CREATE TABLE `CAMP_ANSWER` (
	`mb_nick`	varchar(30)	NOT NULL,
	`q_idx`	int not null,
	`q_title`	varchar(100)	NOT NULL,
	`q_content`	text	NOT NULL,
	`a_idx`	int PRIMARY KEY auto_increment,
	`a_title`	varchar(100)	NOT NULL,
	`a_content`	text	NOT NULL,
	`a_grade`	int	NOT NULL,
	`a_regDate`	timeStamp	NOT NULL,
	`a_modiDate`	timeStamp	NOT NULL
);
select * from CAMP_ANSWER;

CREATE TABLE `CAMP_COMMENT` (
	`rv_idx`	int PRIMARY KEY auto_increment,
	`mb_nick`	varchar(30)	NOT NULL,
	`cm_content`	text	NOT NULL,
	`cm_regDate`	timeStamp	NOT NULL,
	`cm_modiDate`	timeStamp	NOT NULL
);
select * from CAMP_COMMENT;

CREATE TABLE `CAMP_GRADE` (
	`gr_grade`	int	NOT NULL,
	`gr_name`	varchar(15)	NOT NULL,
	`gr_role`	varchar(15)	NOT NULL
);
select * from CAMP_GRADE;

-- -----------------------------------------------------------------------
-- 참조키 설정
ALTER TABLE `CAMP_MEMBER` ADD CONSTRAINT `PK_CAMP_MEMBER` PRIMARY KEY (
	`mb_nick`,
	`gr_grade`
);

ALTER TABLE `CAMP_NOTICE` ADD CONSTRAINT `PK_CAMP_NOTICE` PRIMARY KEY (
	`mb_nick`
);

ALTER TABLE `CAMP_REVIEW` ADD CONSTRAINT `PK_CAMP_REVIEW` PRIMARY KEY (
	`rv_idx`,
	`mb_nick`
);

ALTER TABLE `CAMP_QUESTION` ADD CONSTRAINT `PK_CAMP_QUESTION` PRIMARY KEY (
	`q_idx`,
	`q_title`,
	`q_content`,
	`mb_nick`
);

ALTER TABLE `CAMP_ANSWER` ADD CONSTRAINT `PK_CAMP_ANSWER` PRIMARY KEY (
	`mb_nick`,
	`q_idx`,
	`q_title`,
	`q_content`
);

ALTER TABLE `CAMP_COMMENT` ADD CONSTRAINT `PK_CAMP_COMMENT` PRIMARY KEY (
	`rv_idx`,
	`mb_nick`
);

ALTER TABLE `CAMP_GRADE` ADD CONSTRAINT `PK_CAMP_GRADE` PRIMARY KEY (
	`gr_grade`
);

ALTER TABLE `CAMP_MEMBER` ADD CONSTRAINT `FK_CAMP_GRADE_TO_CAMP_MEMBER_1` FOREIGN KEY (
	`gr_grade`
)
REFERENCES `CAMP_GRADE` (
	`gr_grade`
);

ALTER TABLE `CAMP_NOTICE` ADD CONSTRAINT `FK_CAMP_MEMBER_TO_CAMP_NOTICE_1` FOREIGN KEY (
	`mb_nick`
)
REFERENCES `CAMP_MEMBER` (
	`mb_nick`
);

ALTER TABLE `CAMP_REVIEW` ADD CONSTRAINT `FK_CAMP_MEMBER_TO_CAMP_REVIEW_1` FOREIGN KEY (
	`mb_nick`
)
REFERENCES `CAMP_MEMBER` (
	`mb_nick`
);

ALTER TABLE `CAMP_QUESTION` ADD CONSTRAINT `FK_CAMP_MEMBER_TO_CAMP_QUESTION_1` FOREIGN KEY (
	`mb_nick`
)
REFERENCES `CAMP_MEMBER` (
	`mb_nick`
);

ALTER TABLE `CAMP_ANSWER` ADD CONSTRAINT `FK_CAMP_MEMBER_TO_CAMP_ANSWER_1` FOREIGN KEY (
	`mb_nick`
)
REFERENCES `CAMP_MEMBER` (
	`mb_nick`
);

ALTER TABLE `CAMP_ANSWER` ADD CONSTRAINT `FK_CAMP_QUESTION_TO_CAMP_ANSWER_1` FOREIGN KEY (
	`q_idx`
)
REFERENCES `CAMP_QUESTION` (
	`q_idx`
);

ALTER TABLE `CAMP_ANSWER` ADD CONSTRAINT `FK_CAMP_QUESTION_TO_CAMP_ANSWER_2` FOREIGN KEY (
	`q_title`
)
REFERENCES `CAMP_QUESTION` (
	`q_title`
);

ALTER TABLE `CAMP_ANSWER` ADD CONSTRAINT `FK_CAMP_QUESTION_TO_CAMP_ANSWER_3` FOREIGN KEY (
	`q_content`
)
REFERENCES `CAMP_QUESTION` (
	`q_content`
);

ALTER TABLE `CAMP_COMMENT` ADD CONSTRAINT `FK_CAMP_REVIEW_TO_CAMP_COMMENT_1` FOREIGN KEY (
	`rv_idx`
)
REFERENCES `CAMP_REVIEW` (
	`rv_idx`
);

ALTER TABLE `CAMP_COMMENT` ADD CONSTRAINT `FK_CAMP_MEMBER_TO_CAMP_COMMENT_1` FOREIGN KEY (
	`mb_nick`
)
REFERENCES `CAMP_MEMBER` (
	`mb_nick`
);

