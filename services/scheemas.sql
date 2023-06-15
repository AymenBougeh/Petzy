SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema petzy123
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema petzy123
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `petzy123` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `petzy123` ;

-- -----------------------------------------------------
-- Table `petzy123`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `city` VARCHAR(100) NOT NULL,
  `state` VARCHAR(100) NOT NULL,
  `zip` VARCHAR(10) NOT NULL,
  `latitude` DECIMAL(10,6) NOT NULL,
  `longitude` DECIMAL(10,6) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `petzy123`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `petzy123`.`worker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`worker` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `image` VARCHAR(255) NULL,
  `license_number` VARCHAR(20) NOT NULL,
  `years_of_experience` INT NULL,
  `description` LONGTEXT NULL DEFAULT NULL,
  `role` ENUM('dog walker', 'vet', 'pet boarding') NOT NULL,
  `latitude` DECIMAL(10,6) NOT NULL,
  `longitude` DECIMAL(10,6) NOT NULL,
  `price` INT NULL,
  `services` TEXT(1000) NULL,
  `aboutPet` TEXT(1000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `petzy123`.`appointments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`appointments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `time` TIME NOT NULL,
  `notes` TEXT NOT NULL,
  `worker_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  INDEX `worker_id` (`worker_id` ASC) VISIBLE,
  CONSTRAINT `appointments_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `petzy123`.`users` (`id`),
  CONSTRAINT `appointments_ibfk_2`
    FOREIGN KEY (`worker_id`)
    REFERENCES `petzy123`.`worker` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `petzy123`.`availability`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`availability` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `start_time` TIME NOT NULL,
  `end_time` TIME NOT NULL,
  `day_of_week` ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
  `worker_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_availability_worker1_idx` (`worker_id` ASC) VISIBLE,
  CONSTRAINT `fk_availability_worker1`
    FOREIGN KEY (`worker_id`)
    REFERENCES `petzy123`.`worker` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `petzy123`.`shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`shop` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `petzy123`.`bookmarks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`bookmarks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `shop_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  INDEX `shop_id` (`shop_id` ASC) VISIBLE,
  CONSTRAINT `bookmarks_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `petzy123`.`users` (`id`),
  CONSTRAINT `bookmarks_ibfk_2`
    FOREIGN KEY (`shop_id`)
    REFERENCES `petzy123`.`shop` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `petzy123`.`posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `content` TEXT NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  `date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `posts_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `petzy123`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `petzy123`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `post_id` INT NOT NULL,
  `content` TEXT NOT NULL,
  `date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  INDEX `post_id` (`post_id` ASC) VISIBLE,
  CONSTRAINT `comments_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `petzy123`.`users` (`id`),
  CONSTRAINT `comments_ibfk_2`
    FOREIGN KEY (`post_id`)
    REFERENCES `petzy123`.`posts` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `petzy123`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `status` ENUM('pending', 'shipped', 'delivered') NOT NULL,
  `date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `petzy123`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `petzy123`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`payments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `payment_method` VARCHAR(50) NOT NULL,
  `transaction_id` VARCHAR(100) NOT NULL,
  `date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `worker_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  INDEX `order_id` (`order_id` ASC) VISIBLE,
  INDEX `worker_id` (`worker_id` ASC) VISIBLE,
  CONSTRAINT `payments_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `petzy123`.`users` (`id`),
  CONSTRAINT `payments_ibfk_2`
    FOREIGN KEY (`order_id`)
    REFERENCES `petzy123`.`orders` (`id`),
  CONSTRAINT `payments_ibfk_3`
    FOREIGN KEY (`worker_id`)
    REFERENCES `petzy123`.`worker` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `petzy123`.`pets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`pets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `species` VARCHAR(255) NOT NULL,
  `breed` VARCHAR(255) NOT NULL,
  `age` INT NOT NULL,
  `gender` VARCHAR(10) NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `pets_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `petzy123`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `petzy123`.`reminders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`reminders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `date` DATE NOT NULL,
  `time` TIME NOT NULL,
  `is_completed` TINYINT(1) NOT NULL DEFAULT '0',
  `date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `orders_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  INDEX `orders_id` (`orders_id` ASC) VISIBLE,
  CONSTRAINT `reminders_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `petzy123`.`users` (`id`),
  CONSTRAINT `reminders_ibfk_2`
    FOREIGN KEY (`orders_id`)
    REFERENCES `petzy123`.`orders` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `petzy123`.`reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`reviews` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `rating` INT NOT NULL,
  `comment` TEXT NOT NULL,
  `date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `date_modified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `shop_id` INT NOT NULL,
  `worker_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  INDEX `shop_id` (`shop_id` ASC) VISIBLE,
  INDEX `worker_id` (`worker_id` ASC) VISIBLE,
  CONSTRAINT `reviews_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `petzy123`.`users` (`id`),
  CONSTRAINT `reviews_ibfk_2`
    FOREIGN KEY (`shop_id`)
    REFERENCES `petzy123`.`shop` (`id`),
  CONSTRAINT `reviews_ibfk_3`
    FOREIGN KEY (`worker_id`)
    REFERENCES `petzy123`.`worker` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;