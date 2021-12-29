import { parse } from 'query-string';
import { useState, Fragment, useEffect } from 'react';
import { useLocation } from 'react-router-dom';
import { AboutPage } from './pages/AboutPage';
import { AccountAdventurerPage } from './pages/Adventurers/AccountAdventurerPage';
import { AdventurerPage } from './pages/Adventurers/AdventurerPage';
import { ChestGroupPage } from './pages/Chests/ChestGroupPage';
import { RecommendationPage } from './pages/Chests/RecommendationPage';
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
import { SaveLoad } from './pages/Forms/SaveLoad';
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

export const MainPage = () => {
  const { search } = useLocation();
  const [toRender, setToRender] = useState<JSX.Element>(<Fragment />);

  useEffect(() => {
    const parsedPage = parse(search).page;
    switch (parsedPage) {
      case '':
        setToRender(<HomePage />);
        break;
      case 'quests':
        setToRender(<QuestPage />);
        break;
      case 'chests':
        setToRender(<ChestGroupPage />);
        break;
      case 'account/chests':
        setToRender(<RecommendationPage />);
        break;
      case 'materials':
        setToRender(<MaterialPage />);
        break;
      case 'account/inventory':
        setToRender(<InventoryPage />);
        break;
      case 'costs/totals':
        setToRender(<TotalCostsPage />);
        break;
      case 'adventurers':
        setToRender(<AdventurerPage />);
        break;
      case 'account/adventurers':
        setToRender(<AccountAdventurerPage />);
        break;
      case 'costs/adventurers':
        setToRender(<AdventurerCostsPage />);
        break;
      case 'weapons':
        setToRender(<WeaponPage />);
        break;
      case 'account/weapons':
        setToRender(<AccountWeaponPage />);
        break;
      case 'summary/weapons':
        setToRender(<WeaponSummaryPage />);
        break;
      case 'costs/weapons':
        setToRender(<WeaponCostsPage />);
        break;
      case 'passives':
        setToRender(<PassivePage />);
        break;
      case 'account/passives':
        setToRender(<AccountPassivePage />);
        break;
      case 'costs/passives':
        setToRender(<PassiveCostsPage />);
        break;
      case 'wyrmprints':
        setToRender(<WyrmprintPage />);
        break;
      case 'account/wyrmprints':
        setToRender(<AccountWyrmprintPage />);
        break;
      case 'costs/wyrmprints':
        setToRender(<WyrmprintCostsPage />);
        break;
      case 'dragons':
        setToRender(<DragonPage />);
        break;
      case 'account/dragons':
        setToRender(<AccountDragonPage />);
        break;
      case 'costs/dragons':
        setToRender(<DragonCostsPage />);
        break;
      case 'facilities':
        setToRender(<FacilityPage />);
        break;
      case 'account/facilities':
        setToRender(<AccountFacilityPage />);
        break;
      case 'costs/facilities':
        setToRender(<FacilityCostsPage />);
        break;
      case 'about':
        setToRender(<AboutPage />);
        break;
      case 'settings':
        setToRender(<SaveLoad />);
        break;
      default:
        setToRender(<NotFoundPage />);
        break;
    }
    if (parsedPage === undefined) setToRender(<HomePage />);
  }, [search]);

  return <Fragment>{toRender}</Fragment>;
};
