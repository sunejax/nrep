import ddf.minim.*;
import ddf.minim.ugens.*;

Minim       minim;
AudioOutput out;
Oscil       swave;

//The Wave Class
class Wave {
  //Location
  PVector loc;
  //In case you are not familiar with PVectors, you can
  //think of it as a point; it holds an x and a y position

  //The distance from the wave origin
  int farOut;
  int radius;
  int maxx=800;
  int maxy=800;
  //Color
  color strokeColor;

  Wave(int r) {
    //Initialize the Location PVector
    loc = new PVector();
    //Set location to the Mouse Position
    loc.x = random(0, maxx);
    loc.y = random(0, maxy);
    //Set the distance out to 1
    farOut = 1;
    this.radius = r;
    //Randomize the Stroke Color
    strokeColor = color(random(255), random(255), random(255));
  }

  void update() {
    //Increase the distance out
    farOut += 1;
  }

  void display() {
    //Set the Stroke Color
    stroke(255);
    fill(255);
    //Draw the ellipse
    ellipse(loc.x, loc.y, farOut, farOut);
  }

  boolean dead() {
    //Check to see if this is all the way out
    if (farOut > radius) {
      //If so, return true
      return true;
    }
    //If not, return false
    return false;
  }
}
//Create the ArrayList of Waves
ArrayList<Wave> waves = new ArrayList<Wave>();
Table table;
void setup() {
  //frameRate(40);
  size(800, 800);//window size
  table = loadTable("data.csv", "header");
  println(table.getRowCount() + " total rows in table"); 
  //Set all ellipses to draw from the Center
  //for (TableRow row : table.rows()) {
  //  int e = row.getInt("energy");
  //  Wave w = new Wave(e/10);
  //  //and Add it to the ArrayList
  //  waves.add(w);
  //}
  minim = new Minim(this);

  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();

  // create a sine wave Oscil, set to 440 Hz, at 0.5 amplitude
  swave = new Oscil( 440, 0.5f, Waves.TRIANGLE);
  // patch the Oscil to the output
  swave.patch( out );
  ellipseMode(CENTER);
}
void draw() {
  //Clear the background with 21 opacity
  //background(0, 0, 0, 10);
  fill(0, 10);
  rect(-1, -1, 900, 900);
  boolean recording=true;
  //If the mouse is pressed
  //get the radius from somewhere
  //Create a new Wave

  //Run through all the waves
  for (int i = 0; i < waves.size(); i ++) {
    //Run the Wave methods
    waves.get(i).update();
    waves.get(i).display();
    //Check to see if the current wave has gone all the way out
    if (waves.get(i).dead()) {
      //If so, delete it
      waves.remove(i);
    }
    if (recording) {
      saveFrame("output800/f_####.png");
    }
    //println(frameRate);
  }

  delay(20);
  adder();
}
int p=0;
void adder() {
  TableRow row =table.getRow(p++);
  int e = row.getInt("energy");
  Wave w = new Wave(e/100);
  if(e>1000&&e<9000)
    swave.setFrequency(e/10);
  waves.add(w);
}
