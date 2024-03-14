#!/bin/bash
eval $(ssh-agent)
echo "SSH_AUTH_SOCK ${SSH_AUTH_SOCK}"
git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
cd /tmp
echo "Installing Regula"
curl -o regula_3.2.1_Linux_x86_64.tar.gz -L https://github.com/fugue/regula/releases/download/v3.2.1/regula_3.2.1_Linux_x86_64.tar.gz
tar -xvzf regula_3.2.1_Linux_x86_64.tar.gz
mv regula /usr/bin && rm regula_3.2.1_Linux_x86_64.tar.gz
regula version