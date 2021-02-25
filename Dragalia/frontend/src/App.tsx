/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React from 'react';
import { BrowserRouter, Redirect, Route, Switch } from 'react-router-dom';
import { Example } from './pages/Example';
import { Header } from './pages/Header';
import { HomePage } from './pages/HomePage';
import { MaterialPage } from './pages/Materials/MaterialPage';
import { NotFoundPage } from './pages/NotFoundPage';
import { AccountWeaponsPage } from './pages/Weapons/AccountWeaponPage';
import { WeaponsPage } from './pages/Weapons/WeaponsPage';
import { fontFamily, fontSize, gray2 } from './Styles';

const App: React.FC = () => {
  return (
    <BrowserRouter>
      <div
        css={css`
          font-family: ${fontFamily};
          font-size: ${fontSize};
          color: ${gray2};
        `}
      >
        <Header />
        <Switch>
          <Redirect from="/home" to="/" />
          <Route exact path="/" component={HomePage} />
          <Route path="/weapons" component={WeaponsPage} />
          <Route path="/materials" component={MaterialPage} />
          <Route path="/account/weapons" component={AccountWeaponsPage} />
          <Route path="/example" component={Example} />
          <Route component={NotFoundPage} />
        </Switch>
      </div>
    </BrowserRouter>
  );
};

export default App;