#!/bin/bash

OS=$(uname -s)

RIEMANN_VERSION="0.2.4"
RIEMANN_BASE_DIR="riemann"
RIEMANN_DIR="${RIEMANN_BASE_DIR}/riemann-${RIEMANN_VERSION}"
RIEMANN="${RIEMANN_DIR}/bin/riemann"
RIEMANN_CONF="${RIEMANN_BASE_DIR}/riemann.config"
if [ ! -d "${RIEMANN_BASE_DIR}/riemann-${RIEMANN_VERSION}" ]
then
    echo "Downloading riemann ..."
    wget "http://aphyr.com/riemann/riemann-${RIEMANN_VERSION}.tar.bz2"
    tar xfj "riemann-${RIEMANN_VERSION}.tar.bz2" -C "${RIEMANN_BASE_DIR}"
    rm -f "riemann-${RIEMANN_VERSION}.tar.bz2"
fi


INFLUXDB_VERSION="0.5.2"
INFLUXDB_DIR="influxdb/build"
INFLUXDB=$(which influxdb 2> /dev/null)
INFLUXDB_DIR="influxdb"
INFLUXDB_CONF="${INFLUXDB_DIR}/influxdb.conf"
# On Mac OSX homebrew takes care of installing influxdb
if [ -z "${INFLUXDB}" -a "Darwin" = "${OS}" ]
then
    echo "Influxdb is not installed. Quitting..."
    exit 1
fi

# But on Linux, I have to do it manually
if [ -z "${INFLUXDB}" -a "Linux" = "${OS}" ]
then
    if [ ! -d "${INFLUXDB_DIR}" ]
    then
        wget "http://s3.amazonaws.com/influxdb/influxdb-${INFLUXDB_VERSION}.amd64.tar.gz"
        tar zxf "influxdb-${INFLUXDB_VERSION}.amd64.tar.gz" -C "influxdb"
        rm -f "influxdb-${INFLUXDB_VERSION}.amd64.tar.gz"
    fi
    INFLUXDB="${INFLUXDB_DIR}/build/influxdb"
    cat "${INFLUXDB_CONF}" | sed "s@assets.*@assets = \"$(pwd)/${INFLUXDB_DIR}/build/admin\"@" \
        > "${INFLUXDB_DIR}/influxdb.conf.linux"
    INFLUXDB_CONF="${INFLUXDB_DIR}/influxdb.conf.linux"
fi

UBER_JAR=$(find "riemann-timeseries" -iname "*-standalone.jar")
