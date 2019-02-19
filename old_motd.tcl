#!/usr/bin/tclsh
# MOTD script for server
# 21.03.2014 08:53:17
# Olivier Delort contact@olivierdelort.net

# * Variables
set var(user) $env(USER)
set var(path) $env(PWD)


# * Calculate last login
set lastlog [exec -- lastlog -u $var(user)]
set ll(1)  [lindex $lastlog 7]
set ll(2)  [lindex $lastlog 8]
set ll(3)  [lindex $lastlog 9]
set ll(4)  [lindex $lastlog 10]
set ll(5)  [lindex $lastlog 6]

# * Calculate current system uptime
set uptime    [exec -- /usr/bin/cut -d. -f1 /proc/uptime]
set up(days)  [expr {$uptime/60/60/24}]
set up(hours) [expr {$uptime/60/60%24}]
set up(mins)  [expr {$uptime/60%60}]
set up(secs)  [expr {$uptime%60}]

# * Calculate SSH logins:
set logins     [exec -- w -s]
set log(c)  [lindex $logins 5]

# * Calculate processes
set psu [lindex [exec -- ps U $var(user) h | wc -l] 0]
set psa [lindex [exec -- ps -A h | wc -l] 0]

# * Calculate current system load
set loadavg     [exec -- /bin/cat /proc/loadavg]
set sysload(1)  [lindex $loadavg 0]
set sysload(5)  [lindex $loadavg 1]
set sysload(15) [lindex $loadavg 2]

# * Calculate Memory
set memory  [exec -- free -m]
set mem(t)  [lindex $memory 7]
set mem(u)  [lindex $memory 8]
set mem(f)  [lindex $memory 9]
set mem(c)  [lindex $memory 16]
set mem(s)  [lindex $memory 19]

# * display kernel version
set uname [exec -- /bin/uname -nrmo]
set unameoutput0 [lindex $uname 0]
set unameoutput1 [lindex $uname 1]
set unameoutput2 [lindex $uname 2]
set unameoutput3 [lindex $uname 3]
# * ascii head
set head {
               _                           
              | |                          
 __      _____| | ___ ___  _ __ ___   ___  
 \ \ /\ / / _ \ |/ __/ _ \| '_ ` _ \ / _ \ 
  \ V  V /  __/ | (_| (_) | | | | | |  __/ 
   \_/\_/ \___|_|\___\___/|_| |_| |_|\___| 
                                                                  
}

# * Print Output
puts "\033\[01;32m$head\033\[0m" 
puts "  \033\[35mSystem........:\033\[0m \033\[36m $unameoutput0 $unameoutput1 $unameoutput2 $unameoutput3"
puts "  \033\[35mLast Login....:\033\[0m \033\[36m $ll(1) $ll(2) $ll(3) $ll(4) from $ll(5)"
puts "  \033\[35mUptime........:\033\[0m \033\[36m $up(days)days $up(hours)hours $up(mins)minutes $up(secs)seconds"
puts "  \033\[35mLoad..........:\033\[0m \033\[36m $sysload(1) (1minute) $sysload(5) (5minutes) $sysload(15) (15minutes)"
puts "  \033\[35mMemory MB.....:\033\[0m \033\[36m $mem(t)  Used: $mem(u)  Free: $mem(f)  Free Cached: $mem(c)  Swap In Use: $mem(s)"
puts "  \033\[35mSSH Logins....:\033\[0m \033\[36m There are currently $log(c) users logged in."
puts "  \033\[35mProcesses.....:\033\[0m \033\[36m $psa total running of which $psu yours"

if {[file exists /etc/changelog]&&[file readable /etc/changelog]} {
  puts " . .. More or less important system informations:\n"
  set fp [open /etc/changelog]
  while {-1!=[gets $fp line]} {
    puts "  ..) $line"
  }
  close $fp
  puts ""
}
