unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private

  public

  end;

var
  Form4: TForm4;
  tmp: integer;

implementation

uses Unit1, Unit3;

{$R *.lfm}

procedure EditSpeed(var Key: char);
begin
  if (not (key in ['0'..'9', #8])) then
  begin
    key:=#0;
    Form3.Show;
    Form3.Label1.Caption:='В поле можно вводить только цифры.';
  end;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  Form4.Close;
  Form1.TrackBar1.Position:=Form4.TrackBar1.Position;
  Form1.Edit1.Text:=Form4.Edit1.Text;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Form1.CalculateTimer.Interval:=tmp;
  Form4.Edit1.Caption:=IntToStr(100 - tmp);
  Form4.TrackBar1.Position:=100 - tmp;
  Form4.Close;
end;

{ TForm4 }

procedure TForm4.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  EditSpeed(Key);
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  tmp:=Form1.CalculateTimer.Interval;
  Form4.Edit1.Text:=Form1.Edit1.Text;
  Form4.TrackBar1.Position:=Form1.TrackBar1.Position;
end;

procedure TForm4.Edit1Change(Sender: TObject);

var
  i: integer;

begin
  if (Form4.Edit1.Text='') then
  begin
    Form4.Edit1.Text:='0';
  end;
  if (StrToInt(Form4.Edit1.Text) > 99) or (StrToInt(Form4.Edit1.Text) < 0) then
  begin
    Form4.Edit1.Text:='99';
    Form3.Show;
    Form3.Label1.Caption:='Число должно быть от 0 до 99.';
  end;
  for i:=0 to 99 do if Form4.Edit1.Text = '0' + IntToStr(i) then Form4.Edit1.Text:=IntToStr(i);
  Form4.TrackBar1.Position:=StrToInt(Form4.Edit1.Text);
  Form1.CalculateTimer.Interval:=100 - Form4.TrackBar1.Position;
end;

procedure TForm4.TrackBar1Change(Sender: TObject);
begin
  Form4.Edit1.Text:=IntToStr(Form4.TrackBar1.Position);
  if Form4.TrackBar1.Position=0 then Form1.CalculateTimer.Interval:=0 else
  Form1.CalculateTimer.Interval:=100 - Form4.TrackBar1.Position;
end;

end.

