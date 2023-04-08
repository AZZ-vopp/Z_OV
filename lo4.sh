#!/bin/bash

# Block Censys IP ranges
iptables -A INPUT -s 162.142.125.0/24 -j DROP
iptables -A INPUT -s 167.94.138.0/24 -j DROP
iptables -A INPUT -s 167.94.145.0/24 -j DROP
iptables -A INPUT -s 167.94.146.0/24 -j DROP
iptables -A INPUT -s 167.248.133.0/24 -j DROP
iptables -A INPUT -s 192.35.168.0/23 -j DROP
ip6tables -A INPUT -s 2620:96:e000:b0cc:e::/64 -j DROP

# Save the firewall rules
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6
