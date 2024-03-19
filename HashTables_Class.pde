import java.util.LinkedList;
public class HashTable {
    LinkedList<DataPoint>[] table;
    LinkedList<DataPoint>[] newTable;
    int size;
    
    public HashTable(int size)         //init Hash  Chuan:)
    {
    this.size = size;
    table = new LinkedList[size];
    for(int i = 0; i < size; i++)
        {
          table[i] = new LinkedList<>();
        }    
    }
    
    public HashTable()
    {
      this.size = 1;
      table = new LinkedList[1];
      table[0] = new LinkedList<>();
    }
          
   public LinkedList<DataPoint> getDataByIndex(int i)      //get the arrayList from a certain index   Chuan:)
   {
       return table[i];
   }
   
    public int hashFuncForDate(int x)      // Currently this is only for date   Chuan:)
   {
     int key = x-1;
     return key;
   }
        
   public void putDates(int key, DataPoint aDataPoint)     //used for creating date-keyed hashtable      Chuan:)
   {
     
        int index = hashFuncForDate(key);
        if(index >=size)
        {
             this.size = index + 1;
             newTable = new LinkedList[size];
             for(int i=0; i < table.length ;i++)
             {
                 newTable[i] = table [i];
             }
             table = newTable;
          for(int i = 1; i < size; i++)
        {
          table[i] = new LinkedList<>(); 
        }
        }
        LinkedList<DataPoint> bucket = table[index];
        bucket.add(aDataPoint);

   }
    
   public int hashFuncForAirport(int x)       // currently blank   Chuan:)
   {
     return 0; 
   }
   public void putAirports(int key , DataPoint aDataPoint)
   {
     int index = hashFuncForAirport(key);
       LinkedList<DataPoint> bucket = table[index];
        bucket.add(aDataPoint);
   }

}

  
