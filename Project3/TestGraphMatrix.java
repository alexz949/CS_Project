
import java.util.ArrayList;

public class TestGraphMatrix{
    public static void main(String[] args){
        // For testing GraphMatrix implementaiton.

        GraphMatrix graph = new GraphMatrix();
        graph.init(4);
        
        
        for (int i = 0; i < 4; i++) {
            graph.addEdge(i, i, i+1);
        }
        graph.removeEdge(0, 0);
        graph.addEdge(0, 0, 10);
        System.out.println(graph.hasEdge(0, 0));

        System.out.println("This is node : " + graph.nodeCount());
        System.out.println("This is edge: " + graph.edgeCount());

        
        

        
    }
}