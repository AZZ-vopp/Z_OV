#!/bin/bash

read -p "Cài đặt 2 giao thức trojan và vmess, và tạo chứng chỉ? (nhấn Enter để đồng ý, nếu không muốn chọn 'N'): " install_and_certificate
read -p "Block speedtest? (nhấn Enter để đồng ý, nếu không muốn chọn 'N'): " block_speedtest
rm Aiko-Server.sh
wget --no-check-certificate -O Aiko-Server.sh https://raw.githubusercontent.com/AikoPanel/AikoServer/master/install.sh

if bash Aiko-Server.sh; then
    echo -e "\nHoàn tất cài đặt Aiko Server!"
    echo "Chuyển đến mục cấu hình..."
else
    echo -e "\nCó lỗi xảy ra trong quá trình cài đặt Aiko Server. Vui lòng kiểm tra và thử lại."
    exit 1
fi

if [ "$install_and_certificate" == "" ] || [ "${install_and_certificate^^}" == "Y" ]; then
    read -p "ApiHost(bỏ https:// nhé): " api_host
    read -p "ApiKey: " api_key
    read -p "NodeID for V2ray: " node_id_vmess
    read -p "NodeID for Trojan: " node_id_trojan

    cd /etc/Aiko-Server || exit
    rm -f aiko.yml
    rm -f rulelist
# cấu hình cái file aiko.yml chạy theo vmess và trojan
    cat >aiko.yml <<EOF
Nodes:
   -
     PanelType: AikoPanel
     ApiConfig:
       ApiHost: https://$api_host
       ApiKey: $api_key
       NodeID: $node_id_vmess
       NodeType: V2ray
       Timeout: 60
       EnableVless: false
       VlessFlow: "xtls-rprx-vision"
       RuleListPath:
     ControllerConfig:
       DisableLocalREALITYConfig: false
       EnableREALITY: false
       REALITYConfigs:
         Show: true
       CertConfig:
         CertMode: file
         CertFile: /etc/Aiko-Server/cert/aiko_server.cert
         KeyFile: /etc/Aiko-Server/cert/aiko_server.key
   -
     PanelType: AikoPanel
     ApiConfig:
       ApiHost: https://$api_host
       ApiKey: $api_key
       NodeID: $node_id_trojan
       NodeType: Trojan
       Timeout: 60
       EnableVless: false
       VlessFlow: "xtls-rprx-vision"
       RuleListPath:
     ControllerConfig:
       DisableLocalREALITYConfig: false
       EnableREALITY: false
       REALITYConfigs:
         Show: true
       CertConfig:
         CertMode: file
         CertFile: /etc/Aiko-Server/cert/aiko_server.cert
         KeyFile: /etc/Aiko-Server/cert/aiko_server.key
EOF

    # Tạo chứng chỉ để chạy trojan đây nhé
    cd /etc/Aiko-Server || exit
    aiko-server cert
    aiko-server restart
    clear
    echo "Đã cài đặt hoàn tất"
fi

# PPhần block speedtest
if [ "$block_speedtest" == "" ] || [ "${block_speedtest^^}" == "Y" ]; then
    cd /etc/Aiko-Server || exit
    aiko-server blockspeedtest

    clear
    echo -e "\e[1;31mSpeedtest đã bị chặn!\e[0m"
fi

# Khởi động lại aiko-server restart
aiko-server restart
