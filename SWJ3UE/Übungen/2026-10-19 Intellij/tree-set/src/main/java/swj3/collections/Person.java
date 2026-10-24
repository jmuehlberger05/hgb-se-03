package swj3.collections;

import java.util.Objects;
import java.time.LocalDate;

public class Person {
  private final String    name;
  private final LocalDate dob;

  public Person(String name, LocalDate dob) {
    this.name = name;
    this.dob  = dob;
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
}
