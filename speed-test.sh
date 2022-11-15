#!/bin/env bash
# 
# lework

#
# cfbsks
# more mirrors

######################################################################################################
# environment configuration
######################################################################################################

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;36m'
PLAIN='\033[0m'

declare -A mirrorsA_com
mirrorsA_com=(
  [opentuna]="https://opentuna.cn/"
  [tencent]="https://mirrors.cloud.tencent.com/"
  [aliyun]="https://mirrors.aliyun.com/"
  [163]="https://mirrors.163.com/"
  [koddos-hk]="https://mirror-hk.koddos.net/"
)

declare -A mirrorsA_edu
mirrorsA_edu=(
  [tsinghua]="https://mirrors.tuna.tsinghua.edu.cn/"
  [ustc]="https://mirrors.ustc.edu.cn/"
  [bit]="https://mirrors.bit.edu.cn/"
  [bfsu]="https://mirrors.bfsu.edu.cn/"
  [nju]="https://mirrors.nju.edu.cn/"
  [cqu]="https://mirrors.cqu.edu.cn/"
  [cnnic]="https://mirrors.cnnic.cn/"
)

declare -A mirrorsB
mirrorsB=(
  [huawei]="https://mirrors.huaweicloud.com/"
  [yun-idc]="https://mirrors.yun-idc.com/"
  [neusoft]="https://mirrors.neusoft.edu.cn/"
  [pubyun]="https://mirrors.pubyun.com/"
  [zju]="https://mirrors.zju.edu.cn/"
)

file="ubuntu/dists/trusty/universe/source/Sources.gz"

######################################################################################################
# function
######################################################################################################

speed_test() {
    local output=$(LANG=C wget --header="$3" -4O /dev/null -T300 "$1" 2>&1)
    local speed=$(printf '%s' "$output" | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')
    local ipaddress=$(printf '%s' "$output" | awk -F'|' '/Connecting to .*\|([^\|]+)\|/ {print $2}'| tail -1)
    local time=$(printf '%s' "$output" | awk -F= '/100% / {print $2}')
    local size=$(printf '%s' "$output" | awk '/Length:/ {s=$3} END {gsub(/\(|\)/,"",s); print s}')
    printf "${YELLOW}%-14s${GREEN}%-20s${BLUE}%-14s${PLAIN}%-20s${RED}%-14s${PLAIN}\n" "$2" "${ipaddress}" "${size}" "${time}" "${speed}" 
}

######################################################################################################
# main 
######################################################################################################

clear
echo -e "\n\n mirrors speed test"

echo -e "\n\n[com]"
echo -e "Test File        : ${YELLOW}${file}${PLAIN}\n"
echo -e "[Mirror Site]"
for mirror in ${!mirrorsA_com[*]}; do
printf "${PLAIN}%-14s${GREEN}%-20s${PLAIN}\n" ${mirror} ":  ${mirrorsA_com[$mirror]}"
done
echo
printf "%-14s%-20s%-14s%-20s%-14s\n" "Site Name" "IPv4 address" "File Size" "Download Time" "Download Speed"
for mirror in ${!mirrorsA_com[*]}; do
  speed_test "${mirrorsA_com[$mirror]}${file}" ${mirror}
done

echo -e "\n\n[edu]"
echo -e "Test File        : ${YELLOW}${file}${PLAIN}\n"
echo -e "[Mirror Site]"
for mirror in ${!mirrorsA_edu[*]}; do
printf "${PLAIN}%-14s${GREEN}%-20s${PLAIN}\n" ${mirror} ":  ${mirrorsA_edu[$mirror]}"
done
echo
printf "%-14s%-20s%-14s%-20s%-14s\n" "Site Name" "IPv4 address" "File Size" "Download Time" "Download Speed"
for mirror in ${!mirrorsA_edu[*]}; do
  speed_test "${mirrorsA_edu[$mirror]}${file}" ${mirror}
done

echo -e "\n\n[backup]"
echo -e "Test File        : ${YELLOW}${file}${PLAIN}\n"
echo -e "[Mirror Site]"
for mirror in ${!mirrorsB[*]}; do
printf "${PLAIN}%-14s${GREEN}%-20s${PLAIN}\n" ${mirror} ":  ${mirrorsB[$mirror]}"
done
echo
printf "%-14s%-20s%-14s%-20s%-14s\n" "Site Name" "IPv4 address" "File Size" "Download Time" "Download Speed"
for mirror in ${!mirrorsB[*]}; do
  speed_test "${mirrorsB[$mirror]}${file}" ${mirror}
done

echo
