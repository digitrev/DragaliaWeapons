import { Page } from './Page';

export const AboutPage = () => {
  return (
    <Page title="About">
      <p>
        This is a simple site for tracking your upgradable entites in Dragalia
        Lost. This is also my first time doing any front-end stuff, so apologies
        if things are a little awkward and broken.
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
        <a
          href="https://github.com/digitrev/DragaliaWeapons"
          target="_blank"
          rel="noreferrer"
        >
          Github
        </a>
        . You can also open issues there or even contribute code. I'll put a
        little thank you here if you do.
      </p>
      <p>
        Save/load is just the data structure encoded in base64, so if you want
        to muck around with your save data, try{' '}
        <a
          href="https://www.base64decode.org/"
          target="_blank"
          rel="noreferrer"
        >
          base64 decode/encode
        </a>
        .
      </p>
      <p>
        Thanks to:
        <ul>
          <li>asufyani</li>
        </ul>
      </p>
    </Page>
  );
};
