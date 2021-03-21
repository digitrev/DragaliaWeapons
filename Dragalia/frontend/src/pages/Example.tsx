/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import React, { useEffect, useState } from 'react';
import { PrivateApi } from '../api/PrivateData';
import { PublicApi } from '../api/PublicData';

export const Example = () => {
  useEffect(() => {
    const doThing = async () => {
      const api = new PrivateApi();
      const thing = await api.getPassiveCosts();
      console.log(thing);
    };
    doThing();
  }, []);

  return <div>blank</div>;
};
