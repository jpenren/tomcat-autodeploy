import sys, os, cgi, BaseHTTPServer, SimpleHTTPServer
from BaseHTTPServer import BaseHTTPRequestHandler

IP_ADDRESS='0.0.0.0'
PORT_NUMBER = 8080

servers=sys.argv[1:]
username=os.environ['TOMCAT_USERNAME']
password=os.environ['TOMCAT_PASSWORD']

class HttpHandler(BaseHTTPRequestHandler):
    def do_GET(self):
      self.wfile.write("GET method not allowed!\n")

    def do_POST(self):
        form = cgi.FieldStorage(
            fp=self.rfile,
            headers=self.headers,
            environ={'REQUEST_METHOD':'POST',
                     'CONTENT_TYPE':self.headers['Content-Type'],
                     }) 
        # Store file
        filename = form['file'].filename
        data = form['file'].file.read()
        open("/tmp/%s"%filename, "wb").write(data)

        self.wfile.write("Uploaded %s\n"%filename)
 
        path=filename[:-4]
        # Send file to Tomcat
        for server in servers:
            print "Deploy to server: %s"%server
            cmd="curl --upload-file /tmp/%s -u %s:%s 'http://%s:8080/manager/text/deploy?path=/%s&update=true'"%(filename, username, password, server, path)
            print cmd
            os.system(cmd)

# Main
httpd = BaseHTTPServer.HTTPServer((IP_ADDRESS, PORT_NUMBER), HttpHandler)
print "Server Starts - Port:%s" % (PORT_NUMBER)
try:
    httpd.serve_forever()
except KeyboardInterrupt:
    pass
httpd.server_close()
print "Server Stops"
