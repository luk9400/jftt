package pl.luq.jftt.matcher;

public class KMPMatcher {

  private static int[] computePrefixFunction(String pattern) {
    int m = pattern.length();
    int[] pi = new int[m];
    //pi[0] = 0;
    int k = 0;

    for (int q = 2; q < m; q++) {
      while (k > 0 && (pattern.charAt(k + 1) != pattern.charAt(q))) {
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
      while (q > 0 && (pattern.charAt(q + 1) != text.charAt(i))) {
        q = pi[q];
      }
      if (pattern.charAt(q + 1) == text.charAt(i)) {
        q++;
      }
      if (q == m) {
        System.out.println("Pattern occurs with shift " + (i - pattern.length() + 1));
        q = pi[q];
      }
    }
  }
}
