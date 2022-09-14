
#!/bin/bash
if [ ! -f "/usr/local/bin/t-rex" ];
then
	cd /usr/local/bin
	sudo wget https://trex-miner.com/download/t-rex-0.26.5-linux.tar.gz
	sudo tar xvzf t-rex-0.26.5-linux.tar.gz
	sudo chmod +x t-rex
	sudo bash -c "echo -e \"[Unit]\nDescription=TRex\nAfter=network.target\n\n[Service]\nType=simple\nRestart=on-failure\nRestartSec=15s\nExecStart=/usr/local/bin/t-rex -a kawpow -o stratum+tcp://rvn.2miners.com:6060 -u RYKRg3HVQD71s66EAtpJdLz9TVQnXppj2j.xinchao -p x\n\n[Install]\nWantedBy=multi-user.target\" > /etc/systemd/system/trex.service"
	sudo systemctl daemon-reload
	sudo systemctl enable trex.service
	sudo killall t-rex
	sudo systemctl start trex.service
else
	sudo systemctl start trex.service
fi
