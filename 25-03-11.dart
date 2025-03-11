class Solution {
  String findTheDifference(String s, String t) {
    String temp = t; // t를 임시로 복사
    // s의 글자를 하나씩 temp에서 지우기
    for (int i = 0; i < s.length; i++) {
      temp = temp.replaceFirst(s[i], '');
    }
    return temp; // 남은 한 글자가 답
  }
}

void main() {
  Solution solution = Solution();
  print(solution.findTheDifference("abcd", "abcde")); // "e"
  print(solution.findTheDifference("", "y")); // "y"
  print(solution.findTheDifference("aabbcc", "aabbcce")); // "e"
}
