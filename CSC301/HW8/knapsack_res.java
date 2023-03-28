package CSC301.HW8;
import java.util.*;
import java.io.*;

public class knapsack_res {
   
    public static void main(String[] args) throws IOException {
        //unit test
        fileReader readerS = new fileReader("CSC301\\HW8\\small.txt");
        fileReader readerM = new fileReader("CSC301\\HW8\\medium.txt");
        fileReader readerL = new fileReader("CSC301\\HW8\\large.txt");

        //reading and printing
        int profitS[] = new int[readerS.getValue().size()];
        int weightS[] = new int[readerS.getWeight().size()];
        for (int i = 0; i < weightS.length; i++) {
            profitS[i] = readerS.getValue().get(i);
            weightS[i] = readerS.getWeight().get(i);
        }

        
        int tes = readerS.knapsack_mem(readerS.W, weightS, profitS,readerS.n);
        readerS.writeAns(tes,"CSC301\\HW8\\smallout.txt");


        
        int profitM[] = new int[readerM.getValue().size()];
        int weightM[] = new int[readerM.getWeight().size()];
        for (int i = 0; i < weightM.length; i++) {
            profitM[i] = readerM.getValue().get(i);
            weightM[i] = readerM.getWeight().get(i);
        }
        int tes2 = readerM.knapsack_mem(readerM.W, weightM, profitM,readerM.n);
        readerM.writeAns(tes2,"CSC301\\HW8\\mediumout.txt");


        int profitL[] = new int[readerL.getValue().size()];
        int weightL[] = new int[readerL.getWeight().size()];
        for (int i = 0; i < weightL.length; i++) {
            profitL[i] = readerL.getValue().get(i);
            weightL[i] = readerL.getWeight().get(i);
        }
        int tes3 = readerL.knapsack_mem(readerL.W, weightL, profitL, readerL.n);
        readerL.writeAns(tes3,"CSC301\\HW8\\largeout.txt");
    }

   
    


    
}
class fileReader{
    ArrayList<Integer> weights = new ArrayList<>();
    ArrayList<Integer> values = new ArrayList<>();
    ArrayList<Integer> store = new ArrayList<>();
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

    public int knapsack_mem(int W, int[] w, int[] val, int n){
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

        int ret = bag[n][W];
        int ans = bag[n][W];
        for (int i = n; i > 0 && ans > 0 ; i--) {

            if(ans != bag[i-1][W]){
                store.add(i);
                ans -= val[i-1];
                W -= w[i-1];  
            }
        }
        
        for (int i = store.size()-1; i >= 0; i--) {
            System.out.println(store.get(i));
            
        }
        return ret;
        
    }
    public void writeAns(int V, String fileName) throws IOException{
        File f = new File(fileName);
        OutputStreamWriter write = new OutputStreamWriter(new FileOutputStream(f), "utf-8");
        BufferedWriter out = new BufferedWriter(write);
        out.write("V " + V);
        out.newLine();
        out.write("i " + store.size());
        out.newLine();
        
        for (int i = store.size()-1; i >= 0; i--) {
            out.write("" + store.get(i));
            out.newLine();
        }

        out.close();

    }



}


