import java.util.Stack;

public class WeirdQueue{
    private Stack<Object> stack1;
    private Stack<Object> stack2;
    private int size;

    //constructor
    public WeirdQueue(){
        this.stack1 = new Stack<>();
        this.stack2 = new Stack<>();
        this.size = 0;
    }

    /*
     * Based on the dequeue and enqueue method I wrote, the big-O for my enqueue is O(1) for both best case
     * and worst case. Since I just need to push the item into the stack. For the dequeue method, the big-O
     * will be O(1) for the best case. The best case starts from second dequeue and no enqueue is called. S
     * ine in this case the while loop will not excecute which makes the running time be constant. For the 
     * worst case, it happens when there are always some item enqueuing. The worst case has time complexity
     * for O(n).
     */

    //enqueue method putting item in queue
    public void enqueue(Object item){
        //Exception queue overflow
        try{
            stack1.push(item);
            size++;
        } catch(StackOverflowError e){
            e.printStackTrace();
        }

    }

    //dequeue method poping item from queue
    public Object dequeue(){
        //Exception trying to dequeue an empty queue
        if(size == 0){
            System.out.println("Error: Queue is already empty");
            return null;
        }

        //pushing all items into another stack
        while(!stack1.isEmpty()){
            stack2.push(stack1.pop());
        }
        //pop the top item 
        Object obj = stack2.pop();
        size--;
        
        return obj;
    }

    //unit test
    /*
    public static void main(String[] args) {
        WeirdQueue test = new WeirdQueue();

        test.enqueue(1);
        test.enqueue(23);
        test.enqueue(47);
        test.enqueue(66);
        test.enqueue(90);

        while(test.size > 0){
            System.out.println(test.dequeue());
        }
        test.enqueue(11);
        test.dequeue();
        test.enqueue(87);
        test.enqueue(888888);
        test.enqueue(89898);
        test.enqueue(678798);

        while(test.size > 0){
            System.out.println(test.dequeue());
        }

        test.dequeue();


    }
    */
}