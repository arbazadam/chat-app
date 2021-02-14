import 'dart:io';

import 'package:chat_app/widgets/auth/auth_form.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  static final routeName = '/auth-screen';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    File f,
    BuildContext ctx,
  ) async {
    UserCredential authResult;

    try {
      final collection = FirebaseFirestore.instance.collection('users');
      var imageUrl = '';
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user.uid);

        // await ref
        //     .putFile(f)
        //     .whenComplete(() async => imageUrl = await ref.getDownloadURL());

        await ref.putFile(f);
        final url = await ref.getDownloadURL();

        collection.doc(authResult.user.uid).set({
          'username': username,
          'email': email,
          'password': password,
          'imageFile': url
        });
      }
    } on FirebaseAuthException catch (err) {
      String errorMessage = '';
      if (err.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (err.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else if (err.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (err.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } 
      
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading=false;
      });
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      if (_isLoading == false) {
        Scaffold.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text(err.toString()),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
