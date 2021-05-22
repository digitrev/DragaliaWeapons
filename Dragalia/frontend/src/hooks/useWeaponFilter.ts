import { useState, useCallback } from 'react';
import { WeaponString } from '../components/WeaponIcon';

const useWeaponFilter = () => {
  const allSelected = {
    Axe: true,
    Blade: true,
    Bow: true,
    Dagger: true,
    Lance: true,
    Manacaster: true,
    Sword: true,
    Staff: true,
    Wand: true,
  } as { [key in WeaponString]: boolean };
  const [weaponFilter, setWeaponFilter] = useState(allSelected);

  const selectNone = () => {
    setWeaponFilter({} as { [key in WeaponString]: boolean });
  };

  const selectAll = () => {
    setWeaponFilter(allSelected);
  };

  const toggleWeapon = useCallback((weapon: WeaponString) => {
    setWeaponFilter((current) => {
      return {
        ...current,
        [weapon]: !current[weapon],
      };
    });
  }, []);

  return {
    weaponFilter,
    toggleWeapon,
    selectNone,
    selectAll,
  };
};

export default useWeaponFilter;
