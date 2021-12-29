/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import React from 'react';
import { BrowserRouter } from 'react-router-dom';
import { MainPage } from './MainPage';
import { Header } from './pages/Header';
import { fontFamily, fontSize, gray2 } from './Styles';

const App: React.FC = () => {
  return (
    <BrowserRouter>
      <link
        href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
        rel="stylesheet"
      ></link>
      <div
        css={css`
          font-family: ${fontFamily};
          font-size: ${fontSize};
          color: ${gray2};
        `}
      >
        <Header />
        <MainPage />
      </div>
    </BrowserRouter>
  );
};

export default App;
