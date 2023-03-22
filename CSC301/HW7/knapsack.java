package CSC301.HW7;
import java.util.*;
import java.io.*;

public class knapsack {
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
    
        int ans = knapsack_mem(W, weight, profit,n);
        System.out.println(ans);
        
    }
    public static int knapsack_mem(int W, int[] w, int[] val, int n){
        int bag[][] = new int[n+1][W+1];
        for(int i = 0; i <= n; i++){
            bag[i][0] = 0;
        }
        for(int i = 0; i <= W; i++){
            bag[0][i] = 0;
        }
        for(int i = 1; i <= n; i++){
            for(int j = 1; j <= W; j++){
                if(w[i-1] <= j){
                    bag[i][j] = Math.max(bag[i-1][j], bag[i-1][j-w[i-1]] + val[i-1]);
                }
                else{
                    bag[i][j] = bag[i-1][j];
                }
            }
        }
        return bag[n][W];
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

