# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# initialize new terminal (bash, zsh/Mac), script is called in settings.json
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 
# probe whether terminal is opened on Mac with zsh and
# source $HOME/.zshrc for zsh (Mac) or $HOME/.bashrc otherwise
type setopt 2>/dev/null | grep builtin >/dev/null
[ $? = 0 ] && \
    source ~/.zshrc ||
    source ~/.bashrc
# 
# source the project when a new terminal is opened in VSCode
for env in "env.sh" ".env/env.sh"; do
    [ -f "$env" ] && source "$env" && break
done
