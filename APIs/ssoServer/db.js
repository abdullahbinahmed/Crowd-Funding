const firebase = require('firebase-admin');

const serviceAccount = require('./firestorekey/users-818d2-a4f60c75f443.json');

firebase.initializeApp({
    credential: firebase.credential.cert(serviceAccount)
})

const firestoredb = firebase.firestore();
const userDB = firestoredb.collection('users');

module.exports = userDB ;