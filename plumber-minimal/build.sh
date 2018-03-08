#!/bin/sh
set -x

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Expanding busybox supported commands

for command in `busybox | \
	busybox awk -F'[, \t]' '
$0 == "Currently defined functions:"{
	start = 1
} 
start == 1 && $0 != "Currently defined functions:"{
	for(i=1;i<=NF;i++)
		if($i != "") print $i
}'`
do
	busybox ln -s /bin/busybox /bin/${command}
done

find /etc > /old_etc.txt

# Now we have a lot of commands
wget http://home.chpc.utah.edu/~u0875014/ubuntu.tar.gz
tar -xzvf ubuntu.tar.gz

# Ok, now we have ubuntu this time
mkdir /tmp
apt-get update 
apt-get upgrade -y --allow-unauthenticated
apt-get install -y  --allow-unauthenticated git cmake gcc g++ uuid-dev libssl-dev doxygen pkg-config python2.7 libpython2.7-dev libreadline-dev zsh

find /etc > /new_etc.txt

# Let's build plumber at this point
git clone http://github.com/38/plumber.git
cd plumber
O=4 L=3 cmake -DCMAKE_INSTALL_PREFIX=/ -Dbuild_language_pyservlet=no . 
find /bin > before.txt
find /lib >> before.txt
find /lib64 >> before.txt
find /var >> before.txt
make -j 8 install
sh install-prototype.sh
cp misc/script/* /bin/
sed -i 's/\/usr\/bin\/env/\/bin\/env/g' /bin/plumber-*
find /bin > after.txt
find /lib >> after.txt
find /lib64 >> after.txt
find /var >> after.txt

cat before.txt after.txt | sort | uniq -c | awk '$1 == 1{print $2}' > /should_keep.txt


# Finally let's extract the file we need 
mkdir -p /jail 
cd /jail
for file in `cat /should_keep.txt`
do
	install-bin ${file}
done
install-bin busybox

cd /
rm -rf bin boot home lib lib64 opt root run sbin srv usr var plumber
/jail/bin/busybox mv jail/* .
busybox rm -rf jail

for command in `busybox | \
	busybox awk -F'[, \t]' '
$0 == "Currently defined functions:"{
	start = 1
} 
start == 1 && $0 != "Currently defined functions:"{
	for(i=1;i<=NF;i++)
		if($i != "") print $i
}'`
do
	echo "Creating command ${command}"
	busybox ln -s /bin/busybox /bin/${command}
done

rm ubuntu.tar.gz
rm should_keep.txt
rm -rvf `cat /old_etc.txt /new_etc.txt | sort | uniq -c | awk '$1 != 2 { print $2 }'`
rm old_etc.txt new_etc.txt build.sh
