
#! /bin/sh
#Created by Griffin Trull
while getopts ":fl" flag;do
	case $flag in
		f) echo "Downloading SurfShark VPN\nDisabling ipv6 in systcl\nChanging DNS servers to SurfSharks"
			sudo wget https://ocean.surfshark.com/debian/pool/main/s/surfshark-release/surfshark-release_1.0.0-2_amd64.deb
			path=readlink -f  surfshark-release_1.0.0-2_amd64.deb
			sudo dkpg -i $path
			sudo apt-get update
			sudo apt-get install surfshark-vpn
			printf "nameserver 208.67.222.222\n\n\nnameserver 208.67.220.220\n" > /etc/resolv.conf
			sudo chattr -f +i /etc/resolv.conf
			sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
                        sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
			;;
		l) echo "Updating Systcl files"
			printf "%s\\n" "Disable IPv6 with sysctl" 
			sudo sysctl -p 
			sudo surfshark-vpn
			;;
		?) echo "Try Again but with -l or -f"
	esac
done
