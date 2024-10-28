CREATE TABLE `students` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `adm_year` YEAR NOT NULL,
    `major_code` VARCHAR(10) NOT NULL,
    `idx_code` INT NOT NULL,
    `phone_number` VARCHAR(15) NOT NULL,
    `address` VARCHAR(100),
    `tot_credits` INT DEFAULT 0,
    `gpa` FLOAT DEFAULT 0.0,
    `is_enrolled` TINYINT(1) DEFAULT 1,
    PRIMARY KEY (`id`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8;