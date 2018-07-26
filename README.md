# tomcat-autodeploy
Deploy .war files to multiple Tomcat instances. This image provide a simple method to deploy the same .war file to multiple Tomcat instances, war file will be deployed using tomcat-manager application (bundled with Tomcat).

# Usage

docker run -d --name tomcat-autodeploy -v $PWD/autodeploy:/autodeploy --network demo jpenren/tomcat-autodeploy tomcat1 tomcat2

Copy war file to ./autodeploy dir to be deployed to tomcat1 and tomcat2 servers

Note: use the same network that Tomcat instances running on Docker

# Environment variables

AUTODEPLOY_DIR=Directory to watch for new files. Default: /autodeploy
TOMCAT_USERNAME=Tomcat username with manager-script role. Default: tomcat
TOMCAT_PASSWORD=Tomcat password. Default: tomcat
TOMCAT_DEPLOY_URL=Url template to Tomcat manager endpoint. Default: http://_host_:8080/manager/text/deploy?path=_path_&update=true

Examples:

docker run -d --name tomcat-autodeploy -v $PWD/autodeploy:/autodeploy --network demo -e TOMCAT_USERNAME=admin -e TOMCAT_PASSWORD=s3cret jpenren/tomcat-autodeploy tomcat1 tomcat2
