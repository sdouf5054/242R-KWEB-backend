CREATE TABLE `users` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `user_id` VARCHAR(50) NOT NULL UNIQUE,
    `password` VARCHAR(100) NOT NULL,
    `nickname` VARCHAR(50) NOT NULL,
    `profile_img` VARCHAR(255),
    `profile_msg` VARCHAR(255),
    `is_deleted` TINYINT(1) DEFAULT 0,
    `signup_date` DATETIME NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `channels` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `created_by` INT NOT NULL,
    `channel_link` VARCHAR(255) NOT NULL,
    `capacity` INT NOT NULL,
    `is_deleted` TINYINT(1) DEFAULT 0,
    `created_date` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`created_by`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `chats` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `content` TEXT NOT NULL,
    `author_id` INT NOT NULL,
    `channel_id` INT NOT NULL,
    `created_date` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`author_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`channel_id`) REFERENCES `channels`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `follows` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `follower_id` INT NOT NULL,
    `followee_id` INT NOT NULL,
    `follow_date` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`follower_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`followee_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `blocks` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `blocker_id` INT NOT NULL,
    `blocked_id` INT NOT NULL,
    `block_date` DATETIME NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`blocker_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`blocked_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
