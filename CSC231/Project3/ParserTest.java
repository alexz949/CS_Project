import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class ParserTest {
    Language1Parser l1p;
    YourLanguageParser ylp;

    @Before
    public void setUp() throws Exception {
        l1p = new Language1Parser();
        ylp = new YourLanguageParser();
    }


    // TESTS 1 - 6 EVALUATE WORDS AGAINST THE LANGUAGE 1 GRAMMAR
    // USE THESE TO VERIFY YOUR WORK IN LR0Parser.java
    @Test
    public void test1() {
        assertEquals("R1->R3", l1p.parse("a#"));
    }

    @Test
    public void test2() {
        assertEquals("R1->R2->R3", l1p.parse("(a)#"));
    }

    @Test
    public void test3() {
        assertEquals("R1->R2->R2->R3", l1p.parse("((a))#"));
    }

    @Test
    public void test4() {
        assertEquals(") is an incorrect symbol", l1p.parse("()#"));
    }

    @Test
    public void test5() {
        assertEquals("( is an incorrect symbol", l1p.parse("(a)(#"));
    }

    @Test
    public void test6() {
        assertEquals("# is an incorrect symbol", l1p.parse("#"));
    }


    // TESTS 7 - 12 EVALUATE WORDS AGAINST THE LANGUAGE A GRAMMAR
    // USE THESE TO VERIFY YOUR WORK IF YOU WERE ASSIGNED LANGUAGE A

    /*
    @Test
    public void test7() { assertEquals("R1->R3", ylp.parse("n#")); }

    @Test
    public void test8() {
        assertEquals("R1->R2->R3", ylp.parse("n+n#"));
    }

    @Test
    public void test9() {
        assertEquals("R1->R2->R2->R3", ylp.parse("n+n+n#"));
    }

    @Test
    public void test10() {
        assertEquals("+ is an incorrect symbol", ylp.parse("n++#"));
    }

    @Test
    public void test11() {
        assertEquals("n is an incorrect symbol", ylp.parse("nn#"));
    }

    @Test
    public void test12() {
        assertEquals("# is an incorrect symbol", ylp.parse("#"));
    }
    */


    // TESTS 13 - 18 EVALUATE WORDS AGAINST THE LANGUAGE B GRAMMAR
    // USE THESE TO VERIFY YOUR WORK IF YOU WERE ASSIGNED LANGUAGE B

    /*
    @Test
    public void test13() { assertEquals("R1->R3", ylp.parse("ab#")); }

    @Test
    public void test14() {
        assertEquals("R1->R2->R3", ylp.parse("aabb#"));
    }

    @Test
    public void test15() {
        assertEquals("R1->R2->R2->R3", ylp.parse("aaabbb#"));
    }

    @Test
    public void test16() {
        assertEquals("b is an incorrect symbol", ylp.parse("abb#"));
    }

    @Test
    public void test17() {
        assertEquals("a is an incorrect symbol", ylp.parse("aba#"));
    }

    @Test
    public void test18() {
        assertEquals("# is an incorrect symbol", ylp.parse("#"));
    }
    */


    // TESTS 19 - 24 EVALUATE WORDS AGAINST THE LANGUAGE C GRAMMAR
    // USE THESE TO VERIFY YOUR WORK IF YOU WERE ASSIGNED LANGUAGE C


    @Test
    public void test19() { assertEquals("R1->R3", ylp.parse("b#")); }

    @Test
    public void test20() {
        assertEquals("R1->R2->R3", ylp.parse("ab#"));
    }

    @Test
    public void test21() {
        assertEquals("R1->R2->R2->R3", ylp.parse("aab#"));
    }

    @Test
    public void test22() {
        assertEquals("b is an incorrect symbol", ylp.parse("abb#"));
    }

    @Test
    public void test23() {
        assertEquals("a is an incorrect symbol", ylp.parse("aba#"));
    }

    @Test
    public void test24() {
        assertEquals("# is an incorrect symbol", ylp.parse("#"));
    }


    // TODO: Complete and uncomment the four additional tests here

    @Test
    public void testA() {
        // a word not used previously that is in language 1, and its derivation
        assertEquals("R1->R2->R2->R2->R3", l1p.parse("(((a)))#"));


    }

    @Test
    public void testB() {
        // a word not used previously and not in language 1, and its error message
        assertEquals(") is an incorrect symbol", l1p.parse(")"));

    }

    @Test
    public void testC() {
        // a word not used previously that is in your assigned language, and its derivation
        assertEquals("R1->R2->R2->R2->R2->R2->R3", ylp.parse("aaaaab#"));

    }

    @Test
    public void testD() {
        // a word not used previously that is not your assigned language, and its error message
        assertEquals("b is an incorrect symbol", ylp.parse("bb#"));

    }

}