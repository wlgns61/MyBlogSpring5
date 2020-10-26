CREATE TABLE `tbl_user` (
  `uid` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `pwd` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `enabled` tinyint NOT NULL DEFAULT '1',
  `reg_dt` date DEFAULT NULL,
  `authority` varchar(20) DEFAULT 'ROLE_USER',
  PRIMARY KEY (`uid`)
);

CREATE TABLE `tbl_menu` (
  `mid` int NOT NULL AUTO_INCREMENT,  
  `code` varchar(10) NOT NULL,
  `codename` varchar(50) DEFAULT NULL,  
  `sort_num` int DEFAULT NULL,
  `comment` varchar(1000) DEFAULT NULL,
  `reg_id` varchar(20) DEFAULT NULL,
  `reg_dt` date DEFAULT NULL,
  PRIMARY KEY (`mid`),
  UNIQUE KEY `tbl_menu_code_uindex` (`code`),
  UNIQUE KEY `codename_UNIQUE` (`codename`)
);

CREATE TABLE `tbl_board`( 
	`bid` int NOT NULL AUTO_INCREMENT COMMENT '일련번호',
    `cate_cd` varchar(20) DEFAULT NULL COMMENT '게시글 카테고리',
    `title` varchar(200) NOT NULL COMMENT '제목',
    `content` text NOT NULL COMMENT '게시글',
    `tag` varchar(1000) DEFAULT NULL COMMENT '태그',
    `view_cnt` int NOT NULL DEFAULT '0' COMMENT '카운트',
    `reg_id` varchar(45) NOT NULL COMMENT '작성자',
    `reg_dt` date NOT NULL COMMENT '작성일',
    `edit_dt` date NOT NULL COMMENT '수정일',
    PRIMARY KEY (`bid`),  KEY `cate_cd` (`cate_cd`),
    CONSTRAINT FOREIGN KEY (`cate_cd`) REFERENCES `tbl_menu` (`codename`) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FOREIGN KEY (`reg_id`) REFERENCES `tbl_user` (`uid`) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `tbl_reply` (
  `rid` int NOT NULL AUTO_INCREMENT COMMENT '일련번호',
  `bid` int NOT NULL COMMENT '게시물 일련번호',
  `content` text COMMENT '댓글내용',
  `reg_id` varchar(45) NOT NULL COMMENT '작성자',
  `reg_dt` timestamp NOT NULL COMMENT '작성일',
  `edit_dt` timestamp NOT NULL COMMENT '수정일',
  PRIMARY KEY (`rid`), KEY `bid` (`bid`),
  CONSTRAINT FOREIGN KEY (`bid`) REFERENCES `tbl_board` (`bid`) ON DELETE CASCADE ON UPDATE CASCADE
);
