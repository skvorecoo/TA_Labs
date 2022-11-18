unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Panel1: TPanel;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;
  i: integer;

implementation

{$R *.lfm}

{ TForm3 }

procedure TForm3.FormShow(Sender: TObject);
begin
  i:=0;
  Form3.Timer1.Enabled:=True;
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
  if i > 100 then
  begin
    Form3.Timer1.Enabled:=False;
    Form3.Close;
  end;
  i+=1;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin

end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  Form3.Timer1.Enabled:=False;
  Form3.Close;
end;

end.

