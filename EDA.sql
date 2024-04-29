-- Exploratory Data Analysis
select *
from layoffs_staging2;

select total_laid_off
from layoffs_staging2;

select MAX(total_laid_off),MAX(percentage_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

select company,sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select min(`date`),max(`date`)
from layoffs_staging2;

select industry,sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

select *
from layoffs_staging2;

select year(`date`),sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

select stage,sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

select company,avg(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select substring(`date`,1,7) as `month`,sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 
;

with Rolling_Total as
(
select substring(`date`,1,7) as `month`,sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 
)
select `month`, total_off,
sum(total_off) over(ORDER BY `month`) as rolling_total
from Rolling_Total;

select company,Year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company, Year(`date`)
order by 3 desc;

with Company_Year (company, years, total_laid_off) as
(
select company,Year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company, Year(`date`)
), Company_Year_Rank AS
(select * ,dense_rank() over (partition by years order by total_laid_off desc) as Ranking
from Company_Year
where years is not null
)
select * 
from Company_Year_Rank
Where Ranking <=5
;





