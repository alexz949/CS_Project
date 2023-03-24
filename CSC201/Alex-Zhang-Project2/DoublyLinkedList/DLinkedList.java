public class DLinkedList implements MyList{

    // define any variables you want using the Encapsulation design principle.
    private Node head = null;
    private Node tail = null;
    private int size = 0;

    private class Node{
        //a private nested Node class that users cannot access.
        Object obj;
        Node next;
        Node prev;
        public Node(Object obj){
            this.obj = obj;
        }
    }

    //Insert an object in given index
    @Override
    public void insert(int index, Object item) {
        // TODO Auto-generated method stub
        //Initialization
        if(size == 0){
            head = new Node(item);
            tail = head;
            size++;
            return;
        }
        //Exception out of bound
        if(index >= size || index < 0){
            System.out.println("Error: index out of bound");
            return;
        }

        //looping
        Node temp = head;
        Node temp2 = head.next;
        for (int i = 0; i < index-1; i++) {
            temp = temp.next;
            temp2 = temp2.next;
        }
        
        //switching next and prev pointer
        Node newNode = new Node(item);
        temp.next = newNode;
        newNode.prev = temp;
        newNode.next = temp2;
        temp2.prev = newNode;

        //size increment
        size++;
        return; 
    }

    //Adding given object at tail of LinkedList
    @Override
    public void append(Object item) {
        // TODO Auto-generated method stub
        //initialization
        if(size == 0){
            head = new Node(item);
            tail = head;
            size++;
            return;
        }

        //swtiching tail next, prev
        Node node = new Node(item);
        tail.next = node;
        node.prev = tail;
        tail = tail.next;
        size++;
        return;
    }

    //Making the whole linkedlist be null
    @Override
    public void clear() {
        // TODO Auto-generated method stub
        //resetting 
        head = null;
        tail = null;
        size = 0;
    }

    //Check whether size is 0
    @Override
    public boolean isEmpty() {
        // TODO Auto-generated method stub

        //return size is 0 or not
        return size == 0;
    }

    //Get the size of linkedlist
    @Override
    public int size() {//return size or return -1
        // TODO Auto-generated method stub 
        if(head == null && tail == null)
            return -1;
        else
            return size;
        
    }

    //replace the node in index with another object
    @Override
    public boolean replace(int index, Object item) {
        // TODO Auto-generated method stub
        //Exception out of bound
        if(index >= size || index < 0){
            System.out.println("Error: Index out of bound");
            return false;
        }
        //Exception linkiedlist is empty
        if(size == 0){
            System.out.println("Error: LinkedList is empty");
            return false;
        }
        
        Node node = new Node(item);
        //replace head
        if(index == 0){
            node.next = head.next;
            head.next.prev = node;
            head = node;
        }
        else if(index == size - 1){//replace tail
            tail.prev.next = node;
            node.prev = tail.prev;
            tail = node;
        }
        else{
            //other case 
            insert(index, item);
            remove(index+1);
        }

        //return true if there is no Exception happened
        return true;
        
    }

    //remove the node with given index
    @Override
    public void remove(int index) {
        // TODO Auto-generated method stub
        //Exception out of bound
        if(index < 0 || index >= size){
            System.out.println("Error: Index out of bound");
            return;
        }
        //Exception linkedlist is empty
        if(size == 0){
            System.out.println("Error: LinkedList is empty");
            return;
        }
           
        //size == 1 case
        if(size == 1){
            head = null;
            tail = null;
            size--;
            return;
        }

        //remove head
        if(index == 0){
            head = head.next;
            head.prev = null;
            size--;
            return;
        }
        if(index == size - 1){//remove tail
            tail = tail.prev;
            tail.next = null;
            size--;
            return;
        }

        //looping to index
        Node temp = head;
        for (int i = 0; i < index-1; i++) {
            temp = temp.next;
        }
        //remove
        temp.next = temp.next.next;
        temp.next.prev = temp;

        size--;
        return;
    }

    //Get the node with given index
    @Override
    public Object get(int index) {
        // TODO Auto-generated method stub
        //Exception out of bound
        if(index >= size || index < 0){
            System.out.println("Error: Index out of bound");
            return null;
        }
        //Exception linkedlist is empty
        if(size == 0){
            System.out.println("Error: LinkedList is empty");
            return null;
        }

        //looping
        Node temp = head;
        for (int i = 0; i < index; i++) {
            temp = temp.next;
        }
        //return node's object
        return temp.obj;
    }

    //unit test
    /*
    public static void main(String[] args) {
        DLinkedList linkList = new DLinkedList();
        linkList.insert(0, 3);
        linkList.insert(1, 4);
        linkList.insert(2, 5);
        linkList.insert(3, 6);
        linkList.append(7);

        linkList.insert(2, 13);
        linkList.insert(5, 16);
        
        System.out.println("First list");
        for (int i = 0; i < linkList.size; i++) {
            System.out.println(linkList.get(i));
        }
        System.out.println("Size: " + linkList.size);
        
        linkList.replace(3, 12);
        
        for (int i = 0; i < linkList.size; i++) {
            System.out.println(linkList.get(i));
        }

        System.out.println(linkList.isEmpty());
        linkList.clear();
        linkList.append(11);
        for (int i = 0; i < linkList.size; i++) {
            System.out.println(linkList.get(i));
        }
        System.out.println(linkList.size);
        System.out.println(linkList.isEmpty());

    }
    */
    
}

