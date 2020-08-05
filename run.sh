#!/bin/bash
/prometheus-2.18.1.linux-amd64/prometheus --config.file=/prometheus-2.18.1.linux-amd64/prometheus.yml --storage.tsdb.path=/data </dev/null &>/dev/null &
exec grafana-server                                         \
  --homepath="$GF_PATHS_HOME"                               \
  --config="$GF_PATHS_CONFIG"                               \
  "$@"                                                      \
  cfg:default.log.mode="console"                            \
  cfg:default.paths.data="$GF_PATHS_DATA"                   \
  cfg:default.paths.logs="$GF_PATHS_LOGS"                   \
  cfg:default.paths.plugins="$GF_PATHS_PLUGINS"             \
  cfg:default.paths.provisioning="$GF_PATHS_PROVISIONING"  #&
#sleep 1 && python3 prom_ds.py
#&& python3 prom_ds.py ; python3 prom_ds.py #& python3 prom_ds.py ;
