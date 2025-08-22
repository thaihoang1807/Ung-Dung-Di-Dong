import { useState } from 'react';
import { ThemeProvider } from 'styled-components';
import { lightTheme, darkTheme } from './theme';
import './App.css';
import Header from './components/Header';
import ChatHistory from './components/ChatHistory';
import ChatMessage from './components/ChatMessage';
import MessageInput from './components/MessageInput';
import ThemeToggle from './components/ThemeToggle';

function App() {
  const [theme, setTheme] = useState('light');
  const [messages, setMessages] = useState([]);
  const [history, setHistory] = useState([]);

  const toggleTheme = () => {
    setTheme(theme === 'light' ? 'dark' : 'light');
  };

  const handleSendMessage = async (input) => {
    const userMessage = { sender: 'user', text: input };
    setMessages((prev) => [...prev, userMessage]);

    try {
      const response = await fetch('http://localhost:3000/chat', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ message: input }),
      });

      if (!response.ok) {
        throw new Error('Network response was not ok');
      }

      const data = await response.json();
      const assistantMessage = { sender: 'assistant', text: data.response };
      setMessages((prev) => [...prev, assistantMessage]);
    } catch (error) {
      console.error('Failed to fetch:', error);
      const errorMessage = { sender: 'assistant', text: 'Sorry, something went wrong.' };
      setMessages((prev) => [...prev, errorMessage]);
    }
  };

  return (
    <ThemeProvider theme={theme === 'light' ? lightTheme : darkTheme}>
      <div className="app-container">
        <ChatHistory history={history} onSelectChat={() => {}} />
        <div className="main-content">
          <Header walletName="MyWallet">
            <ThemeToggle theme={theme} toggleTheme={toggleTheme} />
          </Header>
          <div className="message-list">
            {messages.map((msg, index) => (
              <ChatMessage key={index} sender={msg.sender} text={msg.text} />
            ))}
          </div>
          <MessageInput onSendMessage={handleSendMessage} />
        </div>
      </div>
    </ThemeProvider>
  );
}

export default App;
