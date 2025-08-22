import React from 'react';
import styled from 'styled-components';

const Button = styled.button`
  background: ${({ theme }) => theme.background};
  border: 2px solid ${({ theme }) => theme.toggleBorder};
  color: ${({ theme }) => theme.text};
  border-radius: 30px;
  cursor: pointer;
  font-size: 0.8rem;
  padding: 0.6rem;
  transition: all 0.5s linear;
`;

const ThemeToggle = ({ theme, toggleTheme }) => {
  return (
    <Button onClick={toggleTheme}>
      {theme === 'light' ? 'Switch to Dark Mode' : 'Switch to Light Mode'}
    </Button>
  );
};

export default ThemeToggle;