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

