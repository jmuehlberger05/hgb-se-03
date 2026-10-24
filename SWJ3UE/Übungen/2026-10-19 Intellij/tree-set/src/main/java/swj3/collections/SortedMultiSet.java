package swj3.collections;

//public interface SortedMultiSet<T extends Comparable<T>> {
public interface SortedMultiSet<T> {
    void add(T item);

    T get(T item);

    boolean contains(T item);

    int size();

    T first() throws EmptySetException;
}
