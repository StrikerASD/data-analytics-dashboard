# backend/app.py
from flask import Flask, request, jsonify
from google.cloud import bigquery
from flask_cors import CORS
import os

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Initialize BigQuery client
client = bigquery.Client()

@app.route('/api/query', methods=['POST'])
def run_query():
    data = request.get_json()
    query = data.get('query')

    if not query:
        return jsonify({'error': 'No query provided.'}), 400

    try:
        query_job = client.query(query)
        results = query_job.result()

        # Convert results to list of dictionaries
        rows = [dict(row) for row in results]
        return jsonify(rows), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    # For local testing
    app.run(host='0.0.0.0', port=8080, debug=True)
