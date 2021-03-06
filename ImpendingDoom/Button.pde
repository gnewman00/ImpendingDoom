import processing.core.PApplet;

public class Button {
  boolean toggled;
  String buttonText;
  final float X;
  final float Y;
  final float BUTTONWIDTH;
  final float BUTTONHEIGHT;

  Button(float xcor, float ycor, float width, float height, String text) {
    X = xcor;
    Y = ycor;
    BUTTONWIDTH = width;
    BUTTONHEIGHT = height;
    buttonText = text;
  }

  boolean inRect() {
    return
      mouseX > X - (BUTTONWIDTH / 2) &&
      mouseX < X + (BUTTONWIDTH / 2) &&
      mouseY > Y - (BUTTONHEIGHT / 2) &&
      mouseY < Y + (BUTTONHEIGHT / 2);
  }

  boolean clicked() {
    if ( mousePressed && inRect() ) {
      return toggled ^= true;
    }

    return false;
  }

  void draw() {
    textFont(fonts.get("variable"));
    rectMode(CENTER);
    if ( inRect() ) {
      fill(colors.get("background"));
      rect(X, Y, BUTTONWIDTH, BUTTONHEIGHT);
      fill(colors.get("gray"));
    } else {
      fill(colors.get("gray"));
      rect(X, Y, BUTTONWIDTH, BUTTONHEIGHT);
      fill(colors.get("background"));
    }
    text(buttonText, X, Y);
  }
}

/* Yes, this violates the "one class per file" policy too.
 */

abstract class StatefulButton extends Button {
  int maxState;
  int minState;
  int currentState;

  StatefulButton(float xcor, float ycor, float width, float height, String text) {
    super(xcor, ycor, width, height, text);
  }

  int cycle() {
    if ( ++currentState > maxState ) {
      currentState = minState;
    }
    return currentState;
  }
}

class DifficultyButton extends StatefulButton {
  DifficultyButton(float xcor, float ycor, float width, float height, String text) {
    super(xcor, ycor, width, height, text);
    maxState = 3;
    minState = 1;
    currentState = 2;
  }

  boolean clicked() {
    if ( mousePressed && inRect() ) {
      switch ( cycle() ) {
        case 1: buttonText = "Easy";   break;
        case 2: buttonText = "Normal"; break;
        case 3: buttonText = "Hard";   break;
      }
      return true;
    }
    return false;
  }
}

class TowerButton extends StatefulButton {
  Tower current = towerList.get(0);

  TowerButton(float xcor, float ycor, float width, float height, String text) {
    super(xcor, ycor, width, height, text);
    maxState = towerList.size() - 1;
  }

  boolean clicked() {
    if ( mousePressed && inRect() ) {
      current = towerList.get(cycle());
      return true;
    }
    return false;
  }

  @Override void draw() {
    super.draw();
    image(current.img, X - current.img.width / 2, Y - current.img.height / 2);
    text(current.getCost(), X, Y);
  }
}

