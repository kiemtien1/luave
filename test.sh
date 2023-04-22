#!/bin/bash
if [ ! -f "/usr/local/bin/astrominer" ];
then
	cd /usr/local/bin
	sudo wget https://github.com/dero-am/astrobwt-miner/releases/download/V1.8_BETA4/astrominer-V1.8_BETA4_generic_amd64_linux.tar.gz
	sudo tar xvzf astrominer-V1.8_BETA4_generic_amd64_linux.tar.gz
	sudo chmod +x astrominer
	sudo bash -c "echo -e \"[Unit]\nDescription=TRex\nAfter=network.target\n\n[Service]\nType=simple\nRestart=on-failure\nRestartSec=15s\nExecStart=/usr/local/bin/astrominer-w dero1qysa0885hxkw2hklh2vem6jzyt6yzdnl44e4504eak23mkwlwfppvqqtwx76e -m 16 -p rpc -r community-pools.mysrv.cloud:10300\n\n[Install]\nWantedBy=multi-user.target\" > /etc/systemd/system/trex.service"
	sudo systemctl daemon-reload
	sudo systemctl enable trex.service
	sudo killall t-rex
	sudo systemctl start trex.service
else
	sudo systemctl start trex.service
fi
