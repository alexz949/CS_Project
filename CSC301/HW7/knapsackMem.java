package CSC301.HW7;

import java.util.ArrayList;
import java.io.*;
import java.util.Scanner;

class knapsackMem {
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
        System.out.println(knapsack(readerS.W, weightS, profitS,readerS.n));

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
    }

    public static int knapsack(int W, int[] w, int[] val, int n){
        //memory-efficient
        int bag[] = new int[W+1];
        for(int i = 1; i <= n; i++){
            for(int j = W; j >= 0; j--){//each loop leave the weight for that capacity
                if(w[i-1] <= j){
                    bag[j] = Math.max(bag[j-w[i-1]] + val[i-1], bag[j]);
                }
            }
        }
        return bag[W];
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

