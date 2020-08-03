FROM fedora:latest
#FROM alpine:latest
RUN yum install -y grafana
RUN yum install -y wget
RUN wget -P /opt/ https://github.com/prometheus/prometheus/releases/download/v2.18.1/prometheus-2.18.1.linux-amd64.tar.gz
RUN tar xf /opt/prometheus-2.18.1.linux-amd64.tar.gz
RUN rm -f /prometheus-2.18.1.linux-amd64/prometheus.yml
ADD prometheus.yml /prometheus-2.18.1.linux-amd64/
ADD prometheus_data/prom_vol /data
#RUN ln -s /opt/prometheus-2.18.1.linux-amd64 /opt
#RUN ls -alF /prometheus-2.18.1.linux-amd64/ 
#RUN cd /opt/prometheus
#RUN chown -R prometheus:prometheus /opt/prometheus*
#RUN systemctl status grafana-server
EXPOSE 9090
EXPOSE 3000
#ENTRYPOINT ["/prometheus-2-18-1.linux-amd64"]
#CMD ["./prometheus"]
#CMD ["ls", "-alF"]
CMD ["/prometheus-2.18.1.linux-amd64/prometheus",  "--config.file=/prometheus-2.18.1.linux-amd64/prometheus.yml", "--storage.tsdb.path=/data"]
