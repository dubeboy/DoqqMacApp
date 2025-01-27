# Doqq

Doqq is an open-source application designed to streamline the process of searching for and identifying specific or similar code snippets within a given code library. Leveraging natural language queries, Doqq acts as a **Smart Code Documentation Search Agent**, providing developers with an efficient way to locate relevant code in their projects.

---

## Features

- **Natural Language Code Search**:  
  Query the code library using plain English to locate specific functionality or patterns.

- **Efficient Code Matching**:  
  Responds with relevant matches or states when no match is found, ensuring clarity and precision.

- **Developer-Friendly Output**:  
  Results are returned in Markdown format with references to the appropriate chunk index for easy navigation.

- **Runs Locally for Privacy**:  
  Doqq uses **llama**, an AI model running locally on your machine, ensuring your code stays private.

---

## Privacy

Doqq prioritizes your privacy by running entirely on your local machine.  
The app uses **llama 7b**, an AI model, which operates locally, ensuring that no code or queries are sent to external servers.  

---

## Setup Instructions

### Prerequisites

1. **Ollama Setup**:
   - Download Ollama by visiting [Ollama's official site](https://ollama.ai/).
   - Pull the required Ollama model:
     ```bash
     ollama pull ollama-7b
     ```
   - Run Ollama locally:
     ```bash
     ollama run
     ```

### Running the App

1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/doqq.git
   cd doqq
2. Run the app
   You can use xcode, will be providing binaries soon


### Current issues
 1. Fetching data from core data is not working correctly the messages primary key should be enumarable
 2. Should be able to use deepseek as its faster
 3. Requires your machine to be able to run docker. but we plan embed the LLM as a seperate downloadable package in the app directly soon.
