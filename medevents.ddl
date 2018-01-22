#-- #ISR,CASE,I_F_COD,FOLL_SEQ,IMAGE,EVENT_DT,MFR_DT,FDA_DT,REPT_COD,MFR_NUM,MFR_SNDR,AGE,AGE_COD,GNDR_COD,E_SUB,WT,WT_COD,REPT_DT,OCCP_COD,DEATH_DT,TO_MFR,CONFID,REPORTER_COUNTRY
#-- #6668400,7678128,I,,6668400-7,,20100324,20100406,EXP,PHHY2010BR19211,NOVARTIS PHARMACEUTICAL CORPORATION,,YR,F,Y,,,20100406,CN,,,,BR,
impala-shell -i $DATANODE <<eoj
drop table if exists medevents;

create external table medevents ( 
ISR string,
CASEcode string,
I_F_COD string,
FOLL_SEQ string,
IMAGE string,
EVENT_DT string,
MFR_DT string,
FDA_DT string,
REPT_COD string,
MFR_NUM string,
MFR_SNDR string,
AGE string,
AGE_COD string,
GNDR_COD string,
E_SUB string,
WT string,
WT_COD string,
REPT_DT string,
OCCP_COD string,
DEATH_DT string,
TO_MFR string,
CONFID string,
REPORTER_COUNTRY string,
mynull string
)
row format delimited
fields terminated by '$'
stored as textfile
location '/user/$USER/meddata'
;

select * from medevents limit 5;

select REPORTER_COUNTRY , GNDR_COD,  count(*) from medevents
group by REPORTER_COUNTRY, GNDR_COD
order by  REPORTER_COUNTRY, GNDR_COD;

create table medeventsp stored as parquet as select * from medevents;

eoj
