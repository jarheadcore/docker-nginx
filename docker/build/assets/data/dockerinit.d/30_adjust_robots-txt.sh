#!/bin/bash
#set -x
ROBOTSTXT=${DOCUMENT_ROOT}/robots.txt

# Disallow spiders on nondev-environemnt
if [ "${RUNTIME_ENVIRONMENT}" != "prod" && "${RUNTIME_ENVIRONMENT}" != "local" ]; then
  echo "User-agent: *" >$ROBOTSTXT
  echo "Disallow: /" >>$ROBOTSTXT

  echo "non-productive '$ROBOTSTXT' written to disallow all spiders."
fi
