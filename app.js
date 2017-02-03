(function() {
  // Initialize Firebase
  const config = {
    apiKey: "AIzaSyCA8154u7XLQinnme6HvmZZk7i9_TS9UnY",
        authDomain: "myprojectexp.firebaseapp.com",
        databaseURL: "https://myprojectexp.firebaseio.com",
        storageBucket: "myprojectexp.appspot.com",
        messagingSenderId: "700611303995"
  };
  firebase.initializeApp(config);

  const preObject = document.getElementById('object');
  const dbRefObject = firebase.database().ref().child('object');

  dbRefObject.on('value', snap => console.log(snap.val()));

}());
