#-- primaryid$caseid$caseversion$i_f_code$event_dt$mfr_dt$init_fda_dt$fda_dt$rept_cod$auth_num$mfr_num$mfr_sndr$lit_ref$age$age_cod$age_grp$sex$e_sub$wt$wt_cod$rept_dt$to_mfr$occp_cod$reporter_country$occr_country
#-- 1000591924$10005919$24$F$20140308$20170823$20140313$20170825$EXP$$PHHY2014CA017890$NOVARTIS$$69$YR$$M$Y$$$20170825$$OT$CA$CA



impala-shell -i $DATANODE <<eoj
drop table if exists medevents;

create external table medevents ( 
priid string,
CASEcode string,
caseversion string,
I_F_COD string,
EVENT_DT string,
MFR_DT string,
FDA_DT string,
REPT_COD string,
auth_num string,
MFR_NUM string,
MFR_SNDR string,
lit_ref string,
AGE string,
AGE_COD string,
age_grp string,
sex string,
E_SUB string,
WT string,
WT_COD string,
REPT_DT string,
to_mfr string,
OCCP_COD string,
REPORTER_COUNTRY string,
occr_country string
)
row format delimited
fields terminated by '$'
stored as textfile
location '/user/$USER/meddata'
;

select * from medevents limit 5;

select REPORTER_COUNTRY , sex,  count(*) from medevents
group by REPORTER_COUNTRY, sex
order by  REPORTER_COUNTRY, sex;

create table medeventsp stored as parquet as select * from medevents;

eoj
