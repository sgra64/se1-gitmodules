# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# initialize new terminal (bash, zsh/Mac), script is called in settings.json
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# 
# source .rc-file depending on terminal opened with bash or zsh (Mac)
type setopt 2>/dev/null | grep builtin >/dev/null
[ $? = 0 ] && \
    source ~/.zshrc ||
    source ~/.bashrc

# source project with env-file in the new terminal
for env_file in "env.sh" ".env/env.sh"; do
    [ -f "$env_file" ] && source "$env_file" && break
done
