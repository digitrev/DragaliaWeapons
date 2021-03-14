/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import { PublicApi } from '../api/PublicData';

export const Example = () => {
  useEffect(() => {
    const doGetLimits = async () => {
      const api = new PublicApi();
      const unbindLimits = await api.getWeaponLevelLimits(3);
      console.log(unbindLimits);
    };
    doGetLimits();
  }, []);

  return <div>blank</div>;
};
