import org.junit.Before;
import org.junit.Test;

import java.util.ArrayList;

import static org.junit.Assert.*;

public class RegularExpressionMatcherTest {

    ArrayList<String> wordsToTest;
    ArrayList<String> expectedResults;

    @Before
    public void setUp() throws Exception {
        wordsToTest = new ArrayList<String>();
        expectedResults = new ArrayList<String>();
    }

    @Test
    public void test_language1() {
        expectedResults.clear();
        expectedResults.add("AGCTG");
        expectedResults.add("AGAGCTG");
        expectedResults.add("AGCTCTG");
        expectedResults.add("GTAGCTG");
        expectedResults.add("CAGCTG");
        expectedResults.add("AGCTGGC");
        expectedResults.add("GTAGCTGGC");
        expectedResults.add("CAGCTGGC");
        expectedResults.add("AGAGCTCTG");
        expectedResults.add("GTAGAGAGCTCTCTCTGGC");

        wordsToTest.clear();
        wordsToTest.addAll(expectedResults);
        wordsToTest.add("A");
        wordsToTest.add("C");
        wordsToTest.add("G");
        wordsToTest.add("GT");
        wordsToTest.add("AGCT");
        wordsToTest.add("AGG");
        wordsToTest.add("CTG");
        wordsToTest.add("AGCTGG");
        wordsToTest.add("GAAGCTG");
        wordsToTest.add("");

        Language1Matcher l1m = new Language1Matcher();
        l1m.setWordsToCompareAgainst(wordsToTest);
        assertEquals("Language 1", expectedResults, l1m.findMatches());
    }

    @Test
    public void test_language2() {
        expectedResults.clear();
        expectedResults.add("02-28");
        expectedResults.add("04-01");
        expectedResults.add("04-30");
        expectedResults.add("07-02");
        expectedResults.add("07-31");
        expectedResults.add("01-01");
        expectedResults.add("11-14");
        expectedResults.add("05-03");
        expectedResults.add("07-07");
        expectedResults.add("03-31");

        wordsToTest.clear();
        wordsToTest.addAll(expectedResults);
        wordsToTest.add("03-32");
        wordsToTest.add("00-01");
        wordsToTest.add("7-2");
        wordsToTest.add("7-02");
        wordsToTest.add("07-2");
        wordsToTest.add("13-11");
        wordsToTest.add("04=31");
        wordsToTest.add("0422");
        wordsToTest.add("02-30");
        wordsToTest.add("04/01");

        Language2Matcher l2m = new Language2Matcher();
        l2m.setWordsToCompareAgainst(wordsToTest);
        assertEquals("Language 2", expectedResults, l2m.findMatches());
    }

    @Test
    public void test_language3() {
        expectedResults.clear();
        expectedResults.add("01210");
        expectedResults.add("020");
        expectedResults.add("02000");
        expectedResults.add("0000200");
        expectedResults.add("00111122110");
        expectedResults.add("0022200");
        expectedResults.add("011222110");
        expectedResults.add("001112222110");
        expectedResults.add("022220");
        expectedResults.add("000111222111000");

        wordsToTest.clear();
        wordsToTest.addAll(expectedResults);
        wordsToTest.add("012");
        wordsToTest.add("210");
        wordsToTest.add("02210");
        wordsToTest.add("001220");
        wordsToTest.add("02320");
        wordsToTest.add("1112221111");
        wordsToTest.add("01121");
        wordsToTest.add("010");
        wordsToTest.add("00000");
        wordsToTest.add("011222021100");

        Language3Matcher l3m = new Language3Matcher();
        l3m.setWordsToCompareAgainst(wordsToTest);
        assertEquals("Language 3", expectedResults, l3m.findMatches());
    }
}