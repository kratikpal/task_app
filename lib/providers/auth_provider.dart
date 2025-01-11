import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void clearErrorMessage() {
    _errorMessage = '';
    notifyListeners();
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String name}) async {
    setIsLoading(true);
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({'name': name, 'email': email});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        _errorMessage = 'The account already exists for that email.';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    setIsLoading(true);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        _errorMessage = 'Wrong password provided for that user.';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
