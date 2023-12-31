
const express = require("express");
const bodyParser = require("body-parser");
const { initializeApp, applicationDefault, cert } = require('firebase-admin/app');
const { addData, getCampaigns, update } = require('./campaign');
var port = 4000;

var serviceAccount = require("./campaigns-55bd5-firebase-adminsdk-adyt6-925903eabb.json");

const app = express();

app.use(express.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

initializeApp({
    credential: cert(serviceAccount)
});


app.get('/', (req, res) => {
    res.end("OK");
});

app.get('/campaign', async (req, res) => {
    var campaigns = await getCampaigns();
    res.json(campaigns);
})

app.post('/campaign', async (req, res) => {
    console.log(req.body);
    var body = req.body;

    var isSuccess = await addData(body);
    body.amountAchieved = "0";

    res.statusCode = isSuccess ? 201 : 500;
    res.json(isSuccess ? body : { "error": "Failed to process request." });
});


app.put('/campaign', async (req, res) => {
    console.log(req.body);
    var body = req.body;

    var isSuccess = await update(body.campaignId, body.amount);

    res.statusCode = isSuccess ? 200 : 500;
    res.json(isSuccess ? body : { "error": "Failed to process request." });
});


app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})