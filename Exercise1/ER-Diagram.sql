-- -----------------------------------------------------
-- Table `mydb`.`persons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`persons` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `dob` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`directors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`directors` (
  `director_id` INT NOT NULL,
  `movie_id` INT NOT NULL,
  PRIMARY KEY (`director_id`, `movie_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`oscars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`oscars` (
  `movie_id` INT NOT NULL,
  `person_id` INT NOT NULL,
  `type` VARCHAR(45) NULL,
  `year` YEAR(4) NULL,
  PRIMARY KEY (`movie_id`, `person_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`movies` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `year` YEAR(4) NULL,
  `rating` INT NULL,
  `runtime` DATE NULL,
  `genre` VARCHAR(45) NULL,
  `earnings_rank` INT NULL,
  `directors_director_id` INT NOT NULL,
  `directors_movie_id` INT NOT NULL,
  `oscars_movie_id` INT NOT NULL,
  `oscars_person_id` INT NOT NULL,
  PRIMARY KEY (`id`, `directors_director_id`, `directors_movie_id`, `oscars_movie_id`, `oscars_person_id`),
  INDEX `fk_movies_directors1_idx` (`directors_director_id` ASC, `directors_movie_id` ASC) VISIBLE,
  INDEX `fk_movies_oscars1_idx` (`oscars_movie_id` ASC, `oscars_person_id` ASC) VISIBLE,
  CONSTRAINT `fk_movies_directors1`
    FOREIGN KEY (`directors_director_id` , `directors_movie_id`)
    REFERENCES `mydb`.`directors` (`director_id` , `movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movies_oscars1`
    FOREIGN KEY (`oscars_movie_id` , `oscars_person_id`)
    REFERENCES `mydb`.`oscars` (`movie_id` , `person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`actors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`actors` (
  `actor_id` INT NOT NULL,
  `movie_id` INT NOT NULL,
  PRIMARY KEY (`actor_id`, `movie_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`movies_has_actors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`movies_has_actors` (
  `movies_id` INT NOT NULL,
  `actors_actor_id` INT NOT NULL,
  `actors_movie_id` INT NOT NULL,
  PRIMARY KEY (`movies_id`, `actors_actor_id`, `actors_movie_id`),
  INDEX `fk_movies_has_actors_actors1_idx` (`actors_actor_id` ASC, `actors_movie_id` ASC) VISIBLE,
  INDEX `fk_movies_has_actors_movies1_idx` (`movies_id` ASC) VISIBLE,
  CONSTRAINT `fk_movies_has_actors_movies1`
    FOREIGN KEY (`movies_id`)
    REFERENCES `mydb`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movies_has_actors_actors1`
    FOREIGN KEY (`actors_actor_id` , `actors_movie_id`)
    REFERENCES `mydb`.`actors` (`actor_id` , `movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`directors_has_oscars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`directors_has_oscars` (
  `directors_director_id` INT NOT NULL,
  `directors_movie_id` INT NOT NULL,
  `oscars_movie_id` INT NOT NULL,
  `oscars_person_id` INT NOT NULL,
  PRIMARY KEY (`directors_director_id`, `directors_movie_id`, `oscars_movie_id`, `oscars_person_id`),
  INDEX `fk_directors_has_oscars_oscars1_idx` (`oscars_movie_id` ASC, `oscars_person_id` ASC) VISIBLE,
  INDEX `fk_directors_has_oscars_directors1_idx` (`directors_director_id` ASC, `directors_movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_directors_has_oscars_directors1`
    FOREIGN KEY (`directors_director_id` , `directors_movie_id`)
    REFERENCES `mydb`.`directors` (`director_id` , `movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_directors_has_oscars_oscars1`
    FOREIGN KEY (`oscars_movie_id` , `oscars_person_id`)
    REFERENCES `mydb`.`oscars` (`movie_id` , `person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`oscars_has_actors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`oscars_has_actors` (
  `oscars_movie_id` INT NOT NULL,
  `oscars_person_id` INT NOT NULL,
  `actors_actor_id` INT NOT NULL,
  `actors_movie_id` INT NOT NULL,
  PRIMARY KEY (`oscars_movie_id`, `oscars_person_id`, `actors_actor_id`, `actors_movie_id`),
  INDEX `fk_oscars_has_actors_actors1_idx` (`actors_actor_id` ASC, `actors_movie_id` ASC) VISIBLE,
  INDEX `fk_oscars_has_actors_oscars1_idx` (`oscars_movie_id` ASC, `oscars_person_id` ASC) VISIBLE,
  CONSTRAINT `fk_oscars_has_actors_oscars1`
    FOREIGN KEY (`oscars_movie_id` , `oscars_person_id`)
    REFERENCES `mydb`.`oscars` (`movie_id` , `person_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_oscars_has_actors_actors1`
    FOREIGN KEY (`actors_actor_id` , `actors_movie_id`)
    REFERENCES `mydb`.`actors` (`actor_id` , `movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`persons_has_actors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`persons_has_actors` (
  `persons_id` INT NOT NULL,
  `actors_actor_id` INT NOT NULL,
  `actors_movie_id` INT NOT NULL,
  PRIMARY KEY (`persons_id`, `actors_actor_id`, `actors_movie_id`),
  INDEX `fk_persons_has_actors_actors1_idx` (`actors_actor_id` ASC, `actors_movie_id` ASC) VISIBLE,
  INDEX `fk_persons_has_actors_persons1_idx` (`persons_id` ASC) VISIBLE,
  CONSTRAINT `fk_persons_has_actors_persons1`
    FOREIGN KEY (`persons_id`)
    REFERENCES `mydb`.`persons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persons_has_actors_actors1`
    FOREIGN KEY (`actors_actor_id` , `actors_movie_id`)
    REFERENCES `mydb`.`actors` (`actor_id` , `movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`persons_has_directors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`persons_has_directors` (
  `persons_id` INT NOT NULL,
  `directors_director_id` INT NOT NULL,
  `directors_movie_id` INT NOT NULL,
  PRIMARY KEY (`persons_id`, `directors_director_id`, `directors_movie_id`),
  INDEX `fk_persons_has_directors_directors1_idx` (`directors_director_id` ASC, `directors_movie_id` ASC) VISIBLE,
  INDEX `fk_persons_has_directors_persons1_idx` (`persons_id` ASC) VISIBLE,
  CONSTRAINT `fk_persons_has_directors_persons1`
    FOREIGN KEY (`persons_id`)
    REFERENCES `mydb`.`persons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_persons_has_directors_directors1`
    FOREIGN KEY (`directors_director_id` , `directors_movie_id`)
    REFERENCES `mydb`.`directors` (`director_id` , `movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

