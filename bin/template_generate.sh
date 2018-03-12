#!/usr/bin/env bash

IN=${IN:-".README.md"}
OUT=${OUT:-"README.md"}

TIMESTAMP=$(date +"%s")
TMP=/tmp/$TIMESTAMP

mkdir -p $TMP

declare -A DATASOURCES

INCLUDED_MODULES=()

# Merge 2 lists (in format words separated be space in string)
function array-merge {
  # Declare an associative array
  declare -A tmp
  # Store the values of arr3 in arr4 as keys.
  for k in $@; do tmp["$k"]=1; done
  # Extract the keys.
  echo "${!tmp[@]}"
}

## Get template modules from $IN file
## Example of usage
## module ./.README.md
function modules {
  grep -Eo '\(datasource ".*?"\)' "$1" |cut -d'"' -f2  | sort -u |  paste -sd " " -
}

## Fire event $1 for all modules passed as args
## Example of usage
## fire event "test" "git" "make"
## Will call functions "git-test" and "make-test" if exists
function fire_event {
  local event=$1
  local modules=${@:2}

  for module in $modules
  do
    func="$module-$event"
    if [ "$(type -t $func)" = 'function' ]; then
      $func
    fi
  done
}

## Provde datasource options for modules passed as args
## Example of usage
## datasources "git" "make"
function datasources {
  for k in $@; do
    echo "--datasource $k=${DATASOURCES[$k]}"
  done
}

## Register modules
for file in $BUILD_HARNESS_PATH/modules/*/template/*.sh ; do
  if [ -f "$file" ] ; then
    . "$file"
  fi
done

## Find used modules in $IN file
MODULES=$(modules $IN)

until [ -z "$MODULES" ]
do
  ## Merge modules list with modules from previous iteration
  INCLUDED_MODULES=$( array-merge $INCLUDED_MODULES $MODULES)
  ## Prepare data for just found modules
  fire_event "template-prepare-data" $MODULES
  ## Replace template
  $GOMPLATE --file $IN --out $OUT $(datasources $INCLUDED_MODULES)

  ## For all iterations (except first) use $OUT file as $IN template to replace recursive placeholders
  IN=$OUT
  ## Find modules in $IN file for next interation.
  MODULES=$(modules $IN)
done

## Cleanup prepared data for all used modules
fire_event "template-cleanup-data" $INCLUDED_MODULES

rm -rf $TMP

echo "$OUT generated"



