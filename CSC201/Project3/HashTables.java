import java.util.HashSet;

public class HashTables{

    // Problem 4.
    public void findSumPair(int target, int[] array){
        
        int num1 = 0;
        int num2 = 0;
        int res;
        HashSet<Integer> set = new HashSet<>();

        //make a set which contain all subtractions
        for (int i = 0; i < array.length; i++) {
            res = target - array[i];
            if(!set.contains(res)){
                set.add(res);
            }

        }


        //looping through array to find if the num matches
        for (int i = 0; i < array.length; i++) {

            if (set.contains(array[i])) {
                num1 = array[i];
                num2 = target - array[i];
                System.out.println("Pair Found: " + num1 + ", " + num2 + ".");
                return;
            }
        }

        System.out.println("Pair Not Found.");
    }

    // Problem 5.
    public int DistinctValues(int[] array){
    

        //create a set to record the distinct value
        HashSet<Integer> set = new HashSet<>();

        //looping through the array and check the cond
        for (int i = 0; i < array.length; i++) {
            if(!set.contains(Math.abs(array[i]))){
                set.add(Math.abs(array[i]));
            }
        }

        return set.size();
    }
    //Unit test
    public static void main(String[] args){
        // For your tests.
        HashTables table = new HashTables();
        int target = 13;
        int[] array = {11,2,1,1,1,2};
        table.findSumPair(target, array);
        int ans = table.DistinctValues(array);
        System.out.println(ans);

    }
}