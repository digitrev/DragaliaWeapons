/** @jsxImportSource @emotion/react */
import React from 'react';
import { AccountAdventurerList } from '../pages/Adventurers/AccountAdventurerList';
import { AccountAdventurerData } from '../api/DataInterfaces';

const adventurerData = [
  {
    adventurerId: 1,
    currentLevel: 80,
    wantedLevel: 100,
    adventurer: {
      adventurerId: 1,
      adventurer: 'Althemia',
      rarity: 3,
      element: 'Shadow',
      weaponType: 'Wand',
      mcLimit: 70,
    },
  },
  {
    adventurerId: 2,
    currentLevel: 80,
    wantedLevel: 100,
    adventurer: {
      adventurerId: 2,
      adventurer: 'Ezelith',
      rarity: 5,
      element: 'Flame',
      weaponType: 'Dagger',
      mcLimit: 70,
    },
  },
  {
    adventurerId: 3,
    currentLevel: 80,
    wantedLevel: 100,
    adventurer: {
      adventurerId: 3,
      adventurer: 'Elisanne',
      rarity: 4,
      element: 'Water',
      weaponType: 'Lance',
      mcLimit: 70,
    },
  },
] as AccountAdventurerData[];

const AccountAdventurerListStories = {
  title: 'Account Adventurer List',
  component: AccountAdventurerList,
  parameters: {},
};
export default AccountAdventurerListStories;
const Template = (args: any) => <AccountAdventurerList data={adventurerData} />;
export const Primary = Template.bind({});
