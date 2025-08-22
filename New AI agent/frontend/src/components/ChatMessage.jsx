import React from 'react';
import styled from 'styled-components';

const MessageContainer = styled.div`
  display: flex;
  justify-content: ${({ sender }) => (sender === 'user' ? 'flex-end' : 'flex-start')};
  margin-bottom: 1rem;
`;

const MessageBubble = styled.div`
  background-color: ${({ sender, theme }) => (sender === 'user' ? theme.userBubble : theme.assistantBubble)};
  color: ${({ theme }) => theme.text};
  padding: 0.5rem 1rem;
  border-radius: 1.5rem;
  border: 2px solid ${({ theme }) => theme.text};
  box-shadow: 2px 2px 0px ${({ theme }) => theme.text};
  max-width: 80%;
`;

const ChatMessage = ({ sender, text }) => {
  return (
    <MessageContainer sender={sender}>
      <MessageBubble sender={sender}>{text}</MessageBubble>
    </MessageContainer>
  );
};

export default ChatMessage;