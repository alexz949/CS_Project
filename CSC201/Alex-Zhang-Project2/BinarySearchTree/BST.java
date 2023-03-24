public class BST{
    // the below variable should keep track of the number of nodes in the BST. Must increment/decrement num_nodes appropriately in insert/delete and ArrayToTree.
    private int num_nodes = 0;
    private TreeNode root;
    private int index = 0;

    private class TreeNode{
        //implement this class.
        int val;
        TreeNode left;
        TreeNode right;
        //constrcutor
        public TreeNode(int val){
            this.val = val;
        }
    }

    //get the number of nodes in this BST
    public int getNumNodes(){
        //return number of nodes;
        return num_nodes;
    }
    
    //Insert an integer into a BST
    public void insert(int item){
        //Initialization
        if(root == null){
            root = new TreeNode(item);
        }
        else{
            TreeNode node = new TreeNode(item);
            TreeNode temp = root;
            while(temp != null){
                if(temp.val < item){//going right
                    if(temp.right == null){//find position
                        temp.right = node;
                        num_nodes++;
                        return;
                    }
                    else
                        temp = temp.right;
                }
                if(temp.val > item){//going left
                    if(temp.left == null){//find position
                        temp.left = node;
                        num_nodes++;
                        return; 
                    }
                    else
                        temp = temp.left;
                }
            }
        }
        //node increment
        num_nodes++;
        return;
    }

    //check whether given integer is in this BST
    public boolean find(int item){
        TreeNode temp = root;
        //looping
        while(temp != null){
            if(temp.val == item)//found
                return true;
            else if(temp.val < item){
                //going right
                temp = temp.right;
            }
            else{
                //going left
                temp = temp.left;
            }
        }

        //return if not found
        return false;

    }

    //Delete the integer in the BST
    public void delete(int item){
        //create a dummyroot for BST for tracing
        TreeNode prev = new TreeNode(0);
        prev.left = root;
        
        //Exception when root is null
        if(root == null){
            System.out.println("Error: root is null");
            return;
        }
        
        TreeNode temp = root;
        while(temp != null){//looping
            if(temp.val == item){//find the node to delete
                break;
            }
            else if(temp.val < item){//going right
                prev = temp;
                temp = temp.right;
            }
            else{//going left
                prev = temp;
                temp = temp.left;  
            }
            
        }

        //delete node not found
        if(temp == null){
            System.out.println("Error: delete node not found");
            return;
        }
        
    
        //delete node is leaf
        if(temp.left == null && temp.right == null){
            if(prev.left == temp)
                prev.left = null;
            else
                prev.right = null;

            num_nodes--;
            return;
        }

        TreeNode par = null;

        //if delete node only have right side
        if(temp.left == null){
            par = Min(temp.right);
            if(par.left == null){//if min is the child for delete node
                prev.left = temp.right;
            }
            else{
                temp.val = par.left.val;
                par.left = null;
            }
    
            num_nodes--;
        }
        else if(temp.right == null){//if only have left side
            par = Max(temp.left);
            if(par.right == null){//if max is the child for delete node
                prev.left = temp.left;
            }
            else{
                temp.val = par.right.val;
                par.right = null;
            }
            
            num_nodes--;
        }
        else{//if both
            par = Min(temp.right);
            if(par.left == null){
                temp.val = par.val;
                temp.right = par.right;
                par = null;
            }
            else{
                temp.val = par.val;
                par = null;

            }
            num_nodes--;

        }

        prev = null;
        return;
    }
    
    //return Minimum node from given BST 
    private TreeNode Min(TreeNode node){
        TreeNode prev = node;
        while(node != null){
            prev = node;
            node = node.left;
        }
        
        return prev;
    }

    //return Maximum node from given BST
    private TreeNode Max(TreeNode node){
        TreeNode prev = node;
        while(node != null ){
            prev = node;
            node = node.right;

        }
        
        return prev;
    }

    
    //Load array into a BST
    public void ArrayToTree(int array[]){
        //Exception array is invalid
        if(array == null){
            System.out.println("Error: input array is null");
            return;
        }
        ArrayToTree_helper(array, 0, array.length-1);

    }
    
    // Part 2.
    private TreeNode ArrayToTree_helper(int array[], int low, int high){
        //base case when low is greater then high
        if(low > high){
            return null;
        }
        int mid = low + (high - low) / 2;
        TreeNode node = new TreeNode(array[mid]);

        //spliting array and setting nodes
        node.left = ArrayToTree_helper(array, low, mid - 1);
        node.right = ArrayToTree_helper(array, mid + 1, high);
        return node;
    }

    // Part 3.
    public int[] preorder_traversal(){
        //Exception no BST
        if(num_nodes <= 0){
            System.out.println("Error: No node");
            return null;
        }

        int[] ans = new int[num_nodes];
        preorder_helper(root, ans);
        index = 0;
        return ans;

    }
    private void preorder_helper(TreeNode node, int[] array){
        //base case when reached leaf
        if(node == null)
            return;
        array[index++] = node.val;
        preorder_helper(node.left, array);
        preorder_helper(node.right, array);
    }

    public int[] postorder_traversal(){
        //Exception no BST
        if(num_nodes <= 0){
            System.out.println("Error: No node");
            return null;
        }
        
        int[] ans = new int[num_nodes];
        postorder_helper(root, ans);
        index = 0;
        return ans;

    }
    private void postorder_helper(TreeNode node, int[] array){
        //base case when reached leaf
        if(node == null)
            return;
        postorder_helper(node.left, array);
        postorder_helper(node.right, array);
        array[index++] = node.val;
    }

    public int[] inorder_traversal(){
        //Exception no BST
        if(num_nodes <= 0){
            System.out.println("Error: No node");
            return null;
        }
        
        int[] ans = new int[num_nodes];
        inorder_helper(root, ans);
        index = 0;
        return ans;

    }
    private void inorder_helper(TreeNode node, int[] array){
        //base case when node is null
        if(node == null)
            return;
        inorder_helper(node.left, array);
        array[index++] = node.val;
        inorder_helper(node.right, array);
    }

    public int findMax(){
        //Exception no tree exists
        if(num_nodes <= 0){
            System.out.println("Error: No node");
            return -1;
        }
        int max = Integer.MIN_VALUE;
        TreeNode node = root;
        //keep looping right
        while(node != null){
            max = node.val;
            node = node.right;
        }

        //return the max value on the right side of tree
        return max;
    }

    public int findMin(){
        //Exception no tree exists
        if(num_nodes <= 0){
            System.out.println("Error: No node");
            return -1;
        }

        int min = Integer.MAX_VALUE;
        TreeNode node = root;
        //keep looping left
        while(node != null){
            min = node.val;
            node = node.left;
        }

        //return the min value on the left side of tree
        return min;
    }

    //unit test
    /*
    public static void main(String[] args) {
        int[] array;
        BST test = new BST();
        
        test.insert(10);
        test.insert(6);
        test.insert(12);
        test.insert(123);
        test.insert(2);
        test.insert(3);
        test.insert(1);
        test.insert(170);
        test.insert(70);
        test.insert(60);
        test.insert(0);
        
        System.out.println("This is in order!");
        array = test.inorder_traversal();
        for (int i = 0; i < array.length; i++) {
            System.out.println(array[i]);
        }
        
        test.delete(10);
        
        System.out.println("total nodes: " + test.getNumNodes());
        System.out.println("This is in order!");
        array = test.inorder_traversal();
        for (int i = 0; i < array.length; i++) {
            System.out.println(array[i]);
        }
        System.out.println("This is postorder");
        array = test.postorder_traversal();
        for (int i = 0; i < array.length; i++) {
            System.out.println(array[i]);
        }
        System.out.println("This is preorder");
        array = test.preorder_traversal();
        for (int i = 0; i < array.length; i++) {
            System.out.println(array[i]);
        }
        System.out.println("Finding min and max: ");
        System.out.println(test.findMin());
        System.out.println(test.findMax());
    }
    */
}
