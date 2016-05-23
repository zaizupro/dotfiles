new_window "PLAYER"

# run player
run_cmd "mocp"

# Split window into panes.
split_v 20

# run scrobbler
run_cmd "mocpsc -v"


# Set active pane.
select_pane 1
