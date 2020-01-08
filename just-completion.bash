#/usr/bin/env bash
_just_completions()
{
  local cur

  COMPREPLY=()   # Array variable storing the possible completions.
  cur=${COMP_WORDS[COMP_CWORD]}

  case "$cur" in
    -*)
    COMPREPLY=( $( compgen -W '-e -l -q -v -h -V \
                               --edit --summary --version --verbose \
                               --dry-run --dump --clear-shell-args \
                               --evaluate --highlight --init --list \
                               --no-highlight --quiet --help' -- $cur ) );;
#   Generate the completion matches and load them into $COMPREPLY array.
    *)
    COMPREPLY=($(compgen -W "$(just --summary)" "$cur"));;
  esac

  return 0
}

complete -F _just_completions just
