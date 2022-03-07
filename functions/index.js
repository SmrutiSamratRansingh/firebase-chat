const functions = require("firebase-functions");
const admin= require("firebase-admin");
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


admin.initializeApp();

exports.myFunction = functions
    .firestore
    .document("chats/{chatId}/messages/{messageId}")
    .onCreate((snapshot, context) => {
      return admin.messaging().sendToTopic(snapshot.data().topic, {
        "notification": {
          "title": snapshot.data().id,
          "body": snapshot.data().text,
        },
      });
    });
