#!/bin/ksh

project=$1
state=$2
package=$3
user=$4
password=$5
viewpath=$6
version=`echo $7 | sed -e 's/21.111.61.100\\\\\/SHARE\/deploy\/harvest\/repo//g' | sed -e 's/UD02\\\\\/SHARE\/deploy\/harvest\/repo//g' | sed -e 's/UD03\\\\\/SHARE\/deploy\/harvest\/repo//g'`

cbase=/SHARE/deploy/harvest/repo/NGS
logdir=/APP/deployer/harvest/script/log
DATE=`date +%Y%m%d%H%M%S`

module=`echo $viewpath | awk -F '/' '{ if(NF>3) { print $3 } }'`

files_in_java=`echo $version | awk -v cbase=$cbase '{ return_string="";
  for(i=1;i<=NF;i++) {
    split($i,path_token,";");
    if(index(path_token[1],".class")>0) {
      sub(/\/src\/main\/java\//,"\/classes\/",path_token[1]);
      sub(/\\$.*\.class$/,"\.class",path_token[1]);
      sub(/\.class$/,"$*\.class",path_token[1]);
      sub(/\\$.*\.class$/,"\.class",path_token[1]);
      sub(/\/classes\//,"\/src\/main\/java\/",path_token[1]);
      sub(/\.class$/,"\.java",path_token[1]);
      return_string=return_string path_token[1] " ";
    }
  }
  print substr(return_string,1,length(return_string)-1);
}'`
files_in_class=`echo $version | awk -v cbase=$cbase '{ return_string="";
  for(i=1;i<=NF;i++) {
    split($i,path_token,";");
    if(index(path_token[1],".java")>0) {
      sub(/\/classes\//,"\/src\/main\/java\/",path_token[1]);
      sub(/\/src\/main\/java\//,"\/classes\/",path_token[1]);
      sub(/\.java$/,"\.class",path_token[1]);
      return_string=return_string path_token[1] " ";
      sub(/\.class$/,"$*\.class",path_token[1]);
      return_string=return_string path_token[1] " ";
    }
    else if(index(path_token[1],".class")>0) {
      sub(/\/src\/main\/java\//,"\/classes\/",path_token[1]);
      sub(/\\$.*\.class$/,"\.class",path_token[1]);
      sub(/\.class$/,"$*\.class",path_token[1]);
      return_string=return_string path_token[1] " ";
      sub(/\\$.*\.class$/,"\.class",path_token[1]);
      return_string=return_string path_token[1] " ";
    }
  }
  print substr(return_string,1,length(return_string)-1);
}'`

files_not_java=`echo $version | awk -v cbase=$cbase '{ return_string="";
  for(i=1;i<=NF;i++) {
    split($i,path_token,";");
    if(index(path_token[1],".java")<=0 && index(path_token[1],".class")<=0) {
      if(index(path_token[1],"CFG")>0 || index(path_token[1],"SQL")>0 || index(path_token[1],".dxt")>0) {
        if(index(path_token[1],"src/main/java")>0) {
          sub(/\/src\/main\/java\//,"\/classes\/",path_token[1]);
          return_string=return_string path_token[1] " ";
        } else {
          sub(/\/classes\//,"\/src\/main\/java\/",path_token[1]);
          return_string=return_string path_token[1] " ";
        }
      }
    }
  }
  print substr(return_string,1,length(return_string)-1);
}'`

################# OPTIMIZE ##################
if [ -n "$files_in_java" ]; then
  same_path_in_java=`echo $files_in_java | awk '{ is_same="true"; same_cnt=0; token_cnt=split($1,token,"/"); for(i=2;i<token_cnt;i++) { for(j=2;j<=NF;j++) { token_cnt2=split($j,token2,"/"); if(token[i]!=token2[i]) { is_same="false"; } } if(is_same=="true") { same_cnt++; } else { break; } } return_string=""; for(i=0;i<same_cnt;i++) { return_string=return_string "/" token[i+2]; } print return_string "/"; }'`
fi
if [ -n "$files_in_class" ]; then
  same_path_in_class=`echo $files_in_class | awk '{ is_same="true"; same_cnt=0; token_cnt=split($1,token,"/"); for(i=2;i<token_cnt;i++) { for(j=2;j<=NF;j++) { token_cnt2=split($j,token2,"/"); if(token[i]!=token2[i]) { is_same="false"; } } if(is_same=="true") { same_cnt++; } else { break; } } return_string=""; for(i=0;i<same_cnt&&i<3;i++) { return_string=return_string "/" token[i+2]; } print return_string "/"; }'`
