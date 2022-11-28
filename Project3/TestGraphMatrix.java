
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;

public class TestGraphMatrix{
    public static void main(String[] args){
        // For testing GraphMatrix implementation.

        GraphMatrix graph = new GraphMatrix();
        graph.init(5);
        
        graph.addEdge(0,1,1);
        graph.addEdge(0,2,1);
        graph.addEdge(1,4,1);
        graph.addEdge(1,3,1);
        graph.addEdge(2,3,1);
        graph.addEdge(3,4,1);

        GraphMatrix graph2 = new GraphMatrix();
        graph2.init(6);
        graph2.addEdge(5,2,1);
        graph2.addEdge(5,0,1);
        graph2.addEdge(4,1,1);
        graph2.addEdge(4,0,1);
        graph2.addEdge(2,3,1);
        graph2.addEdge(3,1,1);



        System.out.println("Check whether has path: " + graph.hasEdge(0, 1));
        System.out.println(graph.getWeight(0,0));

        ArrayList<Integer> neib;
        neib = graph.neighbors(0);

        System.out.println("The neighbor should be:");
        for (int i = 0; i < neib.size(); i++) {
            System.out.println(neib.get(i));
        }


        System.out.println("Let's try BFS: ");
        ArrayList<Integer> bfsTest;
        bfsTest = graph.BFS(0);
        for (int i = 0; i < bfsTest.size(); i++) {
            System.out.println(bfsTest.get(i));
        }
        graph.resetVisited();


        System.out.println("Whether has a path: " + graph.hasPath(0,3));


        System.out.println("This is check the topological sort");
        ArrayList<Integer> sort = graph2.topologicalSort();
        for (int i = 0; i < sort.size(); i++) {
            System.out.println(sort.get(i));
        }








        System.out.println("This is node : " + graph.nodeCount());
        System.out.println("This is edge: " + graph.edgeCount());

        
        

        
    }
}