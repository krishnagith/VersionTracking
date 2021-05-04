#!/bin/sh
WORKSPACE=$1

baseversion=`cat ${WORKSPACE}/Baseversion/Baseversion`
versiontracking=`cat ${WORKSPACE}/VersionTracking/Versiontracking`

baserootval=`cat ${WORKSPACE}/Baseversion/Baseversion | cut -d"." -f1`
baserootval2=`cat ${WORKSPACE}/Baseversion/Baseversion | cut -d"." -f2`

versiontrackingval=`cat ${WORKSPACE}/VersionTracking/Versiontracking|head -n 1`

echo $baserootval $baserootval2 $versionrootval $versionrootval2 $count

 
   count=1
   echo "newversion=$versiontrackingval-$count"  > ${WORKSPACE}/versionupdated.properties

    
cd ${WORKSPACE}/java-jsp-diary/
cp pom.xml backuppom.xml

newversion=`cat ${WORKSPACE}/versionupdated.properties |  cut -d"=" -f2`

versionProject=`/usr/bin/mvn help:evaluate -Dexpression=project.version | tail -7 | head -1`

echo $versionProject

sed -i "s#<version>$versionProject</version>#<version>$newversion</version>#g" pom.xml
finalversion=`/usr/bin/mvn help:evaluate -Dexpression=project.version | tail -7 | head -1`

echo "Final version to build: $finalversion"



