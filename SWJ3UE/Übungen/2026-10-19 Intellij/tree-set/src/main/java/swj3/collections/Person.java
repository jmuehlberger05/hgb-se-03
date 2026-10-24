package swj3.collections;

import java.time.LocalDate;

public class Person implements Comparable<Person> {
    private final String name;
    private final LocalDate dob;

    public Person(String name, LocalDate dob) {
        this.name = name;
        this.dob = dob;
    }

    public String getName() {
        return name;
    }

    public LocalDate getDob() {
        return dob;
    }

    @Override
    public String toString() {
        return String.format("%s (%s)", name, dob);
    }

    @Override
    public int compareTo(Person other) {
        int cmp = this.name.compareTo(other.name);
        if (cmp != 0) return cmp;
        return dob.compareTo(other.dob);
    }
}
