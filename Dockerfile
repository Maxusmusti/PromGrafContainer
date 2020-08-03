FROM fedora:latest
#FROM alpine:latest
#RUN apk add docker
#RUN rc-update add docker boot
#RUN service docker start
#RUN yum install -y grafana
RUN yum install -y wget
RUN wget -P /opt/ https://github.com/prometheus/prometheus/releases/download/v2.18.1/prometheus-2.18.1.linux-amd64.tar.gz
#RUN cd /opt/
RUN tar xf /opt/prometheus-2.18.1.linux-amd64.tar.gz
RUN rm -f /prometheus-2.18.1.linux-amd64/prometheus.yml
ADD prometheus.yml /prometheus-2.18.1.linux-amd64/
ADD prometheus_data/prom_vol /data

#RUN yum -y update && yum -y install grafana

RUN dnf -y install https://dl.grafana.com/oss/release/grafana-7.1.1-1.x86_64.rpm
ENV PATH=/usr/share/grafana/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    GF_PATHS_CONFIG="/etc/grafana/grafana.ini" \
    GF_PATHS_DATA="/var/lib/grafana" \
    GF_PATHS_HOME="/usr/share/grafana" \
    GF_PATHS_LOGS="/var/log/grafana" \
    GF_PATHS_PLUGINS="/var/lib/grafana/plugins" \
    GF_PATHS_PROVISIONING="/etc/grafana/provisioning"

EXPOSE 3000

WORKDIR /
COPY run.sh .

###RUN rm -f /prometheus-2.18.1.linux-amd64/prometheus.yml
###ADD prometheus.yml /prometheus-2.18.1.linux-amd64/
###ADD prometheus_data/prom_vol .
#RUN ln -s /opt/prometheus-2.18.1.linux-amd64 /opt
#RUN ls -alF /prometheus-2.18.1.linux-amd64/ 
#RUN cd /opt/prometheus
#RUN chown -R prometheus:prometheus /opt/prometheus*
#RUN systemctl status grafana-server
#RUN dnf -y install podman
#RUN podman run -d --name grafana -p 3000:3000 grafana/grafana
#RUN podman pull prom/prometheus
#RUN podman pull grafana/grafana
#CMD ["cd", "/prometheus-2-18-1.linux-amd64"]
EXPOSE 9090
#ENTRYPOINT ["/prometheus-2-18-1.linux-amd64"]
#CMD ["./prometheus"]
#CMD ["ls", "-alF"]
#CMD systemctl start grafana-server && 
RUN chmod +x run.sh

#CMD /prometheus-2.18.1.linux-amd64/prometheus --config.file=/prometheus-2.18.1.linux-amd64/prometheus.yml
CMD ["./run.sh"]

##, "--storage.tsdb.path=/prom_vol"]

