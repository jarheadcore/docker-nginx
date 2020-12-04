#!/bin/sh

if [ "$WAIT_FOR" != "" ]
then
    # set default
    WAIT_TIMEOUT=${WAIT_TIMEOUT:=600}

    echo -n "  Waiting up to ${WAIT_TIMEOUT} seconds for remote port '${WAIT_FOR}' ..."
    /usr/local/bin/wait-for.sh -t ${WAIT_TIMEOUT} ${WAIT_FOR}
    echo " done."
fi
