unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Menus, EditBtn, ComCtrls, ActnList, ColorBox;

type

  { TForm1 }

  TCar=record
    x, y: integer;
    texture: TPortableNetworkGraphic;
    finished: boolean;
  end;

  TPos=record
    pos: integer;
    img: TPortableNetworkGraphic;
  end;

  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    ComboBox10: TComboBox;
    ComboBox11: TComboBox;
    ComboBox12: TComboBox;
    ComboBox13: TComboBox;
    ComboBox14: TComboBox;
    ComboBox15: TComboBox;
    ComboBox16: TComboBox;
    ComboBox17: TComboBox;
    ComboBox18: TComboBox;
    ComboBox19: TComboBox;
    ComboBox2: TComboBox;
    ComboBox20: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    ComboBox7: TComboBox;
    ComboBox8: TComboBox;
    ComboBox9: TComboBox;
    Edit1: TEdit;
    Image1: TImage;
    Image10: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DrawTimer: TTimer;
    CalculateTimer: TTimer;
    TrackBar1: TTrackBar;
    procedure CalculateTimerTimer(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image10MouseEnter(Sender: TObject);
    procedure Image10MouseLeave(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image1MouseEnter(Sender: TObject);
    procedure Image1MouseLeave(Sender: TObject);
    procedure DrawTimerTimer(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image7MouseEnter(Sender: TObject);
    procedure Image7MouseLeave(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  Path: string;
  Cars: array [0..4, 0..9] of TPortableNetworkGraphic;
  PlayGameButton: TImage;
  GrassColor: TColor;
  PauseGameButton: TPortableNetworkGraphic;
  buf: TBitMap;
  Car: array [0..9] of TCar;
  t, h, pos: integer;
  Pause: boolean;
  CarsPositions: array [0..9] of TPos;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);

var
  i, j: integer;

begin
  Pause:=True;
  pos:=1;
  PauseGameButton:=TPortableNetworkGraphic.Create;
  randomize;
  h:=1;
  t:=0;
  for i:=0 to 9 do
  begin
    Car[i].y:=(i)*90+260;
    Car[i].x:=20;
  end;
  buf:=TBitMap.Create; buf.Width:=Form1.Width; buf.Height:=Form1.Width; //создание буфера. Нужно чтобы ничего не мигало
  path:=ExtractFileDir(Application.ExeName);
  for i:=0 to 4 do
  begin
    for j:=0 to 9 do
    begin
      Cars[i][j]:=TPortableNetworkGraphic.Create;
      Cars[i][j].LoadFromFile(path + '\cars\car' + IntToStr(i) + IntToStr(j+1) + '.png');
    end;
  end;
  for i:=0 to 9 do
  begin
    CarsPositions[i].img:=TPortableNetworkGraphic.Create;
  end;
  PauseGameButton.LoadFromFile(path + '\Buttons\PauseGame.png');
end;

procedure TForm1.Image10MouseEnter(Sender: TObject);
begin
  Form1.Image10.Picture.LoadFromFile(path + '\Buttons\RestartPressed.png');
end;

procedure TForm1.Image10MouseLeave(Sender: TObject);
begin
  Form1.Image10.Picture.LoadFromFile(path + '\Buttons\Restart.png');
end;

procedure TForm1.CalculateTimerTimer(Sender: TObject);

var
  a: integer;

begin
  a:=random(10);
  if not(Car[a].finished) then Car[a].x+=20;
  if (Car[a].x > Form1.Width-200) and not(Car[a].finished) then
  begin
    Car[a].finished:=true;
    CarsPositions[a].img.LoadFromFile(path + '\Positions\' + IntToStr(pos) + '.png');
    CarsPositions[a].pos:=pos;
    pos+=1;
  end;
end;

procedure TForm1.Edit1EditingDone(Sender: TObject);
begin
  if Form1.Edit1.Text='' then Form1.Edit1.Text:='1';
  Form1.TrackBar1.Position:=StrToInt(Form1.Edit1.Text);
  Form1.CalculateTimer.Interval:=(Form1.TrackBar1.Position);
end;

procedure TForm1.Image1Click(Sender: TObject);

var
  i: integer;

begin
  Form1.Image7.Visible:=False;
  Form1.Image8.Visible:=True;
  Form1.Image1.Visible:=False;
  Form1.Image1.Enabled:=False;
  Form1.DrawTimer.Enabled:=True;
  Form1.Label1.Visible:=False; Form1.ComboBox1.Visible:=False; // ужас полный отсюда
  Form1.Label2.Visible:=False; Form1.ComboBox2.Visible:=False;
  Form1.Label3.Visible:=False; Form1.ComboBox3.Visible:=False;
  Form1.Label4.Visible:=False; Form1.ComboBox4.Visible:=False;
  Form1.Label5.Visible:=False; Form1.ComboBox5.Visible:=False;
  Form1.Label6.Visible:=False; Form1.ComboBox6.Visible:=False;
  Form1.Label7.Visible:=False; Form1.ComboBox7.Visible:=False;
  Form1.Label8.Visible:=False; Form1.ComboBox8.Visible:=False;
  Form1.Label9.Visible:=False; Form1.ComboBox9.Visible:=False;
  Form1.ComboBox10.Visible:=False;
  Form1.ComboBox11.Visible:=False;
  Form1.ComboBox12.Visible:=False;
  Form1.ComboBox13.Visible:=False;
  Form1.ComboBox14.Visible:=False;
  Form1.ComboBox15.Visible:=False;
  Form1.ComboBox16.Visible:=False;
  Form1.ComboBox17.Visible:=False;
  Form1.ComboBox18.Visible:=False;
  Form1.ComboBox19.Visible:=False;
  Form1.ComboBox20.Visible:=False;
  Form1.Image10.Visible:=True;
  Car[0].texture:=Cars[Form1.ComboBox11.ItemIndex][Form1.ComboBox1.ItemIndex];
  Car[1].texture:=Cars[Form1.ComboBox12.ItemIndex][Form1.ComboBox2.ItemIndex];
  Car[2].texture:=Cars[Form1.ComboBox13.ItemIndex][Form1.ComboBox3.ItemIndex];
  Car[3].texture:=Cars[Form1.ComboBox14.ItemIndex][Form1.ComboBox4.ItemIndex];
  Car[4].texture:=Cars[Form1.ComboBox15.ItemIndex][Form1.ComboBox5.ItemIndex];
  Car[5].texture:=Cars[Form1.ComboBox16.ItemIndex][Form1.ComboBox6.ItemIndex];
  Car[6].texture:=Cars[Form1.ComboBox17.ItemIndex][Form1.ComboBox7.ItemIndex];
  Car[7].texture:=Cars[Form1.ComboBox18.ItemIndex][Form1.ComboBox8.ItemIndex];
  Car[8].texture:=Cars[Form1.ComboBox19.ItemIndex][Form1.ComboBox9.ItemIndex];
  Car[9].texture:=Cars[Form1.ComboBox20.ItemIndex][Form1.ComboBox10.ItemIndex]; //ужас полный досюда
  GrassColor:=clGreen; //цвет травы
  Form1.CalculateTimer.Enabled:=True;
  //DrawScene(GrassColor); //вызов процедуры отрисовки всякой всячины типа дороги, травы и так далее
end;

procedure TForm1.Image1MouseEnter(Sender: TObject);
begin
  Form1.Image1.Picture.LoadFromFile(path + '\Buttons\PlayGamePress.png');
end;

procedure TForm1.Image1MouseLeave(Sender: TObject);
begin
  Form1.Image1.Picture.LoadFromFile(path + '\Buttons\PlayGame.png');
end;

procedure TForm1.DrawTimerTimer(Sender: TObject);

var
  i, j, strips, High, Different: integer;

begin
  buf.Canvas.Brush.Color:=GrassColor;
  strips:=((2*90+10)-(1*90+10)) div 2;
  buf.Canvas.Rectangle(0, 0, Form1.Width, Form1.Height); //травка
  buf.Canvas.Brush.Color:=$00555555;
  for i:=1 to 10 do
  begin
    buf.Canvas.Rectangle(0, ((i-1)*90)+260, buf.Width, (i*90)+240); //дороги
  end;
  buf.Canvas.Brush.Color:=clWhite;
  for i:=1 to 10 do
  begin
    j:=0;
    repeat
      buf.Canvas.Rectangle(j*40+4, (i*90-strips)+245, (j+1)*40, (i*90-strips)+255);
      j+=1;
    until buf.Width < (j+2)*20+20;
  end;
  buf.Canvas.Brush.Color:=clRed;
  buf.Canvas.Rectangle(172, 260, 177, Form1.Height-60);
  j:=1;
  repeat
    i:=1;
    repeat
        if (i+j) mod 2 = 0 then
        buf.Canvas.Brush.Color:=clWhite
        else
        buf.Canvas.Brush.Color:=clBlack;
        buf.Canvas.Rectangle((Form1.Width-195)+((i-1)*10), 260+((j-1)*10), (Form1.Width-195)+((i)*10), 260+((j)*10));
        i+=1;
    until Form1.Width-165 < Form1.Width-195+(i*5);
    j+=1;
  until Form1.Height-60 < 260+(j*10);
  for i:=0 to 9 do
  begin
    buf.Canvas.Draw(Car[i].x, Car[i].y, Car[i].texture);
  end;
  buf.Canvas.Draw(400, 56, PauseGameButton);
  buf.Canvas.Draw(168, 48, Form1.Image10.Picture.Graphic);
  for i:=0 to 9 do
  begin
    if CarsPositions[i].pos <> 0 then
    begin
      buf.Canvas.Draw(50, Car[i].y, CarsPositions[i].img);
    end;
  end;
  Form1.Canvas.Draw(0, 0, buf);
end;

procedure TForm1.Image7Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Image7MouseEnter(Sender: TObject);
begin
  Form1.Image7.Picture.LoadFromFile(path + '\Buttons\ExitGamePress.png');
end;

procedure TForm1.Image7MouseLeave(Sender: TObject);
begin
  Form1.Image7.Picture.LoadFromFile(path + '\Buttons\ExitGame.png');
end;

procedure TForm1.Image8Click(Sender: TObject);

begin
  if Pause then
  begin
    Form1.CalculateTimer.Enabled:=False;
    Pause:=False;
    PauseGameButton.LoadFromFile(path + '\Buttons\PauseGamePressed.png');
  end
  else
  begin
    Form1.CalculateTimer.Enabled:=True;
    Pause:=True;
    PauseGameButton.LoadFromFile(path + '\Buttons\PauseGame.png');
  end;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Form1.Edit1.Caption:=IntToStr(Form1.TrackBar1.Position);
  Form1.CalculateTimer.Interval:=(Form1.TrackBar1.Position);
end;

end.
