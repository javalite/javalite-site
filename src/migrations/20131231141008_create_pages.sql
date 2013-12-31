CREATE TABLE pages (
  id         INT(11)      NOT NULL AUTO_INCREMENT,
  title      VARCHAR(128) NOT NULL,
  content    TEXT         NOT NULL,
  created_at DATETIME DEFAULT NULL,
  updated_at DATETIME DEFAULT NULL,
  seo_id     VARCHAR(128) NOT NULL,
  PRIMARY KEY (id)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;