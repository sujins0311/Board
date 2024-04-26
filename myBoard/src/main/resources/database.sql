create database myBoard;
CREATE USER 'user'@'%' IDENTIFIED BY 'mypw1234';
GRANT ALL PRIVILEGES ON myBoard.* TO 'user'@'localhost' IDENTIFIED BY 'mypw1234';
FLUSH PRIVILEGES;

CREATE TABLE tbl_board (
    bno BIGINT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    content TEXT,
    writer VARCHAR(50),
    createdDate DATETIME NOT NULL, -- LocalDateTime
    updatedDate DATETIME -- LocalDateTime
) DEFAULT CHARSET = utf8;



CREATE TABLE tbl_reply (
    rno BIGINT PRIMARY KEY AUTO_INCREMENT,
    bno BIGINT not null, 
    reply VARCHAR(255) NOT NULL,
    replyer VARCHAR(255) NOT NULL,
    replyDate DATETIME NOT NULL,
    updateDate DATETIME,
  CONSTRAINT chk_updatedDate CHECK (updateDate >= replyDate),
  CONSTRAINT fk_reply_board FOREIGN KEY (bno) REFERENCES tbl_board (bno)
) default CHARSET = utf8;



CREATE TABLE member (
    userid VARCHAR(64) NOT NULL PRIMARY KEY,
    userpw VARCHAR(100) NOT null,
    username VARCHAR(64) NOT null,
    email VARCHAR(100) NOT NULL unique,
    regDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updateDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status CHAR(1) DEFAULT '1' 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



CREATE TABLE member_auth (
    userid VARCHAR(64) NOT NULL,
    auth VARCHAR(20) NOT NULL,
  CONSTRAINT fk_auth_member FOREIGN KEY (userid) REFERENCES member(userid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE persistent_logins (
    username VARCHAR(64) NOT NULL,
    series VARCHAR(64) PRIMARY KEY,
    token VARCHAR(64) NOT NULL,
    last_used TIMESTAMP NOT NULL
);