fi
if [ -n "$files_not_java" ]; then
  same_path_not_java=`echo $files_not_java | awk '{ is_same="true"; same_cnt=0; token_cnt=split($1,token,"/"); for(i=2;i<token_cnt;i++) { for(j=2;j<=NF;j++) { token_cnt2=split($j,token2,"/"); if(token[i]!=token2[i]) { is_same="false"; } } if(is_same=="true") { same_cnt++; } else { break; } } return_string=""; for(i=0;i<same_cnt;i++) { return_string=return_string "/" token[i+2]; } print return_string "/"; }'`
fi
#############################################

echo "          "
echo "################### LOG ###################"

if [ -n "$files_in_java" ]; then
  same_path_in_java_for_replace=`echo $same_path_in_java | sed -e 's/\//\\\\\//g'`
  same_path_in_java_for_cp=`echo $same_path_in_java | sed -e 's/\/NGS\///g'`
  files_in_java=`echo $files_in_java | sed -e "s/$same_path_in_java_for_replace//g"`
  same_path_in_java=`echo $same_path_in_java | sed -e "s/NGS/NGS_Deploy/g"`
  echo "Checking In..."
  hci $files_in_java -b IP40 -en $project -st $state -p $package -usr $user -pw $password -wts -o $logdir/$package-hci_j-$DATE.log -de "Sync And Check In" -vp $same_path_in_java -cp $cbase/$same_path_in_java_for_cp -ur -op pc -if ne
  cat $logdir/$package-hci_j-$DATE.log | grep -v '\-\-\-' | grep -v Warning
  #echo "hci $files_in_java -b IP40 -en $project -st $state -p $package -usr $user -pw $password -wts -o $logdir/$package-hci_j-$DATE.log -vp $same_path_in_java -cp $cbase/$same_path_in_java_for_cp -ur -op pc -if ne" >> $logdir/$package-hci_j-$DATE.log
fi

if [ -n "$files_in_class" ]; then
  same_path_in_class_for_replace=`echo $same_path_in_class | sed -e 's/\//\\\\\//g'`
  same_path_in_class_for_cp=`echo $same_path_in_class | sed -e 's/\/NGS\///g'`
  files_in_class=`echo $files_in_class | sed -e "s/$same_path_in_class_for_replace//g"`
  same_path_in_class=`echo $same_path_in_class | sed -e "s/NGS/NGS_Deploy/g"`
  echo "Checking In..."
  hci $files_in_class -b IP40 -en $project -st $state -p $package -usr $user -pw $password -wts -o $logdir/$package-hci_c-$DATE.log -de "Sync And Check In" -vp $same_path_in_class -cp $cbase/$same_path_in_class_for_cp -ur -op pc -if ne
  cat $logdir/$package-hci_c-$DATE.log | grep -v '\-\-\-' | grep -v Warning
  #echo "hci $files_in_class -b IP40 -en $project -st $state -p $package -usr $user -pw $password -wts -o $logdir/$package-hci_c-$DATE.log -vp $same_path_in_class -cp $cbase/$same_path_in_class_for_cp -ur -op pc -if ne" >> $logdir/$package-hci_c-$DATE.log
fi

if [ -n "$files_not_java" ]; then
  same_path_not_java_for_replace=`echo $same_path_not_java | sed -e 's/\//\\\\\//g'`
  same_path_not_java_for_cp=`echo $same_path_not_java | sed -e 's/\/NGS\///g'`
  files_not_java=`echo $files_not_java | sed -e "s/$same_path_not_java_for_replace//g"`
  same_path_not_java=`echo $same_path_not_java | sed -e "s/NGS/NGS_Deploy/g"`
  echo "Checking In..."
  hci $files_not_java -b IP40 -en $project -st $state -p $package -usr $user -pw $password -wts -o $logdir/$package-hci-$DATE.log -de "Sync And Check In" -vp $same_path_not_java -cp $cbase/$same_path_not_java_for_cp -ur -op pc -if ne
  cat $logdir/$package-hci-$DATE.log | grep -v '\-\-\-' | grep -v Warning
  #echo "hci $files_not_java -b IP40 -en $project -st $state -p $package -usr $user -pw $password -wts -o $logdir/$package-hci-$DATE.log -vp $same_path_not_java -cp $cbase/$same_path_not_java_for_cp -ur -op pc -if ne" >> $logdir/$package-hci-$DATE.log
fi

echo "################### END ###################"

exit 0
