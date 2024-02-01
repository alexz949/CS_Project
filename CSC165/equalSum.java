import java.util.*;
public class equalSum{
    public static void main(String[] args) {
        
        Scanner scan = new Scanner(System.in);
        String tt = scan.nextLine();
        int num = Integer.parseInt(tt);
        int[][] mat = new int[num][20];
        int[] test = new int[20*100000];
        int len = 0;
        for(int i = 0; i < num; i++){
            String cool = scan.nextLine();
            String[] arr = cool.split(" ");
            len = Integer.parseInt(arr[0]);
            for(int j = 0; j < len; j++){
                mat[i][j] = Integer.parseInt(arr[j+1]);
            }
        }


        int ite = 1;
        for(int j = 0; j < mat.length; j++) {
            boolean  check = true;
            System.out.println("Case #" + (j+1) + ":");
            while (ite < 1048576 && check) {
                int sum = 0;

                int tmp = ite;
                int k = 19;
                while (tmp > 0) {
                    if (tmp % 2 == 1) {
                        sum += mat[j][k];
                    }
                    tmp /= 2;
                    k--;
                }


                if (test[sum] == 0)
                    test[sum] = ite;
                else {

                    String output1 = "";
                    String output2 = "";
                    tmp = ite;
                    k = 19;
                    while (tmp > 0) {
                        if (tmp % 2 == 1) {
                            output1 = mat[j][k] + " " + output1;

                        }
                        tmp /= 2;
                        k--;
                    }
                    tmp = test[sum];
                    k = 19;
                    while (tmp > 0) {
                        if (tmp % 2 == 1) {
                            output2 = mat[j][k] + " " + output2;

                        }
                        tmp /= 2;
                        k--;
                    }
                    System.out.println(output1);
                    System.out.println(output2);
                    check = false;

                }
                ite++;

            }
            if(check){
                if(j == mat.length-1)
                    System.out.print("Impossible");
                else{
                    System.out.println("Impossible");
                }

            }



        }




    }


}