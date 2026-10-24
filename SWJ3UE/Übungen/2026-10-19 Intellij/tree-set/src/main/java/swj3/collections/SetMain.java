package swj3.collections;

import java.time.LocalDate;
import java.util.Comparator;

class AgeComparator implements Comparator<Person> {
    @Override
    public int compare(Person p1, Person p2) {
        return p1.getDob().compareTo(p2.getDob());
    }
}

public class SetMain {
    static void main() {
        SortedMultiSet<String> cities = new BSTMultiSet<>();
        cities.add("Linz");
        cities.add("Wien");
        cities.add("Salzburg");
        cities.add("Hagenberg");

        System.out.printf("cities.size = %d%n", cities.size());
        IO.println("cities.contains(\"Hagenberg\") -> %b".formatted(cities.contains("Hagenberg")));
        IO.println("cities.contains(\"Bregenz\") -> %b".formatted(cities.contains("Bregenz")));

        IO.println("cities -> %s".formatted(cities));

        try {
            IO.println("cities.first() -> %s".formatted(cities.first()));


            var empty = new BSTMultiSet<String>();
            IO.println("empty.first() -> %s".formatted(empty.first()));
        } catch (EmptySetException e) {
            IO.println("ERROR: EmptySetException: msg = %s".formatted(e.getMessage()));
        } finally {
            IO.println("finally");
        }

        SortedMultiSet<Person> personSet = new BSTMultiSet<>();
        personSet.add(new Person("Mayr", LocalDate.of(2000, 1, 1)));
        personSet.add(new Person("Huber", LocalDate.of(1980, 1, 1)));
        personSet.add(new Person("Mayr", LocalDate.of(1999, 1, 1)));

        IO.println("personSet -> %s".formatted(personSet));


        SortedMultiSet<Person> ageSortedPersonSet = new BSTMultiSet<>(new AgeComparator());
        ageSortedPersonSet.add(new Person("Mayr", LocalDate.of(2000, 1, 1)));
        ageSortedPersonSet.add(new Person("Huber", LocalDate.of(1980, 1, 1)));
        ageSortedPersonSet.add(new Person("Mayr", LocalDate.of(1999, 1, 1)));

        IO.println("ageSortedPersonSet -> %s".formatted(personSet));
    }
}
