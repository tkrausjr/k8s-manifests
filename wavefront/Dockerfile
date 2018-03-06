FROM wavefronthq/proxy

RUN ["/bin/bash", "-c", "sed -i 's/hostname=wavefront-proxy-6jdm7/hostname=tkraus.proxy.tpmlab.vmware.com/' /etc/wavefront/wavefront-proxy/wavefront.conf"]
RUN ["/bin/bash", "-c", "sed -i 's/#proxyHost=localhost/proxyHost=proxy.tpmlab.vmware.com/' /etc/wavefront/wavefront-proxy/wavefront.conf"]
RUN ["/bin/bash", "-c", "sed -i 's/#proxyPort=8080/proxyPort=8888/' /etc/wavefront/wavefront-proxy/wavefront.conf"]
RUN ["/bin/bash", "-c", "cat /etc/wavefront/wavefront-proxy/wavefront.conf | grep proxyHost"]
RUN ["/bin/bash", "-c", "cat /etc/wavefront/wavefront-proxy/wavefront.conf | grep proxyPort"]
UN ["/bin/bash", "-c", "cat /etc/wavefront/wavefront-proxy/wavefront.conf | grep hostname"]
