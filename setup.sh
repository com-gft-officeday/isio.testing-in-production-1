export DOMAIN_NAME='com.gft'
export CUSTOMER_NAME='deuba'
export PROJECT_NAME='unity.release-1'

export DOMAIN="$DOMAIN_NAME"
export CUSTOMER="$DOMAIN.$CUSTOMER_NAME"
export PROJECT="$CUSTOMER.$PROJECT_NAME"

alias droot="docker run -i -t --rm --privileged --pid=host debian nsenter -t 1 -m -u -n -i "
alias dils='docker image ls --filter  "label=PROJECT=$PROJECT"'
alias dcls='docker container ls --filter "label=PROJECT=$PROJECT" '
alias dcr='docker container run --label="PROJECT=$PROJECT" -i -t '
alias dexec='docker container exec -i -t '

alias kctl='kubectl --namespace $PROJECT'
alias ks1='kubectl --namespace step-1'
alias ks2='kubectl --namespace step-2'
alias ks3='kubectl --namespace step-3'
alias ks4='kubectl --namespace step-4'

function split_project() {
    local path="$1" ; shift
    local base="$1" ; shift

    if [[ -z $base ]] ; then base='/mnt/c/Users/tsbo/Projects' ; fi

    path=$(realpath -m --relative-to="$base" "$path" | sed "s%/.*$%%;" )
    # signature domain customer project
    echo "$path" $( echo "$path" |  sed "s%^\(.*\)\.%\1 %; s%^\([^.]*\.[^.]*\)\.%\1 %")
}

function nice_path() {
    local status=$?
    local path="$1" ; shift
    local base="$1" ; shift
    local nice_path=''

    if [[ $path =~ /home/* && -z $base ]] ; then base='/home' ; fi

    if [[ -z $base ]] ; then base='/mnt/c/Users/tsbo/Projects' ; fi

    if [[ $path =~ $base || $path =~ /home/* ]] ; then

        nice_path=$( realpath -m --relative-to="$base" "$path" | sed "s%/%|%; s%^\([^|/]*\)\.%\1|%" )

    else

       	nice_path=$( realpath -m "$path" ) 

    fi

    echo "$nice_path"
    return $status
}

export PS1='\[\e]0;\[\033[00;34m\]$(nice_path "\w")\[\033[00m\] $(if [[ $? == 0 ]]; then echo -en "\[\033[00;32m\]✓\[\033[00m\]"; else echo -en "\[\033[00;31m\]✗\[\033[00m\]"; fi) \$ '
