import React from 'react';
import { Link } from 'react-router-dom';
import { Page } from './Page';

export const HomePage = () => (
  <Page title="Home">
    <Link to="/weapons">Weapon List</Link>
  </Page>
);
