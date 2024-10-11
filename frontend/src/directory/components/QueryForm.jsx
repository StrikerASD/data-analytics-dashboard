// frontend/src/components/QueryForm.jsx
import React, { useState } from 'react';
import axios from 'axios';

const QueryForm = ({ setQueryResult }) => {
  const [query, setQuery] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post('/api/query', { query });
      setQueryResult(response.data);
    } catch (error) {
      console.error('Error executing query:', error);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <textarea
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        placeholder="Enter your BigQuery SQL here"
        rows="5"
        cols="50"
      />
      <br />
      <button type="submit">Execute Query</button>
    </form>
  );
};

export default QueryForm;
