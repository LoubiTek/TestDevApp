//LoubiTek
//2017

boolean restart = true;
boolean Collision = true;

void Initialize()
{
    //fullScreen();
    size(1280,720,P2D);
}

void Loading()
{
    MyFont = loadFont("Tenderness.vlw");
    
    background = loadImage("background.png");
    Player = loadImage("Player.png");
    Bonus = loadImage("Bonus.png");
    Malus = loadImage("Malus.png");
    Tile1 = loadImage("Tile1.png");
    Tile2 = loadImage("Tile2.png");
    
    //MyShader = loadShader("MyShader.shadron");
}

void LoadAudio()
{
  minim = new Minim(this);
  Reset = minim.loadFile("Reset.wav");
  BonusFX = minim.loadFile("BonusFX.wav");
  Music_01 = minim.loadFile("Music_01.mp3",256);
}

void settings()
{
  Initialize();
  Loading();
  LoadAudio();
}

void setup()
{
  //size(800,600,P2D);
  background(white);
  frameRate(60);
  smooth(4);
  tint(random);
}

void draw()
{
  Playlist();
  Walls();
  Player();
  CheckPlayer_Walls();
  Bonus();
  Malus();
  DrawText();
  println("Image = " + frameCount + " FPS = " + frameRate);
}

void Playlist()
{
  Music_01.play();
}

void DrawText()
{
  textSize(23);
  fill(green);
  textAlign(CENTER);
  text(DevName, DevName_x, DevName_y);
  
  DevName_x = DevName_x + SpeedDevName_x;
  
  if (DevName_x >= width)
  {
    DevName_x = DevNamePos_x;
  }
  
  textSize(48);
  fill(white);
  text(Title, width/2,50);
  
  textSize(24);
  fill(red + green);
  text(Good + BonusGain,70,30);
  text(Bad + MalusGain,70,50);
  
  if(BonusGain >= 1)
  {
    textSize(16);
    text(Win,GlobalPlayer[0] + 20,GlobalPlayer[1]);
  }
  
  else if(MalusGain <= -1)
  {
    textSize(16);
    text(Lose,GlobalPlayer[0] + 10,GlobalPlayer[1]);
            filter(INVERT);
  }
  
  else
  {
    filter(GRAY);
  }
  
  textSize(24);
  text(Explain, Explain_x, Explain_y);
  
  Explain_x = Explain_x + SpeedExplain_x;
  
  if (Explain_x >= width)
  {
    Explain_x = ExplainPos_x;
  }
  
}

void Walls()
{
  fill(random2);
  image(background,0,0);
  //shader(MyShader);
  rect(Wall_Left[0],Wall_Left[0],Wall_Left[1],Wall_Left[2]);
  rect(Wall_Bottom[0],Wall_Bottom[1],Wall_Bottom[2],Wall_Bottom[3]);
  rect(Wall_Right[0],Wall_Right[1],Wall_Right[2],Wall_Right[3]);
  rect(Wall_Top[0],Wall_Top[0],Wall_Top[1],Wall_Top[2]);
           image(Tile1,Wall_Left[0],Wall_Left[0]);
           image(Tile1,Wall_Right[0],Wall_Right[1]);
           image(Tile2,Wall_Bottom[0],Wall_Bottom[1]);
           image(Tile2,Wall_Top[0],Wall_Top[0]);
}

void Player()
{
  strokeWeight(2);
  strokeJoin(BEVEL);
  
  rect(GlobalPlayer[0],GlobalPlayer[1],GlobalPlayer[2],GlobalPlayer[2]);
           image(Player,GlobalPlayer[0],GlobalPlayer[1]);
           tint(random);
}

