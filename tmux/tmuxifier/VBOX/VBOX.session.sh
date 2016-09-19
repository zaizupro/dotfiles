session="VBOX"
if initialize_session $session; then

    # Create a new window inline within session layout definition.
    load_window "VBOX"

    # open tmux tab
    load_window "VBOX"

    # Select the default active window on session creation.
    select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
