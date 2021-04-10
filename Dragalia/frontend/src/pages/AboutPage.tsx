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
        I don't have a privacy statement, but all I store is your name, email,
        and the data you provide through the app.
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
