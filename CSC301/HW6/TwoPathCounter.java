package CSC301.HW6;


import java.util.ArrayList;
import java.util.Arrays;

public class TwoPathCounter {
    
    public int[][] countTwoPaths(ArrayList<ArrayList<Integer>> adjList) {
        int n = adjList.size();
        int[][] twoPaths = new int[n][n];
        
        // for each pair of vertices i,j
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
              
                    // for each neighbor of i
                    for (int k : adjList.get(i)) {
                        // if k is a neighbor of j
                        if (adjList.get(j).contains(k)) {
                            twoPaths[i][j]++;
                        }
                    }
                
            }
        }
        
        return twoPaths;
    }
    
}
class main{
    public static void main(String[] args) {
        ArrayList<ArrayList<Integer>> adjList = new ArrayList<>();
        adjList.add(new ArrayList<>());
        adjList.add(new ArrayList<>());
        adjList.add(new ArrayList<>());
        adjList.get(0).add(2);
        adjList.get(1).add(3);
        TwoPathCounter count = new TwoPathCounter();
        int[][] ans = count.countTwoPaths(adjList);

        for (int i = 0; i < ans.length; i++) {
            System.out.println(Arrays.toString(ans[i]));
        }
        
    }
}
