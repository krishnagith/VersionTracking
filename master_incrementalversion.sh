#!/bin/sh
WORKSPACE=$1

git clone git@github.com:krishnagith/VersionTracking.git
git clone git@github.com:krishnagith/Baseversion.git
git clone git@github.com:krishnagith/java-jsp-diary.git

baseversion=`cat ${WORKSPACE}/Baseversion/Baseversion`
versiontracking=`cat ${WORKSPACE}/VersionTracking/Versiontracking`

baserootval=`cat ${WORKSPACE}/Baseversion/Baseversion | cut -d"." -f1`
baserootval2=`cat ${WORKSPACE}/Baseversion/Baseversion | cut -d"." -f2`

versionrootval=`cat ${WORKSPACE}/VersionTracking/Versiontracking | cut -d"." -f1`
versionrootval2=`cat ${WORKSPACE}/VersionTracking/Versiontracking | cut -d"." -f2`
count=`cat ${WORKSPACE}/VersionTracking/Versiontracking | cut -d"." -f3`

echo $baserootval $baserootval2 $versionrootval $versionrootval2 $count

if [ $baserootval -eq $versionrootval ] && [ $baserootval2 -eq  $versionrootval2 ];
then
    
    count=$((count+1));

    echo "count=$count"
    
    
    echo "newversion=$baseversion.$count"  > ${WORKSPACE}/versionupdated.properties
    
else
   echo " base verison is not matched version tracking number"
   count=1
   echo "newversion=$baseversion.$count"  > ${WORKSPACE}/versionupdated.properties

fi
    
cd ${WORKSPACE}/java-jsp-diary/
cp pom.xml backuppom.xml

newversion=`cat ${WORKSPACE}/versionupdated.properties |  cut -d"=" -f2`

versionProject=`/usr/bin/mvn help:evaluate -Dexpression=project.version | tail -7 | head -1`

echo $versionProject

sed -i "s#<version>$versionProject</version>#<version>$newversion</version>#g" pom.xml



