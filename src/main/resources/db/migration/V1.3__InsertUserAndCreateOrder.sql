-- -----------------------------------------------------
-- Schema flyway
-- -----------------------------------------------------
INSERT INTO users value (1,"user1","123","man","test");


-- -----------------------------------------------------
-- Table `order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `order` (
  `id`          BIGINT(19) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id`     BIGINT UNSIGNED     NOT NULL
  COMMENT '下单用户ID',
  `product_id`  BIGINT UNSIGNED     NOT NULL
  COMMENT '产品ID',
  `price`       INT UNSIGNED        NOT NULL
  COMMENT '实际支付金额',
  `status`      TINYINT UNSIGNED    NOT NULL DEFAULT 0
  COMMENT '订单状态, 0为支付中, 1为交易完成, 2为全部资源已被撤销, 3为资源确认冲突',
  PRIMARY KEY (`id`)
);