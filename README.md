IWF-Webserver -- IWF optimized docker images for Nginx/Apache2
==============================================================

The Master branch should not be used.

Create new releases in the releases/* branches.

Currently there are two streams:


releases/NGINX-1.14
releases/APACHE-2.4


New releases on the release branches should be tagged with internal version updates (changes to configuration).

During the Docker Build job the releases are automatically upgraded to the latest Docker Mysql base images (patch releases).

