package pl.luq.jftt.matcher;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

public class Matcher {
  private Set<Character> sigma;
  private ArrayList<HashMap<Character, Integer>> delta;
  private String pattern;


  public Matcher(String pattern, String alphabet) {
    this.pattern = pattern;

    sigma = new HashSet<>();
    for (char a : alphabet.toCharArray()) {
      sigma.add(a);
    }

    delta = new ArrayList<>();
    for (int i = 0; i <= pattern.length(); i++) {
      delta.add(new HashMap<>(sigma.size()));
    }
    computeTransitionFunction();
    //showTransitionFunction();
  }

  private void showTransitionFunction(){
    for (int i = 0; i <= pattern.length(); i++) {
      System.out.println(delta.get(i).toString());
    }
  }

  private boolean checkText(String text) {
    for (char c : text.toCharArray()) {
      if (!sigma.contains(c)) {
        return false;
      }
    }
    return true;
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

  public void finiteAutomatonMatcher(String text) {
    if (!checkText(text)) {
      System.out.println("Text contains illegal characters");
      return;
    }
    int n = text.length();
    int q = 0;
    for (int i = 0; i < n; i++) {
      q = delta.get(q).get(text.charAt(i));
      if (q == pattern.length()) {
        System.out.println("Pattern occurs with shift " + (i - pattern.length() + 1));
      }
    }
  }

  public static void tests() {
    String alphabet = "αβγδ";
    String[] patterns = {"δ", "γδ", "αβ", "αβαβ"};
    String textToTest = "αβαβγβαβαβαβαβγ";

    for (String pattern : patterns) {
      System.out.println(pattern);
      Matcher matcher = new Matcher(pattern, alphabet);
      matcher.finiteAutomatonMatcher(textToTest);

      KMPMatcher.kmpMatcher(pattern, textToTest);
    }

  }

  public static void main(String[] args) {
    tests();
//    Matcher matcher = new Matcher("ababaca", "abc");
//    matcher.finiteAutomatonMatcher("abababacaba");
//
//    KMPMatcher.kmpMatcher("ababaca", "abababacaba");
  }
}
