#!/bin/bash

OS=$(uname -s)


RIEMANN_VERSION="0.2.5"
RIEMANN_BASE_DIR="riemann"
RIEMANN_DIR="${RIEMANN_BASE_DIR}/riemann-${RIEMANN_VERSION}"
RIEMANN="${RIEMANN_DIR}/bin/riemann"
RIEMANN_CONF="${RIEMANN_BASE_DIR}/riemann.config"


INFLUXDB_VERSION="0.6.1"
INFLUXDB_BUILD_DIR="influxdb/build"
INFLUXDB=$(which influxdb 2> /dev/null)
INFLUXDB_BASE_DIR="influxdb"
INFLUXDB_CONF="${INFLUXDB_BASE_DIR}/influxdb.conf"


UBER_JAR=$(find "riemann-timeseries" -iname "*-standalone.jar")
