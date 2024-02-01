public class Language1Parser extends LR0Parser {

    public Language1Parser() {
        super();
        // Encoding of grammar rules
        // Each grammar rule is three parts:
        //  - a label, such as R1, R2, or R3
        //  - a left hand side which is the non-terminal
        //  - a right hand side which is what the non-terminal can be rewritten as
        addRule("R1","Z", "S#");   // Encodes Z --> S#
        addRule("R2", "S", "(S)"); // Encodes S --> (S)
        addRule("R3", "S", "a");   // Encodes S --> a
        // parse table
        // -- state 1
        // Each action is three parts:
        //  - a state number
        //  - an input symbol
        //  - the action to perform when in that state and see that input symbol
        addAction("1", "(", "S4");  // Encodes that state 1, symbol ( results in action S4
        addAction("1", "a", "S3");  // Encodes that state 1, symbol a results in action S3
        addAction("1", "S", "G2");  // Encodes that state 1, symbol S results in action G2
        // -- state 2
        addAction("2", "#", "Accept"); // Encodes that state 2, symbol # results in acion Accept
        // -- state 3
        addAction("3", "(", "R3");
        addAction("3", ")", "R3");
        addAction("3", "a", "R3");
        addAction("3", "#", "R3");
        // -- state 4
        addAction("4", "(", "S4");
        addAction("4", "a", "S3");
        addAction("4", "S", "G5");
        // -- state 5
        addAction("5", ")", "S6");
        // -- state 6
        addAction("6", "(", "R2");
        addAction("6", ")", "R2");
        addAction("6", "a", "R2");
        addAction("6", "#", "R2");
    }
} 
    

