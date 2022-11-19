import java.util.HashMap;

import javax.xml.validation.Validator;

public class HashTables{

    // Problem 4.
    public static void findSumPair(int target, int[] array){
        //TODO.
        int num1 = 0;
        int num2 = 0;
        HashMap<Integer, Integer> map = new HashMap<>();

        for (int i = 0; i < array.length; i++) {
            
            int res = target - array[i];
            
            map.put(res, array[i]);
        }
        for(int a : array){
            if(map.containsKey(a)){
                num1 = map.get(a);
                num2 = a;
                System.out.println("Pair found:" + num1 + ", " + num2);
                return;
            }
                
        }



        
    }

    // Problem 5.
    public static int DistinctValues(int[] array){
        // TODO.
    }

    public static void main(String[] args){
        // For your tests.
    }
}