/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React from 'react';
import { BrowserRouter, Redirect, Route, Switch } from 'react-router-dom';
import { AboutPage } from './pages/AboutPage';
import { AccountAdventurerPage } from './pages/Adventurers/AccountAdventurerPage';
import { AdventurerPage } from './pages/Adventurers/AdventurerPage';
import { AuthProvider } from './pages/Auth/Auth';
import { SignInPage } from './pages/Auth/SignInPage';
import { SignOutPage } from './pages/Auth/SignOutPage';
import { AuthorizedPage } from './pages/AuthorizedPage';
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
    <AuthProvider>
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
              <AuthorizedPage>
                <AccountAdventurerPage />
              </AuthorizedPage>
            </Route>
            <Route path="/account/facilities">
              <AuthorizedPage>
                <AccountFacilityPage />
              </AuthorizedPage>
            </Route>
            <Route path="/account/inventory">
              <AuthorizedPage>
                <InventoryPage />
              </AuthorizedPage>
            </Route>
            <Route path="/account/passives">
              <AuthorizedPage>
                <AccountPassivePage />
              </AuthorizedPage>
            </Route>
            <Route path="/account/dragons">
              <AuthorizedPage>
                <AccountDragonPage />
              </AuthorizedPage>
            </Route>
            <Route path="/account/weapons">
              <AuthorizedPage>
                <AccountWeaponPage />
              </AuthorizedPage>
            </Route>
            <Route path="/account/wyrmprints">
              <AuthorizedPage>
                <AccountWyrmprintPage />
              </AuthorizedPage>
            </Route>
            <Route path="/costs/adventurers">
              <AuthorizedPage>
                <AdventurerCostsPage />
              </AuthorizedPage>
            </Route>
            <Route path="/costs/dragons">
              <AuthorizedPage>
                <DragonCostsPage />
              </AuthorizedPage>
            </Route>
            <Route path="/costs/facilities">
              <AuthorizedPage>
                <FacilityCostsPage />
              </AuthorizedPage>
            </Route>
            <Route path="/costs/passives">
              <AuthorizedPage>
                <PassiveCostsPage />
              </AuthorizedPage>
            </Route>
            <Route path="/costs/weapons">
              <AuthorizedPage>
                <WeaponCostsPage />
              </AuthorizedPage>
            </Route>
            <Route path="/costs/wyrmprints">
              <AuthorizedPage>
                <WyrmprintCostsPage />
              </AuthorizedPage>
            </Route>
            <Route path="/costs/totals">
              <AuthorizedPage>
                <TotalCostsPage />
              </AuthorizedPage>
            </Route>
            <Route path="/example">
              <AuthorizedPage>
                <Example />
              </AuthorizedPage>
            </Route>

            {/* login/out */}
            <Route
              path="/signin"
              render={() => <SignInPage action="signin" />}
            />
            <Route
              path="/signin-callback"
              render={() => <SignInPage action="signin-callback" />}
            />
            <Route
              path="/signout"
              render={() => <SignOutPage action="signout" />}
            />
            <Route
              path="/signout-callback"
              render={() => <SignOutPage action="signout-callback" />}
            />

            {/* other */}
            <Route path="/about" component={AboutPage} />

            {/* fallback */}
            <Route component={NotFoundPage} />
          </Switch>
        </div>
      </BrowserRouter>
    </AuthProvider>
  );
};

export default App;
