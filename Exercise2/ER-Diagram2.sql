-- -----------------------------------------------------
-- Table `mydb`.`enrolleds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`enrolleds` (
  `student_id` INT NOT NULL,
  `course_crn` VARCHAR(45) NOT NULL,
  `credit_status` INT NULL,
  PRIMARY KEY (`student_id`, `course_crn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`students` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `enrolleds_student_id` INT NOT NULL,
  `enrolleds_course_crn` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `enrolleds_student_id`, `enrolleds_course_crn`),
  INDEX `fk_students_enrolleds1_idx` (`enrolleds_student_id` ASC, `enrolleds_course_crn` ASC) VISIBLE,
  CONSTRAINT `fk_students_enrolleds1`
    FOREIGN KEY (`enrolleds_student_id` , `enrolleds_course_crn`)
    REFERENCES `mydb`.`enrolleds` (`student_id` , `course_crn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`departments` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `office` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rooms` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `capacity` INT NOT NULL,
  `departments_id` INT NOT NULL,
  PRIMARY KEY (`id`, `departments_id`),
  INDEX `fk_rooms_departments1_idx` (`departments_id` ASC) VISIBLE,
  CONSTRAINT `fk_rooms_departments1`
    FOREIGN KEY (`departments_id`)
    REFERENCES `mydb`.`departments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`courses` (
  `crn` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `start_time` DATE NULL,
  `end_time` DATE NULL,
  `room_id` INT NULL,
  `enrolleds_student_id` INT NOT NULL,
  `enrolleds_course_crn` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`crn`, `enrolleds_student_id`, `enrolleds_course_crn`),
  INDEX `fk_courses_enrolleds1_idx` (`enrolleds_student_id` ASC, `enrolleds_course_crn` ASC) VISIBLE,
  CONSTRAINT `fk_courses_enrolleds1`
    FOREIGN KEY (`enrolleds_student_id` , `enrolleds_course_crn`)
    REFERENCES `mydb`.`enrolleds` (`student_id` , `course_crn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`majorsIn`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`majorsIn` (
  `student_id` INT NOT NULL,
  `dept_id` INT NOT NULL,
  `departments_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `dept_id`, `departments_id`),
  INDEX `fk_majorsIn_departments1_idx` (`departments_id` ASC) VISIBLE,
  CONSTRAINT `fk_majorsIn_departments1`
    FOREIGN KEY (`departments_id`)
    REFERENCES `mydb`.`departments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`courses_has_rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`courses_has_rooms` (
  `courses_crn` VARCHAR(45) NOT NULL,
  `courses_enrolleds_student_id` INT NOT NULL,
  `courses_enrolleds_course_crn` VARCHAR(45) NOT NULL,
  `rooms_id` INT NOT NULL,
  `rooms_departments_id` INT NOT NULL,
  PRIMARY KEY (`courses_crn`, `courses_enrolleds_student_id`, `courses_enrolleds_course_crn`, `rooms_id`, `rooms_departments_id`),
  INDEX `fk_courses_has_rooms_rooms1_idx` (`rooms_id` ASC, `rooms_departments_id` ASC) VISIBLE,
  INDEX `fk_courses_has_rooms_courses1_idx` (`courses_crn` ASC, `courses_enrolleds_student_id` ASC, `courses_enrolleds_course_crn` ASC) VISIBLE,
  CONSTRAINT `fk_courses_has_rooms_courses1`
    FOREIGN KEY (`courses_crn` , `courses_enrolleds_student_id` , `courses_enrolleds_course_crn`)
    REFERENCES `mydb`.`courses` (`crn` , `enrolleds_student_id` , `enrolleds_course_crn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_courses_has_rooms_rooms1`
    FOREIGN KEY (`rooms_id` , `rooms_departments_id`)
    REFERENCES `mydb`.`rooms` (`id` , `departments_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`students_has_majorsIn`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`students_has_majorsIn` (
  `students_id` INT NOT NULL,
  `students_enrolleds_student_id` INT NOT NULL,
  `students_enrolleds_course_crn` VARCHAR(45) NOT NULL,
  `majorsIn_student_id` INT NOT NULL,
  `majorsIn_dept_id` INT NOT NULL,
  `majorsIn_departments_id` INT NOT NULL,
  PRIMARY KEY (`students_id`, `students_enrolleds_student_id`, `students_enrolleds_course_crn`, `majorsIn_student_id`, `majorsIn_dept_id`, `majorsIn_departments_id`),
  INDEX `fk_students_has_majorsIn_majorsIn1_idx` (`majorsIn_student_id` ASC, `majorsIn_dept_id` ASC, `majorsIn_departments_id` ASC) VISIBLE,
  INDEX `fk_students_has_majorsIn_students1_idx` (`students_id` ASC, `students_enrolleds_student_id` ASC, `students_enrolleds_course_crn` ASC) VISIBLE,
  CONSTRAINT `fk_students_has_majorsIn_students1`
    FOREIGN KEY (`students_id` , `students_enrolleds_student_id` , `students_enrolleds_course_crn`)
    REFERENCES `mydb`.`students` (`id` , `enrolleds_student_id` , `enrolleds_course_crn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_students_has_majorsIn_majorsIn1`
    FOREIGN KEY (`majorsIn_student_id` , `majorsIn_dept_id` , `majorsIn_departments_id`)
    REFERENCES `mydb`.`majorsIn` (`student_id` , `dept_id` , `departments_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
