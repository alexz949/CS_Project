import java.util.ArrayList;




public class GraphMatrix implements Graph{

    private int[][] array_2D;
    private int edgeNum = 0;
    private boolean[][] check_2D;

    

    @Override
    public void init(int n) {
        // TODO Auto-generated method stub
        array_2D = new int[n][n];
        check_2D = new boolean[n][n];
        
        return;
        
    }

    @Override
    public int nodeCount() {
        // TODO Auto-generated method stub
        
        return array_2D.length;
    }

    @Override
    public int edgeCount() {
        // TODO Auto-generated method stub
        return edgeNum;
        
    }

    @Override
    public void addEdge(int v, int w, int wgt) {
        // TODO Auto-generated method stub
        

        array_2D[v][w] = wgt;
        edgeNum++;
        return;
        
    
    }

    @Override
    public int getWeight(int v, int w) {
        // TODO Auto-generated method stub
        
        return array_2D[v][w];
    }

    @Override
    public void setWeight(int v, int w, int wgt) {
        // TODO Auto-generated method stub
        array_2D[v][w] = wgt;
        return;
        
    }

    @Override
    public void removeEdge(int v, int w) {
        // TODO Auto-generated method stub
        array_2D[v][w] = 0;
        edgeNum--;
        return;
        
    }

    @Override
    public boolean hasEdge(int v, int w) {
        // TODO Auto-generated method stub
        if(array_2D[v][w] == 0)
            return false;
        else{
            return true;
        }
    }

    @Override
    public ArrayList<Integer> neighbors(int v) {
        // TODO Auto-generated method stub
        ArrayList<Integer> array = new ArrayList<>();
        for (int i = 0; i < array_2D.length; i++) {
            if(array_2D[v][i] != 0){
                array.add(array_2D[v][i]);
            }
            
        }
        return array;
    }

    @Override
    public void resetVisited() {
        // TODO Auto-generated method stub
        for (int i = 0; i < check_2D.length; i++) {
            for (int j = 0; j < check_2D[0].length; j++) {
                check_2D[i][j] = false;
            }
        }
        return;

        
    }

    @Override
    public ArrayList<Integer> BFS(int v) {
        // TODO Auto-generated method stub
        ArrayList<Integer> array = new ArrayList<>();
        array.add(v);
        check_2D[v][v] = true;
        
        int num = 0;
        int num2 = v;
        while(true){
            if(hasEdge(num2, num) && check_2D[num2][num] == false){
                array.add(num);
                check_2D[num2][num] = true;
                num2 = num;
                num = 0;
            }
            if(num > nodeCount())
                break;
        }

        return array;
    }

    @Override
    public boolean hasPath(int v, int w) {
        // TODO Auto-generated method stub
        return false;
    }

    @Override
    public ArrayList<Integer> topologicalSort() {
        // TODO Auto-generated method stub
        return null;
    }
    //TODO.
}