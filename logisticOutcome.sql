--select count(*)  from (
drop table if exists  logisticoutcomep;
create table logisticoutcomep stored as parquet as 
select a.priid, count(*) casecount,  max(a.wt*2.2) mywt , max(a.age) myage, 
case when sex = 'M' then 1 when sex = 'F' then 2 else 3  end csex,
case when b.outcome = 'DE' then 0 else 1 end label
from medeventsp a, medoutcomep b
where a.priid=b.priid
and a.wt is not null
and a.age > 0 and age < 100
and a.sex is not null

group by priid, csex, label;
--order by count(*) desc 
--) as foo

