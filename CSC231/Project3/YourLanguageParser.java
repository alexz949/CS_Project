public class YourLanguageParser extends LR0Parser {

    public YourLanguageParser() {
        super(); // calls the constructor for LR0Parser

        // TODO: Encode the grammar assigned to you (based on your student id number)
        // here, making use of the style of encoding shown in Language1Parser.java
        //id: 06615345, Language C

        // Each grammar rule is three parts:
        //  - a label, such as R1, R2, or R3
        //  - a left hand side which is the non-terminal
        //  - a right hand side which is what the non-terminal can be rewritten as
        addRule("R1","Z", "A#");   // Encodes Z --> A#
        addRule("R2", "A", "aA"); // Encodes A --> aA
        addRule("R3", "A", "b");   // Encodes A --> b
        // parse table
        // -- state 1
        // Each action is three parts:
        //  - a state number
        //  - an input symbol
        //  - the action to perform when in that state and see that input symbol
        addAction("1", "a", "S4");  // Encodes that state 1, symbol a results in action S4
        addAction("1", "b", "S3");  // Encodes that state 1, symbol b results in action S3
        addAction("1", "A", "G2");  // Encodes that state 1, symbol A results in action G2
        // -- state 2
        addAction("2", "#", "Accept"); // Encodes that state 2, symbol # results in acion Accept
        // -- state 3
        addAction("3", "a", "R3");
        addAction("3", "b", "R3");
        addAction("3", "#", "R3");
        // -- state 4
        addAction("4", "a", "S4");
        addAction("4", "b", "S3");
        addAction("4", "A", "G5");
        // -- state 5
        addAction("5", "a", "R2");
        addAction("5", "b", "R2");
        addAction("5", "#", "R2");



}
}