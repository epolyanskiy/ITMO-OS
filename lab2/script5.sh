#script5
#!/bin/bash

inputFileName="outputScript4"
outputFileName="outputScript5"

awk -F '[=:]' '
{
    gsub(" ", "", $4);
    gsub(" ", "", $6);
    parent[$4] += $6;
    count[$4]++;
}
END {
    for (p in parent) {
        avg = parent[p] / count[p];
        print "Average_Running_Children_of_ParentID=" p " is " avg;
    }
}' "$inputFileName" > "$outputFileName"
