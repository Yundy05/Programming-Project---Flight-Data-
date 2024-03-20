import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
class ArrDelayComparator implements Comparator<DataPoint>
{
   public int compare(DataPoint dp1, DataPoint dp2) {
        return Integer.compare(dp1.getArrDelay(), dp2.getArrDelay());
    }
    
}
class DepDelayComparator implements Comparator<DataPoint>
{
   public int compare(DataPoint dp1, DataPoint dp2) {
        return Integer.compare(dp1.getDepDelay(), dp2.getDepDelay());
    }
    
}
