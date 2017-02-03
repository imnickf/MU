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

  //login/signup elements
  const txtEmail = document.getElementById('txtEmail');
  const txtPassword = document.getElementById('txtPassword');
  const btnLogin = document.getElementById('btnLogin');
  const btnSignUp = document.getElementById('btnSignUp');
  const btnLogout = document.getElementById('btnLogout');

  //add Login event
  btnLogin.addEventListener('click', e => {
    const email = txtEmail.value;
    const pass = txtPassword.value;
    const auth = firebase.auth();

    const promise = auth.signInWithEmailAndPassword(email, pass);
    promise.catch(e => console.log(e.message));
  });


  //signup
  btnSignUp.addEventListener('click', e => {
    const email = txtEmail.value;
    const pass = txtPassword.value;
    const auth = firebase.auth();

    const promise = auth.createUserWithEmailAndPassword(email, pass);
    promise.catch(e => console.log(e.message));

  });

  btnLogout.addEventListener('click', e => {
    firebase.auth().signOut();
  });


  firebase.auth().onAuthStateChanged(firebaseUser => {
    if(firebaseUser) {
      console.log(firebaseUser);
      console.log('user has logged in');
      btnLogout.classList.remove('hide');
    } else{
      console.log('not logged in');
      btnLogout.classList.add('hide');
    }
  });

}());
