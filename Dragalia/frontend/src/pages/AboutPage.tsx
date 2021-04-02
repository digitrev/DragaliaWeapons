/** @jsxImportSource @emotion/react */
import { css, jsx } from '@emotion/react';
import { Page } from './Page';

export const AboutPage = () => {
  return (
    <Page title="About">
      <p>
        This is a simple site for tracking your upgradable entites in Dragalia
        Lost.
      </p>
      <p>
        Most data comes from{' '}
        <a href="https://dragalialost.wiki" target="_blank" rel="noreferrer">
          The Dragalia Lost Wiki
        </a>
        . Special thanks to the editors for keeping the data up to date, and for
        providing a nice API so I can keep my data up to date.
      </p>
      <p>
        Source code can be found at{' '}
        <a href="https://github.com/digitrev/DragaliaWeapons">github</a>.
      </p>
      <p>
        I don't have a privacy statement, but all I store is your name, email,
        and the data you provide through the app.
      </p>
    </Page>
  );
};
