// frontend/src/App.js
import React, { useState } from 'react';
import QueryForm from './components/QueryForm';
import QueryResult from './components/QueryResult';

function App() {
  const [queryResult, setQueryResult] = useState([]);

  return (
    <div className="App">
      <h1>Data Analytics Dashboard</h1>
      <QueryForm setQueryResult={setQueryResult} />
      <QueryResult data={queryResult} />
    </div>
  );
}

export default App;
