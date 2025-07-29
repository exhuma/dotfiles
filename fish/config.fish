if status is-interactive
    # Commands to run in interactive sessions can go here
end


function push-line
    set -l saved_line (commandline)
    commandline --replace ''
    commandline -f repaint

    read -l -P "Temporary command> " temp_cmd
    if test -n "$temp_cmd"
        eval $temp_cmd
    end

    commandline --replace "$saved_line"
    commandline -f repaint
end

fish_vi_key_bindings

bind -M insert \cq push-line
