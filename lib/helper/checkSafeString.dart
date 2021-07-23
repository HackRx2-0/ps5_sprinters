bool checkSafeString(String text) {
  const potentialWords = ['otp'];
  bool result = false;
  text.toLowerCase();
  for (var i = 0; i < potentialWords.length && !result; i++) {
    result = text.contains(potentialWords[i]);
  }
  return result;
}
