#!/bin/bash
#set -x

if [[ -n ${RUNTIME_ENVIRONMENT} ]]; then

  DATA_PATH=/data/dockerinit.d

  echo -e "\n------------------------------------------------------------"
  echo "$(date): Preparing for environment ${RUNTIME_ENVIRONMENT} ..."
  echo "$(date): Executing startup scripts ..."

  for file in `find "$DATA_PATH" -name "*.sh" -type f | sort -n`
  do
    echo "$(date): Executing script ${file} ..."
    sh ${file}
  done

  echo "$(date): Starting $@ ..."
  exec "$@"

else

  echo "$(date): Variable RUNTIME_ENVIRONMENT must be set. Aborting."
  exit 1

fi
