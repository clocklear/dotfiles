# af-magic-shlvl.zsh-theme
# Repo: https://github.com/andyfleming/oh-my-zsh
# Direct Link: https://gist.github.com/clocklear/ba7ea8849d0a36141cd72e356d7e4a8a

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# primary prompt
PROMPT='$FG[237]------------------------------------------------------------%{$reset_color%}
$FG[032]%~\
$(git_prompt_info) \
$FG[105]%(!.#.»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'

# color vars
eval my_gray='$FG[237]'
eval my_orange='$FG[214]'
eval my_red='$FG[160]'

# right prompt
lvl=''
if [ $SHLVL -gt 1 ]; then
  aws=''
  color=$my_orange
  if [ ! -z $AWS_ACCESS_KEY_ID ]; then
    # AWS_ROLE_ARN="$(aws sts get-caller-identity | jq -r .Arn)"
    AWS_ACCOUNT_ALIAS="$(aws iam list-account-aliases | jq -r ".AccountAliases[0]")"
    # aws="aws "
    aws="${AWS_ACCOUNT_ALIAS} "
    if [[ $AWS_ACCOUNT_ALIAS == *"-prod"* ]]; then
      color=$my_red
    fi
  fi
	lvl="$color% ${aws}$my_orange% lvl $SHLVL "
fi
if type "virtualenv_prompt_info" > /dev/null
then
	RPROMPT='$(virtualenv_prompt_info)$lvl$my_gray%n@%m%{$reset_color%}%'
else
	RPROMPT='$lvl$my_gray%n@4%m%{$reset_color%}%'
fi

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"
