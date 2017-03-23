FROM nginx

MAINTAINER datagridsys.com

# Add version to default index.html
COPY version /tmp/
RUN { echo -n "<h1>Version: "; cat /tmp/version; echo "</h1>"; } > /usr/share/nginx/html/index.html && rm -f /tmp/version


