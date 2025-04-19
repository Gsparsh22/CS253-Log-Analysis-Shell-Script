#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 input_file output_file log_file"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="$2"
LOG_FILE="$3"

# Log messages with timestamps
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Check if the input file exists
if [ ! -f "$INPUT_FILE" ]; then
    log "Input file not detected"
    echo "Error: Input file '$INPUT_FILE' does not exist."
    exit 1
else
    log "Input file exists"
fi

# Task 1: Extract unique IP addresses
echo "Unique IP addresses:" > "$OUTPUT_FILE"  # Overwrite output file
awk -F, '{print $1}' "$INPUT_FILE" | sort | uniq >> "$OUTPUT_FILE"
log "Unique IP extraction completed"

# Task 2: Identify top 3 HTTP methods with frequencies
echo "Top 3 HTTP methods:" >> "$OUTPUT_FILE"
awk -F, 'NR>1 {print $3}' "$INPUT_FILE" | sort | uniq -c | sort -rn | awk '{if(NR<=3) {print $2 ": " $1; if(NR==3) {min_count=$1; min_set=1}} else if(min_set && $1 < min_count) exit; else print $2 ": " $1}' >> "$OUTPUT_FILE"
log "Top 3 HTTP methods identified" 

# Task 3: Count requests per hour (0-23)
echo "Hourly request counts:" >> "$OUTPUT_FILE"
awk -F, '{
    hour=substr($2,12,2);
    count[hour]++
} END {
    for (h=0; h<=23; h++) {
        hour=sprintf("%02d", h);
        printf "Hour %02d: %d requests\n", h, count[hour]+0
    }
}' "$INPUT_FILE" >> "$OUTPUT_FILE"
log "Hourly request count completed"

log "Script execution completed"
cat "$OUTPUT_FILE"
exit 0