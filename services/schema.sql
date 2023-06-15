-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema petzy123
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema petzy123
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `petzy123` DEFAULT CHARACTER SET utf8mb4 COLLATE = utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `petzy123`.`shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`shop` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  `price` INT NOT NULL,
  `category` ENUM('food', 'accessories', 'healthCare') NOT NULL,
  `breed` ENUM('dog', 'cat', 'other') NOT NULL,
  `total_purchase` INT NULL DEFAULT NULL,
  `last_purchase` INT NULL DEFAULT NULL,
  `updated_at` VARCHAR(100) NOT NULL,
  `rating` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `petzy123`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `image` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `petzy123`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`cart` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(100) NOT NULL,
  `product_price` INT NOT NULL,
  `quantity` INT NOT NULL,
  `users_id` INT NOT NULL,
  `shop_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cart_users_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_cart_shop1_idx` (`shop_id` ASC) VISIBLE,
  CONSTRAINT `fk_cart_shop1`
    FOREIGN KEY (`shop_id`)
    REFERENCES `petzy123`.`shop` (`id`),
  CONSTRAINT `fk_cart_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `petzy123`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `petzy123`.`purchases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`purchases` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `purchase_number` INT NOT NULL,
  `date` VARCHAR(100) NOT NULL,
  `shop_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_purchases_shop1_idx` (`shop_id` ASC) VISIBLE,
  CONSTRAINT `fk_purchases_shop1`
    FOREIGN KEY (`shop_id`)
    REFERENCES `petzy123`.`shop` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `petzy123`.`worker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`worker` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `image` VARCHAR(255) NULL DEFAULT NULL,
  `status` ENUM('pending', 'confirmed', 'refused') NULL DEFAULT 'pending',
  `license_number` VARCHAR(20) NULL DEFAULT NULL,
  `years_of_experience` INT NULL DEFAULT NULL,
  `description` LONGTEXT NULL DEFAULT NULL,
  `role` ENUM('Dog Walking', 'vet', 'Pet Bording') NOT NULL,
  `latitude` DECIMAL(10,6) NULL DEFAULT NULL,
  `longitude` DECIMAL(10,6) NULL DEFAULT NULL,
  `price` INT NULL DEFAULT NULL,
  `services` TEXT NULL DEFAULT NULL,
  `aboutPet` TEXT NULL DEFAULT NULL,
  `rating` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `petzy123`.`appointments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`appointments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `time` TIME NOT NULL,
  `notes` TEXT NULL DEFAULT NULL,
  `worker_id` INT NULL DEFAULT NULL,
  `user_id` INT NOT NULL,
  `vet_name` VARCHAR(45) NOT NULL,
  `pet_name` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;


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
    REFERENCES `petzy123`.`worker` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `petzy123`.`blogs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`blogs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `content` MEDIUMTEXT NOT NULL,
  `image` LONGTEXT NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_blogs_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_blogs_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `petzy123`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;


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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `petzy123`.`posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `content` VARCHAR(150) NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  `date_created` VARCHAR(100) NOT NULL,
  `date_modified` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `posts_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `petzy123`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `petzy123`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `post_id` INT NOT NULL,
  `content` TEXT NOT NULL,
  `date_created` VARCHAR(100) NOT NULL,
  `date_modified` VARCHAR(100) NOT NULL,
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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `petzy123`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `status` ENUM('pending', 'accepted', 'rejected') NOT NULL DEFAULT 'pending',
  `worker_name` VARCHAR(45) NOT NULL,
  `pet_name` VARCHAR(45) NOT NULL,
  `pick_up_date` DATE NOT NULL,
  `drop_of_date` DATE NOT NULL,
  `walk_per_day` INT NOT NULL,
  `meal_per_day` INT NOT NULL,
  `worker_id` INT NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  INDEX `fk_orders_worker1_idx` (`worker_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_worker1`
    FOREIGN KEY (`worker_id`)
    REFERENCES `petzy123`.`worker` (`id`),
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `petzy123`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;


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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;


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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;


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
  `date_created` VARCHAR(100) NOT NULL,
  `date_modified` VARCHAR(100) NOT NULL,
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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;


-- -----------------------------------------------------
-- Table `petzy123`.`reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `petzy123`.`reviews` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `rating` INT NOT NULL,
  `comment` TEXT NOT NULL,
  `date_created` VARCHAR(100) NOT NULL,
  `date_modified` VARCHAR(100) NOT NULL,
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
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_general_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;