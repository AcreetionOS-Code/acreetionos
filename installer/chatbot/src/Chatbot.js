import React, { useState } from 'react';
import styled from 'styled-components';
import axios from 'axios';
const AI_OPTIONS = [
  { label: 'OpenAI GPT-4', value: 'openai' },
  { label: 'HuggingFace Free', value: 'huggingface' },
  { label: 'OpenRouter', value: 'openrouter' },
  { label: 'DuckDuckGo Search', value: 'duckduckgo' },
  { label: 'Google Search', value: 'google' },
  { label: 'Bing Search', value: 'bing' }
];

const ChatbotContainer = styled.div`
  width: 400px;
  height: 100vh;
  background: #222e3c;
  color: #fff;
  box-shadow: -2px 0 8px rgba(0,0,0,0.1);
  display: flex;
  flex-direction: column;
  position: fixed;
  right: 0;
  top: 0;
`;
const Header = styled.div`
  padding: 20px;
  font-size: 1.3em;
  font-weight: bold;
  background: #1a2230;
  border-bottom: 1px solid #2c3e50;
`;
const Messages = styled.div`
  flex: 1;
  padding: 20px;
  overflow-y: auto;
`;
const InputContainer = styled.form`
  display: flex;
  padding: 16px;
  background: #1a2230;
`;
const Input = styled.input`
  flex: 1;
  padding: 10px;
  border-radius: 4px;
  border: none;
  font-size: 1em;
`;
const Button = styled.button`
  margin-left: 8px;
  padding: 10px 16px;
  background: #3fa7d6;
  color: #fff;
  border: none;
  border-radius: 4px;
  font-weight: bold;
  cursor: pointer;
`;

const SYSTEM_PROMPT = `You are an expert assistant with deep knowledge of GenesisOS, TornadoOS, AcreetionOS, EcoOS, and StormOS. Answer questions about these operating systems and use internet access to provide up-to-date information.`;

function Chatbot() {
  const [messages, setMessages] = useState([
    { sender: 'bot', text: 'Hello! Ask me anything about GenesisOS, TornadoOS, AcreetionOS, EcoOS, or StormOS.' }
  ]);
  const [input, setInput] = useState('');
  const [loading, setLoading] = useState(false);
  const [aiSource, setAiSource] = useState('openai');

  const sendMessage = async (e) => {
    e.preventDefault();
    if (!input.trim()) return;
    const userMsg = { sender: 'user', text: input };
    setMessages(msgs => [...msgs, userMsg]);
    setLoading(true);
    try {
      let botMsg;
      if (aiSource === 'openai') {
        const response = await axios.post('https://api.openai.com/v1/chat/completions', {
          model: 'gpt-4',
          messages: [
            { role: 'system', content: SYSTEM_PROMPT },
            ...messages.map(m => ({ role: m.sender === 'bot' ? 'assistant' : 'user', content: m.text })),
            { role: 'user', content: input }
          ]
        }, {
          headers: {
            'Authorization': `Bearer YOUR_OPENAI_API_KEY`,
            'Content-Type': 'application/json'
          }
        });
        botMsg = { sender: 'bot', text: response.data.choices[0].message.content };
      } else if (aiSource === 'huggingface') {
        // Example: HuggingFace Inference API (replace with your endpoint/model)
        const response = await axios.post('https://api-inference.huggingface.co/models/gpt2', {
          inputs: input
        }, {
          headers: {
            'Authorization': `Bearer YOUR_HUGGINGFACE_API_KEY`,
            'Content-Type': 'application/json'
          }
        });
        botMsg = { sender: 'bot', text: response.data[0]?.generated_text || 'No response.' };
      } else if (aiSource === 'openrouter') {
        // Example: OpenRouter API (replace with your endpoint/model)
        const response = await axios.post('https://openrouter.ai/api/v1/chat/completions', {
          model: 'openrouter/gpt-3.5',
          messages: [
            { role: 'system', content: SYSTEM_PROMPT },
            ...messages.map(m => ({ role: m.sender === 'bot' ? 'assistant' : 'user', content: m.text })),
            { role: 'user', content: input }
          ]
        }, {
          headers: {
            'Authorization': `Bearer YOUR_OPENROUTER_API_KEY`,
            'Content-Type': 'application/json'
          }
        });
        botMsg = { sender: 'bot', text: response.data.choices[0].message.content };
      } else if (aiSource === 'duckduckgo') {
        // DuckDuckGo Instant Answer API (no key required)
        const response = await axios.get(`https://api.duckduckgo.com/?q=${encodeURIComponent(input)}&format=json`);
        botMsg = { sender: 'bot', text: response.data.AbstractText || 'No instant answer found.' };
      } else if (aiSource === 'google') {
        // Google Custom Search API (requires API key and CX)
        const response = await axios.get(`https://www.googleapis.com/customsearch/v1?q=${encodeURIComponent(input)}&key=YOUR_GOOGLE_API_KEY&cx=YOUR_GOOGLE_CX`);
        botMsg = { sender: 'bot', text: response.data.items?.[0]?.snippet || 'No results found.' };
      } else if (aiSource === 'bing') {
        // Bing Search API (requires API key)
        const response = await axios.get(`https://api.bing.microsoft.com/v7.0/search?q=${encodeURIComponent(input)}`, {
          headers: { 'Ocp-Apim-Subscription-Key': 'YOUR_BING_API_KEY' }
        });
        botMsg = { sender: 'bot', text: response.data.webPages?.value?.[0]?.snippet || 'No results found.' };
      }
      setMessages(msgs => [...msgs, botMsg]);
    } catch (err) {
      setMessages(msgs => [...msgs, { sender: 'bot', text: 'Sorry, I could not fetch an answer.' }]);
    }
    setInput('');
    setLoading(false);
  };

  return (
    <ChatbotContainer>
      <Header>OS Expert Chatbot</Header>
      <div style={{ padding: '0 20px 10px 20px' }}>
        <label htmlFor="ai-source">AI/Search Source: </label>
        <select id="ai-source" value={aiSource} onChange={e => setAiSource(e.target.value)} style={{ marginLeft: 8 }}>
          {AI_OPTIONS.map(opt => (
            <option key={opt.value} value={opt.value}>{opt.label}</option>
          ))}
        </select>
      </div>
      <Messages>
        {messages.map((msg, i) => (
          <div key={i} style={{ marginBottom: 12, textAlign: msg.sender === 'user' ? 'right' : 'left' }}>
            <span style={{ fontWeight: msg.sender === 'user' ? 'bold' : 'normal', color: msg.sender === 'user' ? '#3fa7d6' : '#fff' }}>
              {msg.sender === 'user' ? 'You' : 'Bot'}:
            </span> {msg.text}
          </div>
        ))}
        {loading && <div>Bot is typing...</div>}
      </Messages>
      <InputContainer onSubmit={sendMessage}>
        <Input
          value={input}
          onChange={e => setInput(e.target.value)}
          placeholder="Type your question..."
          disabled={loading}
        />
        <Button type="submit" disabled={loading}>Send</Button>
      </InputContainer>
    </ChatbotContainer>
  );
}

export default Chatbot;
