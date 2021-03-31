/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React from 'react';
import { BrowserRouter, Redirect, Route, Switch } from 'react-router-dom';
import { AccountAdventurerPage } from './pages/Adventurers/AccountAdventurerPage';
import { AdventurerPage } from './pages/Adventurers/AdventurerPage';
import { AdventurerCostsPage } from './pages/Costs/AdventurerCostsPage';
import { DragonCostsPage } from './pages/Costs/DragonCostsPage';
import { FacilityCostsPage } from './pages/Costs/FacilityCostsPage';
import { PassiveCostsPage } from './pages/Costs/PassiveCostsPage';
import { TotalCostsPage } from './pages/Costs/TotalCosts';
import { WeaponCostsPage } from './pages/Costs/WeaponCostsPage';
import { WyrmprintCostsPage } from './pages/Costs/WyrmprintCostPage';
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
import { QuestPage } from './pages/Quests/QuestPage';
import { AccountWeaponPage } from './pages/Weapons/AccountWeaponPage';
import { WeaponPage } from './pages/Weapons/WeaponPage';
import { AccountWyrmprintPage } from './pages/Wyrmprints/AccountWyrmprintPage';
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
          <Route path="/quests" component={QuestPage} />
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
          <Route path="/account/wyrmprints" component={AccountWyrmprintPage} />
          <Route path="/costs/adventurers" component={AdventurerCostsPage} />
          <Route path="/costs/dragons" component={DragonCostsPage} />
          <Route path="/costs/facilities" component={FacilityCostsPage} />
          <Route path="/costs/passives" component={PassiveCostsPage} />
          <Route path="/costs/weapons" component={WeaponCostsPage} />
          <Route path="/costs/wyrmprints" component={WyrmprintCostsPage} />
          <Route path="/costs/totals" component={TotalCostsPage} />
          <Route path="/example" component={Example} />
          <Route component={NotFoundPage} />
        </Switch>
      </div>
    </BrowserRouter>
  );
};

export default App;
