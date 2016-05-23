session="MOCP"
if initialize_session $session; then

  # Create a new window inline within session layout definition.
  load_window "MOCP"

  # open tmux tab for file manager.
  tmuxifier-tmux new-window -t "$session:" -d -n "FILES" "mc ~/Music/"

  # Select the default active window on session creation.
  select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
