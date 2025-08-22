import React from 'react';
import styled from 'styled-components';

const HeaderContainer = styled.header`
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  background-color: ${({ theme }) => theme.background};
  color: ${({ theme }) => theme.text};
`;

const WalletName = styled.div`
  font-weight: bold;
`;

const Header = ({ walletName, children }) => {
  return (
    <HeaderContainer>
      <WalletName>{walletName}</WalletName>
      {children}
    </HeaderContainer>
  );
};

export default Header;