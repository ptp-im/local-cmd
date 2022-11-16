#PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
#PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
#PROMPT='${ret_status}%{$fg[cyan]%}%d%{$reset_color%} $(git_prompt_info)'

function dirprompt {
  # Function for abbreviating folder names instead of listing
  # the pwd output.
  #
  # Turns /Users/jaka/some/folder into j/s/folder for a shorter
  # input in the terminal prompt.
  #
  # Takes in the current directory,
  # gets all of the strings ending with a / character,
  # e.g., from /Users/jaka/test it gets Users/ and jaka/.
  #
  # Then, it extracts the match group 1 from the matches,
  # where it matches only the first character in each match,
  # e.g., from /Users it gets U and from jaka/ it gets j.
  #
  # The match gets replaced in the output with the match group 1,
  # meaning that each folder name gets substituted with its initial
  # letter.
  #
  # Since the last folder is not matched by the regex, its
  # full name remains in the output of the prompt.
  #
  # To extract only the last few folders, each regex match
  # gets a newline character at the end of its substitution
  # so that the tail command can then be used.
  #
  # After using the tail command, we join the lines using tr
  # and remove the weird first new line using another tail.
  #
  # After that, we get rid of the weird output for the home directory,
  # and replace // in e.g. //jaka to /, to get e.g. /jaka in the home directory.
  pwd | sed -E 's/(.)([^\/]+)\//\1\/\n/g' | tail -3 | tr -d '\n' | tail | tr -s "//" "/"
}

PROMPT='${ret_status}%{$fg[cyan]%}~$(dirprompt) %{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
