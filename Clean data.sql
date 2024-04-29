-- Remove duplicate
-- Standardizing
-- deal with null and blank
-- drop column/row


-- Remove duplicate
delete 
from layoffs_staging2
where row_num >1; 

-- Standardizing
select distinct (trim(company))
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select distinct industry
from layoffs_staging2
order by 1 ;

select *
from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct industry
from layoffs_staging2
order by 1 ;

select distinct location
from layoffs_staging2
order by 1 ;

select * 
from layoffs_staging2;

select distinct country
from layoffs_staging2
order by 1 ;

select distinct *
from layoffs_staging2
where country like 'United States%';

select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1 ;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select `date`,
STR_TO_DATE(`date`,'%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

select `date`
from layoffs_staging2;

alter table layoffs_staging2
modify column `date` DATE;

-- deal with null and blank

select * 
from layoffs_staging2
where total_laid_off is null
AND percentage_laid_off is null;

select *
from layoffs_staging2
where industry is null
or industry = '';

select *
from layoffs_staging2
where company = 'Airbnb';

update layoffs_staging2
set industry = null
where industry = '';

select t1.industry ,t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
    and t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and (t2.industry is not null or t2.industry != '');

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;


select *
from layoffs_staging2
where company Like 'Bally%';

select *
from layoffs_staging2;

select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

alter table layoffs_staging2
drop column row_num;