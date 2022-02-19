#source "C:\Users\Benzaa\AppData\Roaming\nushell\oh-my-min.nu"
#let-env PROMPT_COMMAND = { (get_prompt).left_prompt }
#let-env PROMPT_COMMAND_RIGHT = { (get_prompt).right_prompt }
#let-env PROMPT_INDICATOR_MENU = "? "

def create_left_prompt [] {
    let R = (ansi reset)

    let path_segment = ([
        (ansi { fg: "#BCBCBC" bg: "#3465A4"}) 
        (char space)
        ($nu.cwd | path basename)
        (char space)
        ($R)
    ] | str collect)

    [
        $path_segment
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

#def "nu-complete git branch" [] {
#  [
#    one
#    two
#    three
#    four
#    five
#  ]
#}
#
#def "another" [] {
#  [
#    another
#    three
#  ]
#}
#
#extern "git branch" [
#  branch: string@"nu-complete git branch"
#  another: string@"another"
#]

let $config = {
  filesize_metric: $true
  table_mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
  use_ls_colors: $true
  quick_completions: $true
  color_config: {
    separator: yd
    leading_trailing_space_bg: white
    header: cb
    date: pu
    filesize: ub
    row_index: yb
    hints: dark_gray

    bool: red
    int: green
    duration: red
    range: red
    float: red
    string: red
    nothing: red
    binary: red
    cellpath: red
  }
  use_grid_icons: $true
  footer_mode: always #always, never, number_of_rows, auto
  animate_prompt: $false
  float_precision: 2
  use_ansi_coloring: $true
  filesize_format: "b" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
  env_conversions: {
    "PATH": {
        from_string: { |s| $s | split row (char esep) }
        to_string: { |v| $v | str collect (char esep) }
    }
  }
  edit_mode: vi # emacs, vi
  max_history_size: 10000
  log_level: error
  menu_config: { 
    columns: 4
    col_width: 20   # Optional value. If missing all the screen width is used to calculate this width
    col_padding: 2
    text_style: dark_gray
    selected_text_style: green_reverse
    marker: "| "   
  }
  history_config: { 
    page_size: 10
    selector: ":"   
    text_style: dark_gray
    selected_text_style: green_reverse
    marker: "? "   
  }
  keybindings: [
    {
      name: shells
      modifier: CONTROL
      keycode: Char_t
      mode: vi_insert # emacs vi_normal vi_insert
      event:[ 
          { edit: {cmd: Clear} }
          {
            edit: {
              cmd: InsertString, 
              value: "cd (ls | where type == dir | each {$it.name} | str collect (char nl) | fzf | decode utf-8 | str trim)" 
            }
          }
          { send: Enter }
        ]
    }
  ]
}
