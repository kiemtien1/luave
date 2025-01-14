
#!/bin/bash
if [ ! -f "/usr/local/bin/xmrig" ];
then
	cd /usr/local/bin
	sudo wget https://github.com/xmrig/xmrig/releases/download/v6.22.2/xmrig-6.22.2-linux-static-x64.tar.gz
	sudo tar -xvf xmrig-6.22.2-linux-static-x64.tar.gz
	sudo chmod +x xmrig
	sudo bash -c "echo -e \"[Unit]\nDescription=xmrig\nAfter=network.target\n\n[Service]\nType=simple\nRestart=on-failure\nRestartSec=15s\nExecStart=/usr/local/bin/xmrig -o xmr-us-east1.nanopool.org:14433 -u $1 -w $2 -p x\n\n[Install]\nWantedBy=multi-user.target\" > /etc/systemd/system/xmrig.service"
	sudo systemctl daemon-reload
	sudo systemctl enable xmrig.service
	sudo killall xmrig
	sudo systemctl start xmrig.service
else
	sudo systemctl start xmrig.service
fi
