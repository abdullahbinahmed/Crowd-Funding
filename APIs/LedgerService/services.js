
const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');
const { v4: uuidv4 } = require('uuid');

const addEntry=async(data)=>{
    
    try {
        const db = getFirestore();

        const docRef = db.collection('ledger');
        let newEntry={
            "ledgerAccountId":data.ledgerAccountId,
            "poolAccountReference":data.poolAccountReference,
            "amount":data.amount,
            "campaignId":data.campaignId,
            "paymentId":data.paymentId,
            "currency":"PKR",
            "ledgerAccountType":data.ledgerAccountType, // DEBIT/CREDIT
            "postingDate":new Date(),
            "ledgerPostingId":uuidv4(),
                        }
          await docRef.add(
            newEntry
                
                
        );

        return true;
    }
    catch (error) {
        console.error(error);
        return false;
    }
}
const getDocs= (collection)=>{
    const db = getFirestore();
    const docRef = db.collection(collection);
    
    return docRef.get()
    
}


module.exports={
    addEntry,
    getDocs
}