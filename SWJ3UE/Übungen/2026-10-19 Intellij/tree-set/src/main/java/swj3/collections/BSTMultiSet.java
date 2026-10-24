package swj3.collections;

import java.util.Comparator;
import java.util.StringJoiner;

//public class BSTMultiSet<T extends Comparable<T>> implements SortedMultiSet<T> {
public class BSTMultiSet<T> implements SortedMultiSet<T> {

    private static class Node<T> {
        private final T value;
        private Node<T> left;
        private Node<T> right;

        public Node(T value, Node<T> left, Node<T> right) {
            this.value = value;
            this.left = left;
            this.right = right;
        }
    }

    private static class NaturalOrdering<T> implements Comparator<T> {
        @Override
        public int compare(T o1, T o2) {
            if (o1 == null && o2 == null) return 0;
            if (o1 == null) return -1;
            if (o2 == null) return 1;
            ((Comparable<T>) o1).compareTo(o2);

            return 0;
        }
    }

    private Node<T> root = null;
    private int size = 0;

    private Comparator<T> externalComparator;
    private final Comparator<T> comparator;

    private Node<T> addRecursive(Node<T> parent, T item) {
        if (parent == null) {
            this.size++;
            return new Node<>(item, null, null);
        }

        if (comparator.compare(item, parent.value) < 0) {
            parent.left = addRecursive(parent.left, item);
        } else {
            parent.right = addRecursive(parent.right, item);
        }

        return parent;
    }

    public BSTMultiSet() {
        this(null);
    }

    public BSTMultiSet(Comparator<T> comparator) {
        this.externalComparator = comparator;

        // this.comparator = Objects.requireNonNullElseGet(comparator, NaturalOrdering::new);

        // is the same as

        if (comparator == null) {
            this.comparator = new NaturalOrdering<>();
        } else {
            this.comparator = comparator;
        }
    }

    @Override
    public void add(T item) {
        root = addRecursive(root, item);
    }

    @Override
    public T get(T item) {
        var current = root;

        while (current != null) {
            if (comparator.compare(item, current.value) < 0) {
                current = current.left;
            } else if (comparator.compare(item, current.value) > 0) {
                current = current.right;
            } else {
                return current.value;
            }
        }

        return null;
    }

    @Override
    public boolean contains(T item) {
        return get(item) != null;
    }

    @Override
    public int size() {
        return size;
    }

    @Override
    public T first() throws EmptySetException {
        if (root == null) {
            throw new EmptySetException("first not defined for empty set");
        }
        Node<T> current = root;

        while (current.left != null) {
            current = current.left;
        }

        return current.value;
    }

    private void traverseInOrder(Node<T> node, StringJoiner sj) {
        if (node == null) return;

        traverseInOrder(node.left, sj);
        sj.add(node.value.toString());
        traverseInOrder(node.right, sj);
    }

    @Override
    public String toString() {
        StringJoiner sj = new StringJoiner(", ", "(", ")");
        traverseInOrder(root, sj);
        return sj.toString();
    }
}
