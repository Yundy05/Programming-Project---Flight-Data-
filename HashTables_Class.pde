import java.util.LinkedList;
public class HashTable {
    LinkedList<DataPoint>[] table;
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
          
   public int hashFuncForDate(int x)      // Currently this is only for date   Chuan:)
   {
     int key = x;
     return key;
   }
    
   public int hashFuncForAirport()       // currently blank   Chuan:)
   {
     return 0;
   }
   
   public LinkedList<DataPoint> getDataByIndex(int i)      //get the arrayList from a certain index   Chuan:)
   {

       return table[i];
   }
   
        
   public void putDates(int key, DataPoint aDataPoint)     //used for creating date-keyed hashtable      Chuan:)
   {
        int index = hashFuncForDate(key);
       LinkedList<DataPoint> bucket = table[index];
        bucket.add(aDataPoint);
    }

}

  
