/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import React from 'react';
import { BrowserRouter, Redirect, Route, Switch } from 'react-router-dom';
import { AboutPage } from './pages/AboutPage';
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
import { WeaponSummaryPage } from './pages/Weapons/WeaponSummaryPage';
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

          {/* public stuff */}
          <Route path="/adventurers" component={AdventurerPage} />
          <Route path="/dragons" component={DragonPage} />
          <Route path="/facilities" component={FacilityPage} />
          <Route path="/materials" component={MaterialPage} />
          <Route path="/passives" component={PassivePage} />
          <Route path="/quests" component={QuestPage} />
          <Route path="/weapons" component={WeaponPage} />
          <Route path="/wyrmprints" component={WyrmprintPage} />

          {/* account stuff */}
          <Route path="/account/adventurers">
            <AccountAdventurerPage />
          </Route>
          <Route path="/account/facilities">
            <AccountFacilityPage />
          </Route>
          <Route path="/account/inventory">
            <InventoryPage />
          </Route>
          <Route path="/account/passives">
            <AccountPassivePage />
          </Route>
          <Route path="/account/dragons">
            <AccountDragonPage />
          </Route>
          <Route path="/account/weapons">
            <AccountWeaponPage />
          </Route>
          <Route path="/summary/weapons">
            <WeaponSummaryPage />
          </Route>
          <Route path="/account/wyrmprints">
            <AccountWyrmprintPage />
          </Route>
          <Route path="/costs/adventurers">
            <AdventurerCostsPage />
          </Route>
          <Route path="/costs/dragons">
            <DragonCostsPage />
          </Route>
          <Route path="/costs/facilities">
            <FacilityCostsPage />
          </Route>
          <Route path="/costs/passives">
            <PassiveCostsPage />
          </Route>
          <Route path="/costs/weapons">
            <WeaponCostsPage />
          </Route>
          <Route path="/costs/wyrmprints">
            <WyrmprintCostsPage />
          </Route>
          <Route path="/costs/totals">
            <TotalCostsPage />
          </Route>

          {/* other */}
          <Route path="/about" component={AboutPage} />

          {/* fallback */}
          <Route component={NotFoundPage} />
        </Switch>
      </div>
    </BrowserRouter>
  );
};

export default App;
