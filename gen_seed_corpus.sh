#!/bin/sh
# Generate seed corpus for flanterm fuzzing.
# Based on the actual escape sequences and features implemented in flanterm.

set -e

D="${1:-seed_corpus}"
mkdir -p "$D"

# ── Control characters (C0) ──
printf '\x00'                          > "$D/c0_nul"
printf '\x07'                          > "$D/c0_bel"
printf '\x08'                          > "$D/c0_bs"
printf '\x09'                          > "$D/c0_ht"
printf '\x0b'                          > "$D/c0_vt"
printf '\x0c'                          > "$D/c0_ff"
printf '\x0d'                          > "$D/c0_cr"
printf '\x0e'                          > "$D/c0_so"
printf '\x0f'                          > "$D/c0_si"
printf '\x7f'                          > "$D/c0_del"
printf '\x18'                          > "$D/c0_can"
printf '\x1a'                          > "$D/c0_sub"

# ── Plain text ──
printf 'Hello, World!\n'              > "$D/text_hello"
printf 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'   > "$D/text_alpha"
printf 'Line1\nLine2\nLine3\n'        > "$D/text_multiline"
printf '\r\n'                          > "$D/text_crlf"

# ── CSI cursor movement ──
printf '\033[A'                        > "$D/csi_cuu"
printf '\033[B'                        > "$D/csi_cud"
printf '\033[C'                        > "$D/csi_cuf"
printf '\033[D'                        > "$D/csi_cub"
printf '\033[5A'                       > "$D/csi_cuu5"
printf '\033[5B'                       > "$D/csi_cud5"
printf '\033[5C'                       > "$D/csi_cuf5"
printf '\033[5D'                       > "$D/csi_cub5"
printf '\033[E'                        > "$D/csi_cnl"
printf '\033[F'                        > "$D/csi_cpl"
printf '\033[3E'                       > "$D/csi_cnl3"
printf '\033[3F'                       > "$D/csi_cpl3"
printf '\033[10G'                      > "$D/csi_hpa"
printf '\033[10`'                      > "$D/csi_hpa_bt"
printf '\033[10d'                      > "$D/csi_vpa"
printf '\033[3e'                       > "$D/csi_vpr"
printf '\033[3a'                       > "$D/csi_hpr"
printf '\033[10;20H'                   > "$D/csi_cup"
printf '\033[10;20f'                   > "$D/csi_hvp"
printf '\033[H'                        > "$D/csi_cup_home"
printf '\033[;H'                       > "$D/csi_cup_home2"

# ── CSI erase ──
printf '\033[J'                        > "$D/csi_ed0"
printf '\033[0J'                       > "$D/csi_ed0_explicit"
printf '\033[1J'                       > "$D/csi_ed1"
printf '\033[2J'                       > "$D/csi_ed2"
printf '\033[3J'                       > "$D/csi_ed3"
printf '\033[K'                        > "$D/csi_el0"
printf '\033[0K'                       > "$D/csi_el0_explicit"
printf '\033[1K'                       > "$D/csi_el1"
printf '\033[2K'                       > "$D/csi_el2"
printf '\033[5X'                       > "$D/csi_ech"
printf '\033[3P'                       > "$D/csi_dch"
printf '\033[3@'                       > "$D/csi_ich"

# ── CSI insert/delete lines ──
printf '\033[L'                        > "$D/csi_il"
printf '\033[3L'                       > "$D/csi_il3"
printf '\033[M'                        > "$D/csi_dl"
printf '\033[3M'                       > "$D/csi_dl3"

# ── CSI scroll ──
printf '\033[S'                        > "$D/csi_su"
printf '\033[3S'                       > "$D/csi_su3"
printf '\033[T'                        > "$D/csi_sd"
printf '\033[3T'                       > "$D/csi_sd3"

# ── CSI repeat ──
printf '\033[5b'                       > "$D/csi_rep"
printf 'X\033[10b'                     > "$D/csi_rep_x"

# ── CSI save/restore cursor ──
printf '\033[s'                        > "$D/csi_scp"
printf '\033[u'                        > "$D/csi_rcp"
printf '\033[s\033[10;10H\033[u'       > "$D/csi_save_restore"

# ── CSI device/status ──
printf '\033[c'                        > "$D/csi_da"
printf '\033[5n'                       > "$D/csi_dsr_status"
printf '\033[6n'                       > "$D/csi_dsr_pos"
printf '\033[q'                        > "$D/csi_decll"
printf '\033[1q'                       > "$D/csi_decll1"
printf '\033[2q'                       > "$D/csi_decll2"
printf '\033[3q'                       > "$D/csi_decll3"

