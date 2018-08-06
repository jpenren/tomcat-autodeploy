#!/bin/sh
trap "echo Shutting down" SIGTERM

# run script in background
/autodeploy.sh $@ &
wait