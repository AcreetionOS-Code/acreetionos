// AcreetionOS Installer App Store UI
// Simple app store for selecting and installing packages during OS installation

import React, { useState } from 'react';
import axios from 'axios';

function AppStore() {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState([]);
  const [selected, setSelected] = useState([]);
  const [loading, setLoading] = useState(false);

  const searchPackages = async (e) => {
    e.preventDefault();
    setLoading(true);
    // Example: search Arch Linux repo (replace with your repo API)
    const response = await axios.get(`https://archlinux.org/packages/search/json/?q=${encodeURIComponent(query)}`);
    setResults(response.data.results || []);
    setLoading(false);
  };

  const toggleSelect = (pkg) => {
    setSelected(sel => sel.includes(pkg) ? sel.filter(p => p !== pkg) : [...sel, pkg]);
  };

  const installSelected = () => {
    // Implement actual install logic (e.g., call backend script)
    alert('Installing: ' + selected.map(p => p.pkgname).join(', '));
  };

  return (
    <div style={{ padding: 24 }}>
      <h2>App Store</h2>
      <form onSubmit={searchPackages} style={{ marginBottom: 16 }}>
        <input
          value={query}
          onChange={e => setQuery(e.target.value)}
          placeholder="Search for apps/packages..."
          style={{ padding: 8, width: 300 }}
        />
        <button type="submit" style={{ marginLeft: 8, padding: 8 }}>Search</button>
      </form>
      {loading && <div>Searching...</div>}
      <ul>
        {results.map(pkg => (
          <li key={pkg.pkgname} style={{ marginBottom: 8 }}>
            <label>
              <input
                type="checkbox"
                checked={selected.includes(pkg)}
                onChange={() => toggleSelect(pkg)}
              />
              <strong>{pkg.pkgname}</strong> - {pkg.pkgdesc}
            </label>
          </li>
        ))}
      </ul>
      {selected.length > 0 && (
        <button onClick={installSelected} style={{ marginTop: 16, padding: 10 }}>
          Install Selected
        </button>
      )}
    </div>
  );
}

export default AppStore;
