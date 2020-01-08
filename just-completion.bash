#/usr/bin/env bash
_just_completions()
{
  local cur
  local prev
  local pprev
  local justfile
  local recipes

  COMPREPLY=()   # Array variable storing the possible completions.
  cur=${COMP_WORDS[COMP_CWORD]}
  prev=${COMP_WORDS[COMP_CWORD-1]}
  if (( COMP_CWORD > 1 )); then
    pprev=${COMP_WORDS[COMP_CWORD-2]}
    case "$pprev" in
      --set*)
       COMPREPLY=();
       return 0;;
      -f|--justfile*)
       justfile="${prev/#\~/$HOME}";
    esac
  fi

  if test -z "$justfile"; then
     recipes=$(just --summary 2> /dev/null || true)
  else
     recipes=$(just --justfile "$justfile" --summary)
  fi

  case "$prev" in
    --color )
     COMPREPLY=( $( compgen -W 'auto always never' "$cur"));
     return 0;;
    -d|--working-directory )
     _filedir -d
     return 0;;
    -f|--justfile )
     _filedir
     return 0;;
    -s|--show )
     COMPREPLY=($(compgen -W "$recipes" "$cur"));
     return 0;;
    --set|--shell-arg )
     COMPREPLY=();
     return 0;;
    --shell )
     COMPREPLY=( $( compgen -c "$cur"));
     return 0;;
  esac

  case "$cur" in
    --* )
    COMPREPLY=( $( compgen -W '--edit --summary --version --verbose \
                               --dry-run --dump --clear-shell-args \
                               --evaluate --highlight --init --list \
                               --no-highlight --quiet --help --color \
                               --justfile --set --shell --shell-arg \
                               --show --working-directory \
                              ' -- $cur ) );;
    -* )
    COMPREPLY=( $( compgen -W '-e -l -q -v -h -V -f -s -d -- \
                              ' -- $cur ) );;
    *)
    COMPREPLY=($(compgen -W "$recipes" "$cur"));;
  esac

  return 0
}

complete -F _just_completions just


        # --shell <SHELL>                            Invoke <SHELL> to run recipes [default: sh]
        # --shell-arg <SHELL-ARG>...                 Invoke shell with <SHELL-ARG> as an argument [default: -cu]
