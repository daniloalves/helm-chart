#!/bin/bash
set -e

package(){
    chart_name="$1"
    helm lint $chart_name
    helm package $chart_name
    helm repo index .
}

list_changes(){
    chart_changes=$(git status | grep chart | sed 's/[[:space:]]//g')
    echo "$chart_changes"
}

main(){
    for chart in $(list_changes);
    do
        package $chart
    done
}

main

