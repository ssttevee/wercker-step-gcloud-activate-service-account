#!/bin/bash

# check for existence of gcloud
if ! which gcloud; then
	echo "could not find gcloud command" 1>&2
	exit 1
fi

# get the key file
if [ -n "$WERCKER_GCLOUD_ACTIVATE_SERVICE_ACCOUNT_KEY" ]; then
	keyfile=$(mktemp)
	echo $"$WERCKER_GCLOUD_ACTIVATE_SERVICE_ACCOUNT_KEY" > "$keyfile"
else
	keyfile="$WERCKER_GCLOUD_ACTIVATE_SERVICE_ACCOUNT_KEYFILE"
fi

# make sure the key file actually exists
if [ ! -e "$keyfile" ]; then
	echo "key file does not exist" 1>&2
	exit 1
fi

gcloud auth activate-service-account --key-file "$keyfile"

export GOOGLE_APPLICATION_CREDENTIALS="$keyfile"
