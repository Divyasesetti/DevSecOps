#!/bin/bash
Rotation_Type=$1   ###Type of log rotation (size, time)
File_Path=$2       ###log file path
Log_File_Size=`du -b /$File_Path/test.log | tr -s '\t' ' ' | cut -d' ' -f1`       ###log file size in bytes
Max_File_Size=10485760                                                            ###max log file size 10MB
if [[ $Rotation_Type == size ]]
then
   if [[ $Log_File_Size -gt Max_File_Size ]]
   then
   timestamp=`date +%m-%d-%Y`
   mv /$File_Path/test.log /$File_Path/testfile.log.$timestamp
   fi
else
  File_timestamp=`stat -c %y /$File_Path/test.log | awk -F '.' '{print $1}'`      ###timestamp of log file
  perday_timestamp=`date -d "$File_timestamp 1 day" "+%F %T"`                     ###file timestamp + 24 hrs
  if [[ $File_timestamp == $perday_timestamp ]]
  then
    mv $File_Path/test.log /$path_of_file/Test.log.$timestamp
  fi
fi
