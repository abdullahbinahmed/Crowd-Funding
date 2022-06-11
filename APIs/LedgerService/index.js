
 const { addDocument } =require('./services');
const express = require("express");
const bodyParser = require("body-parser");
const { initializeApp, applicationDefault, cert } = require('firebase-admin/app');
const { addEntry,getDocs } = require('./services');

// const settleMentService =require('./settlementService')
var port = 3030;

var serviceAccount = require("./ledger-711ff-firebase-adminsdk-arle0-27b8e951ca.json");

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

app.post('/transactionlog', async (req, res) => {
    console.log(req.body);
    var data = req.body;    
    
    let newDebiitEntry={
        "ledgerAccountId":data.ledgerAccountId,
        "poolAccountReference":data.poolAccountReference,
        "amount":data.amount,
        "campaignId":data.campaignId,
        "paymentId":data.paymentId,
        "currency":"PKR",
        "ledgerAccountType":"DEBIT", // DEBIT/CREDIT
        "postingDate":new Date()
     }
  
    
    
    getDocs('config').then(snapshot=>{
        // console.log();
        let generalAccount=snapshot.docs[0].data()
        let newCreditEntry={
            "ledgerAccountId":generalAccount.accountNumer,
            "poolAccountReference":data.poolAccountReference,
            "amount":data.amount,
            "campaignId":data.campaignId,
            "paymentId":data.paymentId,
            "currency":"PKR",
            "ledgerAccountType":"CREDIT", // DEBIT/CREDIT
            "postingDate":new Date()
            }
        console.log(generalAccount)


        try {
            let promise=Promise.all([
                addEntry(newDebiitEntry),
                addEntry(newCreditEntry)
            ]).then(response=>{
                if(!response[0]){
                    res.status(500).send({'status':'failed','message':'failed to add new debit entry'});
                }else if (!response[1]){
                    res.status(500).send({'status':'failed','message':'failed to add new credit entry'});
                }else{
                    res.status(200).send({'status':'successful'});
    
                }
    
            }).catch(err=>{
                console.log(err)

                res.status(500).send({'status':'failed'});
    
            })
          
        } catch (error) {
    
            res.status(500).send( {"status":"failed", "message": "Failed to process request." });
                
        }

    }).catch(err=>{
        console.log(err)

        res.status(500).send( {"status":"failed", "message": "Failed to process request." });

    })

    

});




app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
  })