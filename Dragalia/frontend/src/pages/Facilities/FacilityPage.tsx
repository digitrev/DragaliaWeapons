import { useEffect, useState } from 'react';
import { FacilityData } from '../../api/DataInterfaces';
import { PublicApi } from '../../api/GameData';
import { LoadingText } from '../Loading';
import { Page } from '../Page';
import { FacilityList } from './FacilityList';

export const FacilityPage = () => {
  const [facilities, setFacilities] = useState<FacilityData[] | null>(null);
  const [facilitiesLoading, setFacilitiesLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    const doGetFacilities = async () => {
      const api = new PublicApi();
      const facilityData = await api.getFacilities();
      if (!cancelled) {
        setFacilities(facilityData);
        setFacilitiesLoading(false);
      }
    };
    doGetFacilities();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <Page title="Facility List">
      {facilitiesLoading ? (
        <LoadingText />
      ) : (
        <FacilityList data={facilities || []} />
      )}
    </Page>
  );
};
