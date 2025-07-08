import os
import subprocess
import sys

# Ensure required packages are installed
def install(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package])

try:
    import requests
    from transformers import AutoTokenizer, AutoModelForSeq2SeqLM, pipeline
except ImportError:
    install("requests")
    install("transformers")
    import requests
    from transformers import AutoTokenizer, AutoModelForSeq2SeqLM, pipeline

# Download and unzip model if not present
MODEL_ZIP_URL = "https://github.com/YagnaAnnadata/Projects/raw/main/AI_Timing_Diff/trained_flan_t5_simple.zip"
ZIP_PATH = "trained_flan_t5_simple.zip"
MODEL_DIR = "trained_flan_t5_simple"

if not os.path.exists(ZIP_PATH):
    print("Downloading model...")
    response = requests.get(MODEL_ZIP_URL)
    with open(ZIP_PATH, "wb") as f:
        f.write(response.content)

if not os.path.exists(MODEL_DIR):
    print("Extracting model...")
    import zipfile
    with zipfile.ZipFile(ZIP_PATH, "r") as zip_ref:
        zip_ref.extractall(MODEL_DIR)

# Load model and tokenizer
print("Loading model...")
tokenizer = AutoTokenizer.from_pretrained(MODEL_DIR)
model = AutoModelForSeq2SeqLM.from_pretrained(MODEL_DIR)
pipe = pipeline("text2text-generation", model=model, tokenizer=tokenizer)

# Main interaction
def main():
    while True:
        print("\nMenu:")
        print("1. Run the model")
        print("2. Exit")
        choice = input("Enter your choice (1 or 2): ").strip()

        if choice == "1":
            delta = input("Enter delta slack (e.g., 0.0042): ").strip()
            classification = input("Enter classification (improved or degraded): ").strip().lower()
            clock = input("Enter clock (e.g., mclk): ").strip().lower()

            prompt = f"delta: {delta}, classification: {classification}, clock: {clock}"
            result = pipe(prompt, max_length=16)
            reason = result[0]['generated_text']
            print(f"\nPredicted Reason: {reason}")

        elif choice == "2":
            print("Exiting...")
            break
        else:
            print("Invalid input. Please enter 1 or 2.")

if __name__ == "__main__":
    main()
