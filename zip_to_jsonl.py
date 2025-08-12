import os
import zipfile
import requests
import pandas as pd
import json
import random
from io import BytesIO

# Step 1: Download ZIP file from GitHub
url = "https://github.com/YagnaAnnadata/Projects/raw/main/AI_Timing_Diff/100_example_tracediff_reports.zip"
response = requests.get(url)
assert response.status_code == 200, "Failed to download zip file"

# Step 2: Extract ZIP into memory
with zipfile.ZipFile(BytesIO(response.content)) as zip_ref:
    zip_ref.extractall("timing_reports")

# Step 3: Define partitions
partitions = [
    "DTSGEN6", "INFRP", "FPAP", "FPRP", "ARRP", "BBQP", "FILP", "FECP",
    "L2DATASMP", "L2DATALP", "L2PGRAMSLP", "L2PGRAMSOMP", "L2PGRAMSLMP",
    "L2TAGSLP", "L2TAGSOMP", "L2TAGSLMP", "LJPLL", "PGMODV"
]

# Step 4: Parse each Excel file
jsonl_data = []

for filename in os.listdir("timing_reports"):
    if filename.endswith(".xlsx"):
        filepath = os.path.join("timing_reports", filename)
        df = pd.read_excel(filepath)

        for _, row in df.iterrows():
            try:
                delta = float(row["delta slack"])
                classification = str(row["delta classification"]).strip().lower()
                clock = str(row["source clk"]).strip().lower()
                reason = str(row["timing change reason"]).strip().lower()

                if pd.notna(delta) and pd.notna(classification) and pd.notna(clock) and pd.notna(reason):
                    partition = random.choice(partitions)
                    input_text = f"delta: {delta}, classification: {classification}, clock: {clock}, partition: {partition}"
                    jsonl_data.append({
                        "input": input_text,
                        "output": reason
                    })
            except Exception as e:
                continue  # Skip malformed rows

# Step 5: Save to JSONL
output_file = "timing_data.jsonl"
with open(output_file, "w") as f:
    for item in jsonl_data:
        f.write(json.dumps(item) + "\n")

print(f"JSONL file saved as: {output_file} ({len(jsonl_data)} samples)")
