class Validator {
  static String? validateInput({required String? input}) {
    if (input == null) {
      return null;
    }

    if (input.isEmpty) {
      return 'can\'t be empty';
    }
    return null;
  }
}