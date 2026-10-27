# System Color Palette (Warm Obsidian)

## Core Surfaces & Text
| Role | Hex | Usage |
| :--- | :--- | :--- |
| **Base Background (`bg0`)** | `#0b0b0a` | `i3bar`, window titlebars, Alacritty background, `dmenu`, `dunst`, Firefox frame/newtab |
| **Elevated Surface (`bg1`)** | `#141312` | Firefox active tab & navigation toolbar |
| **Primary Text (`fg0`)** | `#c8c4bc` | Terminal text, `i3bar` status values, `dmenu` text, `dunst` normal text |
| **Focused / Bright Text (`fg_bright`)** | `#e6e2da` | Focused window titlebar text, Firefox active tab text, critical notifications |
| **Secondary Active Text (`fg_dim`)** | `#9e9a92` | Active window titlebar text on 2nd monitor (`client.focused_inactive`) |
| **Muted / Inactive Text (`fg_muted`)** | `#78746e` | Unfocused window titlebars, inactive workspaces, Firefox inactive tabs, low-urgency notifications |
| **Subtle Divider (`separator`)** | `#383532` | `i3bar` block separators |

## Functional Focus & Border Hierarchy
| Role | Hex | Usage |
| :--- | :--- | :--- |
| **Focused Active (`focus_red`)** | `#99292d` | Active window border (`client.focused`), focused workspace border, `dmenu` selection highlight, Firefox active tab indicator, critical `dunst` frame |
| **Focused Fill (`focus_red_bg`)** | `#6e1d20` | Focused workspace button background in `i3bar` |
| **Secondary Monitor Active (`mid_blue`)** | `#293f66` | Active window on 2nd monitor (`client.focused_inactive`), active workspace on 2nd monitor, normal `dunst` frame |
| **Unfocused / Inactive (`navy_slate`)** | `#182238` | Unfocused window border (`client.unfocused`), Firefox toolbar/input borders, low-urgency `dunst` frame |
| **Inactive Workspace Border** | `#1a1918` | Inactive workspace button border in `i3bar` |

## Status Bar & Semantic Accents
| Role | Hex | Usage |
| :--- | :--- | :--- |
| **Metric Label (`steel_blue`)** | `#527294` | Conky labels (`DISK`, `RAM`, `CPU`, `GPU`, `WIFI`, `VPN`, `BAT`), `dunst` progress highlight |
| **Positive / Active (`sage_green`)** | `#6e945c` | Conky `TRACK` label, `VPN UP` indicator |
| **Threshold Alert (`alert_red`)** | `#cc3e3e` | Conky high RAM (`>=90%`), high CPU (`>=80%`), high GPU temp (`>=85°C`), low battery (`<20%`) |
| **Urgent Window (`urgent_red`)** | `#cc3e3e` / `#801818` | i3 urgent window & urgent workspace |

## Terminal ANSI Palette (`alacritty.toml`)
| ANSI Color | Normal | Bright | Primary Use in `vim` (`basic.vim`) & `bash` |
| :--- | :--- | :--- | :--- |
| **Black** | `#0b0b0a` | `#57534e` | Background / UI chrome |
| **Red** | `#99292d` | `#cc3e3e` | `BadWhitespace` (`ctermbg=red`), dirty git branch |
| **Green** | `#2ea043` | `#3fb950` | 81-char `ColorColumn` (`ctermbg=green`), clean git branch |
| **Yellow** | `#c99a2e` | `#dfb454` | `LineNr` / `NonText` (`ctermfg=Yellow`), unpushed git branch |
| **Blue** | `#293f66` | `#527294` | Directory listings (`ls --color`) |
| **Magenta** | `#9466a8` | `#ad85bf` | `String` literals in `basic.vim` (`ctermfg=Magenta`) |
| **Cyan** | `#468a87` | `#62aba7` | `Comment` blocks in `basic.vim` (`ctermfg=Cyan`) |
| **White** | `#c8c4bc` | `#e6e2da` | Standard foreground text |
