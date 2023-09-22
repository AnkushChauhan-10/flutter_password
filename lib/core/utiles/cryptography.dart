const upperCaseCipher = 18;
const lowerCaseCipher = 13;
const digitCipher = 7;


final int A = 'A'.codeUnitAt(0);
final int Z = 'Z'.codeUnitAt(0);

final int a = 'a'.codeUnitAt(0);
final int z = 'z'.codeUnitAt(0);

final int zero = '0'.codeUnitAt(0);
final int nine = '9'.codeUnitAt(0);

String encodePassword(String p) {
  String temp = "";
  for (int i = 0; i < p.length; i++) {
    int ch = p[i].codeUnitAt(0);
    if (ch >= A && ch <= Z) {
      ch = ch - A;
      temp += String.fromCharCode((ch + upperCaseCipher) % 26 + A);
    } else if (ch >= a && ch <= z) {
      ch = ch - a;
      temp += String.fromCharCode((ch + lowerCaseCipher) % 26 + a);
    } else if (ch >= zero && ch <= nine) {
      ch = ch - zero;
      temp += String.fromCharCode((ch + digitCipher) % 10 + zero);
    } else {
      temp += p[i];
    }
  }
  return temp;
}

String decodePassword(String p) {
  String temp = "";
  for (int i = 0; i < p.length; i++) {
    int ch = p[i].codeUnitAt(0);
    if (ch >= A && ch <= Z) {
      ch = ch - A;
      temp += String.fromCharCode((ch - upperCaseCipher) % 26 + A);
    } else if (ch >= a && ch <= z) {
      ch = ch - a;
      temp += String.fromCharCode((ch - lowerCaseCipher) % 26 + a);
    } else if (ch >= zero && ch <= nine) {
      ch = ch - zero;
      temp += String.fromCharCode((ch - digitCipher) % 10 + zero);
    } else {
      temp += p[i];
    }
  }
  return temp;
}
