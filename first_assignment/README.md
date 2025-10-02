# Explain Like I'm 5 Rewriter

This **JAC program** rewrites complex paragraphs into simple language that a 5-year-old child can understand. It uses an **AI language model** to transform text into very simple words and short sentences, making explanations clear, cheerful, and easy to grasp.

---
## Features

- Uses a node InputText to store the original and rewritten text.
- Uses a walker TextRewriter to process the input text and generate a simplified version.
- Integrates with the Gemini 2.0 Flash AI model to perform the rewriting.
- Provides a system prompt to ensure the output is suitable for young children.

---

## How It Works

- User inputs a complex paragraph.
- The `walker` spawns an `InputText` node holding the original text.
- Calls the AI-powered `rewrite_text` function with a system prompt tailored for explaining to a **5-year-old**.
- Outputs the original and rewritten text.

---
## Usage

- Paste your complex paragraph in the complex_paragraph variable in the `with entry:__main__ block`.
- Run the **JAC program**.
- View the printed output showing the original and simplified text.

---
## Dependencies

- Requires the **Gemini AI API key** set in **.env** as **GEMINI_API_KEY**.
- Uses the **JAC language** runtime and the **byllm.llm module**.

