#!/usr/bin/env bash
yum -y update --security

declare -A bastion_users=(
    ["user1"]="ssh-rsa AAAA user1"
    ["user2"]="ssh-ed25519 AAAA user2"
)

for bastion_user in "$${!bastion_users[@]}"; do
    adduser -U -m $${bastion_user}
    mkdir -p /home/$${bastion_user}/.ssh
    chown $${bastion_user}:$${bastion_user} /home/$${bastion_user}/.ssh
    chmod 700 /home/$${bastion_user}/.ssh
    touch /home/$${bastion_user}/.ssh/authorized_keys
    echo $${bastion_users[$${bastion_user}]} >> /home/$${bastion_user}/.ssh/authorized_keys
    chown $${bastion_user}:$${bastion_user} /home/$${bastion_user}/.ssh/authorized_keys
    chmod 600 /home/$${bastion_user}/.ssh/authorized_keys
done
