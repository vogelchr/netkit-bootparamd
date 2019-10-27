#!/bin/sh

install -v -m755 rpc.bootparamd/bootparamd /usr/local/sbin

[ -f rpc.bootparamd/bootparamd.8.gz ] || gzip -9k rpc.bootparamd/bootparamd.8
install -v -m755 -d /usr/local/share/man/man8
install -v -m644 rpc.bootparamd/bootparamd.8.gz /usr/local/share/man/man8/bootparamd.8.gz

[ -f rpc.bootparamd/bootparams.5.gz ] || gzip -9k rpc.bootparamd/bootparams.5
install -v -m755 -d /usr/local/share/man/man5
install -v -m644 rpc.bootparamd/bootparams.5.gz /usr/local/share/man/man5/bootparams.5.gz

install -v -m644 bootparams.example /etc/bootparams

systemd_reload=0

if [ -f /etc/systemd/system/bootparamd.service ] ; then
    systemd_reload=1
    systemctl stop bootparamd
fi

install -v -m644 bootparamd.service /etc/systemd/system

if [ "$systemd_reload" = "1" ] ; then
    systemctl daemon-reload
fi

systemctl enable bootparamd
systemctl start bootparamd
