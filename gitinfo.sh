#!/bin/zsh

git_info_branch() {
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || echo "")
  echo "$branch"
}

git_info_local() {
  local color_good="#00FF00"
  local color_bad="#FF00FF"
  local branch git_status
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || echo "")
  
  if [ -n "$branch" ]; then
    git_status=$(git status --short 2>/dev/null | wc -l | tr -d ' ')

    if [ "$git_status" -gt 0 ]; then
      sync_status="%F{$color_bad}󰏪%f"  # Dirty repository
    else
      sync_status="%F{$color_good}󰄭%f"  # Clean repository
    fi

    echo "$sync_status"
  fi
}

git_info_origin(){
  local color_good="#00FF00"
  local color_bad="#FF00FF"
  local branch ahead behind
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || echo "")
  
  if [ -n "$branch" ]; then
    ahead=$(git rev-list HEAD..origin/"$branch" --count 2>/dev/null)
    behind=$(git rev-list origin/"$branch"..HEAD --count 2>/dev/null)

    if [ "$ahead" -gt 0 ] && [ "$behind" -gt 0 ]; then
      sync_status+="%F{$color_bad}󰘿%f"  # Diverged
    elif [ "$ahead" -gt 0 ]; then
      sync_status+="%F{$color_bad}󰅢%f"  # Ahead of remote
    elif [ "$behind" -gt 0 ]; then
      sync_status+="%F{$color_bad}󰅧%f"  # Behind remote
    else
		sync_status+="%F{$color_good}󰅠%f"
	fi

    echo "$sync_status"
  fi
}