#!/bin/bash

# Block Censys IP ranges
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="162.142.125.0/24" reject'
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="167.94.138.0/24" reject'
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="167.94.145.0/24" reject'
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="167.94.146.0/24" reject'
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="167.248.133.0/24" reject'
firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.35.168.0/23" reject'
firewall-cmd --permanent --add-rich-rule='rule family="ipv6" source address="2620:96:e000:b0cc:e::/64" reject'

# Reload the firewall
firewall-cmd --reload
