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
    
     ```bash
     env
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
     jac serve main.jac --port 8000
     ```
    
###  Terminal 2 – FastAPI Backend

     ```bash
     cd BE
     python api.py
     ```

###  Terminal 3 – Streamlit Frontend

     ```bash
     cd FE
     streamlit run app.py
     ```
     
     - Then open `http://localhost:8501` in your browser.

## How to Use

   1. **Paste a public GitHub URL**  
      Example: `https://github.com/psf/requests`
   
   2. **Click Generate Documentation**
   
   3. **Read, download, or chat with the docs**

---

## API Endpoints

   | Method | Endpoint     | Use                     |
   |--------|--------------|-------------------------|
   | `GET`  | `/health`    | Check if backend is up  |
   | `POST` | `/generate`  | Generate docs from URL  |
   
   **Example request:**
   ```bash
   curl -X POST http://localhost:8080/generate \
     -H "Content-Type: application/json" \
     -d '{"repo_url": "https://github.com/psf/requests"}'
   ```
---
## Health Check

   1. Jac server: /health verifies that jac serve main.jac is reachable.
   
   2. Gemini API key: /health reports if the key is configured (but doesn’t block the app).

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



