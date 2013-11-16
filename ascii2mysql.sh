#!/bin/bash

# jeremy.donson@centricdigital.com

# bash script turns ascii file into table, where one line => one row

# process db_setup file if db not present; then process data file

ROW_COUNT=`cat $1 | wc -l`
MAX_CHAR_WIDTH=`cat $1 | wc -L`
MAX_WIDTH_ROW=
CHAR_SET="UTF8"
DELIM=","

# DB_STMNT="mysql -ABN -udbroot -e '${DB_CALL}'"

mysql -ABN -udbroot -e 'CREATE SCHEMA ascii2mysql \
/*!40100 DEFAULT CHARACTER SET UTF8 */'

mysql -ABN -udbroot -e "CREATE TABLE ascii2mysql.${1}( \
line_num unsigned int not null auto_increment primary key, \
line varchar(${MAX_CHAR_WIDTH}) NOT NULL DEFAULT 0) \
ENGINE = InnoDB"

while read -r line
do
    name=$line
	mysql -ABN -udbroot -e "INSERT INTO ${1} VALUES (NULL, $line)"
#    echo "Text read from file - $name"
done < $1



/*
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


