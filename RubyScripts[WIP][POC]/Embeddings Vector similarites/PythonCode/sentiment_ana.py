from sentence_transformers import SentenceTransformer
import numpy as np
import faiss

# Initialize the SentenceTransformer model
model = SentenceTransformer('all-MiniLM-L6-v2')

# Example code chunks
code_chunks = [
    "func changeNavigationBarColor(to color: UIColor) { UINavigationBar.appearance().barTintColor = color }",
    "let jsonString = try JSONEncoder().encode(object)",
    "print('Hello, World!')"
]

# Generate embeddings for code chunks
embeddings = model.encode(code_chunks)
print("ok run")
# Save embeddings and code chunks for future use
np.save('code_chunks.npy', code_chunks)
np.save('embeddings.npy', embeddings)

print("faiss")

# Define the dimensions of the embeddings
dimension = embeddings.shape[1]

# Initialize a FAISS index
index = faiss.IndexFlatL2(dimension)

# Add embeddings to the index
index.add(embeddings)

# Save the FAISS index
faiss.write_index(index, "code_index.faiss")

print("Load embeddings and code chunks")

# Load embeddings and code chunks
loaded_embeddings = np.load('embeddings.npy')
code_chunks = np.load('code_chunks.npy')

# Load the FAISS index
index = faiss.read_index("code_index.faiss")

# Embed the query
query = "A function to change the navigation bar color"
query_embedding = model.encode([query])

# Perform the search
k = 3  # Number of results to retrieve
distances, indices = index.search(query_embedding, k)

# Display results
print("Query:", query)
print("\nTop Results:")
for i, idx in enumerate(indices[0]):
    print(f"{i+1}. Code Chunk: {code_chunks[idx]}")
    print(f"   Similarity Score: {1 - distances[0][i]:.4f}")

