# function types:  file, string, db, log

# count chars in file
function charcount($needle, $filestack) {
return `fgrep -o $needle $filestack | wc -l`;
}

# file typing {binary,text,unreadable}  ??ascii,latin1,
typeset -L30 fmtfile
for file in * ; do
      if read line < $file ; then
           if [[ "$line" = *[!\(TAB)\ -\~]* ]] ; then
                 type=binary
           else
                 type=text
           fi
      else
           type=unreadable
      fi 2> /dev/null
      fmtfile=$file
      echo "$fmtfile is a $type file"
done
exit 0

# event logger => queue?
"CREATE TABLE IF NOT EXISTS ${SCHEMA_NAME}.logger \
event_seq     unsigned int not null auto_increment primary key, \
event_type    ENUM(), \
event_name    VARCHAR(30) NOT NULL DEFAULT 0) \
event_start   TIMESTAMP DEFAULT 0, \
event_outcome VARCHAR(30) NOT NULL DEFAULT 0) \
ENGINE = InnoDB"

"INSERT INTO ${SCHEMA_NAME}.logger VALUES (NULL,'logger setup'...)"
# comment/uncomment@lang:file:line
