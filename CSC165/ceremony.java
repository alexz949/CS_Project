import java.util.*;

public class ceremony{
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);
        int num_row = scan.nextInt();

        int[] arr = new int[num_row];
        for (int i = 0; i < num_row; i++) {
            arr[i] = scan.nextInt();
        }
        Arrays.sort(arr);
        
        
        
        int num = num_row;
        for (int i = 0; i < arr.length ; i++) {
            num = Math.min(num, num_row - i -1 + arr[i]);
            
        }
        System.out.print(num);

    }
}

