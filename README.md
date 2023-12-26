# Z_OV


```
sudo apt upgrade
```

```
sudo apt update
```

```
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

```
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
```

```
sudo apt install docker-ce
```

```
sudo systemctl status docker
```
lệnh aiko server
```
bash <(curl -Ls https://raw.githubusercontent.com/AZZ-vopp/Z_OV/main/script/aikoserver.sh)
```

```
sudo ufw allow 80/tcp

sudo ufw allow 443/tcp

sudo ufw allow 80

sudo ufw allow 443
```
