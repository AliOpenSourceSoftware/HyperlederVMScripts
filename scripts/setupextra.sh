#!/bin/bash

su
cd Downloads
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/12.0.1+12/69cfe15208a647278a19ef0990eea691/jdk-12.0.1_linux-x64_bin.deb
apt install  -y ./jdk-12.0.1_linux-x64_bin.deb
update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk-12.0.1/bin/java" 0
update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk-12.0.1/bin/javac" 0
update-alternatives --install "/usr/bin/jar" "jar" "/usr/lib/jvm/jdk-12.0.1/bin/jar" 0
rm jdk-12.0.1_linux-x64_bin.deb
echo 'JAVA_HOME="/usr/lib/jvm/jdk-12.0.1"' >> /etc/environment
echo  "export PATH=/usr/lib/jvm/jdk-12.0.1/bin:$PATH" >> /etc/profile
source /etc/environment
source /etc/profile
apt install make

groupadd tomcat
usermod -aG tomcat workstation
wget -c http://apache.mirror.vexxhost.com/tomcat/tomcat-9/v9.0.26/bin/apache-tomcat-9.0.26.tar.gz
wget -c http://apache.mirror.gtcomm.net/tomcat/tomcat-8/v8.5.46/bin/apache-tomcat-8.5.46.tar.gz
wget -c http://apache.mirror.gtcomm.net/tomcat/tomcat-7/v7.0.96/bin/apache-tomcat-7.0.96.tar.gz
wget -c http://apache.mirror.rafal.ca/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz

tar -xzvf apache-tomcat-9.0.22.tar.gz -C /opt/apache/apache-tomcat-9.0.26
chown -R workstation:tomcat /opt/apache/apache-tomcat-9.0.26
chmod +x /opt/apache/apache-tomcat-9.0.26/bin/*
tar -xzvf apache-tomcat-9.0.22.tar.gz -C /opt/apache/apache-tomcat-8.5.46.tar.gz
chown -R workstation:tomcat /opt/apache/apache-tomcat-8.5.46.tar.gz
chmod +x /opt/apache/apache-tomcat-8.5.46/bin/*
tar -xzvf apache-tomcat-9.0.22.tar.gz -C /opt/apache/apache-tomcat-7.0.96.tar.gz
chown -R workstation:tomcat /opt/apache/apache-tomcat-7.0.96.tar.gz
chmod +x /opt/apache/apache-tomcat-7.0.96/bin/*
tar -xzvf apache-maven-3.6.2-bin.tar.gz -C /opt/apache/apache-maven-3.6.2
 
echo "export M2_HOME=/opt/apache/apache-maven-3.6.2" >> /etc/profile.d/apache-maven.sh
echo "export MAVEN_HOME=/opt/apache/apache-maven-3.6.2" >> /etc/profile.d/apache-maven.sh
echo "export PATH=/opt/apache/apache-maven-3.6.2/bin:${PATH}" >> /etc/profile


cd $HOME/Downloads
wget http://ftp.jaist.ac.jp/pub/eclipse/technology/epp/downloads/release/2019-03/R/eclipse-java-2019-03-R-linux-gtk-x86_64.tar.gz
tar -zxvf eclipse-java-2019-03-R-linux-gtk-x86_64.tar.gz -C /usr/

rm *.gz

echo "[Desktop Entry]" >> usr/share/applications/eclipse.desktop 
echo "Encoding=UTF-8" >> usr/share/applications/eclipse.desktop
echo "Name=Eclipse IDE" >> usr/share/applications/eclipse.desktop
echo "Comment=Eclipse IDE" >> usr/share/applications/eclipse.desktop
echo "Exec=/usr/bin/eclipse" >> usr/share/applications/eclipse.desktop
echo "Icon=/usr/eclipse/icon.xpm" >> usr/share/applications/eclipse.desktop
echo "Categories=Application;Development;Java;IDE" >> usr/share/applications/eclipse.desktop
echo "Version=4.8" >> usr/share/applications/eclipse.desktop
echo "Type=Application" >> usr/share/applications/eclipse.desktop
echo "Terminal=0" >> usr/share/applications/eclipse.desktop
cd $HYPERLEDGER/fabric
make 
cd $WORKSTATON/fabric
make


