FROM wavefronthq/proxy

RUN ["/bin/bash", "-c", "sed -i 's/hostname=wavefront-proxy-6jdm7/hostname=REMOVED.com/' /etc/wavefront/wavefront-proxy/wavefront.conf"]
RUN ["/bin/bash", "-c", "sed -i 's/#proxyHost=localhost/proxyHost=REMOVED.com/' /etc/wavefront/wavefront-proxy/wavefront.conf"]
RUN ["/bin/bash", "-c", "sed -i 's/#proxyPort=8080/proxyPort=8000/' /etc/wavefront/wavefront-proxy/wavefront.conf"]
RUN ["/bin/bash", "-c", "cat /etc/wavefront/wavefront-proxy/wavefront.conf | grep proxyHost"]
RUN ["/bin/bash", "-c", "cat /etc/wavefront/wavefront-proxy/wavefront.conf | grep proxyPort"]
RUN ["/bin/bash", "-c", "cat /etc/wavefront/wavefront-proxy/wavefront.conf | grep hostname"]
