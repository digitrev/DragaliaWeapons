/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React from 'react';
import { BrowserRouter, Redirect, Route, Switch } from 'react-router-dom';
import { Example } from './pages/Example';
import { AccountFacilityPage } from './pages/Facilities/AccountFacilityPage';
import { FacilityPage } from './pages/Facilities/FacilityPage';
import { Header } from './pages/Header';
import { HomePage } from './pages/HomePage';
import { InventoryPage } from './pages/Materials/InventoryPage';
import { MaterialPage } from './pages/Materials/MaterialPage';
import { NotFoundPage } from './pages/NotFoundPage';
import { PassivePage } from './pages/Passives/PassivePage';
import { AccountWeaponPage } from './pages/Weapons/AccountWeaponPage';
import { WeaponsPage } from './pages/Weapons/WeaponsPage';
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
        <Switch>
          <Redirect from="/home" to="/" />
          <Route exact path="/" component={HomePage} />
          <Route path="/weapons" component={WeaponsPage} />
          <Route path="/passives" component={PassivePage} />
          <Route path="/materials" component={MaterialPage} />
          <Route path="/facilities" component={FacilityPage} />
          <Route path="/account/weapons" component={AccountWeaponPage} />
          <Route path="/account/facilities" component={AccountFacilityPage} />
          <Route path="/account/inventory" component={InventoryPage} />
          <Route path="/example" component={Example} />
          <Route component={NotFoundPage} />
        </Switch>
      </div>
    </BrowserRouter>
  );
};

export default App;
