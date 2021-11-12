unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm4 = class(TForm)
    Start: TButton;
    Image1: TImage;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure StartClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Unit6, Unit1;

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
begin
Form1.Visible:=true;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
Form4.Close;
end;

procedure TForm4.StartClick(Sender: TObject);
begin
{Form6.Refresh;
Form6.Repaint;
Form6.Refresh; }
Form6.Visible:=True;
Form4.Visible:=False;
Form6.Left:=Form4.Left;
Form6.Top:=Form4.Top;
end;

end.
