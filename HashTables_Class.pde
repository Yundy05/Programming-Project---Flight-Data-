public class HashTable {

    //the node of each chain
    class Node{
      //key value
        int key;
        Object aDataPoint;
        Node next;   //create the next node
        //no parameter constructor
        Node(){}
        //parameter constructor
        Node(int key, Object aDataPoint){
            this.key = key;
            this.aDataPoint = aDataPoint;
            next = null;
        }
        //rewrite equals()
        public boolean equals(Node node){
            if(this == node) return true;
            else{
                if(node == null) return false;
                else{
                    return this.aDataPoint == node.aDataPoint && this.key == node.key;
                }
            }
        }
    }
    //length of the hash map
    int length;
    // number of entries
    int size;
    //store data
    Node table[];
    //no length constructor
    public HashTable(){
        length = 16;
        size = 0;
        table = new Node[length];
        //init nodes
        for (int i = 0; i < length; i++) {
            table[i] = new Node(i,null);
        }
    }
    //length constructor
    public HashTable(int length){
            this.length = length;
            size = 0;
            table = new Node[length];
            for (int i = 0; i < length; i++) {
                table[i] = new Node(i,null);
            }
        }
        
        
   public int hashFuncForDate(int x)
   {
     int key = x%1000;
     return key;
   }
    
   public int hasFuncForAirport()
   {
     return 0;
   }
        
   public void putDates(int key, Object aDataPoint){
        int index = hashFuncForDate(key);
            //cur 1 is the node before cur2
            Node cur1 = table[index].next;
            Node cur2 = table[index];
            while(cur1 != null){
                if(cur1.key == key){
                    cur1.aDataPoint = aDataPoint;
          //          return aDataPoint;
                }
                cur1 = cur1.next;
                cur2 = cur2.next;
            }
            cur2.next = new Node(key, aDataPoint);
            size++;
        //return value;
    }
    
     public void printHash(){
        for(int i = 0; i < length; i++){
            Node cur = table[i];
            System.out.printf("Chain number : %d: ",i);
            if(cur.next == null){
                System.out.println("null");
                continue;
            }
            cur = cur.next;
            while(cur != null){
                System.out.print(cur.key + "---"+ cur.aDataPoint + "  ");
                cur = cur.next;
            }
            System.out.println();
        }
    }
}
