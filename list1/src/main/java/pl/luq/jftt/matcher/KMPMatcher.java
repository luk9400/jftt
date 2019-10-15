package pl.luq.jftt.matcher;

public class KMPMatcher {

  private static int[] computePrefixFunction(String pattern) {
    int m = pattern.length();
    int[] pi = new int[m];
    pi[0] = -1;
    int k = -1;

    for (int q = 1; q < m; q++) {
      while (k > -1 && (pattern.charAt(k + 1) != pattern.charAt(q))) {
        k = pi[k];
      }
      if (pattern.charAt(k + 1) == pattern.charAt(q)) {
        k++;
      }
      pi[q] = k;
    }

    return pi;
  }

  public static void kmpMatcher(String pattern, String text) {
    int n = text.length();
    int m = pattern.length();
    int[] pi = computePrefixFunction(pattern);
    int q = 0;

    for (int i = 0; i < n; i++) {
      while (q > 0 && (pattern.charAt(q) != text.charAt(i))) {
        q = pi[q - 1] + 1;
      }
      if (pattern.charAt(q) == text.charAt(i)) {
        q++;
      }
      if (q == m) {
        System.out.println("Pattern occurs with shift " + (i - m + 1));
        q = pi[q - 1] + 1;
      }
    }
  }
}
