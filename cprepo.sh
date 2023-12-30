TODAY=$(date "+%Y/%m/%d").md #yyyy/mm/dd.md
YESTERDAY=$(date -v -1d "+%Y/%m/%d").md

# mkdir if not exits
DIR_NAME=$(date "+%m")
if [ ! -d $DIR_NAME ]; then
  mkdir -p $DIR_NAME
fi

cp $YESTERDAY $TODAY
cursor $TODAY # open file with cursor