import React from 'react';
import { Link } from 'react-router-dom';
import { Page } from './Page';

export const HomePage = () => (
  <Page title="Home">
    <ul>
      <li>
        <Link to="/weapons">Weapon List</Link>
      </li>
      <li>
        <Link to="/materials">Material List</Link>
      </li>
      <li>
        <Link to="/account/weapons">Your Weapons</Link>
      </li>
      <li>
        <Link to="/account/inventory">Your Inventory</Link>
      </li>
    </ul>
  </Page>
);
