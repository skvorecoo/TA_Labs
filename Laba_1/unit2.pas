unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
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
    ComboBox21: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    ComboBox7: TComboBox;
    ComboBox8: TComboBox;
    ComboBox9: TComboBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox10Click(Sender: TObject);
    procedure ComboBox10Select(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure ComboBox21Click(Sender: TObject);
    procedure ComboBox21Select(Sender: TObject);
    procedure ComboBox2Click(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    procedure ComboBox3Click(Sender: TObject);
    procedure ComboBox3Select(Sender: TObject);
    procedure ComboBox4Click(Sender: TObject);
    procedure ComboBox4Select(Sender: TObject);
    procedure ComboBox5Click(Sender: TObject);
    procedure ComboBox5Select(Sender: TObject);
    procedure ComboBox6Click(Sender: TObject);
    procedure ComboBox6Select(Sender: TObject);
    procedure ComboBox7Click(Sender: TObject);
    procedure ComboBox7Select(Sender: TObject);
    procedure ComboBox8Click(Sender: TObject);
    procedure ComboBox8Select(Sender: TObject);
    procedure ComboBox9Click(Sender: TObject);
    procedure ComboBox9Select(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;
  OldValues: array [1..21] of integer;

implementation

uses unit1;

{$R *.lfm}

procedure ExitSettings;

begin
  Form2.Close;
end;

procedure RestoreSettings;

begin
  Form2.ComboBox1.ItemIndex:=OldValues[1]; Form2.ComboBox12.ItemIndex:=OldValues[12];
  Form2.ComboBox2.ItemIndex:=OldValues[2]; Form2.ComboBox13.ItemIndex:=OldValues[13];
  Form2.ComboBox3.ItemIndex:=OldValues[3]; Form2.ComboBox14.ItemIndex:=OldValues[14];
  Form2.ComboBox4.ItemIndex:=OldValues[4]; Form2.ComboBox15.ItemIndex:=OldValues[15];
  Form2.ComboBox5.ItemIndex:=OldValues[5]; Form2.ComboBox16.ItemIndex:=OldValues[16];
  Form2.ComboBox6.ItemIndex:=OldValues[6]; Form2.ComboBox17.ItemIndex:=OldValues[17];
  Form2.ComboBox7.ItemIndex:=OldValues[7]; Form2.ComboBox18.ItemIndex:=OldValues[18];
  Form2.ComboBox8.ItemIndex:=OldValues[8]; Form2.ComboBox19.ItemIndex:=OldValues[19];
  Form2.ComboBox9.ItemIndex:=OldValues[9]; Form2.ComboBox20.ItemIndex:=OldValues[20];
  Form2.ComboBox10.ItemIndex:=OldValues[10]; Form2.ComboBox21.ItemIndex:=OldValues[21];
  Form2.ComboBox11.ItemIndex:=OldValues[11];
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

procedure SavePrevSettings;

begin
  OldValues[1]:=Form2.ComboBox1.ItemIndex; OldValues[12]:=Form2.ComboBox12.ItemIndex;
  OldValues[2]:=Form2.ComboBox2.ItemIndex; OldValues[13]:=Form2.ComboBox13.ItemIndex;
  OldValues[3]:=Form2.ComboBox3.ItemIndex; OldValues[14]:=Form2.ComboBox14.ItemIndex;
  OldValues[4]:=Form2.ComboBox4.ItemIndex; OldValues[15]:=Form2.ComboBox15.ItemIndex;
  OldValues[5]:=Form2.ComboBox5.ItemIndex; OldValues[16]:=Form2.ComboBox16.ItemIndex;
  OldValues[6]:=Form2.ComboBox6.ItemIndex; OldValues[17]:=Form2.ComboBox17.ItemIndex;
  OldValues[7]:=Form2.ComboBox7.ItemIndex; OldValues[18]:=Form2.ComboBox18.ItemIndex;
  OldValues[8]:=Form2.ComboBox8.ItemIndex; OldValues[19]:=Form2.ComboBox19.ItemIndex;
  OldValues[9]:=Form2.ComboBox9.ItemIndex; OldValues[20]:=Form2.ComboBox20.ItemIndex;
  OldValues[10]:=Form2.ComboBox10.ItemIndex; OldValues[21]:=Form2.ComboBox21.ItemIndex;
  OldValues[11]:=Form2.ComboBox11.ItemIndex;
end;

{ TForm2 }

procedure TForm2.Button1Click(Sender: TObject);
begin
  ExitSettings;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  RestoreSettings;
end;

procedure TForm2.Button3Click(Sender: TObject);

var
  AlredyTaken: array [1..10] of boolean;
  i, j, b, a: integer;

begin
  for i:=0 to 11 do
  begin
    Reserved[i]:=false;
  end;
  for i:=1 to 10 do
  begin
    AlredyTaken[i]:=false;
  end;
  i:=1;
  repeat
    a:=random(11)+1;
    if not(Reserved[a]) then
    begin
      b:=random(10)+1;
      if not(AlredyTaken[b]) then
      begin
        case b of
        1: Form2.ComboBox1.ItemIndex:=a;
        2: Form2.ComboBox2.ItemIndex:=a;
        3: Form2.ComboBox3.ItemIndex:=a;
        4: Form2.ComboBox4.ItemIndex:=a;
        5: Form2.ComboBox5.ItemIndex:=a;
        6: Form2.ComboBox6.ItemIndex:=a;
        7: Form2.ComboBox7.ItemIndex:=a;
        8: Form2.ComboBox8.ItemIndex:=a;
        9: Form2.ComboBox9.ItemIndex:=a;
        10: Form2.ComboBox10.ItemIndex:=a;
        end;
        AlredyTaken[b]:=true;
        Reserved[a]:=true;
        i+=1;
      end;
    end;
  until i > 10;
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

procedure TForm2.ComboBox10Click(Sender: TObject);
begin
  tmp:=Form2.ComboBox10.ItemIndex;
end;

procedure TForm2.ComboBox10Select(Sender: TObject);
begin
  if not(Reserved[Form2.ComboBox10.ItemIndex]) then
  begin
    Reserved[Form2.ComboBox10.ItemIndex]:=true;
    Reserved[tmp]:=false;
    Car[9].texture:=Cars[Form2.ComboBox20.ItemIndex][Form2.ComboBox10.ItemIndex];
  end
  else
  begin
    Form2.ComboBox10.ItemIndex:=tmp;
    MessageDlg('Цвета травы и машин не могут быть одинаковыми!', mtError , [mbOK], 0);
  end;
end;

procedure TForm2.ComboBox1Click(Sender: TObject);
begin
  tmp:=Form2.ComboBox1.ItemIndex;
end;

procedure TForm2.ComboBox1Select(Sender: TObject);
begin
  if not(Reserved[Form2.ComboBox1.ItemIndex]) then
  begin
    Reserved[Form2.ComboBox1.ItemIndex]:=true;
    Reserved[tmp]:=false;
    Car[0].texture:=Cars[Form2.ComboBox11.ItemIndex][Form2.ComboBox1.ItemIndex];
  end
  else
  begin
    Form2.ComboBox1.ItemIndex:=tmp;
    MessageDlg('Цвета травы и машин не могут быть одинаковыми!', mtError , [mbOK], 0);
  end;
end;

procedure TForm2.ComboBox21Click(Sender: TObject);
begin
  tmp:=Form2.ComboBox21.ItemIndex;
end;

procedure TForm2.ComboBox21Select(Sender: TObject);
begin
  if not(Reserved[Form2.ComboBox21.ItemIndex]) then
  begin
    Reserved[Form2.ComboBox21.ItemIndex]:=true;
    Reserved[tmp]:=false;
  end
  else
  begin
    Form2.ComboBox21.ItemIndex:=tmp;
    MessageDlg('Один травы и цвет может быть выбран только для одного объекта!', mtError , [mbOK], 0);
  end;
end;

procedure TForm2.ComboBox2Click(Sender: TObject);
begin
  tmp:=Form2.ComboBox2.ItemIndex
end;

procedure TForm2.ComboBox2Select(Sender: TObject);
begin
  if not(Reserved[Form2.ComboBox2.ItemIndex]) then
  begin
    Reserved[Form2.ComboBox2.ItemIndex]:=true;
    Reserved[tmp]:=false;
    Car[1].texture:=Cars[Form2.ComboBox12.ItemIndex][Form2.ComboBox2.ItemIndex];
  end
  else
  begin
    Form2.ComboBox2.ItemIndex:=tmp;
    MessageDlg('Цвета травы и машин не могут быть одинаковыми!', mtError , [mbOK], 0);
  end;
end;

procedure TForm2.ComboBox3Click(Sender: TObject);
begin
  tmp:=Form2.ComboBox3.ItemIndex
end;

procedure TForm2.ComboBox3Select(Sender: TObject);
begin
  if not(Reserved[Form2.ComboBox3.ItemIndex]) then
  begin
    Reserved[Form2.ComboBox3.ItemIndex]:=true;
    Reserved[tmp]:=false;
    Car[2].texture:=Cars[Form2.ComboBox13.ItemIndex][Form2.ComboBox3.ItemIndex];
  end
  else
  begin
    Form2.ComboBox3.ItemIndex:=tmp;
    MessageDlg('Цвета травы и машин не могут быть одинаковыми!', mtError , [mbOK], 0);
  end;
end;

procedure TForm2.ComboBox4Click(Sender: TObject);
begin
  tmp:=Form2.ComboBox4.ItemIndex
end;

procedure TForm2.ComboBox4Select(Sender: TObject);
begin
  if not(Reserved[Form2.ComboBox4.ItemIndex]) then
  begin
    Reserved[Form2.ComboBox4.ItemIndex]:=true;
    Reserved[tmp]:=false;
    Car[3].texture:=Cars[Form2.ComboBox14.ItemIndex][Form2.ComboBox4.ItemIndex];
  end
  else
  begin
    Form2.ComboBox4.ItemIndex:=tmp;
    MessageDlg('Цвета травы и машин не могут быть одинаковыми!', mtError , [mbOK], 0);
  end;
end;

procedure TForm2.ComboBox5Click(Sender: TObject);
begin
  tmp:=Form2.ComboBox5.ItemIndex
end;

procedure TForm2.ComboBox5Select(Sender: TObject);
begin
  if not(Reserved[Form2.ComboBox5.ItemIndex]) then
  begin
    Reserved[Form2.ComboBox5.ItemIndex]:=true;
    Reserved[tmp]:=false;
    Car[4].texture:=Cars[Form2.ComboBox15.ItemIndex][Form2.ComboBox5.ItemIndex];
  end
  else
  begin
    Form2.ComboBox5.ItemIndex:=tmp;
    MessageDlg('Цвета травы и машин не могут быть одинаковыми!', mtError , [mbOK], 0);
  end;
end;

procedure TForm2.ComboBox6Click(Sender: TObject);
begin
  tmp:=Form2.ComboBox6.ItemIndex
end;

procedure TForm2.ComboBox6Select(Sender: TObject);
begin
  if not(Reserved[Form2.ComboBox6.ItemIndex]) then
  begin
    Reserved[Form2.ComboBox6.ItemIndex]:=true;
    Reserved[tmp]:=false;
    Car[5].texture:=Cars[Form2.ComboBox16.ItemIndex][Form2.ComboBox6.ItemIndex];
  end
  else
  begin
    Form2.ComboBox6.ItemIndex:=tmp;
    MessageDlg('Цвета травы и машин не могут быть одинаковыми!', mtError , [mbOK], 0);
  end;
end;

procedure TForm2.ComboBox7Click(Sender: TObject);
begin
  tmp:=Form2.ComboBox7.ItemIndex
end;

procedure TForm2.ComboBox7Select(Sender: TObject);
begin
  if not(Reserved[Form2.ComboBox7.ItemIndex]) then
  begin
    Reserved[Form2.ComboBox7.ItemIndex]:=true;
    Reserved[tmp]:=false;
    Car[6].texture:=Cars[Form2.ComboBox17.ItemIndex][Form2.ComboBox7.ItemIndex];
  end
  else
  begin
    Form2.ComboBox7.ItemIndex:=tmp;
    MessageDlg('Цвета травы и машин не могут быть одинаковыми!', mtError , [mbOK], 0);
  end;
end;

procedure TForm2.ComboBox8Click(Sender: TObject);
begin
  tmp:=Form2.ComboBox8.ItemIndex
end;

procedure TForm2.ComboBox8Select(Sender: TObject);
begin
  if not(Reserved[Form2.ComboBox8.ItemIndex]) then
  begin
    Reserved[Form2.ComboBox8.ItemIndex]:=true;
    Reserved[tmp]:=false;
    Car[7].texture:=Cars[Form2.ComboBox18.ItemIndex][Form2.ComboBox8.ItemIndex];
  end
  else
  begin
    Form2.ComboBox8.ItemIndex:=tmp;
    MessageDlg('Цвета травы и машин не могут быть одинаковыми!', mtError , [mbOK], 0);
  end;
end;

procedure TForm2.ComboBox9Click(Sender: TObject);
begin
  tmp:=Form2.ComboBox9.ItemIndex
end;

procedure TForm2.ComboBox9Select(Sender: TObject);
begin
  if not(Reserved[Form2.ComboBox9.ItemIndex]) then
  begin
    Reserved[Form2.ComboBox9.ItemIndex]:=true;
    Reserved[tmp]:=false;
    Car[8].texture:=Cars[Form2.ComboBox19.ItemIndex][Form2.ComboBox9.ItemIndex];
  end
  else
  begin
    MessageDlg('Цвета травы и машин не могут быть одинаковыми!', mtError , [mbOK], 0);
    Form2.ComboBox9.ItemIndex:=tmp;
  end;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  SavePrevSettings;
  randomize;
end;

end.