void Bonus()
{
  rect(Bonus_x,Bonus_y,Bonus_w,Bonus_h);
           image(Bonus,Bonus_x,Bonus_y);
  
  Bonus_y = Bonus_y + SpeedBonus;
  
    // Left Bonus Collision
  if (GlobalPlayer[0] + GlobalPlayer[2] >= Bonus_x &&
      GlobalPlayer[0] <= Bonus_x + Bonus_w &&
      GlobalPlayer[1] + GlobalPlayer[2] >= Bonus_y &&
      GlobalPlayer[1] <= Bonus_y + Bonus_h)
      {
        BonusGain++; 
        Bonus_x = 1280/2;
        Bonus_y = 0;
        Bonus_w &= Bonus_w;
        Bonus_h &= Bonus_h;
      }
  // Bottom Bonus Collision
  if (GlobalPlayer[0] + GlobalPlayer[2] >= Bonus_x &&
      GlobalPlayer[0] <= Bonus_x + Bonus_w &&
      GlobalPlayer[1] + GlobalPlayer[2] >= Bonus_y &&
      GlobalPlayer[1] <= Bonus_y + Bonus_h)
      {
        Bonus_x = 1280/2;
        Bonus_y = 656;
        Bonus_w &= Bonus_w;
        Bonus_h &= Bonus_h;
      }
  // Right Bonus Collision
  if (GlobalPlayer[0] + GlobalPlayer[2] >= Bonus_x &&
      GlobalPlayer[0] <= Bonus_x + Bonus_w &&
      GlobalPlayer[1] + GlobalPlayer[2] >= Bonus_y &&
      GlobalPlayer[1] <= Bonus_y + Bonus_h)
      {
        Bonus_x = 1280/2;
        Bonus_y = 0;
        Bonus_w &= Bonus_w;
        Bonus_h &= Bonus_h;
      }
  // Top Bonus Collision
  if (GlobalPlayer[0] + GlobalPlayer[2] >= Bonus_x &&
      GlobalPlayer[0] <= Bonus_x + Bonus_w &&
      GlobalPlayer[1] + GlobalPlayer[2] >= Bonus_y &&
      GlobalPlayer[1] <= Bonus_y + Bonus_h)
      {
        Bonus_x = 1280/2;
        Bonus_y = 0;
        Bonus_w &= Bonus_w;
        Bonus_h &= Bonus_h;
      }
      BonusFX.play();
}

void Malus()
{ 
  rect(Malus_x,Malus_y,Malus_w,Malus_h);
           image(Malus,Malus_x,Malus_y);
  
  Malus_y = Malus_y + SpeedMalus;
  
    // Left Bonus Collision
  if (GlobalPlayer[0] + GlobalPlayer[2] >= Malus_x &&
      GlobalPlayer[0] <= Malus_x + Malus_w &&
      GlobalPlayer[1] + GlobalPlayer[2] >= Malus_y &&
      GlobalPlayer[1] <= Malus_y + Malus_h)
      {
        MalusGain--;
        Malus_x = 1280/2;
        Malus_y = 0;
        Malus_w &= Malus_w;
        Malus_h &= Malus_h;
      }
  // Bottom Bonus Collision
  if (GlobalPlayer[0] + GlobalPlayer[2] >= Malus_x &&
      GlobalPlayer[0] <= Malus_x + Malus_w &&
      GlobalPlayer[1] + GlobalPlayer[2] >= Malus_y &&
      GlobalPlayer[1] <= Malus_y + Malus_h)
      {
        Malus_x = 1280/2;
        Malus_y = 656;
        Malus_w &= Malus_w;
        Malus_h &= Malus_h;
      }
  // Right Bonus Collision
  if (GlobalPlayer[0] + GlobalPlayer[2] >= Malus_x &&
      GlobalPlayer[0] <= Malus_x + Malus_w &&
      GlobalPlayer[1] + GlobalPlayer[2] >= Malus_y &&
      GlobalPlayer[1] <= Malus_y + Malus_h)
      {
        Malus_x = 1280/2;
        Malus_y = 0;
        Malus_w &= Malus_w;
        Malus_h &= Malus_h;
      }
  // Top Bonus Collision
  if (GlobalPlayer[0] + GlobalPlayer[2] >= Malus_x &&
      GlobalPlayer[0] <= Malus_x + Malus_w &&
      GlobalPlayer[1] + GlobalPlayer[2] >= Malus_y &&
      GlobalPlayer[1] <= Malus_y + Malus_h)
      {
        Malus_x = 1280/2;
        Malus_y = 0;
        Malus_w &= Malus_w;
        Malus_h &= Malus_h;
      }
      
   /*else if(Collision == true)
   {
     MalusFX.play();
   }*/
}

