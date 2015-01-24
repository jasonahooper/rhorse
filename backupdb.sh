#!/bin/bash
echo "Run started: `date`"
~/Dropbox/Personal/RHorse/
sqlite3 /home/jason/rails_projects/rhorse/db/development.sqlite3 ".backup /home/jason//Dropbox/Personal/RHorse/db.`date +%u`.dmp"
echo "Run ended  : `date`"
