/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { ChangeEvent, Fragment, useEffect, useState } from 'react';
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
  const [displayFacilities, setDisplayFacilities] = useState<
    AccountFacilityData[] | null
  >(null);
  const [progressFilter, setProgressFilter] = useState(false);

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

  useEffect(() => {
    let facilityFilter = accountFacilities;
    if (facilityFilter) {
      if (progressFilter) {
        facilityFilter = facilityFilter.filter(
          (f) => f.wantedLevel > f.currentLevel,
        );
      }
      setDisplayFacilities(facilityFilter);
    }
  }, [accountFacilities, progressFilter]);

  const handleChangeProgress = (e: ChangeEvent<HTMLInputElement>) => {
    setProgressFilter(e.currentTarget.checked);
  };

  return (
    <Page title="Your Facilities">
      {accountFacilitiesLoading ? (
        <LoadingText />
      ) : (
        <Fragment>
          <div>
            <input
              type="checkbox"
              name="inProgress"
              onChange={handleChangeProgress}
            />
            <label
              htmlFor="inProgress"
              css={css`
                font-weight: bold;
              `}
            >
              In Progress?
            </label>
          </div>
          <AccountFacilityList data={displayFacilities || []} />
        </Fragment>
      )}
    </Page>
  );
};
