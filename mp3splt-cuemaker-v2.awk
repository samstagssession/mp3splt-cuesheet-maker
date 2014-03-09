#!/usr/bin/awk -f

# todo
#   min >59
# commandline
#   awk -f mp3splt-cuemaker-v2.awk -v mp3file=<mp3file> <trackfile>
# trackfile formats
#   11:22 title
#   11:22 - 33:44 title
#   11:22 - 33:44 -title
#   11:22 - 33:44 - title

BEGIN {
  print "FILE \""mp3file"\" MP3";
}
{
  split($1,time,/:/);
  #shift right if hours empty: 12:34 -> 0:12:34
  if(time[3]==""){
    time[3]=time[2];
    time[2]=time[1];
    time[1]="0";}

  #cut leading tracktime
  title=$0
  sub(/.*:[0-9]+ -? ?/,"",title);
  print "  TRACK " NR " AUDIO\n" \
        "    TITLE " "\""title"\"\n" \
        "    PERFORMER \"\"\n" \
        "    INDEX 01 " time[1]*60+time[2] ":" time[3] ":00"; \
}
