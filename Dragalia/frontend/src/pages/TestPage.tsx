import { parse } from 'query-string';
import { Fragment, useEffect, useState } from 'react';
import { useLocation } from 'react-router-dom';
import { AboutPage } from './AboutPage';
import { AccountAdventurerPage } from './Adventurers/AccountAdventurerPage';
import { AdventurerPage } from './Adventurers/AdventurerPage';
import { ChestGroupPage } from './Chests/ChestGroupPage';
import { RecommendationPage } from './Chests/RecommendationPage';
import { AdventurerCostsPage } from './Costs/AdventurerCostsPage';
import { DragonCostsPage } from './Costs/DragonCostsPage';
import { FacilityCostsPage } from './Costs/FacilityCostsPage';
import { PassiveCostsPage } from './Costs/PassiveCostsPage';
import { TotalCostsPage } from './Costs/TotalCosts';
import { WeaponCostsPage } from './Costs/WeaponCostsPage';
import { WyrmprintCostsPage } from './Costs/WyrmprintCostPage';
import { AccountDragonPage } from './Dragons/AccountDragonPage';
import { DragonPage } from './Dragons/DragonPage';
import { AccountFacilityPage } from './Facilities/AccountFacilityPage';
import { FacilityPage } from './Facilities/FacilityPage';
import { SaveLoad } from './Forms/SaveLoad';
import { HomePage } from './HomePage';
import { InventoryPage } from './Materials/InventoryPage';
import { MaterialPage } from './Materials/MaterialPage';
import { NotFoundPage } from './NotFoundPage';
import { AccountPassivePage } from './Passives/AccountPassivePage';
import { PassivePage } from './Passives/PassivePage';
import { QuestPage } from './Quests/QuestPage';
import { AccountWeaponPage } from './Weapons/AccountWeaponPage';
import { WeaponPage } from './Weapons/WeaponPage';
import { WeaponSummaryPage } from './Weapons/WeaponSummaryPage';
import { AccountWyrmprintPage } from './Wyrmprints/AccountWyrmprintPage';
import { WyrmprintPage } from './Wyrmprints/WyrmprintPage';

export const TestPage = () => {
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
