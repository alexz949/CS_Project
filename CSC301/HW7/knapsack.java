package CSC301.HW7;
import java.util.*;
import java.io.*;

public class knapsack {
   
    public static void main(String[] args) throws IOException {
        //unit test
        fileReader readerS = new fileReader("CSC301\\HW7\\small.txt");
        fileReader readerM = new fileReader("CSC301\\HW7\\medium.txt");
        fileReader readerL = new fileReader("CSC301\\HW7\\large.txt");

        //reading and printing
        int profitS[] = new int[readerS.getValue().size()];
        int weightS[] = new int[readerS.getWeight().size()];
        for (int i = 0; i < weightS.length; i++) {
            profitS[i] = readerS.getValue().get(i);
            weightS[i] = readerS.getWeight().get(i);
        }
        System.out.println(knapsack_mem(readerS.W, weightS, profitS,readerS.n));

        int profitM[] = new int[readerM.getValue().size()];
        int weightM[] = new int[readerM.getWeight().size()];
        for (int i = 0; i < weightM.length; i++) {
            profitM[i] = readerM.getValue().get(i);
            weightM[i] = readerM.getWeight().get(i);
        }
        System.out.println(knapsack_mem(readerM.W, weightM, profitM,readerM.n));


        int profitL[] = new int[readerL.getValue().size()];
        int weightL[] = new int[readerL.getWeight().size()];
        for (int i = 0; i < weightL.length; i++) {
            profitL[i] = readerL.getValue().get(i);
            weightL[i] = readerL.getWeight().get(i);
        }
        System.out.println(knapsack_mem(readerL.W, weightL, profitL,readerL.n));
        
    }

    public static int knapsack_mem(int W, int[] w, int[] val, int n){
        //2-D array version 
        int bag[][] = new int[n+1][W+1];
        for(int i = 1; i <= n; i++){
            for(int j = 1; j <= W; j++){
                if(w[i-1] <= j){
                    bag[i][j] = Math.max(bag[i-1][j], bag[i-1][j-w[i-1]] + val[i-1]); //whether add or not
                }
                else{
                    bag[i][j] = bag[i-1][j];
                }
            }
        }
        return bag[n][W];
    }
    
}

