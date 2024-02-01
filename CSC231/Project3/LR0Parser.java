import java.util.*;

public class LR0Parser {

    protected HashMap<String, ArrayList<String>> rules;
    protected HashMap<String, String> table;
    protected Stack<String> stack;
    protected Stack<String> derivation;
    protected String currentState;
    protected String currentSymbol;

    public LR0Parser() {
        rules = new HashMap<String, ArrayList<String>>();
        table = new HashMap<String, String>();
        stack = new Stack<String>();
        derivation = new Stack<String>();
        currentState = "";
        currentSymbol = "";
    }

    public void addRule(String labelInput, String lhsInput, String rhsInput) {
        ArrayList<String> ruleList = new ArrayList<String>();
        ruleList.add(lhsInput);
        ruleList.add(rhsInput);
        rules.put(labelInput, ruleList);
    }

    public String getRuleLHS(String labelInput) {
        if (rules.containsKey(labelInput)) {
            return rules.get(labelInput).get(0);
        }
        else {
            return "NO_SUCH_RULE";
        }
    }

    public String getRuleRHS(String labelInput) {
        if (rules.containsKey(labelInput)) {
            return rules.get(labelInput).get(1);
        }
        else {
            return "NO_SUCH_RULE";
        }
    }

    public void addAction(String stateInput, String symbolInput, String actionInput) {
        String key = stateInput + "$" + symbolInput;
        table.put(key, actionInput);
    }

    public String getAction(String stateInput, String symbolInput) {
        String key = stateInput + "$" + symbolInput;
        if (table.containsKey(key)) {
            return table.get(key);
        }
        else {
            return "Blank";
        }
    }

    public String getDerivation() {
        String derivationString = "";
        // TODO
        derivationString = derivation.pop();
        while(!derivation.isEmpty()){
            derivationString =  derivationString + "->" +  derivation.pop();
        }


        return derivationString;
    }

    public String getError() {
        String errorMessage = "";
        // TODO
        errorMessage = currentSymbol + " is an incorrect symbol";
        


        return errorMessage;
    }

    public String parse(String word) {

        String remainingInput = word;
        stack.push("1");
        int lengthOfWord = remainingInput.length();

        while (remainingInput.length() > 0) {
            // current state is at the top of the stack
            currentState = stack.peek();

            // current symbol is at the front of the remaining input
            currentSymbol = "" + remainingInput.charAt(0);
            String action = getAction(currentState, currentSymbol);
            if (action.equals("Blank")) {
                return getError();
            }
            else if (action.equals("Accept")) {
                remainingInput = remainingInput.substring(1);
                derivation.push("R1");
                return getDerivation();
            }
            else if (action.charAt(0) == 'S') {
                stack.push(currentSymbol);
                stack.push(action.substring(1));
                remainingInput = remainingInput.substring(1);
            }
            else if (action.charAt(0) == 'R') {
                String ruleLHS = getRuleLHS(action);
                String ruleRHS = getRuleRHS(action);
                int countToPop = ruleRHS.length() * 2;
                for (int i = 0; i < countToPop; i++) {
                    stack.pop();
                }
                String previousState = stack.peek();
                stack.push(ruleLHS);
                derivation.push(action);
                // handle GOTO
                String gotoAction = getAction(previousState, ruleLHS);
                String newState = gotoAction.substring(1);
                stack.push(newState);
                currentState = newState;
            }
        }
        return "";
    }
}