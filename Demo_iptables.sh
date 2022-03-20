# sudo - iptables work only with root privileges
# iptables - command line utility

# View iptables configuration/status
# For filter table (-L - list everything)
sudo iptables -L 
# VIEW WITH RULE NUMBER 
sudo iptables -L --line-numbers 
# For nat table
sudo iptables -t nat -L 
# For mangle table 
sudo iptables -t mangle -L 

# Case 1
# Set default policies/Block all incoming and outgoing traffic
# -F - flush/remove/clear all rules
# -P - set default policy 
sudo iptables -F
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT DROP
sudo iptables -P FORWARD DROP

# Case 2 
# Block all incoming traffic 
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
# Block all outgoing traffic 
sudo iptables -P OUTPUT DROP
sudo iptables -P FORWARD DROP


# Case 3
# Enable loopback/localhost traffic
# -i - input interface 
# -o - o/p interface 
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT


# Case 4
# Control traffic from Ip address
#Replace Ip address xxx.xxx.xxx.xxx with the ip address
# -s - source ip
# Block traffic from Ip address
sudo iptables -A INPUT -s xxx.xxx.xxx.xxx -j DROP 
# Allow traffic from Ip address 
sudo iptables -A INPUT -s xxx.xxx.xxx.xxx -j ACCEPT
# example - enable localhost traffic using ip address
sudo iptables -A INPUT -s 127.0.0.1 -j ACCEPT


# Delete a rule in a chain 
sudo iptables -D [chain] [rule number]
sudo iptables -D INPUT 1

# Insert a rule at a position
sudo iptables -I [chain] [position] [rule]
# To insert rule at position 2 in INPUT chain 
sudo iptables -I INPUT 2 -s 202.54.1.2 -j DROP

# Case 5
# Control traffic to an Ip address
# -d - destination ip
# Block traffic to IP address
sudo iptables -A OUTPUT -d xxx.xxx.xxx.xxx -j DROP 

# Case 6
# Limit traffic from specific ports
# -p - protocol
# dport - destination port
# Allow traffic from specific ports
sudo iptables -A INPUT -p tcp --dport [Port number] -j ACCEPT
#To allow HTTP web traffic, enter the following command:
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
#To allow only incoming SSH (Secure Shell) traffic, enter the following:
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
#To allow HTTPS internet traffic, enter the following command:
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
# Block traffic from specific ports
sudo iptables -A INPUT -p tcp --dport [Port number] -j REJECT
#To block only incoming SSH (Secure Shell) traffic, enter the following:
sudo iptables -A INPUT -p tcp --dport 22 -j REJECT


# Case 7
# ACCEPT INCOMING SSH CONNECTIONS FROM SPECIFIC IP ADDRESS
sudo iptables -A INPUT -p tcp -s [ip address] --dport ssh -j ACCEPT
# Deny incoming ssh connections from specific ip address
sudo iptables -A INPUT -p tcp -s [ip address] --dport ssh -j REJECT

# Case 8
# Blocking Outgoing Access to All Web Servers on a Network
# Using hostname
sudo iptables -A OUTPUT -d [hostname] -j REJECT

# Case 9
# Blocking connections to a network interface
sudo iptables -A INPUT -i eth0 -s 192.168.0.0/16 -j DROP

# Case 10 
# Preventing pings to the server 
sudo iptables -A INPUT -p icmp --icmp-type echo-reply -j DROP
# Example - Prevent icmp pings from localhost 127.0.0.1
sudo iptables -A INPUT -s 127.0.0.1 -p icmp -j DROP

# Case 11
# Preventing pings from server 
sudo iptables -A OUTPUT -p icmp --icmp-type echo-request -j DROP

# Save Iptable rules 
sudo /sbin/iptables-save

