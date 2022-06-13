const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');


async function addData(req) {
    try {
        const db = getFirestore();

        var randomId = Math.floor(Math.random(0000000, 9999999) * 10000000).toString().padStart(7, '0');
        const docRef = db.collection('campaign').doc(`campaign-${randomId}`);

        var startDate = new Date(req.startDate);
        var endDate = new Date(req.endDate);

        await docRef.set({
            "description": req.description,
            "enddate": endDate,
            "id": `c-${randomId}`,
            "name": req.name,
            "startdate": startDate,
            "targetAmount": "20000",
            "amountAchieved": "0",
            "userId": req.userId,
            "imagePath": "https://st.depositphotos.com/1092019/2964/i/450/depositphotos_29644465-stock-photo-keyboard-with-crowd-funding-button.jpg",
            "createddate": new Date(),
            "backers": "0",
            "fundingtype": req.fundingtype,
            "creatorname": req.creatorname
        });
        req.id = `c-${randomId}`;
        req.backers ="0";
        req.daysleft="0";
        return true;
    }
    catch (error) {
        console.error(error);
        return false;
    }
}


async function getCampaigns() {

    var campaigns = [];
    const db = getFirestore();
    const docRef = db.collection('campaign');
    var snapshot = await docRef.orderBy('createddate', 'desc').limit(10).get();


    if (snapshot.empty) {
        return {};
    }

    snapshot.forEach(doc => {
        campaigns.push(doc.data());
        campaigns[campaigns.length - 1].enddate = doc.data().enddate.toDate();
        campaigns[campaigns.length - 1].startdate = doc.data().startdate.toDate();
        campaigns[campaigns.length - 1].createddate = doc.data().createddate.toDate();

        const ONE_DAY = 1000 * 60 * 60 * 24;

        // Calculate the difference in milliseconds
        const differenceMs = Math.abs(doc.data().enddate.toDate() - doc.data().startdate.toDate());
        // Convert back to days and return
        campaigns[campaigns.length - 1].daysleft = Math.round(differenceMs / ONE_DAY).toString();
        console.log(campaigns[campaigns.length - 1].daysleft);

    });

    console.log(campaigns);
    return { "count": campaigns.length, "campaigns": campaigns };
}


async function update(camapaignId, amount) {
    try {
        const db = getFirestore();

        const campaignRef = db.collection('campaign').doc(camapaignId);
        const doc = await campaignRef.get();
        if (!doc.exists) {
            console.log('No such document!');
        } else {
            console.log('Document data:', doc.data().amountAchieved);
            var current_amount = doc.data().amountAchieved;
            var current_backers = doc.data().backers;
            var updated_amount = Number(current_amount) + Number(amount);
            var updated_backers = Number(current_backers) + 1;
            console.log(updated_amount);
            const res = await campaignRef.update({ amountAchieved: updated_amount.toString(), backers: updated_backers.toString() });
            console.log(res);
            return true;
        }
    }
    catch (error) {
        console.error(error);
        return false;
    }
}




// // Date.prototype.addDays = function (days) {
// //     this.setDate(this.getDate() + parseInt(days));
// //     return this;
// // }


module.exports = { addData, getCampaigns, update };