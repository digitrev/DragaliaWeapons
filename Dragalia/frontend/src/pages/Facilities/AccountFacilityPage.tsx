/** @jsxImportSource @emotion/react */
import { css } from '@emotion/react';
import { ChangeEvent, Fragment, useEffect, useState } from 'react';
import { AccountFacilityData, FacilityLimit } from '../../api/DataInterfaces';
import { PrivateApi } from '../../api/PrivateData';
import { PublicApi } from '../../api/PublicData';
import { LoadingText } from '../Loading';
import { useAuth } from '../Auth/Auth';
import { Page } from '../Page';
import { AccountFacilityList } from './AccountFacilityList';

export const AccountFacilityPage = () => {
  const { getAccessToken } = useAuth();
  const [accountFacilities, setAccountFacilities] = useState<
    AccountFacilityData[] | null
  >(null);
  const [accountFacilitiesLoading, setAccountFacilitiesLoading] = useState(
    true,
  );
  const [displayFacilities, setDisplayFacilities] = useState<
    AccountFacilityData[] | null
  >(null);
  const [limits, setLimits] = useState<FacilityLimit[] | null>(null);

  const [progressFilter, setProgressFilter] = useState(false);

  useEffect(() => {
    let cancelled = false;
    const doGetPublicData = async () => {
      const api = new PublicApi();
      const limitData = await api.getAllFacilityLimits();
      if (!cancelled) {
        setLimits(limitData);
      }
    };
    const doGetAccountFacilities = async () => {
      const token = await getAccessToken();
      const api = new PrivateApi(token);
      const accountFacilityData = await api.getFacilities();
      if (!cancelled) {
        setAccountFacilities(accountFacilityData);
        setAccountFacilitiesLoading(false);
      }
    };
    doGetPublicData();
    doGetAccountFacilities();
    return () => {
      cancelled = true;
    };
  }, [getAccessToken]);

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
          <AccountFacilityList
            data={displayFacilities || []}
            limits={limits || []}
          />
        </Fragment>
      )}
    </Page>
  );
};
