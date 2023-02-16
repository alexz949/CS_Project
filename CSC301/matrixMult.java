package CSC301;
import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

public class matrixMult{
    public static void main(String[] args) throws FileNotFoundException, IOException {
        //randomly generating matrix with given dimention
        randMat(128, "mat.txt");
        randMat(128,"mat2.txt");

        //reading and converting into matrices.
        int[][] m1 = matTransform("mat.txt");
        int[][] m2 = matTransform("mat2.txt");
        
        //unti test when n = 2,and 4
        int[][] test = {{1,2},
                        {1,2},};
        int[][] test2 = {{13,14,15,16},
                        {9,10,11,12},
                        {5,6,7,8},
                        {1,2,3,4}};
        
        //unit test 
        print(multiplication(test,test));
        print(multiplication(test2,test2));


        //printing result random matrix
        int[][] ans = multiplication(m1, m2);
        print(ans);

    }
    
    private static int[][] multiplication(int[][] A, int[][]B){
        int n = A.length;
        int[][] ans = new int[n][n];
        //base case
        if(n == 1){
            ans[0][0] = A[0][0] * B[0][0];
            return ans;
        }
        //partition
        int[][] A11 = partition(A,0,0);
        int[][] A12 = partition(A,0,n/2);
        int[][] A21 = partition(A,n/2,0);
        int[][] A22 = partition(A,n/2,n/2);   
        int[][] B11 = partition(B,0,0);
        int[][] B12 = partition(B,0,n/2);
        int[][] B21 = partition(B,n/2,0);
        int[][] B22 = partition(B,n/2,n/2);   
        
        //recursions
        int[][] M1 = multiplication(addition(A11, A22),addition(B11, B22));
        int[][] M2 = multiplication(addition(A21, A22), B11);
        int[][] M3 = multiplication(A11, subtraction(B12, B22));
        int[][] M4 = multiplication(A22, subtraction(B21, B11));
        int[][] M5 = multiplication(addition(A11, A12), B22);
        int[][] M6 = multiplication(subtraction(A21, A11), addition(B11, B12));
        int[][] M7 = multiplication(subtraction(A12, A22), addition(B21, B22));
        //combination
        int[][] C11 = addition(subtraction(addition(M1, M4),M5),M7);
        int[][] C12 = addition(M3, M5);
        int[][] C21 = addition(M2, M4);
        int[][] C22 = addition(subtraction(M1, M2), addition(M3, M6));
        
        //C11
        int num1 = 0;
        for (int i = 0; i < C11.length; i++){
            int tp = 0;
            for (int j = 0; j < C11.length; j++){
                ans[num1][tp] = C11[i][j];
                tp++;
            }
            num1++;
        }
    
        //C12
        num1 = 0;
        for (int i = 0; i < C12.length; i++){
            int temp = n/2;
            for (int j = 0; j < C12.length; j++){
                ans[num1][temp] = C12[i][j];
                temp++;
            }
            num1++;
        }
        
        //C21
        num1 = n/2;
        for (int i = 0; i < C21.length; i++){
            int tmp = 0;
            for (int j = 0; j < C21.length; j++){
                ans[num1][tmp] = C21[i][j];
                tmp++;
            }
            num1++;
        }
        
        //C22
        num1 = n/2;
        int num2 = 0;
        for (int i = 0; i < C22.length; i++){
            num2 = n/2;
            for (int j = 0; j < C22.length; j++){
                ans[num1][num2] = C22[i][j];
                num2++;
            }
            num1++;
        }

        return ans;
    }


    private static int[][] partition(int[][] A, int num1, int num2){ //partitioning
        int[][] m = new int[A.length/2][A.length/2];
        int c1 = num1;
        int c2 = num2;
        for (int i = 0; i < m.length; i++){
            c2 = num2;
            for (int j = 0; j < m.length; j++){
                m[i][j] = A[c1][c2];
                c2++;
            }
            c1++;
        }

        return m;
    }

    private static int[][] addition(int[][] A, int[][] B){ //adding entries
        int[][] m = new int[A.length][A.length];
        for (int i = 0; i < m.length; i++) {
            for (int j = 0; j < m.length; j++) {
                m[i][j] =  B[i][j] + A[i][j];
            }
        }
        return m;

    }
    private static int[][] subtraction(int[][] A, int[][] B){ //subtracting entries
        int[][] m = new int[A.length][A.length];
        for (int i = 0; i < m.length; i++) {
            for (int j = 0; j < m.length; j++) {
                m[i][j] = A[i][j] - B[i][j];
            }
        }
        return m;
    }
    private static int[][] matTransform(String fileName) throws IOException{ //reading txt file into matrix
        File file = new File(fileName);
        Scanner sc = new Scanner(file);
        ArrayList<String[]> array = new ArrayList<>();
        while(sc.hasNextLine()){
            String str = sc.nextLine();
            array.add(str.split(" "));
        } 
        int[][] m1 = new int[array.size()][array.get(0).length];
        for (int i = 0; i < m1.length; i++) {
            for (int j = 0; j < m1[0].length; j++) {
                m1[i][j] = Integer.parseInt(array.get(i)[j]);
            }
        }
        return m1;
    

    }
    private static void print(int[][] mat){//printing matrix
        System.out.println("Matrix dimension: " + mat.length);
        for (int i = 0; i < mat.length; i++) {
            System.out.println(Arrays.toString(mat[i]));
        } 

    }
   
    private static void randMat(int n, String fileName) throws IOException{ //random generating txt matrix.
        int max = 100;
        int min = -100;
        File f = new File(fileName);
        OutputStreamWriter write = new OutputStreamWriter(new FileOutputStream(f), "UTF-8");
        BufferedWriter out = new BufferedWriter(write);
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if(j == n-1) {
                    out.write("" + (min + (int)(Math.random() * ((max - min) + 1))));
                } else {
                    out.write(min + (int)(Math.random() * ((max - min) + 1)) + " ");
                }
            }
            if(i != n-1)
                out.newLine();
        }

        out.close();
    }
}