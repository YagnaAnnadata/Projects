import os
import zipfile
import subprocess

# Install required packages if not available
try:
    import gradio as gr
    from transformers import AutoModelForSeq2SeqLM, AutoTokenizer, pipeline
except ImportError:
    subprocess.check_call(["pip", "install", "transformers", "gradio"])
    from transformers import AutoModelForSeq2SeqLM, AutoTokenizer, pipeline
    import gradio as gr

# File paths
zip_path = "trained_flan_t5_base.zip"
model_dir = "trained_flan_t5_base"

# Unzip the model if not already extracted
if not os.path.exists(model_dir):
    with zipfile.ZipFile(zip_path, 'r') as zip_ref:
        zip_ref.extractall(model_dir)

# Load model and tokenizer
model = AutoModelForSeq2SeqLM.from_pretrained(model_dir)
tokenizer = AutoTokenizer.from_pretrained(model_dir)
pipe = pipeline("text2text-generation", model=model, tokenizer=tokenizer)

# Prediction function
def predict_reason(delta, classification, clock, partition):
    prompt = f"delta: {delta}, classification: {classification}, clock: {clock}, partition: {partition}"
    result = pipe(prompt, max_new_tokens=20)
    return result[0]['generated_text']

# Gradio UI (local only)
iface = gr.Interface(
    fn=predict_reason,
    inputs=[
        gr.Textbox(label="Delta Slack"),
        gr.Dropdown(["degraded", "improved"], label="Classification"),
        gr.Textbox(label="Clock"),
        gr.Textbox(label="Partition")
    ],
    outputs="text",
    title="Timing Path Reason Predictor",
    description="Enter delta slack, classification, clock, and partition to get predicted reason."
)

iface.launch(share=True)
