class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure(
      [this.message = "An Unknown error occured"]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
            'Please enter a stronger password.');
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
            'Email is invalid or badyly formatted.');
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
            'The email already used for an account.');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
            'Operation is not allowed. Please contact support.');
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
            'The user has been disabled. Please contact support for help.');
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}
