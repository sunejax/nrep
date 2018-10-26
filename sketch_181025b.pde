
    //The Wave Class
    class Wave {
      //Location
      PVector loc;
      //In case you are not familiar with PVectors, you can
      //think of it as a point; it holds an x and a y position
     
      //The distance from the wave origin
      int farOut;
     
      //Color
      color strokeColor;
     
      Wave() {
        //Initialize the Location PVector
        loc = new PVector();
       
        //Set location to the Mouse Position
        loc.x = mouseX;
        loc.y = mouseY;
       
        //Set the distance out to 1
        farOut = 1;
       
        //Randomize the Stroke Color
        strokeColor = color(random(255), random(255), random(255));
      }
     
      void update() {
        //Increase the distance out
        farOut += 1;
      }
     
      void display() {
        //Set the Stroke Color
        stroke(strokeColor);
       
        //Draw the ellipse
        ellipse(loc.x, loc.y, farOut, farOut);
      }
     
      boolean dead() {
        //Check to see if this is all the way out
        if(farOut > 100) {
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
      size(800, 800);//window size
      table = loadTable("", "header");
      println(table.getRowCount() + " total rows in table"); 
      for (TableRow row : table.rows()) {
        int id = row.getInt("id");
        String species = row.getString("species");
        String name = row.getString("name");
        println(name + " (" + species + ") has an ID of " + id);
  }
      //Set all ellipses to draw from the Center
      ellipseMode(CENTER);
    }
    void draw() {
      //Clear the background with 21 opacity
      background(255, 255, 255, 21);
     
      //If the mouse is pressed
      //get the radius from somewhere
        //Create a new Wave
      
        Wave w = new Wave();
        //and Add it to the ArrayList
        waves.add(w);
      //Run through all the waves
      for(int i = 0; i < waves.size(); i ++) {
        //Run the Wave methods
        waves.get(i).update();
        waves.get(i).display();
       
        //Check to see if the current wave has gone all the way out
        if(waves.get(i).dead()) {
          //If so, delete it
          waves.remove(i);
        }
      }
    }
