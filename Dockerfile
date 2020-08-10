FROM fedora:latest

RUN yum install -y wget pip && \
    pip3 install requests && \
    wget -P /opt/ https://github.com/prometheus/prometheus/releases/download/v2.18.1/prometheus-2.18.1.linux-amd64.tar.gz && \
    tar xf /opt/prometheus-2.18.1.linux-amd64.tar.gz && \
    rm -f /prometheus-2.18.1.linux-amd64/prometheus.yml && \
    yum -y clean all && rm -rf /var/cache/yum/* && rm -rf ~/.cache/pip/*
    
ADD prometheus.yml /prometheus-2.18.1.linux-amd64/
ADD prometheus_data/prom_vol /data
ADD prom_ds.py .
ADD nodefull.json .

RUN dnf -y install https://dl.grafana.com/oss/release/grafana-7.1.1-1.x86_64.rpm

## THE FOLLOWING LINE WAS TAKEN FROM https://github.com/grafana/grafana-docker/blob/master/Dockerfile#L7#L13
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

EXPOSE 9090
RUN chmod +x run.sh

CMD ["./run.sh"]


