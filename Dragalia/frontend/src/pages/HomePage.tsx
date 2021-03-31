import React from 'react';
import { Link } from 'react-router-dom';
import { Page } from './Page';

export const HomePage = () => (
  <Page title="Home">
    <ul>
      <li>
        Quests
        <ul>
          <li>
            <Link to="/quests">Quest List</Link>
          </li>
        </ul>
      </li>
      <li>
        Materials
        <ul>
          <li>
            <Link to="/materials">Material List</Link>
          </li>
          <li>
            <Link to="/account/inventory">Your Inventory</Link>
          </li>
          <li>
            <Link to="/costs/totals">Total Costs</Link>
          </li>
        </ul>
      </li>
      <li>
        Adventurers
        <ul>
          <li>
            <Link to="/adventurers">Adventurer List</Link>
          </li>
          <li>
            <Link to="/account/adventurers">Your Adventurers</Link>
          </li>
          <li>
            <Link to="/costs/adventurers">Adventurer Costs</Link>
          </li>
        </ul>
      </li>
      <li>
        Weapons
        <ul>
          <li>
            <Link to="/weapons">Weapon List</Link>
          </li>
          <li>
            <Link to="/account/weapons">Your Weapons</Link>
          </li>
          <li>
            <Link to="/costs/weapons">Weapon Costs</Link>
          </li>
        </ul>
      </li>
      <li>
        Passives
        <ul>
          <li>
            <Link to="/passives">Passive List</Link>
          </li>
          <li>
            <Link to="/account/passives">Your Passives</Link>
          </li>
          <li>
            <Link to="/costs/passives">Passive Costs</Link>
          </li>
        </ul>
      </li>
      <li>
        Wyrmprints
        <ul>
          <li>
            <Link to="/wyrmprints">Wyrmprint List</Link>
          </li>
          <li>
            <Link to="/account/wyrmprints">Your Wyrmprints</Link>
          </li>
          <li>
            <Link to="/costs/wyrmprints">Wyrmprint Costs</Link>
          </li>
        </ul>
      </li>
      <li>
        Dragons
        <ul>
          <li>
            <Link to="/dragons">Dragon List</Link>
          </li>
          <li>
            <Link to="/account/dragons">Your Dragons</Link>
          </li>
          <li>
            <Link to="/costs/dragons">Dragon Costs</Link>
          </li>
        </ul>
      </li>
      <li>
        Facilities
        <ul>
          <li>
            <Link to="/facilities">Facility List</Link>
          </li>
          <li>
            <Link to="/account/facilities">Your Facilities</Link>
          </li>
          <li>
            <Link to="/costs/facilities">Facility Costs</Link>
          </li>
        </ul>
      </li>
    </ul>
  </Page>
);
