/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import { AccountFacilityData } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { LoadingText } from '../../Loading';
import { Page } from '../Page';
import { AccountFacilityList } from './AccountFacilityList';

export const AccountFacilityPage = () => {
  const [accountFacilities, setAccountFacilities] = useState<
    AccountFacilityData[] | null
  >(null);
  const [accountFacilitiesLoading, setAccountFacilitiesLoading] = useState(
    true,
  );

  useEffect(() => {
    let cancelled = false;
    const doGetAccountFacilities = async () => {
      const api = new PrivateApi();
      const accountFacilityData = await api.getFacilities();
      if (!cancelled) {
        setAccountFacilities(accountFacilityData);
        setAccountFacilitiesLoading(false);
      }
    };
    doGetAccountFacilities();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <Page title="Your Facilities">
      {accountFacilitiesLoading ? (
        <LoadingText />
      ) : (
        <AccountFacilityList data={accountFacilities || []} />
      )}
    </Page>
  );
};
