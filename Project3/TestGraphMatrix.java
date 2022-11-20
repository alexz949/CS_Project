
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;

public class TestGraphMatrix{
    public static void main(String[] args){
        // For testing GraphMatrix implementation.

        GraphMatrix graph = new GraphMatrix();
        graph.init(4);
        
        
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                graph.addEdge(1, j, j+1);
            }

        }
        graph.removeEdge(0, 0);
        graph.addEdge(0, 0, 10);
        graph.setWeight(0,0,100);
        System.out.println(graph.hasEdge(0, 1));
        System.out.println(graph.getWeight(0,0));
        ArrayList<Integer> neib = new ArrayList<>();
        neib = graph.neighbors(0);

        System.out.println("The neibor should be:");
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


        System.out.println(graph.hasPath(0,3));








        System.out.println("This is node : " + graph.nodeCount());
        System.out.println("This is edge: " + graph.edgeCount());

        
        

        
    }
}