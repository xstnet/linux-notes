# 日期提示
week_map=('天' '一' "二" '三' '四', '五' '六')
week_index=$(date +%w)
year_day='20210212'
diff_day=$((($(date +%s -d $year_day) - $(date +%s ))/86400))
echo '-----------------------------------------------------------'
echo -e "| Hello Shantong!                                         |\n| 现在是 $(date +%F) $(date +%T) 星期${week_map[week_index]}, 离过年还有${diff_day}天       |"
echo '-----------------------------------------------------------'

# git 分支显示
function git-branch-name {
      git symbolic-ref --short -q HEAD 2>/dev/null
}
function git-branch-prompt {
      local branch=`git-branch-name`
        if [ $branch ]; then printf " [%s]" $branch; fi
}

# PS1
export PS1="\[\033]0;Bash\007\]\n\[\033[32;1m\]••• \[\033[33;1m\]\u@\w\[\033[31m\]\$(git-branch-prompt)\[\033[37m\] [\t]\n\[\033[32;1m\]➜ \[\033[36m\]"

# ls -l 日期显示
export TIME_STYLE='+%Y-%m-%d %H:%M:%S'

alias gocode='cd /home/code'
alias goprograme='cd /home/programes' 
