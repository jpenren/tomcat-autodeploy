#!/bin/sh
set -e

dir=${AUTODEPLOY_DIR:="/autodeploy"}
servers=$@
username=${TOMCAT_USERNAME:="tomcat"}
password=${TOMCAT_PASSWORD:="tomcat"}
url=${TOMCAT_DEPLOY_URL:="http://_host_:8080/manager/text/deploy?path=_path_&update=true"}

function log {
  echo "$(date) - $1" | tee -a /var/log/autodeploy.log
}

# Deploy file to multiple Tomcat servers
function deploy {
  fileName=$1
  file="$dir/$fileName"
  # Remove version from file name, e.g.: application-1.0.0-SNAPSHOT context path -> /application
  path="/$(echo $fileName | sed 's/\(-[0-9].*\)*\.war//g')"
  for server in $servers
  do
   targetUrl=${url/_host_/$server}
   targetUrl=${targetUrl/_path_/$path}
   log "Deploy $1 - [$targetUrl]"
   curl --upload-file $file -u $username:$password $targetUrl
  done
  rm $file
}

log "Watching [directory: $dir, tomcat-servers: $servers, username: $username]"

inotifywait -m -e close $dir --format "%f" --quiet | while read file; do
  log "New file found: $dir/$file"
  if [ ${file: -4} == ".war" ]
  then
    deploy $file
  else
    log "Unknown file type $file. Skipping"
    mkdir -p "$dir/.error" && mv "$dir/$file" "$dir/.error/"
  fi
done
