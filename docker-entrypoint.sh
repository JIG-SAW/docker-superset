#!/bin/bash
set -eo pipefail
shopt -s nullglob

if [ "$1" = "superset" ]; then
	if [ ! -e ${SUPERSET_HOME}/superset.db ]; then
		if [ -z "$SUPERSET_PASSWORD" ]; then
			echo >&2 'You need to specify of SUPERSET_PASSWORD'
			exit 1
		fi
		SUPERSET_USER=${SUPERSET_USER:-admin}

		fabmanager create-admin \
			--app superset \
			--username ${SUPERSET_USER} \
			--firstname ${SUPERSET_FIRSTNAME:-${SUPERSET_USER}} \
			--lastname ${SUPERSET_LASTNAME:-user} \
			--email ${SUPERSET_EMAIL:-admin@fab.org} \
			--password ${SUPERSET_PASSWORD}

	fi
	superset db upgrade
	superset init
fi

exec "$@"
