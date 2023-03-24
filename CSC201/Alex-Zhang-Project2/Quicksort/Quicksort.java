

public class Quicksort{

    public void my_quicksort(int[] array){
        quicksort_helper(array, 0, array.length-1);
    }

    private void quicksort_helper(int[] array, int low, int high){
        //Using recurion partitioning arrays
        if(low >= high)
            return;
        else{
            int pivot = partition(array, low, high);
            swap(array, high, pivot);
            quicksort_helper(array, pivot+1, high);
            quicksort_helper(array, low, pivot-1);
        }
    }

    private int partition(int[] array, int low, int high){
        //Set pivot at the begining.
        int pivot = array[high];
        int right = high-1;
        int left = low;

        while(right >= left){
            while(array[left] > pivot)
                left++;
            while(right >= left && array[right] <= pivot)
                right--;
            if(right > left) 
                swap(array, right, left);
        }
        return right+1;
    }
    private void swap(int[] array, int idx1, int idx2){
        int temp = array[idx1];
        array[idx1] = array[idx2];
        array[idx2] = temp;
    }
    //unit test
    
    public static void main(String[] args) {
        int[] test = {2,1,6,3,8,2,9,3,1,89};
        Quicksort sort = new Quicksort();
        sort.my_quicksort(test);
        
        for (int i = 0; i < test.length; i++) {
            System.out.println(test[i]);
        }
    }
    
}