
# View iptables configuration/status
# For filter table
sudo iptables -L 
# For nat table
sudo iptables -t nat -L 
# For mangle table 
sudo iptables -t mangle -L 

# Case 1
# Block all incoming and outgoing traffic
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


# For users logged in to remote ssh sessions
# Reject all outgoing network connections
# The second line of the rules only allows current outgoing and established connections
sudo iptables -F OUTPUT
sudo iptables -A OUTPUT -m state --state ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -j REJECT
# Reject all incoming network connections
sudo iptables -F INPUT
sudo iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -j REJECT

# Case 3
# Enable loopback traffic
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT


# Case 4
# Control traffic from Ip address
#Replace Ip address xxx.xxx.xxx.xxx with the ip address
# Block traffic from Ip address
sudo iptables -A INPUT -s xxx.xxx.xxx.xxx -j DROP 
# Allow traffic from Ip address 
sudo iptables -A INPUT -s xxx.xxx.xxx.xxx -j ACCEPT



# Case 5
# Control traffic to an Ip address
# Block traffic to IP address
sudo iptables -A OUTPUT -d xxx.xxx.xxx.xxx -j DROP 

# Case 6
# Limit traffic from specific ports
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
# Using CIDR 
sudo iptables -A OUTPUT -p tcp -d [CIDR Mask Format] --dport www -j REJECT
# Using hostname
sudo iptables -A OUTPUT -d [hostname] -j REJECT

#Reject all incoming ssh traffic except specified IP address range
sudo iptables -A INPUT -t filter -m iprange ! --src-range 10.1.1.90-10.1.1.100  -p tcp --dport 22 -j REJECT

# Case 9
# Blocking connections to a network interface
sudo iptables -A INPUT -i eth0 -s 192.168.0.0/16 -j DROP

# Case 10 
# Preventing pings from outside
sudo iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
# Example - Prevent icmp pings from localhost 127.0.0.1
sudo iptables -A INPUT -s 127.0.0.1 -p icmp -j DROP

# Case 11
# Preventing pings from server 
sudo iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# Save Iptable rules 
sudo /sbin/iptables-save