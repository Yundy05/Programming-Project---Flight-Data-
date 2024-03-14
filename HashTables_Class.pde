public class HashTableDemo {

    //the node of each chain
    class Node{
      //key value
        int key;
        String value;
        Node next;   //create the next node
        //no parameter constructor
        Node(){}
        //parameter constructor
        Node(int key, String value){
            this.key = key;
            this.value = value;
            next = null;
        }
        //rewrite equals()
        public boolean equals(Node node){
            if(this == node) return true;
            else{
                if(node == null) return false;
                else{
                    return this.value == node.value && this.key == node.key;
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
    public HashTableDemo(){
        length = 16;
        size = 0;
        table = new Node[length];
        //init nodes
        for (int i = 0; i < length; i++) {
            table[i] = new Node(i,null);
        }
    }
    //length constructor
    public HashTableDemo(int length){
            this.length = length;
            size = 0;
            table = new Node[length];
            for (int i = 0; i < length; i++) {
                table[i] = new Node(i,null);
            }
        }
}
