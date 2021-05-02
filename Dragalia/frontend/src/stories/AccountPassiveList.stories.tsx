/** @jsxImportSource @emotion/react */
import React from 'react';
import { AccountPassiveList } from '../pages/Passives/AccountPassiveList';
import { AccountPassiveData } from '../api/DataInterfaces';

const passiveData = [
  {
    passiveId: 1,
    owned: false,
    wanted: true,
    passive: {
      passiveId: 1,
      abilityNumber: 1,
      ability: 'Test Water Sword ability',
      element: 'Water',
      weaponType: 'Sword',
    },
  },
  {
    passiveId: 2,
    owned: false,
    wanted: true,
    passive: {
      passiveId: 2,
      abilityNumber: 2,
      ability: 'Another Test Water Sword ability',
      element: 'Water',
      weaponType: 'Sword',
    },
  },
  {
    passiveId: 3,
    owned: true,
    wanted: true,
    passive: {
      passiveId: 3,
      abilityNumber: 3,
      ability: 'Test Flame Sword ability',
      element: 'Flame',
      weaponType: 'Sword',
    },
  },
  {
    passiveId: 4,
    owned: true,
    wanted: true,
    passive: {
      passiveId: 4,
      abilityNumber: 4,
      ability: 'Second Flame Sword ability',
      element: 'Flame',
      weaponType: 'Sword',
    },
  },
  {
    passiveId: 5,
    owned: false,
    wanted: true,
    passive: {
      passiveId: 5,
      abilityNumber: 5,
      ability: 'Test Wind Dagger ability',
      element: 'Wind',
      weaponType: 'Dagger',
    },
  },
] as AccountPassiveData[];

const AccountPassiveListStories = {
  title: 'Account Passive List',
  component: AccountPassiveList,
  parameters: {},
};
export default AccountPassiveListStories;
const Template = (args: any) => <AccountPassiveList data={passiveData} />;
export const Primary = Template.bind({});
