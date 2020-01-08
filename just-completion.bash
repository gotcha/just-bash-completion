#/usr/bin/env bash
_just_completions()
{
  COMPREPLY=($(compgen -W "$(just --summary)" "${COMP_WORDS[${COMP_CWORD}]}"))
}

complete -F _just_completions just

