import { Button, ButtonGroup } from '@material-ui/core';
import { FC } from 'react';
import { WeaponIcon, WeaponString } from './WeaponIcon';

export interface WeaponSelectProps {
  weaponFilter: { [key in WeaponString]: boolean };
  toggleWeapon: (weaponType: WeaponString) => void;
  selectNone: () => void;
  selectAll: () => void;
}

export const WeaponSelect: FC<WeaponSelectProps> = ({
  weaponFilter,
  toggleWeapon,
  selectNone,
  selectAll,
}) => {
  const weapons: WeaponString[] = [
    'Sword',
    'Blade',
    'Axe',
    'Dagger',
    'Lance',
    'Bow',
    'Wand',
    'Staff',
    'Manacaster',
  ];
  return (
    <>
      <ButtonGroup>
        {weapons.map((weapon) => {
          return (
            <Button
              onClick={() => toggleWeapon(weapon)}
              color={weaponFilter[weapon] ? 'primary' : 'default'}
              variant={weaponFilter[weapon] ? 'contained' : undefined}
            >
              <WeaponIcon weaponType={weapon} />
            </Button>
          );
        })}
        <Button onClick={selectAll}>Select All</Button>
        <Button onClick={selectNone}>Select None</Button>
      </ButtonGroup>
    </>
  );
};
