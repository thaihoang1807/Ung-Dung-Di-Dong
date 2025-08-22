import React, { useState } from 'react';
import styled from 'styled-components';

const FormContainer = styled.form`
  display: flex;
  padding: 1rem;
  border-top: 2px solid ${({ theme }) => theme.text};
`;

const Input = styled.input`
  flex-grow: 1;
  padding: 0.5rem;
  border: 2px solid ${({ theme }) => theme.text};
  border-radius: 1rem;
  background: ${({ theme }) => theme.body};
  color: ${({ theme }) => theme.text};
  box-shadow: 2px 2px 0px ${({ theme }) => theme.text};
`;

const Button = styled.button`
  margin-left: 0.5rem;
  padding: 0.5rem 1rem;
  border: 2px solid ${({ theme }) => theme.text};
  border-radius: 1rem;
  background-color: ${({ theme }) => theme.buttonBackground};
  color: ${({ theme }) => theme.buttonText};
  cursor: pointer;
  transition: all 0.2s ease-in-out;
  box-shadow: 2px 2px 0px ${({ theme }) => theme.text};

  &:hover {
    transform: translate(2px, 2px);
    box-shadow: 0px 0px 0px ${({ theme }) => theme.text};
  }
`;

const MessageInput = ({ onSendMessage }) => {
  const [input, setInput] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!input.trim()) return;
    onSendMessage(input);
    setInput('');
  };

  return (
    <FormContainer onSubmit={handleSubmit}>
      <Input
        type="text"
        value={input}
        onChange={(e) => setInput(e.target.value)}
        placeholder="Type a message..."
      />
      <Button type="submit">Send</Button>
    </FormContainer>
  );
};

export default MessageInput;