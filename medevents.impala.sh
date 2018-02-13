#-- primaryid$caseid$caseversion$i_f_code$event_dt$mfr_dt$init_fda_dt$fda_dt$rept_cod$auth_num$mfr_num$mfr_sndr$lit_ref$age$age_cod$age_grp$sex$e_sub$wt$wt_cod$rept_dt$to_mfr$occp_cod$reporter_country$occr_country
#-- 1000591924$10005919$24$f$20140308$20170823$20140313$20170825$exp$$phhy2014ca017890$novartis$$69$yr$$m$y$$$20170825$$ot$ca$ca



impala-shell -i $DATANODE <<eoj
drop table if exists medevents;

create external table medevents ( 
priid string,
caseid string,
caseversion string,
i_f_cod string,
event_dt string,
mfr_dt string,
init_fda_dt string,
fda_dt string,
rept_cod string,
auth_num string,
mfr_num string,
mfr_sndr string,
lit_ref string,
age int,
age_cod string,
age_grp string,
sex string,
e_sub string,
wt int,
wt_cod string,
rept_dt string,
to_mfr string,
occp_cod string,
reporter_country string,
occr_country string
)
row format delimited
fields terminated by '$'
stored as textfile
location '/user/$USER/meddata'
;

select * from medevents limit 5;

select reporter_country , sex,  count(*) from medevents
group by reporter_country, sex
order by  reporter_country, sex;

drop table if exists medeventsp;
create table medeventsp stored as parquet as select * from medevents
where age between 0 and 100;


drop table if exists medoutcome;

create external table medoutcome ( 
priid string,
caseid string,
outcome string
)
row format delimited
fields terminated by '$'
stored as textfile
location '/user/$USER/medoutcome'
;

select * from medoutcome limit 5;

select outcome, count(*) from medoutcome group by outcome;

drop table if exists medoutcomep;
create table medoutcomep stored as parquet as select * from medoutcome
;

eoj

 impala-shell -i $DATANODE  -f logisticOutcome.sql

