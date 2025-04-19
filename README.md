# CS253-Log-Analysis-Shell-Script

This project provides a Bash script to analyze web server log files in CSV format. The script extracts unique IP addresses, identifies the top 3 HTTP methods, and counts requests per hour.

## Usage

```bash
./log_analysis.sh input_file output_file log_file
```

- `input_file`: Path to the CSV log file (format: IP,Timestamp,Method,...).
- `output_file`: File where analysis results will be written.
- `log_file`: File where script logs will be stored.

## Features

1. **Unique IP Extraction**: Lists all unique IP addresses found in the log.
2. **Top 3 HTTP Methods**: Shows the three most frequent HTTP methods and their counts.
3. **Hourly Request Count**: Displays the number of requests for each hour (00-23).

## Example

```bash
./log_analysis.sh access_log.csv analysis.txt script.log
```

## Notes

- Ensure the input file exists and is in the expected CSV format.
- The script logs its progress and errors to the specified log file.

---

*For academic use in CS253 or similar courses. Contributions and suggestions are welcome!*