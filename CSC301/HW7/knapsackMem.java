package CSC301.HW7;

import java.util.ArrayList;
import java.io.*;
import java.util.Scanner;

class knapsackMem {
    static ArrayList<Integer> weights = new ArrayList<>();
    static ArrayList<Integer> values = new ArrayList<>();
    static int W;
    static int n;
    public static void main(String[] args) throws IOException {
        readFile("CSC301\\HW7\\large.txt");


        
        int profit[] = new int[values.size()];
        int weight[] = new int[weights.size()];
        for (int i = 0; i < weight.length; i++) {
            profit[i] = values.get(i);
            weight[i] = weights.get(i);
        }
    
        int ans = knapsack(W, weight, profit,n);
        System.out.println(ans);
        
    }
    public static int knapsack(int W, int[] w, int[] val, int n){
        int bag[] = new int[W+1];
        
        

        for(int i = 1; i <= n; i++){
            for(int j = W; j >= 0; j--){
                if(w[i-1] <= j){
                    bag[j] = Math.max(bag[j], bag[j-w[i-1]] + val[i-1]);
                }
              
            }
        }
        return bag[W];
    }
    public static void readFile(String path) throws IOException{
        File file = new File(path);
        Scanner sc = new Scanner(file);
        String info = sc.nextLine();
        String[] ans = info.split(" ");
        W = Integer.parseInt(ans[1]);
        String info2 = sc.nextLine();
        String[] ans2 = info2.split(" ");
        n = Integer.parseInt(ans2[1]);

        while(sc.hasNextLine()){
            String str = sc.nextLine();
            String[] store = str.split(" ");
            weights.add(Integer.parseInt(store[1]));
            values.add(Integer.parseInt(store[3]));
        }
        sc.close();
    }
    
}

