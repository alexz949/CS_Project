import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;


public class GraphMatrix implements Graph{

    private int[][] array_2D;
    private int edgeNum;
    private boolean[] check;
    private int nodeNum;

    

    @Override
    public void init(int n) {
        // TODO Auto-generated method stub
        //initialize matrix and visited
        array_2D = new int[n][n];
        check = new boolean[n];
        Arrays.fill(check, false);
        nodeNum = n;
        edgeNum = 0;
        return;
        
    }

    @Override
    public int nodeCount() {
        // TODO Auto-generated method stub
        //return the node number
        return nodeNum;
    }

    @Override
    public int edgeCount() {
        // TODO Auto-generated method stub
        //return the total edge number
        return edgeNum;
        
    }

    @Override
    public void addEdge(int v, int w, int wgt) {
        // TODO Auto-generated method stub

        //adding an edge with [v][w]
        array_2D[v][w] = wgt;
        edgeNum++;
        return;
        
    
    }

    @Override
    public int getWeight(int v, int w) {
        // TODO Auto-generated method stub
        //return the weight number
        return array_2D[v][w];
    }

    @Override
    public void setWeight(int v, int w, int wgt) {
        // TODO Auto-generated method stub
        //set the weight number
        array_2D[v][w] = wgt;
        return;
        
    }

    @Override
    public void removeEdge(int v, int w) {
        // TODO Auto-generated method stub
        //set the [v][w] entry to be 0
        array_2D[v][w] = 0;
        edgeNum--;
        return;
        
    }

    @Override
    public boolean hasEdge(int v, int w) {
        // TODO Auto-generated method stub
        //check the whether has an edge
        if(array_2D[v][w] == 0)
            return false;
        else{
            return true;
        }
    }

    @Override
    public ArrayList<Integer> neighbors(int v) {
        // TODO Auto-generated method stub
        //looping through the matrix to check whether there is an edge
        ArrayList<Integer> array = new ArrayList<>();
        for (int i = 0; i < array_2D.length; i++) {
            if(array_2D[v][i] != 0){//yes, add into array
                array.add(i);
            }
            
        }
        return array;
    }

    @Override
    public void resetVisited() {
        // TODO Auto-generated method stub
        //set all element to be false
        Arrays.fill(check, false);
        return;
    }

    @Override
    public ArrayList<Integer> BFS(int v) {
        // TODO Auto-generated method stub
        //initialization
        ArrayList<Integer> array = new ArrayList<>();
        LinkedList<Integer> queue = new LinkedList<>();


        //add the starting vertex
        queue.add(v);
        check[v] = true;


        int num1 = 0;
        while(!queue.isEmpty()){
            num1 = queue.get(0);

            //pop into array
            array.add(queue.remove());
            for (int i = 0; i < array_2D.length; i++) {//keep finding neighbor
                if(array_2D[num1][i] != 0 && check[i] == false){//yes, then push into queue and set as visited.
                    queue.add(i);
                    check[i] = true;
                }
            }
        }

        return array;
    }

    @Override
    public boolean hasPath(int v, int w) {
        // TODO Auto-generated method stub
        //Use bfs to store all possible connecting vertexes
        ArrayList<Integer> array = BFS(v);
        if(array.contains(w)){// if vertex w exists, return true
            resetVisited();
            return true;
        }
        else{
            resetVisited();
            return false;
        }

    }

    @Override
    public ArrayList<Integer> topologicalSort() {
        // TODO Auto-generated method stub
        //initialization
        ArrayList<Integer> topo = new ArrayList<>();
        LinkedList<Integer> queue = new LinkedList<>();
        int[] indegree = new int[nodeNum];

        //looping to find the number in coming directions
        for (int i = 0; i < array_2D.length; i++) {
            for (int j = 0; j < array_2D.length; j++) {
                if(array_2D[j][i] != 0){
                    indegree[i]++;
                }
            }
        }


        //find all vertexes with no incoming directions and add them into queue
        for (int i = 0; i < indegree.length; i++) {
            if(indegree[i] == 0){
                queue.add(i);
                check[i] = true;
            }
        }

        //BFS which start from vertexes which have no incoming
        int num1 = 0;
        while(!queue.isEmpty()){
            num1 = queue.get(0);

            topo.add(queue.remove());
            for (int i = 0; i < array_2D.length; i++) {
                if(array_2D[num1][i] != 0 && check[i] == false){
                    queue.add(i);
                    check[i] = true;
                }
            }
        }

        //return the array
        return topo;


    }

}