# ── CSI scroll region ──
printf '\033[r'                        > "$D/csi_decstbm_default"
printf '\033[5;20r'                    > "$D/csi_decstbm"
printf '\033[1;10r'                    > "$D/csi_decstbm_top"
printf '\033[5;20r\033[3S'             > "$D/csi_region_scroll"
printf '\033[5;20r\033[L'              > "$D/csi_region_insert"
printf '\033[5;20r\033[M'              > "$D/csi_region_delete"

# ── CSI mode set/reset ──
printf '\033[4h'                       > "$D/csi_irm_set"
printf '\033[4l'                       > "$D/csi_irm_reset"

# ── CSI DEC private modes ──
printf '\033[?6h'                      > "$D/dec_decom_set"
printf '\033[?6l'                      > "$D/dec_decom_reset"
printf '\033[?7h'                      > "$D/dec_decawm_set"
printf '\033[?7l'                      > "$D/dec_decawm_reset"
printf '\033[?25h'                     > "$D/dec_dectcem_show"
printf '\033[?25l'                     > "$D/dec_dectcem_hide"
printf '\033[?1049h'                   > "$D/dec_altscreen_on"
printf '\033[?1049l'                   > "$D/dec_altscreen_off"

# ── SGR (Select Graphic Rendition) ──
printf '\033[m'                        > "$D/sgr_empty"
printf '\033[0m'                       > "$D/sgr_reset"
printf '\033[1m'                       > "$D/sgr_bold"
printf '\033[5m'                       > "$D/sgr_blink"
printf '\033[7m'                       > "$D/sgr_reverse"
printf '\033[22m'                      > "$D/sgr_unbold"
printf '\033[25m'                      > "$D/sgr_unblink"
printf '\033[27m'                      > "$D/sgr_unreverse"
printf '\033[2m'                       > "$D/sgr_dim_ignored"
printf '\033[3m'                       > "$D/sgr_italic_ignored"
printf '\033[4m'                       > "$D/sgr_underline_ignored"
printf '\033[8m'                       > "$D/sgr_hidden_ignored"
printf '\033[23m'                      > "$D/sgr_no_italic_ignored"
printf '\033[24m'                      > "$D/sgr_no_underline_ignored"
printf '\033[28m'                      > "$D/sgr_no_hidden_ignored"

# SGR foreground colors
printf '\033[30m'                      > "$D/sgr_fg_black"
printf '\033[31m'                      > "$D/sgr_fg_red"
printf '\033[32m'                      > "$D/sgr_fg_green"
printf '\033[33m'                      > "$D/sgr_fg_yellow"
printf '\033[34m'                      > "$D/sgr_fg_blue"
printf '\033[35m'                      > "$D/sgr_fg_magenta"
printf '\033[36m'                      > "$D/sgr_fg_cyan"
printf '\033[37m'                      > "$D/sgr_fg_white"
printf '\033[39m'                      > "$D/sgr_fg_default"

# SGR background colors
printf '\033[40m'                      > "$D/sgr_bg_black"
printf '\033[41m'                      > "$D/sgr_bg_red"
printf '\033[42m'                      > "$D/sgr_bg_green"
printf '\033[47m'                      > "$D/sgr_bg_white"
printf '\033[49m'                      > "$D/sgr_bg_default"

# SGR bright colors
printf '\033[90m'                      > "$D/sgr_fg_bright_black"
printf '\033[91m'                      > "$D/sgr_fg_bright_red"
printf '\033[97m'                      > "$D/sgr_fg_bright_white"
printf '\033[100m'                     > "$D/sgr_bg_bright_black"
printf '\033[107m'                     > "$D/sgr_bg_bright_white"

# SGR 256-color
printf '\033[38;5;0m'                  > "$D/sgr_256_fg_0"
printf '\033[38;5;7m'                  > "$D/sgr_256_fg_7"
printf '\033[38;5;8m'                  > "$D/sgr_256_fg_8"
printf '\033[38;5;15m'                 > "$D/sgr_256_fg_15"
printf '\033[38;5;16m'                 > "$D/sgr_256_fg_16"
printf '\033[38;5;196m'               > "$D/sgr_256_fg_196"
printf '\033[38;5;255m'               > "$D/sgr_256_fg_255"
printf '\033[48;5;82m'                > "$D/sgr_256_bg_82"

