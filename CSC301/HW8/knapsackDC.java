package CSC301.HW8;

import java.util.Arrays;
import java.util.Collections;
import java.io.*;




public class knapsackDC {
    public static void main(String[] args) throws IOException {
     
        System.out.println("See this if it is HW8");
        
        //unit test
        fileReader readerS = new fileReader("CSC301\\HW7\\small.txt");
        fileReader readerM = new fileReader("CSC301\\HW7\\medium.txt");
        fileReader readerL = new fileReader("CSC301\\HW7\\large.txt");
    
         
        int profitS[] = new int[readerS.getValue().size()];
        int weightS[] = new int[readerS.getWeight().size()];
       
        for (int i = 0; i < weightS.length; i++) {
            profitS[i] = readerS.getValue().get(i);
            weightS[i] = readerS.getWeight().get(i);
        }
        
        int[] temp = divide(readerS.W, weightS, profitS);
        int count = 0;
        for (int i = 0; i < temp.length; i++) {
            System.out.print(temp[i] + " ");
            if(temp[i]!= 0)
                count++;
        }
        int V = 0;
        
        int[] re1 = new int[count];
        int t = 0;
        for (int i = 0; i < temp.length-2; i++) {
            if(temp[i]!= 0){
                re1[t] = temp[i];
                System.out.print(re1[t]);
                t++;
            }
        }
        for (int i = 0; i < re1.length; i++) {
            for (int j = profitS.length-1; j >= 0; j--) {
                if(re1[i] == weightS[j]){
                    V += profitS[j];
                    readerS.store.add(j+1);
                }
            }
        }
        Collections.reverse(readerS.store);
        readerS.writeAns(V, "CSC301\\HW8\\DCsmallerout.txt");
        
        
        
        
        

        
        /* 
        int profitM[] = new int[readerM.getValue().size()];
        int weightM[] = new int[readerM.getWeight().size()];
        for (int i = 0; i < weightM.length; i++) {
            profitM[i] = readerM.getValue().get(i);
            weightM[i] = readerM.getWeight().get(i);
        }


        System.out.println(Arrays.toString(divide(readerM.W, weightM, profitM)));
        
        
       
        
        
       
        
        //reading and printing
        
        int profitL[] = new int[readerL.getValue().size()];
        int weightL[] = new int[readerL.getWeight().size()];
        for (int i = 0; i < weightL.length; i++) {
            profitL[i] = readerL.getValue().get(i);
            weightL[i] = readerL.getWeight().get(i);
        }
        System.out.println(divide(readerL.W, weightL, profitL));
        int[] what = divide(readerL.W, weightL, profitL);
        int sum = 0;
        for (int i = 0; i < what.length; i++) {
            if(what[i]!= 0){
                sum += what[i];
            }
        }
        System.out.println("asuchiwopefh: " + sum);
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
    
    
    public static int[] divide(int W, int[] w, int[] val){
        int k = knapsack(W, w, val, val.length);

        System.out.println(Arrays.toString(w));
        System.out.println("K "+ k + " W " + (W));

        int mid = (w.length-1) / 2;
   
        if(val.length == 2){
            
            int[] ans = new int[2];
            if(k != 0 || (W-k) != 0){
                if((W+k) == w[0] || (W+k) == w[1]){
                    if(w[0] == (W+k))
                        ans[0] = w[0];
                    else
                        ans[0] = w[1];
                    return ans;
                }
                if(w[0] == w[1]){
                    if(val[0] > val[1])
                        ans[0] = w[0];
                    else
                        ans[0] = w[1];
                    return ans;
                }
                if(w[1] == k)
                    ans[0] = w[1];
                else if(w[0] == k)
                    ans[0] = w[0];
                
            }
            return ans;
        }


        int[] wl = new int[mid+1];
        int[] wr = new int[w.length-mid];
        int[] vl = new int[mid+1];
        int[] vr = new int[w.length-mid];
        for (int i = 0; i < mid+1; i++) {
            wl[i] = w[i];
            vl[i] = val[i];
        }
 
        int t = 0;
        for (int i = mid; i < w.length; i++) {
            wr[t] = w[i];
            vr[t] = val[i];
            t++;
        }
        

        //System.out.println(Arrays.toString(wl));
        //System.out.println(Arrays.toString(wr));
         
        int[] num1 = divide(k, wl, vl);
        int[] num2 = divide(W-k, wr, vr);
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
    

    






