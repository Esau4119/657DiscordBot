-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema biotech_researchdb
-- -----------------------------------------------------
DROP DATABASE IF EXISTS biotech_researchdb; 

CREATE DATABASE IF NOT EXISTS biotech_researchdb; 

USE biotech_researchdb;
-- hi
-- -----------------------------------------------------
-- Table `Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Users` ;

CREATE TABLE IF NOT EXISTS `Users` (
  `user_Id` INT NOT NULL AUTO_INCREMENT,
  `first_Name` VARCHAR(128) NOT NULL,
  `last_Name` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`user_Id`),
  UNIQUE INDEX `user_Id_UNIQUE` (`user_Id` ASC) VISIBLE,
  INDEX `first_Name` (`first_Name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Projects` ;

CREATE TABLE IF NOT EXISTS `Projects` (
  `project_Id` INT NOT NULL AUTO_INCREMENT,
  `project_Name` VARCHAR(128) NOT NULL,
  `project_Description` LONGTEXT NOT NULL,
  `start_Date` DATE NOT NULL,
  `endt_Date` DATE NOT NULL,
  `project_Lead_Id` INT NULL,
  PRIMARY KEY (`project_Id`),
  INDEX `project_Lead_Id_idx` (`project_Lead_Id` ASC) VISIBLE,
  UNIQUE INDEX `project_Id_UNIQUE` (`project_Id` ASC) VISIBLE,
  CONSTRAINT `project_Lead_Id`
    FOREIGN KEY (`project_Lead_Id`)
    REFERENCES `Users` (`user_Id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Role` ;

CREATE TABLE IF NOT EXISTS `Role` (
  `role_Id` INT NOT NULL AUTO_INCREMENT,
  `role_Name` VARCHAR(128) NULL,
  `role_Permissions` MEDIUMTEXT NULL,
  `fk_userId` INT NULL,
  PRIMARY KEY (`role_Id`),
  INDEX `fk_userId_idx` (`fk_userId` ASC) VISIBLE,
  UNIQUE INDEX `role_Id_UNIQUE` (`role_Id` ASC) VISIBLE,
  CONSTRAINT `role_fk_userId`
    FOREIGN KEY (`fk_userId`)
    REFERENCES `Users` (`user_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Labs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Labs` ;

CREATE TABLE IF NOT EXISTS `Labs` (
  `lab_Id` INT NOT NULL AUTO_INCREMENT,
  `lab_Name` VARCHAR(128) NULL,
  `manager_Id` INT NULL,
  `location` VARCHAR(128) NULL,
  `max_Capacity` INT NULL,
  PRIMARY KEY (`lab_Id`),
  INDEX `fk_userId_idx` (`manager_Id` ASC) VISIBLE,
  UNIQUE INDEX `lab_Id_UNIQUE` (`lab_Id` ASC) VISIBLE,
  CONSTRAINT `lab_fk_userId`
    FOREIGN KEY (`manager_Id`)
    REFERENCES `Users` (`user_Id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Equipment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Equipment` ;

CREATE TABLE IF NOT EXISTS `Equipment` (
  `equipment_Id` INT NOT NULL AUTO_INCREMENT,
  `equimpent_Name` VARCHAR(128) NOT NULL,
  `maintenance_schedule` LONGTEXT NULL,
  `maintenance_Log` LONGTEXT NULL,
  `is_available` VARCHAR(45) NULL,
  `fk_LabId` INT NULL,
  PRIMARY KEY (`equipment_Id`),
  INDEX `lab_Id_idx` (`fk_LabId` ASC) VISIBLE,
  UNIQUE INDEX `equipment_Id_UNIQUE` (`equipment_Id` ASC) VISIBLE,
  CONSTRAINT `equipment_fk_labId`
    FOREIGN KEY (`fk_LabId`)
    REFERENCES `Labs` (`lab_Id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sample`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sample` ;

CREATE TABLE IF NOT EXISTS `Sample` (
  `sample_Id` INT NOT NULL AUTO_INCREMENT,
  `sample_Name` VARCHAR(128) NOT NULL,
  `description` LONGTEXT NULL,
  `storage_Location` VARCHAR(128) NOT NULL,
  `fk_projectId` INT NULL,
  PRIMARY KEY (`sample_Id`),
  UNIQUE INDEX `sample_Id_UNIQUE` (`sample_Id` ASC) VISIBLE,
  INDEX `fk_projectId_idx` (`fk_projectId` ASC) VISIBLE,
  CONSTRAINT `sample_fk_projectId`
    FOREIGN KEY (`fk_projectId`)
    REFERENCES `Projects` (`project_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Experiments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Experiments` ;

CREATE TABLE IF NOT EXISTS `Experiments` (
  `experiment_Id` INT NOT NULL AUTO_INCREMENT,
  `experiment_date` DATE NULL,
  `experiment_Description` LONGTEXT NULL,
  `fk_sampleId` INT NULL,
  `fk_labId` INT NULL,
  PRIMARY KEY (`experiment_Id`),
  UNIQUE INDEX `experiment_Id_UNIQUE` (`experiment_Id` ASC) VISIBLE,
  INDEX `fk_sampleId_idx` (`fk_sampleId` ASC) VISIBLE,
  INDEX `fk_labId_idx` (`fk_labId` ASC) VISIBLE,
  CONSTRAINT `experiments_fk_sampleId`
    FOREIGN KEY (`fk_sampleId`)
    REFERENCES `Sample` (`sample_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `experiments_fk_labId`
    FOREIGN KEY (`fk_labId`)
    REFERENCES `Labs` (`lab_Id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ExperimentResults`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ExperimentResults` ;

CREATE TABLE IF NOT EXISTS `ExperimentResults` (
  `results_Id` INT NOT NULL AUTO_INCREMENT,
  `fk_ExperimentId` INT NULL,
  `experiment_description` LONGTEXT NULL,
  PRIMARY KEY (`results_Id`),
  UNIQUE INDEX `results_Id_UNIQUE` (`results_Id` ASC) INVISIBLE,
  INDEX `fk_ExperimentId_idx` (`fk_ExperimentId` ASC) VISIBLE,
  CONSTRAINT `results_fk_ExperimentId`
    FOREIGN KEY (`fk_ExperimentId`)
    REFERENCES `Experiments` (`experiment_Id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Publication`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Publication` ;

CREATE TABLE IF NOT EXISTS `Publication` (
  `publication_Id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(128) NOT NULL,
  `publication_Date` DATE NOT NULL,
  `DOI` VARCHAR(128) NULL,
  `fk_projectId` INT NULL,
  PRIMARY KEY (`publication_Id`),
  INDEX `fk_projectId_idx` (`fk_projectId` ASC) VISIBLE,
  UNIQUE INDEX `publication_Id_UNIQUE` (`publication_Id` ASC) VISIBLE,
  CONSTRAINT `pub_fk_projectId`
    FOREIGN KEY (`fk_projectId`)
    REFERENCES `Projects` (`project_Id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FundingSource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FundingSource` ;

CREATE TABLE IF NOT EXISTS `FundingSource` (
  `Source_Id` INT NOT NULL AUTO_INCREMENT,
  `source_Name` VARCHAR(128) NULL,
  `contact_Info` VARCHAR(128) NULL,
  PRIMARY KEY (`Source_Id`),
  UNIQUE INDEX `Source_Id_UNIQUE` (`Source_Id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjectFunding`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProjectFunding` ;

CREATE TABLE IF NOT EXISTS `ProjectFunding` (
  `fk_projectId` INT NOT NULL,
  `fk_sourceId` INT NULL,
  `funding_Amount` INT NULL,
  PRIMARY KEY (`fk_projectId`),
  INDEX `fk_sourcetId_idx` (`fk_sourceId` ASC) VISIBLE,
  CONSTRAINT `fund_fk_projectId`
    FOREIGN KEY (`fk_projectId`)
    REFERENCES `Projects` (`project_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fund_fk_sourcetId`
    FOREIGN KEY (`fk_sourceId`)
    REFERENCES `FundingSource` (`Source_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Gene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gene` ;

CREATE TABLE IF NOT EXISTS `Gene` (
  `gene_Id` INT NOT NULL AUTO_INCREMENT,
  `gene_Name` VARCHAR(128) NULL,
  `sequence` VARCHAR(128) NULL,
  `fk_sampleId` INT NULL,
  PRIMARY KEY (`gene_Id`),
  INDEX `fk_sampleId_idx` (`fk_sampleId` ASC) VISIBLE,
  CONSTRAINT `gene_fk_sampleId`
    FOREIGN KEY (`fk_sampleId`)
    REFERENCES `Sample` (`sample_Id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Researcher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Researcher` ;

CREATE TABLE IF NOT EXISTS `Researcher` (
  `fk_researcher_Id` INT NOT NULL,
  `fk_researcherName` VARCHAR(128) NOT NULL,
  `affiliation` VARCHAR(128) NOT NULL,
  `researcher_expertise` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`fk_researcher_Id`),
  INDEX `fk_researcherName_idx` (`fk_researcherName` ASC) INVISIBLE,
  INDEX `fk_researcher_Id` (`fk_researcher_Id` ASC) VISIBLE,
  CONSTRAINT `research_fk_researcherId`
    FOREIGN KEY (`fk_researcher_Id`)
    REFERENCES `Users` (`user_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `research_fk_researcherName`
    FOREIGN KEY (`fk_researcherName`)
    REFERENCES `Users` (`first_Name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ResearchProposal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ResearchProposal` ;

CREATE TABLE IF NOT EXISTS `ResearchProposal` (
  `proposal_id` INT NOT NULL AUTO_INCREMENT,
  `proposal_description` LONGTEXT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `fk_researcherId` INT NULL,
  PRIMARY KEY (`proposal_id`),
  UNIQUE INDEX `proposal_id_UNIQUE` (`proposal_id` ASC) VISIBLE,
  INDEX `fk_researcherId_idx` (`fk_researcherId` ASC) VISIBLE,
  CONSTRAINT `prop_fk_researcherId`
    FOREIGN KEY (`fk_researcherId`)
    REFERENCES `Researcher` (`fk_researcher_Id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Collaboration`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Collaboration` ;

CREATE TABLE IF NOT EXISTS `Collaboration` (
  `collaboration_Id` INT NOT NULL AUTO_INCREMENT,
  `collaboration_Date` DATE NULL,
  `number_Participants` INT NULL,
  `fk_researchertId` INT NULL,
  PRIMARY KEY (`collaboration_Id`),
  UNIQUE INDEX `collaboration_Id_UNIQUE` (`collaboration_Id` ASC) VISIBLE,
  INDEX `collab_fk_researchertId_idx` (`fk_researchertId` ASC) VISIBLE,
  CONSTRAINT `collab_fk_researchertId`
    FOREIGN KEY (`fk_researchertId`)
    REFERENCES `Researcher` (`fk_researcher_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LabAccessRequest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LabAccessRequest` ;

CREATE TABLE IF NOT EXISTS `LabAccessRequest` (
  `request_id` INT NOT NULL AUTO_INCREMENT,
  `request_description` VARCHAR(128) NULL,
  `status` VARCHAR(128) NULL,
  `access_Level` INT NULL,
  `fk_labId` INT NULL,
  PRIMARY KEY (`request_id`),
  UNIQUE INDEX `request_id_UNIQUE` (`request_id` ASC) VISIBLE,
  INDEX `fk_labId_idx` (`fk_labId` ASC) VISIBLE,
  CONSTRAINT `access_fk_labId`
    FOREIGN KEY (`fk_labId`)
    REFERENCES `Labs` (`lab_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PublicationAuthor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PublicationAuthor` ;

CREATE TABLE IF NOT EXISTS `PublicationAuthor` (
  `author_name` VARCHAR(128) NOT NULL,
  `affiliation` VARCHAR(45) NULL,
  `fk_projectLeadId` INT NULL,
  `fk_publicationId` INT NULL,
  PRIMARY KEY (`author_name`),
  INDEX `fk_projectLeadId_idx` (`fk_projectLeadId` ASC) VISIBLE,
  INDEX `fk_publicationId_idx` (`fk_publicationId` ASC) VISIBLE,
  CONSTRAINT `pubAuth_fk_projectLeadId`
    FOREIGN KEY (`fk_projectLeadId`)
    REFERENCES `Projects` (`project_Id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `pubAuth_fk_publicationId`
    FOREIGN KEY (`fk_publicationId`)
    REFERENCES `Publication` (`publication_Id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SampleResults`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SampleResults` ;

CREATE TABLE IF NOT EXISTS `SampleResults` (
  `analysis_Id` INT NOT NULL AUTO_INCREMENT,
  `analysis_description` VARCHAR(128) NOT NULL,
  `fk_sampleId` INT NULL,
  PRIMARY KEY (`analysis_Id`),
  UNIQUE INDEX `analysis_Id_UNIQUE` (`analysis_Id` ASC) VISIBLE,
  INDEX `fk_sampleId_idx` (`fk_sampleId` ASC) VISIBLE,
  CONSTRAINT `sampRes_fk_sampleId`
    FOREIGN KEY (`fk_sampleId`)
    REFERENCES `Sample` (`sample_Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
