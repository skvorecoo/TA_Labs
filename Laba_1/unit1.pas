unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Menus, ComCtrls, fpjson, jsonparser,jsonscanner,FileUtil;

type

  TCar=record
    x, y: integer;
    texture: TPortableNetworkGraphic;
    finished: boolean;
  end;

  TPos=record
    pos: integer;
    img: TPortableNetworkGraphic;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    PlayPauseBtn: TButton;
    MainMenu1: TMainMenu;
    FileMenu: TMenuItem;
    AboutAuthor: TMenuItem;
    SaveDialog1: TSaveDialog;
    SettingsMenu: TMenuItem;
    About: TMenuItem;
    FileOpen: TMenuItem;
    FileSave: TMenuItem;
    ExitApplication: TMenuItem;
    SetColors: TMenuItem;
    SetSpeed: TMenuItem;
    AboutApplication: TMenuItem;
    StartStopBtn: TButton;
    ExitGameBtn: TButton;
    DrawGameTimer: TTimer;
    Panel1: TPanel;
    CalculateTimer: TTimer;
    TrackBar1: TTrackBar;
    procedure CalculateTimerTimer(Sender: TObject);
    procedure DrawGameTimerTimer(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure ExitApplicationClick(Sender: TObject);
    procedure ExitGameBtnClick(Sender: TObject);
    procedure FileOpenClick(Sender: TObject);
    procedure FileSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PlayPauseBtnClick(Sender: TObject);
    procedure SetColorsClick(Sender: TObject);
    procedure SetSpeedClick(Sender: TObject);
    procedure StartStopBtnClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  buf: TBitMap;
  Colors: array [0..15] of TColor;
  Car: array [0..9] of TCar;
  Cars: array [0..4, 0..15] of TPortableNetworkGraphic;
  CarsPositions: array [0..9] of TPos;
  path: string;
  Reserved: array [0..15] of boolean;
  PlayPause, StartStop, ShowSpeed: boolean;
  pos, tmp: integer;

implementation

uses unit2, Unit3;

{$R *.lfm}

procedure PrepareGameFilesAndVariables;

var
  i, j: integer;

begin
  ShowSpeed:=True; // Показать скрыть скорость
  PlayPause:=True; //True - Play, False - Pause
  StartStop:=False; //True - Start, False - Stop
  path:=ExtractFileDir(Application.ExeName);

  randomize;

  buf:=TBitMap.Create; buf.Width:=Form1.Width; buf.Height:=Form1.Width; //создание буфера. Нужно чтобы ничего не мигало

  for i:=0 to 9 do //начальные координаты машин
  begin
    Car[i].y:=(i)*90+260;
    Car[i].x:=20;
  end;

  for i:=0 to 4 do //картинки с машинами рахных цветов
  begin
    for j:=0 to 15 do
    begin
      Cars[i][j]:=TPortableNetworkGraphic.Create;
      Cars[i][j].LoadFromFile(path + '\cars\car' + IntToStr(i) + IntToStr(j+1) + '.png');
    end;
  end;

  for i:=0 to 9 do //картинки с номерами мест
  begin
    CarsPositions[i].img:=TPortableNetworkGraphic.Create;
  end;

  for i:=1 to 10 do
  begin
    Reserved[i]:=true;
  end;

  for i:=0 to 9 do //начальные координаты машин
  begin
    Car[i].y:=(i)*90+260;
    Car[i].x:=20;
  end;

  for i:=0 to 4 do //картинки с машинами рахных цветов
  begin
    for j:=0 to 11 do
    begin
      Cars[i][j]:=TPortableNetworkGraphic.Create;
      Cars[i][j].LoadFromFile(path + '\cars\car' + IntToStr(i) + IntToStr(j+1) + '.png');
    end;
  end;

  for i:=0 to 9 do //картинки с номерами мест
  begin
    CarsPositions[i].img:=TPortableNetworkGraphic.Create;
  end;

  Colors[0]:=clAqua;
  Colors[1]:=clBlue;
  Colors[2]:=clFuchsia;
  Colors[3]:=clGreen;
  Colors[4]:=clLime;
  Colors[5]:=clPurple;
  Colors[6]:=clRed;
  Colors[7]:=clSilver;
  Colors[8]:=clWhite;
  Colors[9]:=clYellow;
  Colors[10]:=clSkyBlue;
  Colors[11]:=clMoneyGreen;
  Colors[12]:=clBlack;
  Colors[13]:=$000080;
  Colors[14]:=$008080;
  Colors[15]:=$808080;

  Car[0].texture:=Cars[0][1];
  Car[1].texture:=Cars[1][2];
  Car[2].texture:=Cars[2][3];
  Car[3].texture:=Cars[3][4];
  Car[4].texture:=Cars[4][5];
  Car[5].texture:=Cars[0][6];
  Car[6].texture:=Cars[1][7];
  Car[7].texture:=Cars[2][8];
  Car[8].texture:=Cars[3][9];
  Car[9].texture:=Cars[4][10];
end;

procedure DrawGame;

var
  i, j, strips: integer;

begin
  buf.Canvas.Brush.Color:=Colors[Form2.ComboBox21.ItemIndex];
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

  buf.Canvas.Brush.Color:=clRed; //Линиия старта
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

  for i:=0 to 9 do if CarsPositions[i].pos <> 0 then buf.Canvas.Draw(1700, Car[i].y, CarsPositions[i].img);

  Form1.Canvas.Draw(0, 0, buf);
end;

procedure RaceComplete;

begin
  Form1.CalculateTimer.Enabled:=False;
  ShowMessage('Игра завершена!');
end;

procedure ChooseAnotherCar(a, tmp: integer);

begin
  if pos = 11 then RaceComplete
  else
    if a >= 11 then a:=0
  else
  if not(Car[a].finished) and (Car[a].x > Form1.Width-200) then
  begin
    Car[a].finished:=true;
    CarsPositions[a].img.LoadFromFile(path + '\Positions\' + IntToStr(pos) + '.png');
    CarsPositions[a].pos:=pos;
    pos+=1;
  end
  else if not((Car[a].finished) and (Car[a].x > Form1.Width-200)) then
    Car[a].x+=60
  else if pos = 11 then RaceComplete
  else
    ChooseAnotherCar(a+1, tmp);
end;

procedure DriveCar;

var
  a, tmp: integer;

begin
  a:=random(10);
  tmp:=a;
  if not(Car[a].finished) and (Car[a].x > Form1.Width-200) then
  begin
    Car[a].finished:=true;
    CarsPositions[a].img.LoadFromFile(path + '\Positions\' + IntToStr(pos) + '.png');
    CarsPositions[a].pos:=pos;
    pos+=1;
  end
  else if not((Car[a].finished) and (Car[a].x > Form1.Width-200)) then
    Car[a].x+=60
  else if pos = 11 then RaceComplete
  else
    ChooseAnotherCar(a, tmp);
end;

procedure PlayPauseGame;

begin
  if PlayPause then
  begin
    Form1.PlayPauseBtn.Caption:='Продолжить';
    Form1.CalculateTimer.Enabled:=False;
    Form1.SetColors.Enabled:=True;
  end
  else
  begin
    Form1.PlayPauseBtn.Caption:='Пауза';
      if StartStop then Form1.CalculateTimer.Enabled:=True;
    Form1.SetColors.Enabled:=False;
  end;
  PlayPause:=not(PlayPause);
end;

procedure StartStopGame;

var
  i: integer;

begin
  if StartStop then
  begin
    Form1.StartStopBtn.Caption:='Старт';
    Form1.CalculateTimer.Enabled:=False;
    pos:=1;

    for i:=0 to 9 do //начальные координаты машин
    begin
      Car[i].x:=20;
    end;

    for i:=0 to 9 do
    begin
      CarsPositions[i].pos:=0;
      Car[i].finished:=false;
    end;


    Form1.SetColors.Enabled:=False;
    Form1.PlayPauseBtn.Caption:='Пауза';
    PlayPause:=True;
    Form1.SetColors.Enabled:=True;
  end
  else
  begin
    Form1.StartStopBtn.Caption:='Стоп';
    Form1.CalculateTimer.Enabled:=True;
    pos:=1;
    Form1.PlayPauseBtn.Caption:='Пауза';
    Form1.SetColors.Enabled:=True;
    PlayPause:=True;
    Form1.SetColors.Enabled:=False;
    Form2.Close;
    Form3.Close;
  end;
  StartStop:=not(StartStop);
end;

procedure UpdateTextures;

begin
  Car[0].texture:=Cars[Form2.ComboBox11.ItemIndex][Form2.ComboBox1.ItemIndex];
  Car[1].texture:=Cars[Form2.ComboBox12.ItemIndex][Form2.ComboBox2.ItemIndex];
  Car[2].texture:=Cars[Form2.ComboBox13.ItemIndex][Form2.ComboBox3.ItemIndex];
  Car[3].texture:=Cars[Form2.ComboBox14.ItemIndex][Form2.ComboBox4.ItemIndex];
  Car[4].texture:=Cars[Form2.ComboBox15.ItemIndex][Form2.ComboBox5.ItemIndex];
  Car[5].texture:=Cars[Form2.ComboBox16.ItemIndex][Form2.ComboBox6.ItemIndex];
  Car[6].texture:=Cars[Form2.ComboBox17.ItemIndex][Form2.ComboBox7.ItemIndex];
  Car[7].texture:=Cars[Form2.ComboBox18.ItemIndex][Form2.ComboBox8.ItemIndex];
  Car[8].texture:=Cars[Form2.ComboBox19.ItemIndex][Form2.ComboBox9.ItemIndex];
  Car[9].texture:=Cars[Form2.ComboBox20.ItemIndex][Form2.ComboBox10.ItemIndex];
end;

procedure ShowSettings;

begin
  Form2.Show;
end;

procedure ExitApp;

begin
  Form1.Close;
end;

procedure EditSpeed(var Key: char);

begin
  if (not (key in ['1'..'9', #8])) then
  begin
    key:=#0;
    Form3.Show;
    Form3.Label1.Caption:='В поле можно вводить только цифры.';
  end;
end;

procedure ShowHideSpeed;

begin
  if ShowSpeed then
  begin
    Form1.TrackBar1.Visible:=True;
    Form1.Edit1.Visible:=True;
    Form1.Label1.Visible:=True;
  end
  else
  begin
    Form1.TrackBar1.Visible:=False;
    Form1.Edit1.Visible:=False;
    Form1.Label1.Visible:=False;
  end;
  ShowSpeed:=not(ShowSpeed);
end;

procedure OpenSavedGame;

var
  JData: TJSONData;

begin
  if Form1.OpenDialog1.Execute then
  begin
    JData:=GetJSON(ReadFileToString(Form1.OpenDialog1.FileName));
    Form2.ComboBox1.ItemIndex:=JData.FindPath('Cars.Car0.Color').AsInteger; // Цвет машины
    Form2.ComboBox2.ItemIndex:=JData.FindPath('Cars.Car1.Color').AsInteger;
    Form2.ComboBox3.ItemIndex:=JData.FindPath('Cars.Car2.Color').AsInteger;
    Form2.ComboBox4.ItemIndex:=JData.FindPath('Cars.Car3.Color').AsInteger;
    Form2.ComboBox5.ItemIndex:=JData.FindPath('Cars.Car4.Color').AsInteger;
    Form2.ComboBox6.ItemIndex:=JData.FindPath('Cars.Car5.Color').AsInteger;
    Form2.ComboBox7.ItemIndex:=JData.FindPath('Cars.Car6.Color').AsInteger;
    Form2.ComboBox8.ItemIndex:=JData.FindPath('Cars.Car7.Color').AsInteger;
    Form2.ComboBox9.ItemIndex:=JData.FindPath('Cars.Car8.Color').AsInteger;
    Form2.ComboBox10.ItemIndex:=JData.FindPath('Cars.Car9.Color').AsInteger;

    Form2.ComboBox11.ItemIndex:=JData.FindPath('Cars.Car0.Type').AsInteger; // Тип кузова
    Form2.ComboBox12.ItemIndex:=JData.FindPath('Cars.Car1.Type').AsInteger;
    Form2.ComboBox13.ItemIndex:=JData.FindPath('Cars.Car2.Type').AsInteger;
    Form2.ComboBox14.ItemIndex:=JData.FindPath('Cars.Car3.Type').AsInteger;
    Form2.ComboBox15.ItemIndex:=JData.FindPath('Cars.Car4.Type').AsInteger;
    Form2.ComboBox16.ItemIndex:=JData.FindPath('Cars.Car5.Type').AsInteger;
    Form2.ComboBox17.ItemIndex:=JData.FindPath('Cars.Car6.Type').AsInteger;
    Form2.ComboBox18.ItemIndex:=JData.FindPath('Cars.Car7.Type').AsInteger;
    Form2.ComboBox19.ItemIndex:=JData.FindPath('Cars.Car8.Type').AsInteger;
    Form2.ComboBox20.ItemIndex:=JData.FindPath('Cars.Car9.Type').AsInteger;

    UpdateTextures; // Применить новые текстуры к машинам

    Car[0].x:=JData.FindPath('Cars.Car0.X').AsInteger; // Координаты машин по X
    Car[1].x:=JData.FindPath('Cars.Car1.X').AsInteger;
    Car[2].x:=JData.FindPath('Cars.Car2.X').AsInteger;
    Car[3].x:=JData.FindPath('Cars.Car3.X').AsInteger;
    Car[4].x:=JData.FindPath('Cars.Car4.X').AsInteger;
    Car[5].x:=JData.FindPath('Cars.Car5.X').AsInteger;
    Car[6].x:=JData.FindPath('Cars.Car6.X').AsInteger;
    Car[7].x:=JData.FindPath('Cars.Car7.X').AsInteger;
    Car[8].x:=JData.FindPath('Cars.Car8.X').AsInteger;
    Car[9].x:=JData.FindPath('Cars.Car9.X').AsInteger;

    Car[0].finished:=JData.FindPath('Cars.Car0.Finished').AsBoolean; // Статуст машины
    Car[1].finished:=JData.FindPath('Cars.Car1.Finished').AsBoolean;
    Car[2].finished:=JData.FindPath('Cars.Car2.Finished').AsBoolean;
    Car[3].finished:=JData.FindPath('Cars.Car3.Finished').AsBoolean;
    Car[4].finished:=JData.FindPath('Cars.Car4.Finished').AsBoolean;
    Car[5].finished:=JData.FindPath('Cars.Car5.Finished').AsBoolean;
    Car[6].finished:=JData.FindPath('Cars.Car6.Finished').AsBoolean;
    Car[7].finished:=JData.FindPath('Cars.Car7.Finished').AsBoolean;
    Car[8].finished:=JData.FindPath('Cars.Car8.Finished').AsBoolean;
    Car[9].finished:=JData.FindPath('Cars.Car9.Finished').AsBoolean;

    Form2.ComboBox21.ItemIndex:=JData.FindPath('Grass.Color').AsInteger; // Цвет травы

    Form1.PlayPauseBtn.Caption:=JData.FindPath('GameState.PlayPauseCaption').AsString; // Состояние игры
    PlayPause:=JData.FindPath('GameState.PlayPauseState').AsBoolean;
    Form1.StartStopBtn.Caption:=JData.FindPath('GameState.StartStopCaption').AsString;
    StartStop:=JData.FindPath('GameState.StartStopState').AsBoolean;
    pos:=JData.FindPath('GameState.NumbersOfArrivedCars').AsInteger;
    CarsPositions[0].pos:=JData.FindPath('GameState.CarsPositions0').AsInteger;
    CarsPositions[1].pos:=JData.FindPath('GameState.CarsPositions1').AsInteger;
    CarsPositions[2].pos:=JData.FindPath('GameState.CarsPositions2').AsInteger;
    CarsPositions[3].pos:=JData.FindPath('GameState.CarsPositions3').AsInteger;
    CarsPositions[4].pos:=JData.FindPath('GameState.CarsPositions4').AsInteger;
    CarsPositions[5].pos:=JData.FindPath('GameState.CarsPositions5').AsInteger;
    CarsPositions[6].pos:=JData.FindPath('GameState.CarsPositions6').AsInteger;
    CarsPositions[7].pos:=JData.FindPath('GameState.CarsPositions7').AsInteger;
    CarsPositions[8].pos:=JData.FindPath('GameState.CarsPositions8').AsInteger;
    CarsPositions[9].pos:=JData.FindPath('GameState.CarsPositions9').AsInteger;
    Form1.DrawGameTimer.Enabled:=JData.FindPath('GameState.DrawTimerEnabled').AsBoolean;
    Form1.CalculateTimer.Enabled:=JData.FindPath('GameState.CalculateTimerEnabled').AsBoolean;

    if pos > 1 then
      for i:=0 to 9 do
        if CarsPositions[i].pos > 0 then CarsPositions[i].img.LoadFromFile(path + '\Positions\' + IntToStr(CarsPositions[i].pos) + '.png');
  end;
end;

procedure SaveGame;

var
  JSaveGame, JCars, JCar, JGrass, JGameState: TJSONObject;
  strList: TStringList;

begin
  strList:=TStringList.Create;
  JSaveGame:=TJSONObject.Create;
  JCars:=TJSONObject.create;

  JCar:=TJSONObject.Create;
  JCar.Add('Color', Form2.ComboBox1.ItemIndex);
  JCar.Add('Type', Form2.ComboBox11.ItemIndex);
  JCar.Add('X', Car[0].x);
  Jcar.Add('Y', Car[0].y);
  JCar.Add('Finished', Car[0].finished);
  JCars.Add('Car0', JCar);

  JCar:=TJSONObject.Create;
  JCar.Add('Color', Form2.ComboBox2.ItemIndex);
  JCar.Add('Type', Form2.ComboBox12.ItemIndex);
  JCar.Add('X', Car[1].x);
  Jcar.Add('Y', Car[1].y);
  JCar.Add('Finished', Car[1].finished);
  JCars.Add('Car1', JCar);

  JCar:=TJSONObject.Create;
  JCar.Add('Color', Form2.ComboBox3.ItemIndex);
  JCar.Add('Type', Form2.ComboBox13.ItemIndex);
  JCar.Add('X', Car[2].x);
  Jcar.Add('Y', Car[2].y);
  JCar.Add('Finished', Car[2].finished);
  JCars.Add('Car2', JCar);

  JCar:=TJSONObject.Create;
  JCar.Add('Color', Form2.ComboBox4.ItemIndex);
  JCar.Add('Type', Form2.ComboBox14.ItemIndex);
  JCar.Add('X', Car[3].x);
  Jcar.Add('Y', Car[3].y);
  JCar.Add('Finished', Car[3].finished);
  JCars.Add('Car3', JCar);

  JCar:=TJSONObject.Create;
  JCar.Add('Color', Form2.ComboBox5.ItemIndex);
  JCar.Add('Type', Form2.ComboBox15.ItemIndex);
  JCar.Add('X', Car[4].x);
  Jcar.Add('Y', Car[4].y);
  JCar.Add('Finished', Car[4].finished);
  JCars.Add('Car4', JCar);
  JSaveGame.Add('Cars', JCars);

  JCar:=TJSONObject.Create;
  JCar.Add('Color', Form2.ComboBox6.ItemIndex);
  JCar.Add('Type', Form2.ComboBox16.ItemIndex);
  JCar.Add('X', Car[5].x);
  Jcar.Add('Y', Car[5].y);
  JCar.Add('Finished', Car[5].finished);
  JCars.Add('Car5', JCar);

  JCar:=TJSONObject.Create;
  JCar.Add('Color', Form2.ComboBox7.ItemIndex);
  JCar.Add('Type', Form2.ComboBox17.ItemIndex);
  JCar.Add('X', Car[6].x);
  Jcar.Add('Y', Car[6].y);
  JCar.Add('Finished', Car[6].finished);
  JCars.Add('Car6', JCar);

  JCar:=TJSONObject.Create;
  JCar.Add('Color', Form2.ComboBox8.ItemIndex);
  JCar.Add('Type', Form2.ComboBox18.ItemIndex);
  JCar.Add('X', Car[7].x);
  Jcar.Add('Y', Car[7].y);
  JCar.Add('Finished', Car[7].finished);
  JCars.Add('Car7', JCar);

  JCar:=TJSONObject.Create;
  JCar.Add('Color', Form2.ComboBox9.ItemIndex);
  JCar.Add('Type', Form2.ComboBox19.ItemIndex);
  JCar.Add('X', Car[8].x);
  Jcar.Add('Y', Car[8].y);
  JCar.Add('Finished', Car[8].finished);
  JCars.Add('Car8', JCar);

  JCar:=TJSONObject.Create;
  JCar.Add('Color', Form2.ComboBox10.ItemIndex);
  JCar.Add('Type', Form2.ComboBox20.ItemIndex);
  JCar.Add('X', Car[9].x);
  Jcar.Add('Y', Car[9].y);
  JCar.Add('Finished', Car[9].finished);
  JCars.Add('Car9', JCar);

  JGrass:=TJSONObject.Create;
  JGrass.Add('Color', Form2.ComboBox21.ItemIndex);
  JSaveGame.Add('Grass', JGrass);

  JGameState:=TJSONObject.Create;
  JGameState.Add('PlayPauseCaption', Form1.PlayPauseBtn.Caption);
  JGameState.Add('PlayPauseState', PlayPause);
  JGameState.Add('StartStopCaption', Form1.StartStopBtn.Caption);
  JGameState.Add('StartStopState', StartStop);
  JGameState.Add('NumbersOfArrivedCars', pos);
  JGameState.Add('CarsPositions0', CarsPositions[0].pos);
  JGameState.Add('CarsPositions1', CarsPositions[1].pos);
  JGameState.Add('CarsPositions2', CarsPositions[2].pos);
  JGameState.Add('CarsPositions3', CarsPositions[3].pos);
  JGameState.Add('CarsPositions4', CarsPositions[4].pos);
  JGameState.Add('CarsPositions5', CarsPositions[5].pos);
  JGameState.Add('CarsPositions6', CarsPositions[6].pos);
  JGameState.Add('CarsPositions7', CarsPositions[7].pos);
  JGameState.Add('CarsPositions8', CarsPositions[8].pos);
  JGameState.Add('CarsPositions9', CarsPositions[9].pos);
  JGameState.Add('Speed', Form1.TrackBar1.Position);
  JGameState.Add('DrawTimerEnabled', Form1.DrawGameTimer.Enabled);
  JGameState.Add('CalculateTimerEnabled', Form1.CalculateTimer.Enabled);
  JSaveGame.Add('GameState', JGameState);

  strList.Text:=JSaveGame.FormatJSON();
  if Form1.SaveDialog1.Execute then
  strList.SaveToFile(Form1.SaveDialog1.FileName);
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  PrepareGameFilesAndVariables;
end;

procedure TForm1.PlayPauseBtnClick(Sender: TObject);
begin
  PlayPauseGame;
end;

procedure TForm1.SetColorsClick(Sender: TObject);
begin
  ShowSettings;
end;

procedure TForm1.SetSpeedClick(Sender: TObject);
begin
  ShowHideSpeed;
end;

procedure TForm1.StartStopBtnClick(Sender: TObject);
begin
  StartStopGame;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Form1.Edit1.Text:=IntToStr(Form1.TrackBar1.Position);
  if Form1.TrackBar1.Position=0 then Form1.CalculateTimer.Interval:=0 else
  Form1.CalculateTimer.Interval:=100 - Form1.TrackBar1.Position;
end;

procedure TForm1.DrawGameTimerTimer(Sender: TObject);
begin
  DrawGame;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  if (Form1.Edit1.Text='') then
  begin
    Form1.Edit1.Text:='0';
  end;
  if StrToInt(Form1.Edit1.Text) > 99 then
  begin
    Form1.Edit1.Text:='99';
    Form3.Show;
    Form3.Label1.Caption:='Число должно быть от 0 до 99.';
  end;
  Form1.TrackBar1.Position:=StrToInt(Form1.Edit1.Text);
  Form1.CalculateTimer.Interval:=100 - Form1.TrackBar1.Position;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  EditSpeed(Key);
end;

procedure TForm1.CalculateTimerTimer(Sender: TObject);
begin
  DriveCar;
end;

procedure TForm1.ExitApplicationClick(Sender: TObject);
begin
  ExitApp;
end;

procedure TForm1.ExitGameBtnClick(Sender: TObject);
begin
  ExitApp;
end;

procedure TForm1.FileOpenClick(Sender: TObject);
begin
  OpenSavedGame;
end;

procedure TForm1.FileSaveClick(Sender: TObject);
begin
  SaveGame;
end;

end.

