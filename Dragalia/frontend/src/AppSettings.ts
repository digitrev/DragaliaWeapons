export const server =
  process.env.REACT_APP_ENV === 'production'
    ? 'https://dragaliaapi.azurewebsites.net'
    : process.env.REACT_APP_ENV === 'staging'
    ? 'https://dragaliaapistaging.azurewebsites.net'
    : 'http://localhost:5000';

export const webAPIUrl = `${server}/api`;

export const submitDelay = 0;

export const displayLimit = 20;
export const pageRangeDisplayed = 5;
export const marginPagesDisplayed = 2;

export const authSettings = {
  domain: 'dev-7fftggv6.us.auth0.com',
  client_id: '4U1Mltw1sbpLgWNMssUvylHRBFYOjzQN',
  redirect_uri: window.location.origin + '/signin-callback',
  scope: 'openid profile dragaliaFarmApi email',
  audience: 'https://dragaliafarming',
};
