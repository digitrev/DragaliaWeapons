/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { FC, useEffect, useState } from 'react';
import { AccountWeaponData, WeaponData } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';

interface Props {
  propValue: string;
}

export const AddWeapon: FC<Props> = ({ propValue }) => {
  const [weapons, setWeapons] = useState<WeaponData[] | null>(null);
  const [weaponsLoading, setWeaponsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetWeapons = async () => {
      const api = new PrivateApi();
      const weaponData = await api.getUntrackedWeapons();
      if (!cancelled) {
        setWeapons(weaponData);
        setWeaponsLoading(false);
      }
    };
    doGetWeapons();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    //Element picker
    //Weapon type picker
    //Weapon series picker
    //Rarity picker

    //show current weapons
    //Have a field with a button to track selected weapon
    <div>
      <div>{propValue}</div>
    </div>
  );
};
