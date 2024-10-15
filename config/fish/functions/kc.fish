
# Kubectl Commandar.
function kc
    set command $argv[1]

    if test -z "$command"
        kc_help
        return 0
    end

    switch $command
        case logs
            kc_logs
        case ns
            kc_ns
        case '*'
            kc_help
    end
end

function kc_help
    string trim '
"kc" means "Kubectl Commandar".

kc <command>

Command:
  ns     Change default namespace of current context
  logs   Show log from the pod
    '
end

# change default namespace of current context
function kc_ns
    set finder (__select_finder)

    # set current_ns (kubectl config view | grep namespace | )
    kubectl get namespaces | \
    $finder --header-lines 1 | \
    read -l name _status age

    if test -n "$name"
        kubectl config set-context (kubectl config current-context) --namespace=$name
    end

    commandline -f repaint
end

# show log the pod selected by the finder
function kc_logs
    set finder (__select_finder)

    # set current_ns (kubectl config view | grep namespace | )
    kubectl get pods | \
    $finder --header-lines 1 | \
    read -l name _ready _status _restarts _age

    if test -n "$name"
        kubectl logs $name
    end

    commandline -f repaint
end
