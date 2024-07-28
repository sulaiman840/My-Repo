importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

const firebaseConfig = {
  apiKey: "AIzaSyByFyhWeTuXTxC2OVT3w0-OmI7q-WHx3hc",
  authDomain: "warehouse-management-d8a87.firebaseapp.com",
  projectId: "warehouse-management-d8a87",
  storageBucket: "warehouse-management-d8a87.appspot.com",
  messagingSenderId: "193004774523",
  appId: "1:193004774523:web:4b3b459ea4d55f02a06ede",
  measurementId: "G-WBG1QY7VP6"
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});
