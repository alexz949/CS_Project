package CSC301.HW8;

import java.util.ArrayList;
import java.util.Arrays;
import java.io.*;
import java.util.Scanner;



public class knapsackDC {
    public static void main(String[] args) throws IOException {
     
        System.out.println("See this if it is HW8");
        
        //unit test
        fileReader readerS = new fileReader("CSC301\\HW7\\small.txt");
        fileReader readerM = new fileReader("CSC301\\HW7\\medium.txt");
        fileReader readerL = new fileReader("CSC301\\HW7\\large.txt");
        fileReader test = new fileReader("CSC301\\HW7\\test.txt");
        
        int profitt[] = new int[test.getValue().size()];
        int weightt[] = new int[test.getWeight().size()];
        for (int i = 0; i < weightt.length; i++) {
            profitt[i] = test.getValue().get(i);
            weightt[i] = test.getWeight().get(i);
        }
        //System.out.println(knapsack(test.W, weightt, profitt, test.n));
        System.out.println(Arrays.toString(divide(test.W, weightt, profitt, weightt, profitt)));
        /* 
        
        
        int profitS[] = new int[readerS.getValue().size()+1];
        int weightS[] = new int[readerS.getWeight().size()+1];
        profitS[0] = 0;
        weightS[0] = 0;
        for (int i = 1; i < weightS.length-1; i++) {
            profitS[i] = readerS.getValue().get(i);
            weightS[i] = readerS.getWeight().get(i);
        }
        
        System.out.println(Arrays.toString(divide(readerS.W, weightS, profitS, weightS, profitS)));
        
        /* 
        int profitM[] = new int[readerM.getValue().size()];
        int weightM[] = new int[readerM.getWeight().size()];
        for (int i = 0; i < weightM.length; i++) {
            profitM[i] = readerM.getValue().get(i);
            weightM[i] = readerM.getWeight().get(i);
        }
        System.out.println(knapsack(readerM.W, weightM, profitM,readerM.n));
        System.out.println(Arrays.toString(divide(readerM.W, weightM, profitM, weightM, profitM)));

        /* 
        
        
        /* 
        


        /*
       
        
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
            /*
            
            System.out.println("Outputting!");
            for (int k = 0; k < m[0].length; k++) {
                System.out.println(m[0][k] +  " " + m[1][k]);
            }
            */
            
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
    
    
    public static int[] divide(int W, int[] w, int[] val, int[] stdW, int[] stdV){
        int k = knapsack(W, w, val, val.length);

    
        
        

        if(val.length == 1){
            if(k == 0 && W-k != 0){
                System.out.println(k + " " + (W-k));

            }
            else
                System.out.println("test");
            
            
            return new int[1];
        }
        
        int mid = w.length / 2 ;
        
        int[] wl = new int[mid];
        int[] wr = new int[w.length-mid];
        int[] vl = new int[mid];
        int[] vr = new int[w.length-mid];
        for (int i = 0; i < mid; i++) {
            wl[i] = w[i];
            vl[i] = val[i];
        }
 
        int t = 0;
        for (int i = mid; i < w.length; i++) {
            wr[t] = w[i];
            vr[t] = val[i];
            t++;
        }
         
        int[] num1 = divide(k, wl, vl, stdW, stdV);
        int[] num2 = divide(W-k, wr, vr, stdW, stdV);
        int[] sum = new int[num1.length+num2.length];
        
        for (int i = 0; i < num1.length; i++) {
            sum[i] = num1[i];
            
        }
        t = 0;
        for (int i = num1.length; i < sum.length; i++) {
            sum[i] = num2[t];
            t++;
        }
        return sum;
            

    }
}
    

    

class fileReader{
    ArrayList<Integer> weights = new ArrayList<>();
    ArrayList<Integer> values = new ArrayList<>();
    int W;
    int n;
    public fileReader(String path) throws IOException{
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
    public ArrayList<Integer> getWeight(){
        return weights;
    }
    public ArrayList<Integer> getValue(){
        return values;
    }


}


