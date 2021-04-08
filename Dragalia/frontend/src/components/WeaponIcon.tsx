import React from 'react';
import Axe from '../img/weapon/Axe.png';
import Blade from '../img/weapon/Blade.png';
import Bow from '../img/weapon/Bow.png';
import Dagger from '../img/weapon/Dagger.png';
import Lance from '../img/weapon/Lance.png';
import Manacaster from '../img/weapon/Manacaster.png';
import Sword from '../img/weapon/Sword.png';
import Staff from '../img/weapon/Staff.png';
import Wand from '../img/weapon/Wand.png';

export type WeaponString =
  | 'Axe'
  | 'Blade'
  | 'Bow'
  | 'Dagger'
  | 'Lance'
  | 'Manacaster'
  | 'Sword'
  | 'Staff'
  | 'Wand';
export interface WeaponIconProps {
  weaponType: WeaponString;
}

const map: {
  [K in WeaponString]: string;
} = {
  Axe: Axe,
  Blade: Blade,
  Bow: Bow,
  Dagger: Dagger,
  Lance: Lance,
  Manacaster: Manacaster,
  Sword: Sword,
  Staff: Staff,
  Wand: Wand,
};
export const WeaponIcon: React.FC<WeaponIconProps> = (props) => {
  return (
    <img
      src={map[props.weaponType]}
      alt={props.weaponType}
      height={17}
      style={{ marginBottom: '-3px' }}
    />
  );
};
