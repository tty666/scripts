#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#Script programmed by hackendemoniado
#Completion date:16/01/2016
#Details with detailed explanation
#Follow me on my blog http://hackendemoniado.blogspot.com/

#Create the path to save the necessary txt files for the script to work
path_dir=$HOME/network_control
#simple check to know if the folder exists
if [ ! -d $path_dir ]; then
echo "Creating the network_control folder in the home directory "
mkdir $path_dir
#check if the file exists
if [ -f $path_dir/whitelist.txt ];
then
echo "Yes, the allowed hosts file already exists"
else
echo "No, the allowed hosts file does not exist"
echo "creating whitelist.txt....."
echo "00:00:00:00:00:00" >$path_dir/whitelist.txt
cat $path_dir/whitelist.txt
fi
fi
echo "Path: $path_dir"
#We must execute this to test the script and when we know which segments to analyze
#we must comment these lines and uncomment the nmap command below
########............................................########################

echo "To start, enter the IP segment(s) to analyze:"
read ips
#Run nmap on my network; you must change to the segment corresponding to your network #sed '1,4d'
echo "Running nmap on the network: "$ips
nmap -sP $ips > $path_dir/networkcontrol.txt

#if you read carefully, it's simple: comment the previous 4 lines and uncomment the following
#placing your network segment
#nmap -sP 192.168.100.1-255 --exclude 192.168.100.4 > $path_dir/networkcontrol.txt
#search for the MAC of connected hosts
echo "creating the relevant files"
cat $path_dir/networkcontrol.txt | grep Address | cut -c 14-31 | tr -d "()" > $path_dir/hosts.txt
#search for the IP of connected hosts
cat $path_dir/networkcontrol.txt | grep for | cut -c 22-36 | tr -d "()" > $path_dir/ip.txt
#count the number of connected hosts to use in the for loop
host_count=`wc -l $path_dir/hosts.txt | awk '{print $1}'`
#declare a flag to check if at least one intruder exists and then send the mail
flag=0
echo "Searching for MAC addresses"
for ((i=1; i<= $host_count ; i++))
do
#store the host MAC in a variable; this is a loop...
host_mac=`head -$i $path_dir/hosts.txt | tail -1 | cut -c 1-17`
#store the IP of the hosts in another variable
host_ip=`head -$i $path_dir/ip.txt | tail -1 | cut -c 1-15`
#I have a whitelist of allowed MACs in which I must search
search=`grep -ic "$host_mac" $path_dir/whitelist.txt`
#If the search variable is zero, it means an intruder
if [ $search == 0 ];then
#Change the flag because I must send the email to notify
flag=1
#Extract intruder info and save it to a txt
echo $host_mac | nmap -v -A -O $host_ip >> $path_dir/intruderinfo.txt
echo "An intruder was found with MAC Address: "$host_mac "IP: "$host_ip
#end if
fi
#end for
done
#Here I check if the flag is one, meaning there is an intruder
if [ $flag == 1 ];then
#send the email with the attached file containing the extracted information
echo "One or more intruders connected to the network" | mutt -s "NETWORK ACCESS" -a $path_dir/intruderinfo.txt -- sergiosysforence@hotmail.com.ar
#delete the file with the info so it doesn't keep adding repeated info next time
rm -rf $path_dir/intruderinfo.txt
fi
echo ---------End of the script-------------
