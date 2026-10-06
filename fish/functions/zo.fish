function zo
    set -l command_output ($SCRIPTS/0-cd)
    if test (count $command_output) -gt 0
        eval $command_output
    end
end
