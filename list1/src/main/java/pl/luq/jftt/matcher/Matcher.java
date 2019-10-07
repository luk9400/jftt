package pl.luq.jftt.matcher;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

public class Matcher {
  private Set<Character> sigma;
  private ArrayList<HashMap<Character, Integer>> delta;
  private String pattern;
  private String text;

  public Matcher(String pattern, String text) {
    this.pattern = pattern;
    this.text = text;

    sigma = new HashSet<>();
    for (char a : text.toCharArray()) {
      sigma.add(a);
    }

    delta = new ArrayList<>();
    for (int i = 0; i <= pattern.length(); i++) {
      delta.add(new HashMap<>(sigma.size()));
    }
    computeTransitionFunction();
  }

  public void showTransitionFunction(){
    for (int i = 0; i <= pattern.length(); i++) {
      System.out.println(delta.get(i).toString());
    }
  }

  public void computeTransitionFunction() {
    int m = pattern.length();
    for (int q = 0; q <= m; q++) {
      for (Character a : sigma) {
        int k = Math.min(m + 1, q + 2);
        k--;
        while (!((pattern.substring(0, q) + a).endsWith(pattern.substring(0, k)))) {
          k--;
        }
        delta.get(q).put(a, k);
      }
    }
  }

  public void finiteAutomatonMatcher() {
    int n = text.length();
    int q = 0;
    for (int i = 0; i < n; i++) {
      q = delta.get(q).get(text.charAt(i));
      if (q == pattern.length()) {
        System.out.println("Pattern occurs with shift " + (i - pattern.length() + 1));
      }
    }
  }

  public static void main(String[] args) {
    Matcher matcher = new Matcher("ababaca", "abababacaba");
    matcher.finiteAutomatonMatcher();

    KMPMatcher.kmpMatcher("ababaca", "abababacaba");
  }
}
