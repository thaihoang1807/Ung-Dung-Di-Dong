import React from 'react';
import styled from 'styled-components';

const ChatHistoryContainer = styled.div`
  width: 250px;
  border-right: 1px solid #ccc;
  padding: 1rem;
  background-color: ${({ theme }) => theme.background};
  color: ${({ theme }) => theme.text};
  display: flex;
  flex-direction: column;
`;

const HistoryItem = styled.div`
  padding: 0.5rem;
  margin-bottom: 0.5rem;
  border: 1px solid #ccc;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s;

  &:hover {
    background-color: #f0f0f0;
  }
`;

const ChatHistory = ({ history, onSelectChat }) => {
  return (
    <ChatHistoryContainer>
      <h2>Chat History</h2>
      {history.map((chat, index) => (
        <HistoryItem key={index} onClick={() => onSelectChat(chat)}>
          {chat.title}
        </HistoryItem>
      ))}
    </ChatHistoryContainer>
  );
};

export default ChatHistory;