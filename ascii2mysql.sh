#!/bin/bash

# jeremy.donson@centricdigital.com

# bash script turns ascii file into table, where one line => one row

#  process db_setup file if db not present; then process data file

# DB_STMNT="mysql -ABN -udbroot -e '${DB_CALL}'"

mysql -ABN -udbroot -e 'CREATE SCHEMA ascii2mysql /*!40100 DEFAULT CHARACTER SET UTF8 */'

mysql -ABN -udbroot -e "CREATE TABLE ascii2mysql.${1} \

(line_num unsigned int not null autoprimary  ) \
ENGINE = InnoDB; */"

while read -r line
do
    name=$line

mysql -ABN -udbroot -e 'INSERT INTO '
#    echo "Text read from file - $name"

done < $1



