#!/bin/sh

if [ "$WAIT_FOR" != "" ]
then
    /usr/local/bin/wait-for.sh -t 600 ${WAIT_FOR}
fi
