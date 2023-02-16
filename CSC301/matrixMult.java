package CSC301;
import java.io.File;
import java.io.FileNotFoundException;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;
public class matrixMult{
    public static void main(String[] args) throws FileNotFoundException {
        /* 
        if(args.length != 3){
            System.out.println("argument input is incorrect");
            System.exit(0);
        }
        File file = new File(args[1]);
        Scanner sc = new Scanner(file);

    
        File file2 = new File(args[2]);
        Scanner sc2 = new Scanner(file2);
        

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
        array.clear();

        while(sc2.hasNextLine()){
            String str2 = sc2.nextLine();
            array.add(str2.split(" "));
        } 
        int[][] m2 = new int[array.size()][array.get(0).length];
        for (int i = 0; i < m2.length; i++) {
            for (int j = 0; j < m2[0].length; j++) {
                m2[i][j] = Integer.parseInt(array.get(i)[j]);
            }
        }
        int[][] ans = multiplication(m1, m2);
        for (int i = 0; i < ans.length; i++) {
            System.out.println(Arrays.toString(ans[i]));
        }
        */
        int[][] test = {{1,2,3,4},
                        {5,6,7,8},
                        {9,10,11,12},
                        {13,14,15,16}};
        int[][] test2 = {{13,14,15,16},
                        {9,10,11,12},
                        {5,6,7,8},
                        {1,2,3,4}};
        int[][] test3 = {{1,2},{1,2}};        
        int[][] ans = multiplication(test, test2);
        for (int i = 0; i < ans.length; i++) {
            System.out.println(Arrays.toString(ans[i]));
        }





        

        
    }
    static int[][] multiplication(int[][] A, int[][]B){
        int n = A.length;
        int[][] ans = new int[n][n];
        if(n == 1){
            ans[0][0] = A[0][0] * B[0][0];
            return ans;
        }
        int[][] A11 = partition(A,0,0);
        System.out.println("Length of A11 " + A11.length);
        int[][] A12 = partition(A,0,n/2);
        int[][] A21 = partition(A,n/2,0);
        int[][] A22 = partition(A,n/2,n/2);   
        int[][] B11 = partition(B,0,0);
        int[][] B12 = partition(B,0,n/2);
        int[][] B21 = partition(B,n/2,0);
        int[][] B22 = partition(B,n/2,n/2);   
        

        int[][] M1 = multiplication(addition(A11, A22),addition(B11, B22));
        int[][] M2 = multiplication(addition(A21, A22), B11);
        int[][] M3 = multiplication(A11, subtraction(B12, B22));
        int[][] M4 = multiplication(A22, subtraction(B21, B11));
        int[][] M5 = multiplication(addition(A11, A12), B22);
        int[][] M6 = multiplication(subtraction(A21, A11), addition(B11, B12));
        int[][] M7 = multiplication(subtraction(A12, A22), addition(B21, B22));
        for (int i = 0; i < M5.length; i++) {
            System.out.println(Arrays.toString(M5[i]));
        }
        int[][] C11 = addition(subtraction(addition(M1, M4),M5),M7);
        int[][] C12 = addition(M3, M5);
        int[][] C21 = addition(M2, M4);
        int[][] C22 = addition(subtraction(M1, M2), addition(M3, M6));
        System.out.println("This is C11");
        for (int i = 0; i < C11.length; i++) {
            System.out.println(Arrays.toString(C11[i]));
        }
        System.out.println("This is C12");
        for (int i = 0; i < C12.length; i++) {
            System.out.println(Arrays.toString(C12[i]));
        }
        System.out.println("This is C21");
        for (int i = 0; i < C11.length; i++) {
            System.out.println(Arrays.toString(C21[i]));
        }
        System.out.println("This is C22");
        for (int i = 0; i < C11.length; i++) {
            System.out.println(Arrays.toString(C22[i]));
        }
        
       
        //C11
        int num1 = 0;
        
        for (int i1 = 0; i1 < C11.length; i1++){
            int tp = 0;
            // Inner loop for columns
            for (int j1 = 0; j1 < C11.length; j1++){

                ans[num1][tp] = C11[i1][j1];
                tp++;
            }
            num1++;
        }
        
        //C12
        num1 = 0;
        for (int i1 = 0; i1 < C11.length; i1++){
            int temp = n/2;

            // Inner loop for columns
            for (int j1 = 0; j1 < C11.length; j1++){

                ans[num1][temp] = C12[i1][j1];
                temp++;
            }
            num1++;


        }
        
        //C21
        num1 = n/2;
        for (int i1 = 0; i1 < C11.length; i1++){
            int tmp = 0;
            // Inner loop for columns
            for (int j1 = 0; j1 < C11.length; j1++){

                ans[num1][tmp] = C21[i1][j1];
                tmp++;
            }
            num1++;
        }
        
        //C22
        num1 = n/2;
        int num2 = 0;
        for (int i1 = 0; i1 < C11.length; i1++){
            num2 = n/2;
            // Inner loop for columns
            for (int j1 = 0; j1 < C11.length; j1++){

                ans[num1][num2] = C22[i1][j1];
                num2++;
            }
            num1++;
        }
        
        
        

        return ans;
    }









    private static int[][] partition(int[][] A, int num1, int num2){
        int[][] m = new int[A.length/2][A.length/2];
        int c1 = num1;
        int c2 = num2;
        for (int i1 = 0, i2 = num1; i1 < m.length; i1++, i2++)

            // Inner loop for columns
            for (int j1 = 0, j2 = num2; j1 < m.length;
                j1++, j2++)

                m[i1][j1] = A[i2][j2];
        return m;
    }
    private static int[][] addition(int[][] A, int[][] B){
        int[][] m = new int[A.length][A.length];
        for (int i = 0; i < m.length; i++) {
            for (int j = 0; j < m.length; j++) {
                m[i][j] =  B[i][j] + A[i][j];
            }
        }
        return m;

    }
    private static int[][] subtraction(int[][] A, int[][] B){
        int[][] m = new int[A.length][A.length];
        for (int i = 0; i < m.length; i++) {
            for (int j = 0; j < m.length; j++) {
                m[i][j] = A[i][j] - B[i][j];
            }
        }
        return m;
    }
    public static void join(int[][] C, int[][] P, int iB, int jB)

    {
        // Iterating over elements of 2D matrix
        // using nested for loops

        // Outer loop for rows
        for (int i1 = 0, i2 = iB; i1 < C.length; i1++, i2++)

            // Inner loop for columns
            for (int j1 = 0, j2 = jB; j1 < C.length;
                j1++, j2++)

                P[i2][j2] = C[i1][j1];
        
    }

}