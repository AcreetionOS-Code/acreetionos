import React from 'react';
import { createRoot } from 'react-dom/client';
import Chatbot from './Chatbot';

const App = () => (
  <div style={{ display: 'flex', height: '100vh' }}>
    <div style={{ flex: 1 }} />
    <Chatbot />
  </div>
);

const root = createRoot(document.getElementById('root'));
root.render(<App />);
