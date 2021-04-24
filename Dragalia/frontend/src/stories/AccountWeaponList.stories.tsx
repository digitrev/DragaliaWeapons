/** @jsxImportSource @emotion/react */
import React from 'react';
import { AccountWeaponList } from '../pages/Weapons/AccountWeaponList';
import { AccountWeaponData, WeaponLimit } from '../api/DataInterfaces';

const weaponData: AccountWeaponData[] = [
  {
    weaponId: 1,
    copies: 1,
    copiesWanted: 4,
    weaponLevel: 40,
    weaponLevelWanted: 60,
    unbind: 3,
    unbindWanted: 6,
    refine: 1,
    refineWanted: 2,
    slot: 1,
    slotWanted: 1,
    dominion: 0,
    dominionWanted: 0,
    bonus: 0,
    bonusWanted: 0,
    weapon: {
      weaponId: 1,
      weapon: 'Durandal',
      weaponSeries: 'Agito',
      weaponType: 'Sword',
      rarity: 6,
      element: 'Wind',
    },
  },
  {
    weaponId: 2,
    copies: 1,
    copiesWanted: 4,
    weaponLevel: 40,
    weaponLevelWanted: 60,
    unbind: 3,
    unbindWanted: 6,
    refine: 1,
    refineWanted: 2,
    slot: 1,
    slotWanted: 1,
    dominion: 1,
    dominionWanted: 0,
    bonus: 0,
    bonusWanted: 0,
    weapon: {
      weaponId: 1,
      weapon: 'Tyrfing',
      weaponSeries: 'Agito',
      weaponType: 'Blade',
      rarity: 6,
      element: 'Flame',
    },
  },
  {
    weaponId: 3,
    copies: 1,
    copiesWanted: 4,
    weaponLevel: 40,
    weaponLevelWanted: 60,
    unbind: 3,
    unbindWanted: 6,
    refine: 1,
    refineWanted: 2,
    slot: 1,
    slotWanted: 1,
    dominion: 0,
    dominionWanted: 0,
    bonus: 0,
    bonusWanted: 0,
    weapon: {
      weaponId: 1,
      weapon: 'Areadbhar',
      weaponSeries: 'Agito',
      weaponType: 'Lance',
      rarity: 6,
      element: 'Light',
    },
  },
];

const AccountWeaponListStories = {
  title: 'Account Weapon List',
  component: AccountWeaponList,
  parameters: {},
};
export default AccountWeaponListStories;
const Template = (args: any) => (
  <AccountWeaponList data={weaponData} limits={[] as WeaponLimit[]} />
);
export const Primary = Template.bind({});
