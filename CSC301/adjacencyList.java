package CSC301;


import java.util.ArrayList;
import java.util.LinkedList;

public class adjacencyList{
    


    LinkedList<Node>[] adjacencyList;



    private static ArrayList<ArrayList<Integer>> countTwoPath(ArrayList<ArrayList<Integer>> array){
        ArrayList<ArrayList<Integer>> ans = new ArrayList<>();

        for (int i = 0; i < array.size(); i++) {
            ans.add(new ArrayList<>());
            for (int j = 0; j < array.get(i).size(); j++) {
                for (int j2 = 0; j2 < array.get(j).size(); j2++) {
                    if(!array.get(array.get(i).get(j2)).contains(i))
                        ans.get(i).add(array.get(i).get(j2));
                }
            }
        }

        return ans;

    }

    private static void addedge(ArrayList<ArrayList<Integer>> array, int start, int end){
        array.get(start).add(end);
    }




    public static void main(String[] args) {
        

        
    }

   


}




class Node{
    int start;
    int end;
    int weight;

    public Node(int start, int end, int weight){
        this.start = start;
        this.end = end;
        this.weight = weight;

    }

}