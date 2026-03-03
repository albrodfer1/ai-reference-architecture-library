#!/bin/bash

OUT_FILE="dt_ref_arch_mar_2026_graph.mmd"
IN_FILE="dt_ref_arch_mar_2026.mmd"

indent="\t"

parse_container() {
  container=$(echo $1 | awk -F '(' '{print $2}' | tr -d ')' | tr -d '{')

  name=$(echo $container | awk -F ',' '{print $1}')
  tag=$(echo $container | awk -F ',' '{print $2}' |  sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

  echo -e "${indent}${name}[$tag]" | tee -a $OUT_FILE
}

parse_boundary() {
  boundary=$(echo $1 | awk -F '(' '{print $2}' | tr -d ')' | tr -d '{')

  name=$(echo $boundary | awk -F ',' '{print $1}')
  tag=$(echo $boundary | awk -F ',' '{print $2}' |  sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

  echo -e "${indent}subgraph $tag" | tee -a $OUT_FILE
  indent+="\t"
}

parse_end() {
  indent=${indent::-2}
  echo -e "${indent}end" | tee -a $OUT_FILE
}

parse_rel() {
  rel=$(echo $1 | awk -F '(' '{print $2}' | tr -d ')' | tr -d '{')

  name1=$(echo $rel | awk -F ',' '{print $1}')
  name2=$(echo $rel | awk -F ',' '{print $2}' |  sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  rel=$(echo $rel | awk -F ',' '{print $3}' |  sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

  echo -e "${indent}$name1 -->|$rel| $name2" | tee -a $OUT_FILE
}

parse_line() {
  in=$1

  echo $in | grep -q "Person(\|Container(\|System_Ext(\|System(" && parse_container "$in"

  echo $in | grep -q "System_Boundary(\|Enterprise_Boundary(" && parse_boundary "$in"

  echo $in | grep -q "}" && parse_end "$in"

  echo $in | grep -q "Rel(" && parse_rel "$in"
}

echo "graph TD" > $OUT_FILE

while read line
do
  parse_line "$line"
done < "$IN_FILE"