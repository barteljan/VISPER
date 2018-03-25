#/bin/bash
POD_DIR="../VISPER-Sourcery/Classes"
SOURCE_DIR="./VISPER-Sourcery-Example/"
OUTPUT_DIR="$SOURCE_DIR/VISPER-Generated"
TEMPLATE_DIR="../VISPER-Sourcery/Assets"

mkdir -p $OUTPUT_DIR

sourcery --sources $SOURCE_DIR --sources $POD_DIR --templates $TEMPLATE_DIR --output $OUTPUT_DIR
