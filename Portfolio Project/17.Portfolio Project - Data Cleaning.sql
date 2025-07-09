-- ================================================
-- 📊 SQL PROJECT: DATA CLEANING – LAYOFFS DATASET
-- Author: Mubasshir Ahmed
-- Source Dataset: https://www.kaggle.com/datasets/swaptr/layoffs-2022
-- Learning Reference: Alex The Analyst (YouTube series)
-- Repo: https://github.com/mubasshirahmed-3712/MySQL-Mastery-Journey
-- ================================================

-- STEP 0: Initial data preview
SELECT * FROM world_layoffs.layoffs;

-- ================================================
-- ✅ STEP 1: Creating staging tables and initial inspection
-- ================================================
-- Create a staging table for data transformation, preserving the original data
CREATE TABLE world_layoffs.layoffs_staging 
LIKE world_layoffs.layoffs;

INSERT INTO layoffs_staging 
SELECT * FROM world_layoffs.layoffs;

-- Define standard data cleaning process steps
-- 1. Remove duplicates
-- 2. Standardize values
-- 3. Handle NULL values
-- 4. Drop unneeded columns and rows

-- ================================================
-- ✅ STEP 2: Removing duplicates using ROW_NUMBER()
-- ================================================
-- Identify potential duplicates with partial key partitioning
SELECT company, industry, total_laid_off, `date`,
  ROW_NUMBER() OVER (PARTITION BY company, industry, total_laid_off, `date`) AS row_num
FROM world_layoffs.layoffs_staging;

-- Show only confirmed duplicates using full column partitioning
SELECT *
FROM (
  SELECT company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions,
    ROW_NUMBER() OVER (
      PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
    ) AS row_num
  FROM world_layoffs.layoffs_staging
) duplicates
WHERE row_num > 1;

-- Strategy: Add row numbers to identify and remove true duplicates
ALTER TABLE world_layoffs.layoffs_staging ADD row_num INT;

-- Create a new cleaned staging table with deduplicated rows
CREATE TABLE world_layoffs.layoffs_staging2 (
  company TEXT,
  location TEXT,
  industry TEXT,
  total_laid_off INT,
  percentage_laid_off TEXT,
  `date` TEXT,
  stage TEXT,
  country TEXT,
  funds_raised_millions INT,
  row_num INT
);

INSERT INTO world_layoffs.layoffs_staging2
SELECT company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions,
  ROW_NUMBER() OVER (
    PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
  ) AS row_num
FROM world_layoffs.layoffs_staging;

DELETE FROM world_layoffs.layoffs_staging2
WHERE row_num >= 2;

-- ================================================
-- ✅ STEP 3: Standardizing NULL and fixing industry values
-- ================================================
-- Inspect unique industry values and clean inconsistent or blank entries
UPDATE world_layoffs.layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- Fill missing industry fields by referencing existing company rows with valid industry
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2 ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL AND t2.industry IS NOT NULL;

-- Normalize variations of Crypto industry
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry IN ('Crypto Currency', 'CryptoCurrency');

-- ================================================
-- ✅ STEP 4: Standardizing country names and formatting date
-- ================================================
-- Clean inconsistent country entries (e.g., 'United States.')
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);

-- Convert string-based date column to DATE type
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- ================================================
-- ✅ STEP 5: Null values and final cleanup
-- ================================================
-- Keep null values in important numeric fields to support accurate aggregations
-- These nulls will help distinguish missing vs. zero-layoff companies in EDA

-- ================================================
-- ✅ STEP 6: Removing irrelevant rows and columns
-- ================================================
-- Delete rows where both layoff count and percentage are missing
DELETE FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

-- Drop temporary deduplication helper column
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- ✅ Final Cleaned Preview
SELECT * 
FROM world_layoffs.layoffs_staging2
LIMIT 20;
