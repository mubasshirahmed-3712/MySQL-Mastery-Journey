
-- ================================================
-- 📊 SQL PROJECT: LAYOFFS 2022 – DATA CLEANING & EDA
-- Author: Mubasshir Ahmed
-- Source Dataset: https://www.kaggle.com/datasets/swaptr/layoffs-2022
-- Repo: https://github.com/mubasshirahmed-3712/MySQL-Mastery-Journey
-- ================================================

-- STEP 0: Initial data preview
SELECT * FROM world_layoffs.layoffs;

-- ================================================
-- ✅ STEP 1: Creating staging tables and initial inspection
-- ================================================
CREATE TABLE world_layoffs.layoffs_staging 
LIKE world_layoffs.layoffs;

INSERT INTO layoffs_staging 
SELECT * FROM world_layoffs.layoffs;

-- ================================================
-- ✅ STEP 2: Removing duplicates using ROW_NUMBER()
-- ================================================
ALTER TABLE world_layoffs.layoffs_staging ADD row_num INT;

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
-- ✅ STEP 3: Standardizing missing and inconsistent values
-- ================================================
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2 ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry IN ('Crypto Currency', 'CryptoCurrency');

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- ================================================
-- ✅ STEP 4: Final NULL clean-up and row drop
-- ================================================
DELETE FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- ✅ Final Cleaned Preview
SELECT * 
FROM world_layoffs.layoffs_staging2
LIMIT 20;

-- ================================================
-- 📈 STEP 5: EDA – Exploring key layoff trends
-- ================================================

-- Max layoffs in one entry
SELECT MAX(total_laid_off) FROM world_layoffs.layoffs_staging2;

-- Companies with 100% layoffs
SELECT * FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Top 5 single-day layoffs
SELECT company, total_laid_off
FROM world_layoffs.layoffs_staging
ORDER BY total_laid_off DESC
LIMIT 5;

-- Top 10 total layoffs by company
SELECT company, SUM(total_laid_off) AS total
FROM world_layoffs.layoffs_staging2
GROUP BY company
ORDER BY total DESC
LIMIT 10;

-- Layoffs by location
SELECT location, SUM(total_laid_off) AS total
FROM world_layoffs.layoffs_staging2
GROUP BY location
ORDER BY total DESC
LIMIT 10;

-- Layoffs by country
SELECT country, SUM(total_laid_off) AS total
FROM world_layoffs.layoffs_staging2
GROUP BY country
ORDER BY total DESC;

-- Yearly trend
SELECT YEAR(date) AS year, SUM(total_laid_off) AS total
FROM world_layoffs.layoffs_staging2
GROUP BY year
ORDER BY year;

-- By industry
SELECT industry, SUM(total_laid_off) AS total
FROM world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY total DESC;

-- By company stage
SELECT stage, SUM(total_laid_off) AS total
FROM world_layoffs.layoffs_staging2
GROUP BY stage
ORDER BY total DESC;

-- Top 3 companies with most layoffs per year
WITH Company_Year AS (
  SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(date)
),
Company_Year_Rank AS (
  SELECT company, years, total_laid_off,
         DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3 AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;

-- Rolling layoffs trend (month-wise)
WITH DATE_CTE AS (
  SELECT SUBSTRING(date, 1, 7) AS dates, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY dates
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates) AS rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates;
