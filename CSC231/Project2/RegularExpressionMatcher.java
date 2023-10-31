import java.util.ArrayList;
import java.util.regex.Pattern;

public class RegularExpressionMatcher {

    protected String regularExpressionString;
    protected ArrayList<String> wordsToCompareAgainst;
    protected Pattern pattern;

    public RegularExpressionMatcher() {
        regularExpressionString = "";
        wordsToCompareAgainst = null;
    }

    public void setRegularExpressionString(String regexInput) {
        regularExpressionString = regexInput;
        pattern = Pattern.compile(regularExpressionString);
    }

    public String getRegularExpressionString() {
        return regularExpressionString;
    }

    public void setWordsToCompareAgainst(ArrayList<String> wordsInput) {
        wordsToCompareAgainst = wordsInput;
    }

    public ArrayList<String> findMatches() {

        // TODO: Given the ArrayList wordsToCompareaAgainst
        // and the pattern object representing
        // a regular expression, both of which have been set with data by
        // other methods, add to the ArrayList matchingList
        // the words that are in the wordsToCompareAgainst list that "match"
        // (could have been generated from) the regular expression
        // NOTE: Some guidance on how to do this is in the project description

        ArrayList<String> matchingList = new ArrayList<String>();

        // YOUR INSTRUCTIONS GO HERE

        return matchingList;
    }
}