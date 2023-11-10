public class Language2Matcher extends RegularExpressionMatcher {
    public Language2Matcher() {
        // TODO: Add your regular expression for language 2 below
        
        setRegularExpressionString("(04|06|09|11)-((0|1|2)\\p{Digit}|30)|(01|03|05|07|08|10|12)-((0|1|2)\\p{Digit}|30|31)|02-((0|1)\\p{Digit}|20|21|22|23|24|25|26|27|28)");
    }
}