#!/bin/awk -f
BEGINFILE { printf "%s", FILENAME }
          { printf "\t%s", $0 }
ENDFILE   { printf "\n" }
