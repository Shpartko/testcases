
# This is a fix for InnoDB in MySQL >= 4.1.x
# It "suspends judgement" for fkey relationships until are tables are set.
SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------------------
-- post
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `post`;

CREATE TABLE `post`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `text` VARCHAR(1024) NOT NULL,
    `username` VARCHAR(128) NOT NULL,
    `topic_id` INTEGER NOT NULL,
    `created_at` DATETIME,
    `updated_at` DATETIME,
    PRIMARY KEY (`id`),
    INDEX `post_fi_5f1143` (`topic_id`),
    CONSTRAINT `post_fk_5f1143`
        FOREIGN KEY (`topic_id`)
        REFERENCES `topic` (`id`)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- topic
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `topic`;

CREATE TABLE `topic`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(256) NOT NULL,
    `body` VARCHAR(1024) NOT NULL,
    `username` VARCHAR(128) NOT NULL,
    `views` INTEGER NOT NULL,
    `created_at` DATETIME,
    `updated_at` DATETIME,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB;

# This restores the fkey checks, after having unset them earlier
SET FOREIGN_KEY_CHECKS = 1;
