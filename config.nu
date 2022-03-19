#source "C:\Users\Benzaa\AppData\Roaming\nushell\oh-my-min.nu"
#let-env PROMPT_COMMAND = { (get_prompt).left_prompt }
#let-env PROMPT_COMMAND_RIGHT = { (get_prompt).right_prompt }
#let-env PROMPT_INDICATOR_MENU = "? "

def create_left_prompt [] {
    let R = (ansi reset)

    let path_segment = ([
        (ansi { fg: "#BCBCBC" bg: "#3465A4"}) 
        (char space)
        ($env.PWD | path basename)
        (char space)
        ($R)
    ] | str collect)

    let branch = (do -i { git rev-parse --abbrev-ref HEAD } | str trim)
    let branch_segment = if $branch == "" {
        $branch
    } else {
        [ 
            (ansi { fg: "#BC0000" bg: "#D3D7CF"}) 
            (char space)
            $branch
            (char space)
            ($R)
            (char -u e0b0)     
        ] | str collect
    }

    [
        $path_segment
        $branch_segment
    ] | str collect
}

def create_right_prompt [] {
    let TIME_BG = "#D3D7CF"
    let TERM_FG = "#282C34"
    let R = (ansi reset)

    let time_segment = ([
        (ansi { fg: $TIME_BG bg: $TERM_FG})
        (char -u e0b2)     # 
        (ansi { fg: $TERM_FG bg: $TIME_BG})
        (char space)
        (date now | date format '%m/%d/%Y %I:%M:%S%.3f')
        (char space)
        ($R)
    ] | str collect)

    $time_segment
}

let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = "〉"
let-env PROMPT_INDICATOR_VI_INSERT = ": "
let-env PROMPT_INDICATOR_VI_NORMAL = "〉"
let-env PROMPT_MULTILINE_INDICATOR = "::: "

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running extrnal commands (to_string)
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str collect (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str collect (char esep) }
  }
}

let my_theme = {
  separator: white
  leading_trailing_space_bg: white
  header: green_bold
  date: white
  filesize: white
  row_index: green_bold
  hints: dark_gray
  bool: white
  int: white
  duration: white
  range: white
  float: white
  string: white
  nothing: white
  binary: white
  cellpath: white
}


let $config = {
  filesize_metric: $false
  table_mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
  use_ls_colors: $true
  rm_always_trash: $false
  color_config: $my_theme
  use_grid_icons: $true
  footer_mode: "30" # always, never, number_of_rows, auto
  quick_completions: $true  # set this to $false to prevent auto-selecting completions when only one remains
  animate_prompt: $false # redraw the prompt every second
  float_precision: 2
  use_ansi_coloring: $true
  filesize_format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
  edit_mode: vi # emacs, vi
  max_history_size: 10000
  menu_config: { 
    columns: 10
    #col_width: 20   # Optional value. If missing all the screen width is used to calculate this width
    col_padding: 4
    text_style: dark_gray
    selected_text_style: green_reverse
    marker: "📎"
  }
  history_config: { 
    page_size: 10
    selector: "!"   
    text_style: dark_gray
    selected_text_style: green_reverse
    marker: "🔍"
  }
  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: vi_insert # emacs vi_normal vi_insert
      event: { 
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: completion_previous
      modifier: shift
      keycode: backtab
      mode: vi_insert # emacs vi_normal vi_insert
      event: { send: menuprevious }
    }
    {
      name: history_menu
      modifier: control
      keycode: char_x
      mode: vi_insert # emacs vi_normal vi_insert
      event: { 
        until: [
          { send: menu name: history_menu }
          { send: menupagenext }
        ]
      }
    }
    {
      name: history_previous
      modifier: control
      keycode: char_z
      mode: vi_insert # emacs vi_normal vi_insert
      event: { send: menupageprevious }
    }
  ]
}

# Custom completions for external commands (those outside of Nushell)
# Each completions has two parts: the form of the external command, including its flags and parameters
# and a helper command that knows how to complete values for those flags and parameters
#
# This is a simplified version of completions for git branches and git remotes
def "nu-complete git branches" [] {
  ^git branch | lines | each { |line| $line | str find-replace '\* ' '' | str trim }
}

def "nu-complete git remotes" [] {
  ^git remote | lines | each { |line| $line | str trim }
}

extern "git branch" [
  branch?: string@"nu-complete git branches" # name of the branch to checkout
  -D                                         # force delete the branch
  -d                                         # delete the branch
]

extern "git checkout" [
  branch?: string@"nu-complete git branches" # name of the branch to checkout
  -b: string                                 # create and checkout a new branch
  -B: string                                 # create/reset and checkout a branch
  -l                                         # create reflog for new branch
  --guess                                    # second guess 'git checkout <no-such-branch>' (default)
  --overlay                                  # use overlay mode (default)
  --quiet(-q)                                # suppress progress reporting
  --recurse-submodules: string               # control recursive updating of submodules
  --progress                                 # force progress reporting
  --merge(-m)                                # perform a 3-way merge with the new branch
  --conflict: string                         # conflict style (merge or diff3)
  --detach(-d)                               # detach HEAD at named commit
  --track(-t)                                # set upstream info for new branch
  --force(-f)                                # force checkout (throw away local modifications)
  --orphan: string                           # new unparented branch
  --overwrite-ignore                         # update ignored files (default)
  --ignore-other-worktrees                   # do not check if another worktree is holding the given ref
  --ours(-2)                                 # checkout our version for unmerged files
  --theirs(-3)                               # checkout their version for unmerged files
  --patch(-p)                                # select hunks interactively
  --ignore-skip-worktree-bits                # do not limit pathspecs to sparse entries only
  --pathspec-from-file: string               # read pathspec from file
]

extern "git push" [
  remote?: string@"nu-complete git remotes", # the name of the remote
  refspec?: string@"nu-complete git branches"# the branch / refspec
  --verbose(-v)                              # be more verbose
  --quiet(-q)                                # be more quiet
  --repo: string                             # repository
  --all                                      # push all refs
  --mirror                                   # mirror all refs
  --delete(-d)                               # delete refs
  --tags                                     # push tags (can't be used with --all or --mirror)
  --dry-run(-n)                              # dry run
  --porcelain                                # machine-readable output
  --force(-f)                                # force updates
  --force-with-lease: string                 # require old value of ref to be at this value
  --recurse-submodules: string               # control recursive pushing of submodules
  --thin                                     # use thin pack
  --receive-pack: string                     # receive pack program
  --exec: string                             # receive pack program
  --set-upstream(-u)                         # set upstream for git pull/status
  --progress                                 # force progress reporting
  --prune                                    # prune locally removed refs
  --no-verify                                # bypass pre-push hook
  --follow-tags                              # push missing but relevant tags
  --signed: string                           # GPG sign the push
  --atomic                                   # request atomic transaction on remote side
  --push-option(-o): string                  # option to transmit
  --ipv4(-4)                                 # use IPv4 addresses only
  --ipv6(-6)                                 # use IPv6 addresses only
]
