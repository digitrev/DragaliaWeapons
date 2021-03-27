/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React from 'react';
import { BrowserRouter, Redirect, Route, Switch } from 'react-router-dom';
import { AccountAdventurerPage } from './pages/Adventurers/AccountAdventurerPage';
import { AdventurerPage } from './pages/Adventurers/AdventurerPage';
import { AccountDragonPage } from './pages/Dragons/AccountDragonPage';
import { DragonPage } from './pages/Dragons/DragonPage';
import { Example } from './pages/Example';
import { AccountFacilityPage } from './pages/Facilities/AccountFacilityPage';
import { FacilityPage } from './pages/Facilities/FacilityPage';
import { Header } from './pages/Header';
import { HomePage } from './pages/HomePage';
import { InventoryPage } from './pages/Materials/InventoryPage';
import { MaterialPage } from './pages/Materials/MaterialPage';
import { NotFoundPage } from './pages/NotFoundPage';
import { AccountPassivePage } from './pages/Passives/AccountPassivePage';
import { PassivePage } from './pages/Passives/PassivePage';
import { AccountWeaponPage } from './pages/Weapons/AccountWeaponPage';
import { WeaponPage } from './pages/Weapons/WeaponPage';
import { WyrmprintPage } from './pages/Wyrmprints/WyrmprintPage';
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
          <Route path="/adventurers" component={AdventurerPage} />
          <Route path="/dragons" component={DragonPage} />
          <Route path="/facilities" component={FacilityPage} />
          <Route path="/materials" component={MaterialPage} />
          <Route path="/passives" component={PassivePage} />
          <Route path="/weapons" component={WeaponPage} />
          <Route path="/wyrmprints" component={WyrmprintPage} />
          <Route
            path="/account/adventurers"
            component={AccountAdventurerPage}
          />
          <Route path="/account/facilities" component={AccountFacilityPage} />
          <Route path="/account/inventory" component={InventoryPage} />
          <Route path="/account/passives" component={AccountPassivePage} />
          <Route path="/account/dragons" component={AccountDragonPage} />
          <Route path="/account/weapons" component={AccountWeaponPage} />
          <Route path="/example" component={Example} />
          <Route component={NotFoundPage} />
        </Switch>
      </div>
    </BrowserRouter>
  );
};

export default App;
