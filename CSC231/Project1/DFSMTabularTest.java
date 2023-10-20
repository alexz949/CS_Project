import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class DFSMTabularTest {
    DFSMTabular dfsm;

    @Before
    public void setUp() throws Exception {
        dfsm = new DFSMTabular();
    }

    @Test
    public void test1() {
        assertTrue(dfsm.checkWord("AGCTG"));
    }

    @Test
    public void test2() {
        assertTrue(dfsm.checkWord("AGAGCTG"));
    }

    @Test
    public void test3() {
        assertTrue(dfsm.checkWord("AGCTCTG"));
    }

    @Test
    public void test4() {
        assertTrue(dfsm.checkWord("GTAGCTG"));
    }

    @Test
    public void test5() {
        assertTrue(dfsm.checkWord("CAGCTG"));
    }

    @Test
    public void test6() {
        assertTrue(dfsm.checkWord("AGCTGGC"));
    }

    @Test
    public void test7() {
        assertTrue(dfsm.checkWord("GTAGCTGGC"));
    }

    @Test
    public void test8() {
        assertTrue(dfsm.checkWord("CAGCTGGC"));
    }

    @Test
    public void test9() {
        assertTrue(dfsm.checkWord("AGAGCTCTG")); }

    @Test
    public void test10() {
        assertTrue(dfsm.checkWord("GTAGAGAGCTCTCTCTGGC")); }

    @Test
    public void test11() {
        assertFalse(dfsm.checkWord("A")); }

    @Test
    public void test12() {
        assertFalse(dfsm.checkWord("C")); }

    @Test
    public void test13() {
        assertFalse(dfsm.checkWord("G")); }

    @Test
    public void test14() {
        assertFalse(dfsm.checkWord("GT")); }

    @Test
    public void test15() {
        assertFalse(dfsm.checkWord("AGCT")); }

    @Test
    public void test16() {
        assertFalse(dfsm.checkWord("AGG")); }

    @Test
    public void test17() {
        assertFalse(dfsm.checkWord("CTG")); }

    @Test
    public void test18() {
        assertFalse(dfsm.checkWord("AGCTGG")); }

    @Test
    public void test19() {
        assertFalse(dfsm.checkWord("GAAGCTG")); }

    @Test
    public void test20() {
        assertFalse(dfsm.checkWord("")); }
}