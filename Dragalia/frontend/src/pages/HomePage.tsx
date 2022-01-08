import { Fragment } from 'react';
import { Link } from 'react-router-dom';
import { Page } from './Page';

export const HomePage = () => {
  return (
    <Page title="Home">
      <ul>
        <li>
          Quests
          <ul>
            <li>
              <Link to="/DragaliaWeapons?page=quests">Quest List</Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=chests">Chest List</Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=account/chests">
                Chest Recommendations
              </Link>
            </li>
          </ul>
        </li>
        <li>
          Materials
          <ul>
            <li>
              <Link to="/DragaliaWeapons?page=materials">Material List</Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=account/inventory">
                Your Inventory
              </Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=costs/totals">Total Costs</Link>
            </li>
          </ul>
        </li>
        <li>
          Adventurers
          <ul>
            <li>
              <Link to="/DragaliaWeapons?page=adventurers">
                Adventurer List
              </Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=account/adventurers">
                Your Adventurers
              </Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=costs/adventurers">
                Adventurer Costs
              </Link>
            </li>
          </ul>
        </li>
        <li>
          Weapons
          <ul>
            <li>
              <Link to="/DragaliaWeapons?page=weapons">Weapon List</Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=account/weapons">
                Your Weapons
              </Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=summary/weapons">
                Weapon Summary
              </Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=costs/weapons">Weapon Costs</Link>
            </li>
          </ul>
        </li>
        <li>
          Passives
          <ul>
            <li>
              <Link to="/DragaliaWeapons?page=passives">Passive List</Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=account/passives">
                Your Passives
              </Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=costs/passives">
                Passive Costs
              </Link>
            </li>
          </ul>
        </li>
        <li>
          Wyrmprints
          <ul>
            <li>
              <Link to="/DragaliaWeapons?page=wyrmprints">Wyrmprint List</Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=account/wyrmprints">
                Your Wyrmprints
              </Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=costs/wyrmprints">
                Wyrmprint Costs
              </Link>
            </li>
          </ul>
        </li>
        <li>
          Dragons
          <ul>
            <li>
              <Link to="/DragaliaWeapons?page=dragons">Dragon List</Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=account/dragons">
                Your Dragons
              </Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=costs/dragons">Dragon Costs</Link>
            </li>
          </ul>
        </li>
        <li>
          Facilities
          <ul>
            <li>
              <Link to="/DragaliaWeapons?page=facilities">Facility List</Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=account/facilities">
                Your Facilities
              </Link>
            </li>
            <li>
              <Link to="/DragaliaWeapons?page=costs/facilities">
                Facility Costs
              </Link>
            </li>
          </ul>
        </li>
      </ul>
    </Page>
  );
};
