javacoffee
==========

Coffeescript-like syntax for writing Java code.

```bash
npm install javacoffee -g
```

**Please don't install yet. This is still in development!!!**

## Examples

### Fibonacci

```jc
class Fibonacci
  # Print out the Fibonacci sequence for values < 50
  main
    lo = hi = 1
    println lo
    while hi < 50
      print hi
      hi = lo + hi
      lo = hi - lo
```

converts to

```java
class Fibonacci {
  // Print out the Fibonacci sequence for values < 50
  public static void main(String[] args) {
    int lo = 1;
    int hi = 1;
    System.out.println(lo);
    while (hi < 50) {
      System.out.print(hi);
      hi = lo + hi;
      lo = hi - lo;
    }
  }
}
```

### Point

```jc
class Point
  +double x, y
  +&origin = Point 0 0
  Point @x @y
  +clear @x = @y = 0
  +distance(Point that):double
    xDiff = x - that.x
    yDiff = y - that.y
    Math.sqrt xDiff^2 + yDiff^2
```

converts to 

```java
class Point {
  public double x, y; 
  public static Point origin = new Point(0,0); 
  Point(double x_value, double y_value) {
    x = x_value; 
    y = y_value; 
  }
  public void clear() {
    this.x = 0; 
    this.y = 0; 
  }
  public double distance(Point that) {
    double xDiff = x - that.x; 
    double yDiff = y - that.y; 
    return Math.sqrt(xDiff * xDiff + yDiff * yDiff);
  }
}
```

## How to compile

`javacoffee file.jc` -> `file.class`

Filetype: _.jc_
