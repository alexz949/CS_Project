package CSC301.HW6;

import java.io.*;

import java.util.ArrayList;
import java.util.Scanner;
import java.util.*;


public class adjacencyList {
    public static void main(String[] args) throws IOException {
        //initial 16
        int[][] m1 = readFile("A16-edge.txt");
        int vertex = m1[0][1];
        Graph node = new Graph(vertex);
        for (int i = 1; i < m1.length; i++) {
            node.addEdge(m1[i][0]-1, m1[i][1]-1);
        }

        //initial 1024
        int[][] m2 = readFile("A1024-edge.txt");
        int vertex2 = m2[0][1];
        Graph node2 = new Graph(vertex2);
        for (int i = 1; i < m2.length; i++) {
            node2.addEdge(m2[i][0]-1, m2[i][1]-1);
        }


        long start = System.currentTimeMillis();
        //First putting all two-path into temporary adjacency list and then
        //use hashmap to eliminate the duplicates and creating the number of
        //two-paths in adjacency list representation.
        ArrayList<ArrayList<Integer>> array = node.raw();
        ArrayList<HashMap<Integer, Integer>> countTwo = new ArrayList<>();
        for (int i = 0; i < array.size(); i++) {
            countTwo.add(new HashMap<>());
            for (int j = 0; j <array.get(i).size(); j++) {
                int temp = array.get(i).get(j);
                if(countTwo.get(i).containsKey(temp)){
                    countTwo.get(i).put(temp, countTwo.get(i).get(temp)+1);
                }
                else{
                    countTwo.get(i).put(temp, 1);
                }

            }
        }
        //initialize array to store the value.
        int[] result = new int[vertex];
        for (int i = 0; i < vertex; i++) {
            ArrayList<Integer> test = node.BFS(i); //BFS to check whether the distance is 2
            result[i] = recommend(countTwo.get(i), test);
        }


        long end = System.currentTimeMillis();
        long time = end - start;
        System.out.println(time);

        ArrayList<ArrayList<Integer>> array2 = node2.raw();
        ArrayList<HashMap<Integer, Integer>> countTwo2 = new ArrayList<>();
        for (int i = 0; i < array2.size(); i++) {
            countTwo2.add(new HashMap<>());
            for (int j = 0; j <array2.get(i).size(); j++) {

                int temp = array2.get(i).get(j);
                if(countTwo2.get(i).containsKey(temp)){
                    countTwo2.get(i).put(temp, countTwo2.get(i).get(temp)+1);
                }
                else{
                    countTwo2.get(i).put(temp, 1);
                }
            }
        }

        int[] result2 = new int[vertex2];
        for (int i = 0; i < vertex2; i++) {
            ArrayList<Integer> test = node2.BFS(i);
            result2[i] = recommend(countTwo2.get(i), test);
        }

        //function for writing the file
        writingFile("rec16.txt", result);
        writingFile("rec1024.txt", result2);
    }

    public static int[][] readFile(String fileName) throws IOException{
        File file = new File(fileName);
        Scanner sc = new Scanner(file);
        ArrayList<String[]> array = new ArrayList<>();
        String info = sc.nextLine();

        String[] ans = info.split(" ");
        //separating first line
        int num1 = Integer.parseInt(ans[1]);
        int num2 = Integer.parseInt(ans[3]);
        while(sc.hasNextLine()){
            String str = sc.nextLine();
            array.add(str.split(" "));
        }
        //put array elements into matrix
        int[][] m1 = new int[array.size()+1][array.get(0).length];
        m1[0][0] = num1;
        m1[0][1] = num2;
        int num = 0;
        for (int i = 1; i < m1.length; i++) {
            for (int j = 0; j < m1[0].length; j++) {
                m1[i][j] = Integer.parseInt(array.get(num)[j]);
            }
            num++;
        }
        return m1;
    }

    public static void writingFile(String fileName, int[] nums) throws IOException {
        File f = new File(fileName);
        OutputStreamWriter write = new OutputStreamWriter(new FileOutputStream(f), "UTF-8");
        BufferedWriter out = new BufferedWriter(write);
        for (int i = 0; i < nums.length; i++) {
            if(nums[i] != 0)
                out.write((nums[i]+1)+""); //writing one integer each line
            else{
                out.write("User " + (i+1) + " have " + nums[i]+" recommender");
            }
            out.newLine();
        }
        out.close();
    }


    public static int recommend(HashMap<Integer,Integer> map, ArrayList<Integer> check){
        int ans = 0;
        int max = 0;
        //putting keys into array
        ArrayList<Integer> keys = new ArrayList<>();
        for(Integer key : map.keySet()){
            keys.add(key);
        }
        //sorting
        Collections.sort(keys);
        //looping through the key checking conditions
        for (int i = 0; i < keys.size(); i++) {
            int temp = map.get(keys.get(i));
            if(temp > max){
                if(check.contains(keys.get(i))){
                    max = temp;
                    ans = keys.get(i);
                }
            }
        }
        return ans;
    }


}

class Graph{
    ArrayList<ArrayList<Integer>> adjacencyList;
    int vertex_num;
    //Constructor
    public Graph(int vertex_num){
        this.vertex_num = vertex_num;
        //initialization
        this.adjacencyList = new ArrayList<>();
        for (int i = 0; i < vertex_num; i++) {
            adjacencyList.add(new ArrayList<>());
        }
    }
    //add edge
    public void addEdge(int start, int end){
        adjacencyList.get(start).add(end);
    }

    ArrayList<Integer> BFS (int s) {

        ArrayList<Integer> ans = new ArrayList<>();
        //initialize distance
        int[] dis = new int[vertex_num];
        for (int i = 0; i < dis.length; i++) {
            dis[i]=Integer.MAX_VALUE;
        }
        dis[s] = 0;

        // Create a queue for BFS
        LinkedList<Integer> queue = new LinkedList<>();

        queue.add(s);

        while (queue.size() != 0) {
            //dequeue
            s = queue.poll();
            //looping through the neighbors
            Iterator<Integer> i = adjacencyList.get(s).iterator();
            while (i.hasNext()) {
                int n = i.next();
                if (dis[n] == Integer.MAX_VALUE) {//updating distances
                    dis[n] = dis[s] + 1;
                    queue.add(n);
                }
            }
        }

        //adding all two path vertices.
        for (int i = 0; i <dis.length; i++) {
            if(dis[i]==2)
                ans.add(i);
        }
        return ans;
    }


    public ArrayList<ArrayList<Integer>> raw(){
        //initialize
        ArrayList<ArrayList<Integer>> ans = new ArrayList<>();
        //looping through list
        for (int i = 0; i < adjacencyList.size(); i++) {
            ArrayList<Integer> array = getVer(i);
            ans.add(new ArrayList<>());
            for (int j = 0; j < array.size(); j++) {//get all neighbors' neighbors vertices
                int temp = array.get(j);
                for (int k = 0; k < adjacencyList.get(temp).size(); k++) {
                    int temp2 = adjacencyList.get(temp).get(k);
                    ans.get(i).add(temp2);
                }
            }
        }

        return ans;

    }
    public ArrayList<Integer> getVer(int s){//get all neighbor vertices
        ArrayList<Integer> array = new ArrayList<>();
        for (int i = 0; i < adjacencyList.get(s).size(); i++) {
            array.add(adjacencyList.get(s).get(i));
        }
        return array;
    }








}










