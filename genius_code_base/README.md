# Codebase Genius

AI-powered tool that generates clean Markdown docs for any **public GitHub repo**.  
Built with **Jac + FastAPI + Gemini 2.5 Flash + Streamlit**.

---

## What It Does
- Auto-generates documentation: overview, file structure, key files  
- Saves docs locally in `BE/outputs/`  
- Includes a simple **chat panel** to ask questions about the code  

---

## Project Structure

## Setup

1. **Clone the repo**
   ```bash
   git clone https://github.com/murungadaniel/codebase_genius.git
   cd codebase_genius

2. **Create and activate a virtual environment**
   ```bash
    python -m venv .venv
    source .venv/bin/activate     # Linux / macOS
    # OR
    .venv\Scripts\activate        # Windows
   ```

3. **Install dependencies**

   **Backend (BE)**
     ```bash
     cd BE
     pip install -r requirements.txt
     ```
   **Frontend (FE)**
     ```bash
     cd ../FE
     pip install -r requirements.txt
     ```
     
4. **Add your API key**

     Create `BE/.env`:
    
     ```env
     GEMINI_API_KEY=your-key-here
     JAC_SERVER_URL=http://localhost:8000
     FASTAPI_PORT=8080
     JAC_VERBOSE=false
     ```

# Running the System

  - You’ll run three terminals (or processes):

###  Terminal 1 – Jac API Server
     ```bash
     cd BE
     jac serve main.jac --port 8000```
    
###  Terminal 2 – FastAPI Backend
     ```bash
     cd BE
     python api.py```

###  Terminal 3 – Streamlit Frontend
     ```bash
     cd FE
     streamlit run app.py```

     - Then open `http://localhost:8501` in your browser.

#  How It Works

User inputs a GitHub URL in Streamlit.

Frontend sends the URL to the FastAPI /generate endpoint.

Backend constructs a detailed prompt and calls Gemini 2.5 Flash.

Gemini returns structured Markdown documentation.

The docs are saved under BE/outputs/ and displayed in Streamlit.

Users can read or download the docs, and use a lightweight chat panel for guidance.

# Health Check

Jac server: /health verifies that jac serve main.jac is reachable.

Gemini API key: /health reports if the key is configured (but doesn’t block the app).

Example:

curl http://localhost:8080/health
# → {"status": "ok", "gemini_configured": true}

#  Example Output

# Input:

https://github.com/psf/requests


Generated Output (excerpt):

# Codebase Documentation

## Overview
The `requests` library provides an elegant and Pythonic interface for making HTTP requests.

## Repository Structure
- requests/
  - api.py
  - models.py
  - sessions.py
  - utils.py

## Key Files and Responsibilities
- `sessions.py` handles HTTP session persistence.
- `models.py` defines request and response objects.

## How to Run Locally
Install dependencies and import `requests` into any Python 3.7+ project.

## Possible Improvements
- Add type annotations to internal modules.
- Improve connection-pool diagnostics.

# API Endpoints Summary
Method	Endpoint	   Description
GET	   /health Check    backend + Jac connectivity
POST	/generate	   Generate documentation from a GitHub URL

Sample Request:

curl -X POST http://localhost:8080/generate \
  -H "Content-Type: application/json" \
  -d '{"repo_url": "https://github.com/psf/requests"}'

# Common Issues & Fixes
Issue	Likely Cause	Fix
Backend response not OK	Missing .env or GEMINI_API_KEY	Run load_dotenv() verified, check .env syntax
Jac server not reachable	Forgot to run jac serve main.jac	Start Jac before FastAPI
Empty docs	Invalid Gemini key or model name	Check your Gemini 2.5 Flash key
Streamlit UI not updating	Cached state	Press R or rerun app

