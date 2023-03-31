package CSC301.HW8;

import java.util.ArrayList;
import java.io.*;
import java.util.Scanner;

public class knapsack_opt {
    public static void main(String[] args) throws IOException {
        System.out.println("See this if it is HW8");
        /*
        //unit test
        fileReader readerS = new fileReader("CSC301\\HW7\\small.txt");
        int profitS[] = new int[readerS.getValue().size()];
        int weightS[] = new int[readerS.getWeight().size()];
        for (int i = 0; i < weightS.length; i++) {
            profitS[i] = readerS.getValue().get(i);
            weightS[i] = readerS.getWeight().get(i);
        }
        System.out.println(knapsack(readerS.W, weightS, profitS,readerS.n));

        
        fileReader readerM = new fileReader("CSC301\\HW7\\medium.txt");
        fileReader readerL = new fileReader("CSC301\\HW7\\large.txt");
        
        //reading and printing
        
        
        
        int profitM[] = new int[readerM.getValue().size()];
        int weightM[] = new int[readerM.getWeight().size()];
        for (int i = 0; i < weightM.length; i++) {
            profitM[i] = readerM.getValue().get(i);
            weightM[i] = readerM.getWeight().get(i);
        }
        System.out.println(knapsack(readerM.W, weightM, profitM,readerM.n));


        int profitL[] = new int[readerL.getValue().size()];
        int weightL[] = new int[readerL.getWeight().size()];
        for (int i = 0; i < weightL.length; i++) {
            profitL[i] = readerL.getValue().get(i);
            weightL[i] = readerL.getWeight().get(i);
        }
        System.out.println(knapsack(readerL.W, weightL, profitL,readerL.n));
        
        */
        
        fileReader test = new fileReader("CSC301\\HW7\\test.txt");
        int profitt[] = new int[test.getValue().size()];
        int weightt[] = new int[test.getWeight().size()];
        for (int i = 0; i < weightt.length; i++) {
            profitt[i] = test.getValue().get(i);
            weightt[i] = test.getWeight().get(i);
        }
        System.out.println(knapsack(test.W, weightt, profitt, test.n));
        
        
        
        
    }

    public static int knapsack(int W, int[] w, int[] val, int n){
        int read = 0;
        int write = 1;
        int tmp;
        int readM = 0;
        int writeM = 1;
        int temp;
        int[][] m = new int[2][W+1];
        for (int i = 0; i < W+1; i++) {
            m[0][i] = i;
        }
        /* 
        for (int i = 0; i < m[0].length; i++) {
            System.out.println(m[0][i] +  " " + m[1][i]);
        }
        */


        //memory-efficient
        int[][] bag = new int[2][W+1];
        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= W; j++) { 
                if(w[i-1] <= j){
                    
                    bag[write][j] = Math.max(bag[read][j],(val[i-1]) + bag[read][j-(w[i-1])]); 
                    if(i > (n+1)/2){
                        if(bag[write][j] == bag[read][j]){
                            m[writeM][j] = m[readM][j];
                            
                        }
                        else{
                            m[writeM][j] = m[readM][j-w[i-1]];
                        }
                        
                    }
                   
                }
                else{
                    bag[write][j] = bag[read][j];
                    if(i > (n+1)/2)
                        m[writeM][j] = m[readM][j];

                }
    
            }
            
            System.out.println("Outputting!");
            for (int k = 0; k < m[0].length; k++) {
                System.out.println(m[0][k] +  " " + m[1][k]);
            }
            
            if(i > (n+1)/2){
                temp = readM;
                readM = writeM;
                writeM = temp;
            }
            tmp = read;
            read = write;
            write = tmp;     
        }
        
        
        


        
        return m[read][W];

    }
    
    }
    