# SGR truecolor (24-bit)
printf '\033[38;2;255;128;0m'         > "$D/sgr_rgb_fg"
printf '\033[48;2;0;64;128m'          > "$D/sgr_rgb_bg"
printf '\033[38;2;255;255;255m'       > "$D/sgr_rgb_fg_white"
printf '\033[48;2;0;0;0m'             > "$D/sgr_rgb_bg_black"

# SGR combined
printf '\033[1;31;42m'                > "$D/sgr_combined"
printf '\033[0;1;5;7;38;5;196;48;2;0;0;0m' > "$D/sgr_everything"

# ── ESC sequences ──
printf '\0337'                         > "$D/esc_decsc"
printf '\0338'                         > "$D/esc_decrc"
printf '\0337\033[10;10H\0338'         > "$D/esc_save_restore"
printf '\033c'                         > "$D/esc_ris"
printf '\033D'                         > "$D/esc_ind"
printf '\033E'                         > "$D/esc_nel"
printf '\033M'                         > "$D/esc_ri"
printf '\033Z'                         > "$D/esc_decid"

# ── Character set selection ──
printf '\033(B'                        > "$D/charset_g0_ascii"
printf '\033(0'                        > "$D/charset_g0_dec"
printf '\033)B'                        > "$D/charset_g1_ascii"
printf '\033)0'                        > "$D/charset_g1_dec"

# DEC Special Graphics drawing
printf '\033(0lqqqqqqqqk\n'            > "$D/dec_box_top"
printf '\033(0x        x\n'            > "$D/dec_box_mid"
printf '\033(0mqqqqqqqqj\n'            > "$D/dec_box_bot"
printf '\033(0lqqqwqqqk\nx   x   x\nmqqqvqqqj\033(B\n' > "$D/dec_box_full"
printf '\033(0`afgjklmnopqrstuvwxyz{|}~\033(B' > "$D/dec_all_specials"

# Shift in/out for charsets
printf '\033)0\x0eabc\x0fdef'          > "$D/charset_shift"

# ── OSC sequences ──
printf '\033]0;Window Title\x07'       > "$D/osc_title_bel"
printf '\033]0;Window Title\033\\'     > "$D/osc_title_st"
printf '\033]2;Another Title\x07'      > "$D/osc_title2"
printf '\033]\x07'                     > "$D/osc_empty"
printf '\033]0;%s\x07' "$(printf 'A%.0s' $(seq 1 200))" > "$D/osc_long"

# ── Linux private sequences ──
printf '\033[]'                        > "$D/linux_private"

# ── UTF-8 sequences ──
printf '\xc3\xa9'                      > "$D/utf8_2byte"
printf '\xe2\x80\x93'                  > "$D/utf8_3byte_endash"
printf '\xe2\x94\x80'                  > "$D/utf8_3byte_boxdraw"
printf '\xf0\x9f\x98\x80'             > "$D/utf8_4byte_emoji"
printf '\xc2\x80'                      > "$D/utf8_2byte_min"
printf '\xdf\xbf'                      > "$D/utf8_2byte_max"
printf '\xe0\xa0\x80'                  > "$D/utf8_3byte_min"
printf '\xef\xbf\xbf'                 > "$D/utf8_3byte_max"
printf '\xf0\x90\x80\x80'             > "$D/utf8_4byte_min"
printf '\xf4\x8f\xbf\xbf'             > "$D/utf8_4byte_max"

# Wide characters (CJK)
printf '\xe4\xb8\xad\xe6\x96\x87'     > "$D/utf8_cjk"
printf '\xef\xbc\xa1'                  > "$D/utf8_fullwidth_a"

# Invalid UTF-8
printf '\x80'                          > "$D/utf8_invalid_continuation"
printf '\xc0\x80'                      > "$D/utf8_overlong_nul"
printf '\xfe'                          > "$D/utf8_invalid_lead"
printf '\xff'                          > "$D/utf8_invalid_0xff"
printf '\xc3'                          > "$D/utf8_truncated_2byte"
printf '\xe2\x94'                      > "$D/utf8_truncated_3byte"
printf '\xf0\x9f\x98'                  > "$D/utf8_truncated_4byte"
printf '\xed\xa0\x80'                  > "$D/utf8_surrogate"

# ── Edge cases / boundary conditions ──
printf '\033[999;999H'                 > "$D/edge_huge_cursor"
printf '\033[0;0H'                     > "$D/edge_zero_pos"
printf '\033[9999999A'                 > "$D/edge_huge_cuu"
printf '\033[0A'                       > "$D/edge_zero_cuu"
printf '\033[65535b'                   > "$D/edge_max_rep"

