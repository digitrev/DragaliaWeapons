'use strict';
var express = require('express');
var router = express.Router();
var https = require('https');
const axios = require('axios').default;

var dragalia = axios.create({
    baseURL: 'https://localhost:44323/api/',
    timeout: 1000,
    httpsAgent: https.Agent({
        rejectUnauthorized: false
    })
});

/* GET home page. */
router.get('/', function (req, res) {
    res.render('index', { title: 'Index' });
});

/* GET accounts page. */
router.get('/accounts', async (req, res) => {
    const accountsData = await dragalia.get('/Accounts');
    res.render('accounts', { title: 'DL Accounts', data: accountsData.data });
});

router.get('/account/:accountId', async (req, res) => {
    const accountData = await dragalia.get('/Accounts/' + req.params.accountId);
    const weaponData = await dragalia.get('/AccountWeapons/' + req.params.accountId)
    console.log(weaponData);
    res.render('account', { title: 'Account', account: accountData.data, weapons: weaponData.data });
});

module.exports = router;
