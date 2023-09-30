TODAY=$(date "+%m/%d").md #mm/dd.md
YESTERDAY=$(date -v -1d "+%m/%d").md
cp $YESTERDAY $TODAY
code $TODAY # open file with vscode