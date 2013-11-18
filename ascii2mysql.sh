#!/bin/bash
# bash script turns ascii file into mysql table where each line => one database table row
# jeremy.donson@centricdigital.com

# exec stages: file metadata, functions, includes, settings, db setups,
# file metadata, file load, audit, explode on delim = \n

# includes = functions, data, settings

# if ![[ -r "$1" && -f "$1" ]]; then  # if type = {ascii,utf8,binary,btypes}
if ![[ -r "$1" && -f "$1" ]]; then
    OUTPUT_MESSAGE="Data file named ${1} !(exists + readable).\nTry \$ chmod 700 ${1}"; 
    echo ${OUTPUT_MESSAGE}; exit;
fi

DATA_FILE_NAME="${1}" # named only after file access confirmed
SCHEMA_NAME=`echo "$FILE" | cut -d'.' -f1` # file name => table name
DATA_FILE_EXT=`echo "$FILE" | cut -d'.' -f2` # file name => table name
DATE_STRING=`date "+%Y%m%d"`
TIME_STRING=`date "+%H%M%S"`
TSTAMP_STRING=`date "+%Y%m%d%H%M%S"`
MICROTIME=
ROW_COUNT=`cat ${DATA_FILE_NAME} | wc -l`
FILE_BYTES=`cat ${DATA_FILE_NAME} | wc -c`
FILE_CHARS=`cat ${DATA_FILE_NAME} | wc -m`
FILE_WORDS=`cat ${DATA_FILE_NAME} | wc -w`
LONGEST=`cat filename | awk '{ print length }' | sort -n | tail -1` # find longest line
# awk 'length > max_length { max_length = length; longest_line = $0 } END { print longest_line }' ./text 
MAX_CHAR_WIDTH=`wc -m ${LONGEST}`
CHAR_SET="UTF8"
HORIZONTAL_DELIM="\n"
VERTICAL_DELIM=","

# DB_CALLS[]  # DB_STMNT="mysql -ABN -udbroot -e '${DB_CALL}'"

DB_VERSION_Q="SELECT VERSION()"  # select _rowid


DB_SCHEMA_CALL="CREATE SCHEMA IF NOT EXISTS ${SCHEMA_NAME} \
/*!40100 DEFAULT CHARACTER SET UTF8 */; USE ${SCHEMA_NAME}"

mysql -ABN -udbroot -e "CREATE TABLE IF NOT EXISTS ${SCHEMA_NAME}.${}( \
line_num      unsigned int not null auto_increment primary key, \
ascii_line    varchar(${MAX_CHAR_WIDTH}) NOT NULL DEFAULT 0) \
ENGINE = InnoDB"

# batch
LOAD DATA LOCAL INFILE "${DATA_FILE_NAME}"
INTO TABLE test.hum_assess_comp_keyed
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(page_name, view_date, cookie_id, session_id, session_start_date,view_date_f,sstart_date_f);

# singleton
while read -r line
do
    name=$line
	mysql -ABN -udbroot -e "INSERT INTO temp_${DATE_STRING} VALUES (NULL, $line); SELECT LAST_INSERT_ID() INTO @last_id"
#    echo "Text read from file - $name"
done < $1

# performance

/*

http://stackoverflow.com/questions/5928599/equivalent-of-explode-to-work-with-strings-in-mysql

--  PAGE_NAME,VIEW_DATE,COOKIE_ID,SESSION_ID,SESSION_START_DATE

use csv_schema;

CREATE TABLE hum_assess_completion (
page_name     VARCHAR(100) NOT NULL DEFAULT '0',
view_date     TIMESTAMP NOT NULL,
cookie_id     BIGINT UNSIGNED NOT NULL,
session_id     BIGINT UNSIGNED NOT NULL,
session_start_date     TIMESTAMP NOT NULL 
)
ENGINE = CSV;


CREATE TABLE test.hum_assess_comp_keyed (
intkey        BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
page_name     VARCHAR(100) NOT NULL DEFAULT '0',
view_date      VARCHAR(30) NOT NULL,
cookie_id      VARCHAR(30) NOT NULL,
session_id     VARCHAR(30) NOT NULL,
session_start_date     VARCHAR(30) NOT NULL,
view_date_f    DATE NOT NULL,
sstart_date_f    DATE NOT NULL
)
ENGINE = InnoDB;

LOAD DATA LOCAL INFILE ''
INTO TABLE test.hum_assess_comp_keyed
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(page_name, view_date, cookie_id, session_id, session_start_date,view_date_f,sstart_date_f);


CREATE TABLE test.hum_assess_comp_keyed (
intkey        BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
page_name     VARCHAR(100) NOT NULL DEFAULT '0',
view_date     TIMESTAMP NOT NULL,
cookie_id     BIGINT UNSIGNED NOT NULL,
session_id     BIGINT UNSIGNED NOT NULL,
session_start_date     TIMESTAMP NOT NULL
)
ENGINE = InnoDB;

truncate table hum_assess_comp_keyed;

alter table hum_assess_comp_keyed auto_increment = 0;

*/