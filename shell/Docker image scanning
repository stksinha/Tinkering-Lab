#!/bin/bash
# docker_audit.sh - Sanitized Qualys Scan Automation

# --- Configuration & Paths ---
SCAN_DIR="/opt/security/scanner" # Recommend a generic, non-company-specific path
REPORT_FILE="$SCAN_DIR/scan_report.txt"
LOG_DIR="$SCAN_DIR/logs" # Directory for full scan outputs

# Load API Credentials (Ensure this file is secured with 600 permissions!)
# Expected variables in .env: QUALYS_ACCESS_TOKEN, QUALYS_API_URL, PROXY_URL
# Example .env content:
# export QUALYS_ACCESS_TOKEN="YOUR_QUALYS_ACCESS_TOKEN_HERE"
# export QUALYS_API_URL="https://qualysapi.qg1.apps.qualys.com" # Example POD URL
# export PROXY_URL="http://your.proxy.server:8080" # Optional proxy
. "$SCAN_DIR/.env"

# Initialize the report file
echo "###################################################################" > "$REPORT_FILE"
echo "### Monthly Docker Image Scan Report - $(date +"%Y-%m-%d") ###" >> "$REPORT_FILE"
echo "###################################################################" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE" # Add a blank line for readability

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# 1. Get list of all local Docker Image IDs (skipping the header)
docker images --format "{{.ID}}" | tail -n+2 > "$SCAN_DIR/image_list.txt"

# 2. Iterate through each image and trigger the Qualys scan
while IFS= read -r image_id; do
    # Capture metadata using modern syntax and quoted variables
    image_name=$(docker images --format "{{.Repository}}" --filter "id=$image_id")
    image_tag=$(docker images --format "{{.Tag}}" --filter "id=$image_id")

    echo "--- Scanning started for: $image_name:$image_tag ---" >> "$REPORT_FILE"

    # Execute Qualys qscanner
    "$SCAN_DIR/qscanner" image "$image_id" \
        --access-token "$QUALYS_ACCESS_TOKEN" \
        --pod "$QUALYS_API_URL" \
        --proxy "$PROXY_URL" \
        --report-format table \
        --output-dir "$LOG_DIR" > "$LOG_DIR/output_$image_id.log" # Log full output to a file

    # 3. Data Extraction and Formatting via AWK
    # Extract vulnerability counts and severity summary
    awk '/vulnerabilities found/ || /Severity/ { $1=""; $2=""; sub(/^+/,""); print }' \
        "$LOG_DIR/output_$image_id.log" >> "$REPORT_FILE"
    
    # Extract the actual vulnerability table for detailed view
    awk '/^\+/ {in_table=1} in_table {print} NF==0 {in_table=0}' \
        "$LOG_DIR/output_$image_id.log" >> "$REPORT_FILE"

    echo "--- Scanning completed for: $image_name:$image_tag ---" >> "$REPORT_FILE"
    echo "###################################################################" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE" # Add a blank line for readability

done < "$SCAN_DIR/image_list.txt"

# 4. Notify Team via Email
# Ensure email_body.txt exists and contains a simple message.
# Example email_body.txt: "Please find the monthly Docker image scan report attached."
mailx -a "$REPORT_FILE" \
      -S from="Scanner Automation <scanner@example.com>" \
      -s "Monthly Docker Image Audit Report - $(date +"%Y-%m-%d")" \
      security-team@example.com < "$SCAN_DIR/email_body.txt"

# Clean up temporary files (optional, but good for production)
rm "$SCAN_DIR/image_list.txt"
# For log cleanup: find "$LOG_DIR" -mtime +30 -delete # Uncomment to delete logs older than 30 days
