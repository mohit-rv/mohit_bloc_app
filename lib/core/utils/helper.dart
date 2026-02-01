class Helper {
  // Show safe print for debugging
  static void log(String message) {
    // ignore: avoid_print
    print("[APP_LOG] $message");
  }

  // Shorten long strings
  static String limit(String text, {int max = 50}) {
    if (text.length <= max) return text;
    return "${text.substring(0, max)}...";
  }
}
