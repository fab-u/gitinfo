# Git info
Just a small script to display if there are uncommitted changes and if the local and the remote repository are in sync.

In my .zshrc i just have
```shell
source ~/path/to/gitinfo.sh

setopt PROMPT_SUBST
PROMPT='%B%F{#00FFFF}%1~ >>%b%f '
RPROMPT='%F{#00FFFF}$(git_info_branch) $(git_info_local) $(git_info_origin)%f'
```

where
- `git_info_branch` is the current branch
- `git_info_local` singals if there are uncommitted changes
- `git_info_origin` signals if the repository is in sync with the remote
