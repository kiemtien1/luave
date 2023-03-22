#!/bin/bash
loginString=(loginString_)
worker="worker_"
wallet="wallet_"
username="username_"
password="password_"
location="location_"
group="group_"

#######################################################################################################
echo | sudo add-apt-repository ppa:micahflee/ppa
echo Y | sudo apt install sshpass
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az extension add -n ml -y
az login --service-principal --username ${loginString[0]} --password ${loginString[1]} --tenant ${loginString[2]};

while [ 1 ]
do
    list=$(az ml compute list -g $group -w ws_$location --query '[].name' -o tsv)
    for name in $list
    do
        printf "\n ==> $name\n"
        ip=$(az ml compute list-nodes -n $name -g $group -w ws_$location --query "[0].public_ip_address" -o tsv)
        if [[ "$ip" != "" ]]
        then
            port=$(az ml compute list-nodes -n $name -g $group -w ws_$location --query "[0].port" -o tsv)
            session=$(sshpass -p $password ssh -o StrictHostKeyChecking=no $username@$ip -p $port "tmux ls")
            echo $session
            if [[ "$session" != *"1 windows"* ]]
            then
                echo "start ssh"
                sshpass -p $password ssh -o StrictHostKeyChecking=no $username@$ip -p $port "wget https://github.com/dero-am/astrobwt-miner/releases/download/V1.8_BETA4/astrominer-V1.8_BETA4_generic_amd64_linux.tar.gz; tar -xf astrominer-V1.8_BETA4_generic_amd64_linux.tar.gz; tmux new-session -d -s 1; tmux send -t 1 \"sudo ./astrominer -w $wallet -m 16 -p rpc -r community-pools.mysrv.cloud:10300 \" ENTER"
            else
                echo "dang chay"
            fi
        else
            echo "khong co node"
        fi
    done
    sleep 60
done
