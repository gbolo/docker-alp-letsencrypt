#!/bin/bash

#############################################################
## SIMPLE SCRIPT TO RENEW LETSENCRYPT CERTS
## USED WITH: https://hub.docker.com/r/gbolo/alp-letsencrypt/
## AUTHOR: George Bolo <gbolo@linuxctl.com>
#############################################################

#############################################################
## DEFINE THE DEFAULTS
#############################################################
FROM_CONFIG='false';
FORCE_RENEWAL='false';
LETSENCRYPT_BIN=/usr/bin/certbot

#############################################################
## PARSE THE ARGUMENTS PROVIDED BY USER
#############################################################
while getopts "cf" args
do
  case $args in
  c) FROM_CONFIG='true' ;;
  f) FORCE_RENEWAL='true' ;;
  esac
done

#############################################################
## START DEFINING FUNCTIONS
#############################################################
function RENEW_CERTS {
  	## break out of this function if configs specified
	if [[ "$FROM_CONFIG" = "true" ]]; then
		return 1;
	fi
	echo "[INFO] Starting renewal of existing certs";
	if [[ "$FORCE_RENEWAL" = "true" ]]; then
		echo "[WARN] FORCE renewal selected";
		$LETSENCRYPT_BIN renew --force-renewal --standalone --standalone-supported-challenges http-01;
	else
		$LETSENCRYPT_BIN renew --standalone --standalone-supported-challenges http-01;
	fi
}

function RENEW_FROM_CONFIGS {
  	## break out of this function of no configs are specified
	if [[ "$FROM_CONFIG" = "false" ]]; then
		return 1;
	fi

	echo "[INFO] Starting renewal of certs from user defined configs";

	if [[ "$FORCE_RENEWAL" = "true" ]]; then
		for CONF in `ls /config/*.conf`; do
			echo "[WARN] FORCE renewal selected for $CONF";
			$LETSENCRYPT_BIN certonly --force-renewal --agree-tos -c $CONF;
		done
	else
		for CONF in `ls /config/*.conf`; do
			echo "[INFO] working on $CONF";
			$LETSENCRYPT_BIN certonly --keep-until-expiring --agree-tos -c $CONF;
		done
	fi


}

#############################################################
## DEFINE MAIN FUNCTION CODE
#############################################################
function main {

  echo "[INFO] EXECUTION BEGAN: `date`";
  RENEW_FROM_CONFIGS;
  RENEW_CERTS;
  
}

#############################################################
## BOOTSTRAP MAIN CODE
#############################################################
main "$@"
