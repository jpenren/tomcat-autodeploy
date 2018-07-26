# tomcat-autodeploy
Deploy war files to multiple Tomcat instances 

# Usage
docker run -d --name tomcat-autodeploy -v $PWD/autodeploy:/autodeploy --network demo tomcat-autodeploy tomcat1 tomcat2

Note: use the same network that Tomcat instances
