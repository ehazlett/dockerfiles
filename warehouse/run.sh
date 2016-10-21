#!/bin/bash
BASE_DIR=${BASE_DIR:-/p}
CONFIG_DIR=${CONFIG_DIR:-/config}
PORT=${PORT:-10022}

cat << EOF > $CONFIG_DIR/sshd_config
Port $PORT
Protocol 2
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_dsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key
UsePrivilegeSeparation yes
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
AuthorizedKeysFile	$CONFIG_DIR/authorized_keys
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
ClientAliveInterval 120
ClientAliveCountMax 2
PasswordAuthentication no
EOF

function run() {
    echo " -> creating user"
    usermod -d $CONFIG_DIR git
    usermod -p '*' git
    usermod -U git

    echo " -> setting up host keys"
    # copy host keys to persist
    mkdir -p $CONFIG_DIR/.keys

    for key in $(ls /etc/ssh/ssh_host_*); do
        if [ ! -e $CONFIG_DIR/$(basename $key) ]; then
            cp $key $CONFIG_DIR/$(basename $key)
        fi
    done

    echo " -> setting up projects"
    for project in $(cat $CONFIG_DIR/.projects); do
        if [ ! -e "$BASE_DIR/$project" ]; then
            echo "initializing repository: $project"
            mkdir -p $BASE_DIR/$project
            ln -sf $BASE_DIR/$project $BASE_DIR/$project.git
            pushd $BASE_DIR/$project > /dev/null
            git init --bare
            popd > /dev/null
        fi
    done

    echo " -> updating permissions"
    chown -R git:git $BASE_DIR

    echo " -> starting ssh"
    mkdir -p /var/run/sshd
    /usr/sbin/sshd -f $CONFIG_DIR/sshd_config -D -E /var/log/sshd.log
}

trap run SIGHUP SIGINT

run

sleep infinity

