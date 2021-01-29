#!/bin/bash

# name: deploy api into API Connect 
# requirement :
#         - jq ( wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 )
#         - curl
#
# #!/bin/bash
# ls -l
# chmod +x bin/jq
# chmod +x scripts/*.sh
# export PATH=$PATH:$(pwd)/bin 

echo "Start: `date`"
SECONDS=0

pwd
. $PWD/apic.properties

if [ ! -d "tmp" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir tmp
fi


ls *-prd.json > tmp/list_draft-products.txt

# Get the access token to access the REST API with user/pwd & Toolkit creds
porg_token=$(curl -sk "https://$ep_pmgmt/api/token" \
 -H 'Accept: application/json' \
 -H 'Cache-Control: no-cache' \
 -H 'Content-Type: application/json' \
 --data-binary "{\"username\":\"${porg_user}\",\"password\":\"${porg_user_password}\",\"realm\":\"provider/${porg_user_realm}\",\"client_id\":\"${toolk_clientid}\",\"client_secret\":\"${toolk_clientsecret}\",\"grant_type\":\"password\"}" | jq .access_token | sed -e s/\"//g  );

retVal=$?
if [ $retVal -ne 0 ] || [ -z "$porg_token" ] ; then
    	echo "Error with login -> $retVal"
	exit 1
fi

echo -------- TOKEN
echo $porg_token
echo --------


for value in $(awk '{print $1}' tmp/list_draft-products.txt); do

  openapi=$(echo $value | sed 's/-prd/-api/g');

  echo --------
  echo Product to be uploaded:
  echo $value
  echo APIs attached
  echo $openapi
  echo --------

  echo ---------
  echo Publish Product
  echo ---------

publish_response=$(curl -sk "https://$ep_pmgmt/api/catalogs/$porg_name/$pcat_name/publish"\
 -H "Accept: application/json"\
 --compressed\
 -H "authorization: Bearer $porg_token"\
 -H "content-type: multipart/form-data"\
 -H "Connection: keep-alive"\
 --form "product=@$value;type=application/json"\
 --form "openapi=@$openapi;type=application/json");
 
echo $publish_response

done

echo "End: `date`"
duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."