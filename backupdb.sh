#!/bin/bash
echo "Run started: `date`"
sqlite3 /home/jason/rails_projects/rhorse/db/development.sqlite3 ".backup /home/jason/rails_projects/rhorse/db.`date +%u`.dmp"
echo "Run ended  : `date`"
