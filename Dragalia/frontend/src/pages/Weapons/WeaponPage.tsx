import { useEffect, useState } from 'react';
import { WeaponData } from '../../api/DataInterfaces';
import { PublicApi } from '../../api/GameData';
import { LoadingText } from '../Loading';
import { Page } from '../Page';
import { WeaponList } from './WeaponList';

export const WeaponPage = () => {
  const [weapons, setWeapons] = useState<WeaponData[] | null>(null);
  const [weaponsLoading, setWeaponsLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetWeapons = async () => {
      const api = new PublicApi();
      const weaponData = await api.getWeapons();
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
    <Page title="Weapon List">
      {weaponsLoading ? <LoadingText /> : <WeaponList data={weapons || []} />}
    </Page>
  );
};
