import java.util.Stack;
public class StackSorting{
    public Stack<Integer> sort(Stack<Integer> s){
        //implement this function.
        Stack<Integer> temp = new Stack<>();

        //looping through the origin stack
        while(!s.isEmpty()){
            int tmp = s.pop();
            while(!temp.isEmpty() && temp.peek() < tmp)
            //item smaller than tmp pushing back
                s.push(temp.pop());

            temp.push(tmp);
        }
        //pushing all items back to origin stack
        while(!temp.isEmpty())
            s.push(temp.pop());

        return s;

    }

    //unit test
    /*
    public static void main(String[] args) {
        StackSorting sort = new StackSorting();
        Stack<Integer> stack = new Stack<>();

        stack.push(23);
        stack.push(47);
        stack.push(90);
        stack.push(66);
        stack.push(1);
        stack.push(23234);
        stack.push(329847);
        stack.push(827332498);

        stack = sort.sort(stack);
        while(!stack.isEmpty()){
            System.out.println(stack.pop());
        }
    }
    */
}