# Many CSI params (max 16)
printf '\033[1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16m' > "$D/edge_max_params"
printf '\033[1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18m' > "$D/edge_overflow_params"

# Empty/malformed CSI
printf '\033['                         > "$D/edge_csi_incomplete"
printf '\033[;m'                       > "$D/edge_csi_empty_param"
printf '\033[;;;m'                     > "$D/edge_csi_multi_empty"
printf '\033[?'                        > "$D/edge_dec_incomplete"

# CAN/SUB abort during sequence
printf '\033[1\x18'                    > "$D/edge_can_abort"
printf '\033[1\x1a'                    > "$D/edge_sub_abort"

# Control chars inside CSI
printf '\033[\x07m'                    > "$D/edge_bel_in_csi"
printf '\033[\x08m'                    > "$D/edge_bs_in_csi"
printf '\033[\x09m'                    > "$D/edge_ht_in_csi"
printf '\033[\x0dm'                    > "$D/edge_cr_in_csi"

# Rapid state changes
printf '\033[?7h\033[?7l\033[?7h'      > "$D/edge_toggle_wrap"
printf '\033[?25h\033[?25l\033[?25h'   > "$D/edge_toggle_cursor"

# Scroll region edge cases
printf '\033[0;0r'                     > "$D/edge_region_zero"
printf '\033[1;1r'                     > "$D/edge_region_same"
printf '\033[999;999r'                 > "$D/edge_region_huge"

# Origin mode + scroll region interaction
printf '\033[5;20r\033[?6h\033[H'      > "$D/edge_origin_home"
printf '\033[5;20r\033[?6h\033[999;999H' > "$D/edge_origin_clamp"

# Insert mode with text
printf '\033[4hHello\033[3DWorld\033[4l' > "$D/edge_insert_mode"

# ── Realistic combined sequences ──
printf '\033[2J\033[H'                 > "$D/combo_clear_home"
printf '\033[2J\033[H\033[1;31mERROR\033[0m: failed\n' > "$D/combo_error_msg"
printf '\033[s\033[999;999H\033[6n\033[u' > "$D/combo_query_size"
printf '\r\033[K[####------] 40%%'     > "$D/combo_progress"
printf '\033[?1049h\033[2J\033[H'      > "$D/combo_altscreen_clear"
printf '\033[?1049h\033[2J\033[Hcontent\033[?1049l' > "$D/combo_altscreen_full"

# Colored output with reset
printf '\033[1;34m>>> \033[0;32mOK\033[0m\n' > "$D/combo_colored_status"

# Simulated ncurses-style screen update
printf '\033[?25l\033[H' > "$D/combo_tui_start"
for i in $(seq 1 10); do
    printf '\033[%d;1H\033[2K Line %2d content here' "$i" "$i"
done >> "$D/combo_tui_start"
printf '\033[?25h' >> "$D/combo_tui_start"

# Box drawing with attributes
printf '\033[1;36m\033(0lqqqqqk\033(B\033[0m\n' > "$D/combo_styled_box"
printf '\033[1;36m\033(0x\033(B\033[0m     \033[1;36m\033(0x\033(B\033[0m\n' >> "$D/combo_styled_box"
printf '\033[1;36m\033(0mqqqqqj\033(B\033[0m\n' >> "$D/combo_styled_box"

# Long line that wraps
printf '%0200d\n' 0                    > "$D/combo_long_line"

# Many newlines (fill + scroll)
printf '%050s\n' '' | tr ' ' '\n'      > "$D/combo_many_newlines"

# Tabs
printf 'A\tB\tC\tD\n'                 > "$D/combo_tabs"
printf '\t\t\t\t\t\t\t\t\t\t'         > "$D/combo_many_tabs"

# Backspace overwrite
printf 'ABCDE\b\b\bXY'                > "$D/combo_bs_overwrite"

# ESC D/M at margins (index / reverse index causing scroll)
printf '\033[999B\033D\033D\033D'       > "$D/combo_index_scroll"
printf '\033[H\033M\033M\033M'          > "$D/combo_ri_scroll"

# Reverse index within scroll region
printf '\033[5;10r\033[5;1H\033M\033M'  > "$D/combo_ri_region"

# Delete then insert characters
printf 'ABCDEFGH\033[4G\033[2P\033[2@XY' > "$D/combo_dch_ich"

# Scroll region with content fill
printf '\033[5;15r\033[5;1H'           > "$D/combo_region_fill"
for i in $(seq 1 20); do
    printf 'Line %d\n' "$i"
done >> "$D/combo_region_fill"

echo "Generated $(ls "$D" | wc -l) seed files in $D/"