void CheckPlayer_Walls()
{
  // Left Wall Collision
  if (GlobalPlayer[0] + GlobalPlayer[2] >= Wall_Left[0] &&
      GlobalPlayer[0] <= Wall_Left[0] + Wall_Left[1] &&
      GlobalPlayer[1] + GlobalPlayer[2] >= Wall_Left[0] &&
      GlobalPlayer[1] <= Wall_Left[0] + Wall_Left[2])
      {
        Wall_Left[0] = 0;
        Wall_Left[1] &= Wall_Left[1];
        Wall_Left[2] &= Wall_Left[2];
        GlobalPlayer[0] = GlobalPlayer[0] + 20;
        GlobalPlayer[1] = GlobalPlayer[1] + 1;
      }
  // Bottom Wall Collision
  if (GlobalPlayer[0] + GlobalPlayer[2] >= Wall_Bottom[0] &&
      GlobalPlayer[0] <= Wall_Bottom[0] + Wall_Bottom[2] &&
      GlobalPlayer[1] + GlobalPlayer[2] >= Wall_Bottom[1] &&
      GlobalPlayer[1] <= Wall_Bottom[1] + Wall_Bottom[3])
      {
        Wall_Bottom[0] = 0;
        Wall_Bottom[1] = 656;
        Wall_Bottom[2] &= Wall_Bottom[2];
        Wall_Bottom[3] &= Wall_Bottom[3];
        GlobalPlayer[0] = GlobalPlayer[0] + 1;
        GlobalPlayer[1] = GlobalPlayer[1] - 20;
      }
  // Right Wall Collision
  if (GlobalPlayer[0] + GlobalPlayer[2] >= Wall_Right[0] &&
      GlobalPlayer[0] <= Wall_Right[0] + Wall_Right[2] &&
      GlobalPlayer[1] + GlobalPlayer[2] >= Wall_Right[1] &&
      GlobalPlayer[1] <= Wall_Right[1] + Wall_Right[3])
      {
        Wall_Right[0] = 1216;
        Wall_Right[1] = 0;
        Wall_Right[2] &= Wall_Right[2];
        Wall_Right[3] &= Wall_Right[3];
        GlobalPlayer[0] = GlobalPlayer[0] - 20;
        GlobalPlayer[1] = GlobalPlayer[1] + 1;
      }
  // Top Wall Collision
  if (GlobalPlayer[0] + GlobalPlayer[2] >= Wall_Top[0] &&
      GlobalPlayer[0] <= Wall_Top[0] + Wall_Top[1] &&
      GlobalPlayer[1] + GlobalPlayer[2] >= Wall_Top[0] &&
      GlobalPlayer[1] <= Wall_Top[0] + Wall_Top[2])
      {
        Wall_Right[0] = 1216;
        Wall_Right[1] = 0;
        Wall_Top[1] &= Wall_Top[1];
        Wall_Top[2] &= Wall_Top[2];
        GlobalPlayer[0] = GlobalPlayer[0] - 1;
        GlobalPlayer[1] = GlobalPlayer[1] + 50;
      }
}
/*
void mousePressed()
{
  println("Pressed: " + mouseX + " " + mouseY);
}

void mouseClicked()
{
  println("Clicked: " + mouseX + " " + mouseY);
  fill(white);
  rect(mouseX,mouseY,10,10);
}

void mouseMoved()
{
  println("Moved: " + mouseX + " " + mouseY);
  fill(white);
  Player_x = mouseX;
  Player_y = mouseY;
}

void mouseDragged()
{
  println("Dragged: " + mouseX + " " + mouseY);
  fill(white);
  rect(mouseX,mouseY,10,10);
}

void mouseReleased()
{
 println("Released: " + mouseX + " " + mouseY);
}*/

void keyPressed()
{
  if(key == 122 || key == 90) // ASCII | 122 = z, 90 = Z
  {
    GlobalPlayer[1] = GlobalPlayer[1] - GlobalPlayer[3];
  }
  
  else if(key == 115 || key == 83) // ASCII | 115 = s, 83 = S
  {
    GlobalPlayer[1] = GlobalPlayer[1] + GlobalPlayer[3];
  }
  
  else if(key == 113|| key == 81) // ASCII | 113 = q, 81 = Q
  {
    GlobalPlayer[0] = GlobalPlayer[0] - GlobalPlayer[3];
  }
  
  else if(key == 100|| key == 68) // ASCII | 100 = d, 68 = D
  {
    GlobalPlayer[0] = GlobalPlayer[0] + GlobalPlayer[3];
  }
  
  else if(key == 114 || key == 82) // ASCII | 114 = r, 82 = R
  {
    restart =! restart;
    noLoop();
    if (restart == false) loop();
    GlobalPlayer[0] = GlobalPlayer[0];
    GlobalPlayer[1] = GlobalPlayer[1];
    Bonus_x = Bonus_Pos_x;
    Bonus_y = Bonus_Pos_y;
    Malus_x = Malus_Pos_x;
    Malus_y = Malus_Pos_y;
    
    //Audio
    if (Reset.isPlaying())
    {
      Reset.pause();
    }
    else if(Reset.position()==Reset.length())
    {
      Reset.rewind();
      Reset.play();
    }
    else
    {
      Reset.play();
    }
        BonusGain = 0;
        MalusGain = 0;
  }
    restart = true;
}

void keyReleased()
{
  
}
