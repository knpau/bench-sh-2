#!/bin/bash
#####################################################################
# Benchmark Script 2 by Hidden Refuge from FreeVPS                  #
# Copyright(C) 2015 - Hidden Refuge                                 #
# License: GNU General Public License 3.0                           #
# Github: https://github.com/hidden-refuge/bench-sh-2               #
#####################################################################
# Original script by akamaras/camarg                                #
# Original: http://www.akamaras.com/linux/linux-server-info-script/ #
# Original Copyright (C) 2011 by akamaras/camarg                    #
#####################################################################
# The speed test was added by dmmcintyre3 from FreeVPS.us as a      #
# modification to the original script.                              #
# Modded Script: https://freevps.us/thread-2252.html                # 
# Copyright (C) 2011 by dmmcintyre3 for the modification            #
#####################################################################
sysinfo () {
	# Reading out system information...
	# Reading CPU model
	cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
	# Reading amount of CPU cores
	cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
	# Reading CPU frequency in MHz
	freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
	# Reading total memory in MB
	tram=$( free -m | awk 'NR==2 {print $2}' )
	# Reading Swap in MB
	vram=$( free -m | awk 'NR==4 {print $2}' )
	# Reading system uptime
	up=$( uptime | awk '{ $1=$2=$(NF-6)=$(NF-5)=$(NF-4)=$(NF-3)=$(NF-2)=$(NF-1)=$NF=""; print }' )
	# Reading operating system and version (simple, didn't filter the strings at the end...)
	opsy=$( cat /etc/issue.net | awk 'NR==1 {print}' ) # Operating System & Version
	arch=$( uname -m ) # Architecture
	lbit=$( getconf LONG_BIT ) # Architecture in Bit
	hn=$( hostname ) # Hostname
	kern=$( uname -r )
	# Output of results
	echo "System Information" | tee bench.log
	echo "------------------" | tee -a bench.log
	echo "Processor: $cname" | tee -a bench.log
	echo "CPU Cores: $cores" | tee -a bench.log
	echo "Frequency: $freq MHz" | tee -a bench.log
	echo "Memory: $tram MB" | tee -a bench.log
	echo "Swap: $vram MB" | tee -a bench.log
	echo "Uptime: $up" | tee -a bench.log
	echo "" | tee -a bench.log
	echo "OS: $opsy" | tee -a bench.log
	echo "Arch: $arch ($lbit Bit)" | tee -a bench.log
	echo "Kernel: $kern" | tee -a bench.log
	echo "Hostname: $hn" | tee -a bench.log
	echo "" | tee -a bench.log
	echo "" | tee -a bench.log
}
speedtest4 () {
	ipiv=$( wget -qO- ipv4.icanhazip.com ) # Getting IPv4
	# Speed test via wget for IPv4 only with 10x 100 MB files. 1 GB bandwidth will be used!
	echo "Speedtest IPv4 only" | tee -a bench.log
	echo "-------------------" | tee -a bench.log
	echo "Your public IPv4 is $ipiv" | tee -a bench.log
	echo "" | tee -a bench.log
	# Cachefly CDN speed test
	echo "CDN - nearest location:" | tee -a bench.log
	cachefly=$( wget -4 -O /dev/null http://cachefly.cachefly.net/100mb.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Cachefly: $cachefly " | tee -a bench.log
	echo "" | tee -a bench.log
	# United States speed test
	echo "America - United States:" | tee -a bench.log
	coloatatl=$( wget -4 -O /dev/null http://speed.atl.coloat.com/100mb.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Coloat, Atlanta, GA: $coloatatl " | tee -a bench.log
	sldltx=$( wget -4 -O /dev/null http://speedtest.dal05.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Softlayer, Dallas, TX: $sldltx " | tee -a bench.log
	slwa=$( wget -4 -O /dev/null http://speedtest.sea01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Softlayer, Seattle, WA: $slwa " | tee -a bench.log
	slsjc=$( wget -4 -O /dev/null http://speedtest.sjc01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Softlayer, San Jose, CA: $slsjc " | tee -a bench.log
	slwdc=$( wget -4 -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Softlayer, Washington, DC: $slwdc " | tee -a bench.log
	echo "" | tee -a bench.log
	# Asia speed test
	echo "Asia:" | tee -a bench.log
	linodejp=$( wget -4 -O /dev/null http://speedtest.tokyo.linode.com/100MB-tokyo.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Linode, Tokyo, Japan: $linodejp " | tee -a bench.log
	slsg=$( wget -4 -O /dev/null http://speedtest.sng01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Softlayer, Singapore: $slsg " | tee -a bench.log
	echo "" | tee -a bench.log 
	# Europe speed test
	echo "Europe:" | tee -a bench.log
	i3d=$( wget -4 -O /dev/null http://mirror.i3d.net/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from i3d.net, Rotterdam, Netherlands: $i3d" | tee -a bench.log
	leaseweb=$( wget -4 -O /dev/null http://mirror.leaseweb.com/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Leaseweb, Haarlem, Netherlands: $leaseweb " | tee -a bench.log
	echo "" | tee -a bench.log
	echo "" | tee -a bench.log
}
speedtest6 () {
	ipvii=$( wget -qO- ipv6.icanhazip.com ) # Getting IPv6
  	# Speed test via wget for IPv6 only with 10x 100 MB files. 1 GB bandwidth will be used! No CDN - Cachefly not IPv6 ready...
  	echo "Speedtest IPv6 only" | tee -a bench.log
  	echo "-------------------" | tee -a bench.log
  	echo "Your public IPv6 is $ipvii" | tee -a bench.log
  	echo "" | tee -a bench.log
  	# United States speed test
  	echo "America - United States:" | tee -a bench.log
	v6atl=$( wget -6 -O /dev/null http://speedtest.atlanta.linode.com/100MB-atlanta.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Linode, Atlanta, GA: $v6atl" | tee -a bench.log
  	v6dal=$( wget -6 -O /dev/null http://speedtest.dallas.linode.com/100MB-dallas.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
  	echo "Download speed from Linode, Dallas, TX: $v6dal" | tee -a bench.log
  	v6new=$( wget -6 -O /dev/null http://speedtest.newark.linode.com/100MB-newark.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
  	echo "Download speed from Linode, Newark, NJ: $v6new" | tee -a bench.log
	v6fre=$( wget -6 -O /dev/null http://speedtest.fremont.linode.com/100MB-fremont.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Linode, Fremont, CA: $v6fre" | tee -a bench.log
  	v6chi=$( wget -6 -O /dev/null http://testfile.chi.steadfast.net/data.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
  	echo "Download speed from Steadfast, Chicago, IL: $v6chi" | tee -a bench.log
	echo "" | tee -a bench.log
	# Asia speed test
	echo "Asia:" | tee -a bench.log
  	v6tok=$( wget -6 -O /dev/null http://speedtest.tokyo.linode.com/100MB-tokyo.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
  	echo "Download speed from Linode, Tokyo, Japan: $v6tok" | tee -a bench.log
  	v6sin=$( wget -6 -O /dev/null http://speedtest.singapore.linode.com/100MB-singapore.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
  	echo "Download speed from Linode, Singapore: $v6sin" | tee -a bench.log
	echo "" | tee -a bench.log
	# Europe speed test
	echo "Europe:" | tee -a bench.log
	v6fra=$( wget -6 -O /dev/null http://speedtest.frankfurt.linode.com/100MB-frankfurt.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Linode, Frankfurt, Germany: $v6fra" | tee -a bench.log
        v6lon=$( wget -6 -O /dev/null http://speedtest.london.linode.com/100MB-london.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
	echo "Download speed from Linode, London, UK: $v6lon" | tee -a bench.log
        v6har=$( wget -6 -O /dev/null http://mirror.nl.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
        echo "Download speed from Leaseweb, Haarlem, Netherlands: $v6har" | tee -a bench.log
	echo "" | tee -a bench.log
	echo "" | tee -a bench.log
}
iotest () {
	# Measuring disk speed with DD
	io=$( ( dd if=/dev/zero of=test_$$ bs=64k count=16k conv=fdatasync && rm -f test_$$ ) 2>&1 | awk -F, '{io=$NF} END { print io}' )
	io2=$( ( dd if=/dev/zero of=test_$$ bs=64k count=16k conv=fdatasync && rm -f test_$$ ) 2>&1 | awk -F, '{io=$NF} END { print io}' )
	io3=$( ( dd if=/dev/zero of=test_$$ bs=64k count=16k conv=fdatasync && rm -f test_$$ ) 2>&1 | awk -F, '{io=$NF} END { print io}' )
	# Output of DD result
	echo "Drive Speed:" | tee -a bench.log
	echo "------------" | tee -a bench.log
	echo "I/O (1st attempt): $io" | tee -a bench.log
	echo "I/O (2nd attempt): $io2" | tee -a bench.log
	echo "I/O (3rd attempt): $io3" | tee -a bench.log
	# Calculating avg I/O (better approach with awk for non int values)
	ioraw=$( echo $io | awk 'NR==1 {print $1}' )
	ioraw2=$( echo $io2 | awk 'NR==1 {print $1}' )
	ioraw3=$( echo $io3 | awk 'NR==1 {print $1}' )
	ioall=$( awk 'BEGIN{print '$ioraw' + '$ioraw2' + '$ioraw3'}' )
	ioavg=$( awk 'BEGIN{print '$ioall'/3}' )
	echo "Average I/O: $ioavg MB/s" | tee -a bench.log
	echo "" | tee -a bench.log
}
gbench () {
	# Improved version of my code by thirthy_speed https://freevps.us/thread-16943-post-191398.html#pid191398
	echo "" | tee -a bench.log
	echo "System Benchmark (Experimental)" | tee -a bench.log
	echo "-------------------------------" | tee -a bench.log
	echo "" | tee -a bench.log
	echo "Note: The benchmark might not always work (eg: missing dependencies)." | tee -a bench.log
	echo "If it's too quick or takes too long it most likely means that the" | tee -a bench.log
	echo "benchmark has failed." | tee -a bench.log
	echo "" | tee -a bench.log
        gb_page=http://www.primatelabs.com/geekbench/download/linux/
        gb_dl=$(wget -qO - $gb_page | \
                 sed -n 's/.*\(https\?:[^:]*\.tar\.gz\).*/\1/p')
        gb_noext=${gb_dl##*/}
        gb_noext=${gb_noext%.tar.gz} 
        gb_name=${gb_noext//-/ }
	echo "File is located at $gb_dl" | tee -a bench.log
	echo "Downloading and extracting $gb_name" | tee -a bench.log
        wget -qO - "$gb_dl" | tar xzv 2>&1 >/dev/null
	echo "" | tee -a bench.log
	echo "Starting $gb_name" | tee -a bench.log
	echo "The system benchmark with Geekbench may take a while." | tee -a bench.log
	echo "Don't close your terminal/SSH session!" | tee -a bench.log
	echo "All output is redirected into a result file." | tee -a bench.log
	sleep 2
	$HOME/dist/$gb_noext/geekbench_x86_32 | tee -a bench.log
	echo "Finished. Removing Geekbench files" | tee -a bench.log
	sleep 1
	rm -rf $HOME/dist/
	echo "" | tee -a bench.log
        gbl=$(sed -n '/following link/,/following link/ {/following link\|^$/b; p}' $HOME/results.txt)
	echo "Benchmark Results: $gbl" | tee -a bench.log
	echo "Full report available at $HOME/results.txt" | tee -a bench.log
	echo "" | tee -a bench.log
}
case $1 in
	'-sysinfo')
		sysinfo;;
	'-io')
		iotest;;
	'-6' )
		sysinfo; speedtest6; iotest;;
	'-46' )
		sysinfo; speedtest4; speedtest6; iotest;;
	'-b' )
		sysinfo; speedtest4; iotest; gbench;;
	'-b6' )
		sysinfo; speedtest6; iotest; gbench;;
	'-b46' )
		sysinfo; speedtest4; speedtest6; iotest; gbench;;
	*)
		sysinfo; speedtest4; iotest;;
esac
#################################################################################
# Contributors									#
#-------------------------------------------------------------------------------#
# thirthy_speed https://freevps.us/thread-16943-post-191398.html#pid191398 	#
#################################################################################
