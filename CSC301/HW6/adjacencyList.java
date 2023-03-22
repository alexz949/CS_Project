package CSC301.HW6;

import java.util.LinkedList;
import java.util.ArrayList;
import java.util.Iterator;




class Node{
    int vertex;
    int weight = 0;

    public Node(int vertex, int weight){
        this.vertex = vertex;
        this.weight = weight;


    }
    public Node(int vertex){
        this.vertex = vertex;
        this.weight = 1;
    }

}



class Graph{
    ArrayList<ArrayList<Integer>> adjacencyList;
    int vertex_num;

    public Graph(int vertex_num){
        this.vertex_num = vertex_num;
        this.adjacencyList = new ArrayList<>(vertex_num);
        for (int i = 0; i < adjacencyList.size(); i++) {
            adjacencyList.add(new ArrayList<>());
        }
    }
    public void addEdge(int start, int end){
        
        adjacencyList.get(start).add(end);
    }




    
    void BFS(int s)
    {
        // Mark all the vertices as not visited(By default
        // set as false)
        boolean visited[] = new boolean[vertex_num];
 
        // Create a queue for BFS
        LinkedList<Integer> queue
            = new LinkedList<Integer>();
 
        // Mark the current node as visited and enqueue it
        visited[s] = true;
        queue.add(s);
 
        while (queue.size() != 0) {
            // Dequeue a vertex from queue and print it
            s = queue.poll();
            System.out.print(s + " ");
 
            // Get all adjacent vertices of the dequeued
            // vertex s If a adjacent has not been visited,
            // then mark it visited and enqueue it
            Iterator<Integer> i = adjacencyList.get(s).iterator();
            while (i.hasNext()) {
                int n = i.next();
                if (!visited[n]) {
                    visited[n] = true;
                    queue.add(n);
                }
            }
        }
    
    /*

    public ArrayList<Node> BFS_Two(int v) {
        ArrayList<Node> array = new ArrayList<>();
        LinkedList<Node> queue = new LinkedList<>();
        int distance = 0;


        //add the starting vertex
        queue.add(v);
        


        int num1 = 0;
        while(!queue.isEmpty() || distance < 3){
            num1 = queue.get(0).vertex;
            distance++;

            //pop into array
            queue.poll();
            for (int i = 0; i < adjacencyList.get(v).size(); i++) {//keep finding neighbor
                if(array2[num1][i] != 0 && check[i] == false){//yes, then push into queue and set as visited.
                    queue.add(i);
                    check[i] = true;
                }
            }
            
        }



        return array;
    }

    private ArrayList<ArrayList<Node>> countTwoPath(){
        ArrayList<ArrayList<Node>> ans


        for (int i = 0; i < adjacencyList.size(); i++) {
            ans.add(new ArrayList<>());
            for (int j = 0; j < adjacencyList.get(i).size(); j++) {
                int ver = adjacencyList.get(i).get(j).vertex;
                ArrayList<Integer> connected = new ArrayList<>();
                for (int j2 = 0; j2 < adjacencyList.get(ver).size(); j2++) {
                   
                    connected.add(adjacencyList.get(ver).get(j2).vertex);

                    
                }
                for (int k = 0; k < connected.size(); k++) {
                    
                    if(ans.get(i).contains(connected.get(k))){

                    }
                }

                







            }
        }

        return ans;

    }

*/

    
}







public class adjacencyList{
    
   




    public static void main(String[] args) {
        Graph node = new Graph(3);
        node.addEdge(0, 1);
        node.addEdge(1, 2);
        node.BFS(0);

       

        
    }
}
}
