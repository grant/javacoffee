javacoffee
==========

Coffeescript-like syntax for writing Java code. :coffee:

**Does not work yet!!!**

```bash
npm install javacoffee -g
javacoffee Fibonacci.jc
# Generates Fibonacci.java and Fibonacci.class
java Fibonacci
```

## TODO list

- Make very simple translations work.
- Enforce strict syntax style.
- Work on tokenizer
- Translate comments
- Translate class
- Translate methods
- Write Wiki

## Examples

### Fibonacci

```jc
Fibonacci
  # Print out the Fibonacci sequence for values < 50
  main
    lo = hi = 1
    println lo
    while hi < 50
      println hi
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
      System.out.println(hi);
      hi = lo + hi;
      lo = hi - lo;
    }
  }
}
```

### Point

```jc
Point
  +double x, y
  +&origin = Point 0 0
  Point @x @y
  +clear @x = @y = 0
  +distance(Point that):double
    xDiff = x - that.x
    yDiff = y - that.y
    Math.sqrt xDiff * xDiff + yDiff * yDiff
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

## How to develop

### Install and keep `coffee-gulp` running

```bash
npm install
coffee-gulp
```

### Test with the following:

```bash
node ./bin/javacoffee myFile.jc
```

### Run tests

```bash
npm test
```

Specific tests

```bash
mocha -g 'examples' --compilers coffee:coffee-script/register
```

Filetype: _.jc_
