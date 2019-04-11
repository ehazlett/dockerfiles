#!/bin/sh
NET=${NET:-192.168.0.1}

cat << EOF > /etc/dnsmasq.conf
port=0
dhcp-range=${NET},proxy
dhcp-option=vendor:PXEClient,6,2b
dhcp-no-override

#pxe-service=X86PC, "netboot", pxelinux
#pxe-service=X86PC, "netboot", undionly.kpxe
log-queries
log-dhcp

dhcp-userclass=set:ENH,iPXE
pxe-service=tag:!ENH,X86PC, Chainload Boot - iPXE, undionly.kpxe
pxe-service=tag:ENH,X86PC, boot.ipxe - iPXE, boot.ipxe

enable-tftp
tftp-root=/tftp
EOF

cat << EOF > /tftp/pxelinux.cfg/default
default menu.c32
prompt 0
menu title Netboot
  label local
    menu label Boot Disk
    localboot 0

  label terralive
    menu label Terra Live
    kernel /terra/vmlinuz
    initrd /terra/initrd
    append boot=live init=/sbin/init console=tty0

  label terrainstall
    menu label Terra Install
    kernel /terra/vmlinuz
    initrd /terra/initrd
    append boot=live init=/sbin/install console=tty0

  label ubuntu18.10
    menu label Ubuntu 18.10 Installer
EOF

cd /tftp && python -m SimpleHTTPServer 80 &

exec dnsmasq -d -C /etc/dnsmasq.conf
