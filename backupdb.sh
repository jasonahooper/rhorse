#!/bin/bash
sqlite3 db/development.sqlite3 ".backup db.`date +%u`.dmp"
