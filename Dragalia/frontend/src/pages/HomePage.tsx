import React from 'react';
import { Link } from 'react-router-dom';
import { Page } from './Page';

export const HomePage = () => (
  <Page title="Home">
    <ul>
      <li>
        <Link to="/adventurers">Adventurer List</Link>
      </li>
      <li>
        <Link to="/weapons">Weapon List</Link>
      </li>
      <li>
        <Link to="/passives">Passive List</Link>
      </li>
      <li>
        <Link to="/wyrmprints">Wyrmprint List</Link>
      </li>
      <li>
        <Link to="/dragons">Dragon List</Link>
      </li>
      <li>
        <Link to="/facilities">Facility List</Link>
      </li>
      <li>
        <Link to="/materials">Material List</Link>
      </li>
      <li>
        <Link to="/account/adventurers">Your Adventurers</Link>
      </li>
      <li>
        <Link to="/account/weapons">Your Weapons</Link>
      </li>
      <li>
        <Link to="/account/passives">Your Passives</Link>
      </li>
      <li>
        <Link to="/account/wyrmprints">Your Wyrmprints</Link>
      </li>
      <li>
        <Link to="/account/dragons">Your Dragons</Link>
      </li>
      <li>
        <Link to="/account/facilities">Your Facilities</Link>
      </li>
      <li>
        <Link to="/account/inventory">Your Inventory</Link>
      </li>
    </ul>
  </Page>
);
