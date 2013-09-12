import java.util.Iterator;

class Mover {
  PVector location;
  PVector velocity;
  float rotation;
  float rotationVelocity;
  float size;
  float strokeWeight;
  int lifetimeMax;
  int lifetime;
  
  public Mover() {
    //pick a random location
    location = new PVector(random(0, width), random(-100, height*0.7));
    println(location);
    rotation = noise(frameCount*0.003) * 0.1;
    rotationVelocity = random(-0.1, 0.1);
    size = random(5, 50);
    strokeWeight = random(0.01, 0.5);
    velocity = new PVector(0, random(1,1.5));
    lifetimeMax = (int)random(200, 1000);
    lifetime = 0;
  }
  void draw() {
    //update
    lifetime += 1;
    location.add(velocity);
    rotation += rotationVelocity;
    
    //draw
    float a = 255;
    /*
    if (lifetime < 100) {
      a = lifetime/100 * 255;
    } else if(lifetimeMax - lifetime < 200) {
      a = (lifetimeMax - lifetime)/200 * 255;
      println("dying");
    }
    */
    pushMatrix();
    if (size > 30) {
      translate(location.x + currentOffset, location.y);
    } else if (size > 15) {
      translate(location.x + currentOffset*0.5, location.y);
    } else {
      translate(location.x + currentOffset*0.1, location.y);
    }
    
    rotate(rotation);
    stroke(255, a);
    noFill();
    strokeWeight(strokeWeight);
    rect(-size/2, -size/2, size, size);
    popMatrix();
  }
}

/*
class Tweener { //this was for tweening but no time : (
  float fromValue;
  float toValue;
  float step;
  boolean running;
  boolean complete;
  public Tweener() {
    type = 0;
    step = 0.05;
  }
  void step() {
    boolean ascending;
    if (fromValue < toValue) {
      ascending = true;
      fromValue += step;
    } else  {
      ascending = false;
      fromValue -= step;
    }
    if ((ascending && fromValue >= toValue) || (!ascending && fromValue <= toValue)) {
      complete = true;
      running = false;
    }
    
    
  }
}
*/

ArrayList<Mover> movers = new ArrayList<Mover>();
float maxOffset, currentOffset;
color backgroundColor;

void doSomething() {
  backgroundColor = color(random(0,255), random(0,255), random(0,255));
}

void changeSomething(float arg1, float arg2) {
  println("changed " +  arg1);
  currentOffset = (arg1-0.5) * maxOffset;
}

void keyPressed() {
  doSomething();  
}

void mouseMoved() {
  println("x " + mouseX + " width " + width); 
  changeSomething((float)mouseX/(float)width, (float)mouseY/(float)height);
}

void setup() {
  size(700, 394);
  maxOffset = 100;
 
}

void draw() {
  background(backgroundColor);

  if(random(0,1) > 0.9) {
    movers.add(new Mover());
  }
  Iterator<Mover> it = movers.iterator();
  while(it.hasNext()) {
    Mover m = it.next();
    if (m.lifetime > m.lifetimeMax) {
      it.remove();
    } else {
      m.draw();
    }
  }

  
}


