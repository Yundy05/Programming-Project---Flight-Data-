import java.util.LinkedList;
public class HashTable {
  LinkedList<DataPoint>[] table;
  //    LinkedList<DataPoint>[] newTable;
  int size;

  public HashTable(int size)         //init Hash  Chuan:)
  {
    this.size = size;
    table = new LinkedList[size];
    for (int i = 0; i < size; i++)
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
    if (index >=size)
    {
      this.size = index + 1;
      LinkedList<DataPoint>[] newTable = new LinkedList[size];
      for (int i=0; i < table.length; i++)
      {
        newTable[i] = table [i];
      }
      table = newTable;
      for (int i = 1; i < size; i++)
      {
        if (table[i]==null)
          table[i] = new LinkedList<>();
      }
    }
    LinkedList<DataPoint> bucket = table[index];
    bucket.add(aDataPoint);
  }
  public int hashFuncForAirport(String airport)
  {
    int key;
    int a;
    int b;
    int c;
    a = airport.charAt(0);
    a -= 'A';
    b = airport.charAt(1);
    b-='A';
    c = airport.charAt(2);
    c -= 'A';
    return key = a*26*26 + b*26 + c;
  }

  public void putAirport(DataPoint p, String s)
  {
    int index = hashFuncForAirport(s);
    if (index >=size)
    {
      this.size = index + 1;
      LinkedList<DataPoint>[] newTable = new LinkedList[size];
      for (int i=0; i < table.length; i++)
      {
        newTable[i] = table [i];
      }
      table = newTable;
      for (int i = 1; i < size; i++)
      {
        if (table[i]==null)
          table[i] = new LinkedList<>();
      }
    }

    LinkedList<DataPoint> bucket = table[index];
    bucket.add(p);
  }

  public int hashFuncForOrigin(DataPoint p)       // group flights by their origin city  Chuan:)
  {
    int key;
    int a;
    int b ;
    int c;
    a  = p.originCity.charAt(1);
    a -= 'A';
    a *= 26*26;
    b = p.originCity.charAt(2);
    b -= 'a';
    b *= 26;
    c = p.originCity.charAt(3);
    c -= 'a';
    key = a + b + c;
    return key;
  }
  public void putOrigin(DataPoint aDataPoint)    // place flights into groups
  {
    int index = hashFuncForOrigin(aDataPoint);
    if (index >=size)
    {
      this.size = index + 1;
      LinkedList<DataPoint>[] newTable = new LinkedList[size];
      for (int i=0; i < table.length; i++)
      {
        newTable[i] = table [i];
      }
      table = newTable;
      for (int i = 1; i < size; i++)
      {
        if (table[i]==null)
          table[i] = new LinkedList<>();
      }
    }

    LinkedList<DataPoint> bucket = table[index];
    bucket.add(aDataPoint);
  }

  public int hashFuncForDestination(DataPoint p)       // group flights by their destination
  {
    int key;
    int a;
    int b ;
    int c;
    a  = p.destCity.charAt(1);
    a -= 'A';
    a *= 26*26;
    b = p.destCity.charAt(2);
    b -= 'a';
    b *= 26;
    c = p.destCity.charAt(3);
    c -= 'a';
    key = a + b + c;
    return key;
  }
  public void putDestination(DataPoint aDataPoint)
  {
    int index = hashFuncForDestination(aDataPoint);
    if (index >=size)
    {
      this.size = index + 1;
      LinkedList<DataPoint>[] newTable = new LinkedList[size];
      for (int i=0; i < table.length; i++)
      {
        newTable[i] = table [i];
      }
      table = newTable;
      for (int i = 1; i < size; i++)
      {
        if (table[i]==null)
          table[i] = new LinkedList<>();
      }
    }

    LinkedList<DataPoint> bucket = table[index];
    bucket.add(aDataPoint);
  }
  public int getIndexFromCity(String s)       // get a index to origin-sorted or destination-sorted hashtables by city name, capitalize first letter!!!  Chuan:)   Can't tell newark and new york
  {
    int key;
    int a;
    int b ;
    int c;
    a  = s.charAt(1);
    a -= 'A';
    a *= 26*26;
    b = s.charAt(2);
    b -= 'a';
    b *= 26;
    c = s.charAt(3);
    c -= 'a';
    key = a + b + c;
    return key;
  }

  public int hashFuncForWacs(int w)
  {
    return w;
  }
  public void putOriginWac(DataPoint p)
  {
    int index = hashFuncForWacs(p.originWac);
    if (index >=size)
    {
      this.size = index + 1;
      LinkedList<DataPoint>[] newTable = new LinkedList[size];
      for (int i=0; i < table.length; i++)
      {
        newTable[i] = table [i];
      }
      table = newTable;
      for (int i = 1; i < size; i++)
      {
        if (table[i]==null)
          table[i] = new LinkedList<>();
      }
    }

    LinkedList<DataPoint> bucket = table[index];
    bucket.add(p);
  }
  public void putDestinationWac(DataPoint p)
  {
    int index = hashFuncForWacs(p.destWac);
    if (index >=size)
    {
      this.size = index + 1;
      LinkedList<DataPoint>[] newTable = new LinkedList[size];
      for (int i=0; i < table.length; i++)
      {
        newTable[i] = table [i];
      }
      table = newTable;
      for (int i = 1; i < size; i++)
      {
        if (table[i]==null)
          table[i] = new LinkedList<>();
      }
    }

    LinkedList<DataPoint> bucket = table[index];
    bucket.add(p);
  }
}
