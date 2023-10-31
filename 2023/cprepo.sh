TODAY=$(date "+%m/%d").md #mm/dd.md
YESTERDAY=$(date -v -1d "+%m/%d").md

# mkdir if not exits
DIR_NAME=$(date "+%m")
if [ ! -d $DIR_NAME ]; then
  mkdir $DIR_NAME
fi

cp $YESTERDAY $TODAY
code $TODAY # open file with vscode