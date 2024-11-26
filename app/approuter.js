const ar = require('@sap/approuter')();
const jwtDecode = require('jwt-decode');

ar.beforeRequestHandler.use('/my-jwt', function (req, res) {
    res.statusCode = 200;
    // res.headers['Content-Type'] = 'application/json';
    res.end(`${JSON.stringify(jwtDecode.jwtDecode(req.user.token.accessToken))}`);
});

ar.beforeRequestHandler.use('/raw-jwt', function (req, res) {
    res.statusCode = 200;
    // res.headers['Content-Type'] = 'application/json';
    res.end(req.user.token.accessToken);
});

ar.start();