unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,JPEG, ExtCtrls, StdCtrls;

type
  TForm6 = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Image1: TImage;
    Label6: TLabel;
    Timer2: TTimer;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Label7: TLabel;
    Button2: TButton;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer2Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  lose: boolean;
  score,lines: integer;
  Form6: TForm6;
  backstage: TImage;
  blocks: array[1..100,1..100] of TImage;
  blocksnum: array[1..16,1..16] of integer;
  check: array[0..100,0..100] of boolean;
  x,x1: array[1..100] of integer;
  y,y1: array[1..100] of integer;
  pos,figcur,fignext: integer;

implementation
uses Unit4;

{$R *.dfm}

procedure TForm6.Button1Click(Sender: TObject);
var
  i: Integer;
  j: Integer;
begin
randomize;
for i := 1 to 16 - 1 do
for j := 1 to 16 - 1 do
begin
  blocksnum[i,j]:=random(2);
end;
for i := 1 to 16 - 1 do
    for j := 1 to 16 - 1 do
      begin
        if blocksnum[i,j]=0 then blocks[i,j].Visible:=false;
        if blocksnum[i,j]<>0 then blocks[i,j].Visible:=true;
      end;
end;


procedure TForm6.Button2Click(Sender: TObject);
var i,j:integer;
begin
randomize;
score:=0;
for i := 1 to 16 - 1 do
for j := 1 to 16 - 1 do
blocksnum[i,j]:=0;
lose:=false;
timer1.Enabled:=true;
Image1.Visible:=false;
Label6.Visible:=false;
Button2.Visible:=false;
fignext:=random(5)+1;
lines:=0;
end;

procedure TForm6.FormActivate(Sender: TObject);
var
  i: Integer;
  j: Integer;
begin
randomize;
score:=0;
for i := 1 to 16 - 1 do
for j := 1 to 16 - 1 do
blocksnum[i,j]:=0;
lose:=false;
timer1.Enabled:=true;
Image1.Visible:=false;
Label6.Visible:=false;
Button2.Visible:=false;
fignext:=random(5)+1;
lines:=0;
end;

procedure TForm6.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form4.Visible:=True;
Form4.Left:=Form6.Left;
Form4.Top:= Form6.Top;
end;

procedure TForm6.FormCreate(Sender: TObject);
var
  i,j: Integer;
begin
  backstage:=TImage.Create(Form6);
  backstage.Picture.LoadFromFile('backstage.bmp');
  backstage.Parent:=Form6;
  backstage.Height:=300;
  backstage.Width:=300;
  backstage.Left:=20;
  backstage.Top:=20;
  backstage.Visible:=True;
  for i := 1 to 15 do
  for j := 1 to 15 do
    begin
      blocks[i,j]:=TImage.Create(Form6);
      blocks[i,j].Picture.LoadFromFile('blockspray.bmp');
      blocks[i,j].Parent:=Form6;
      blocks[i,j].Height:=20;
      blocks[i,j].Width:=20;
      blocks[i,j].Left:=20*i;
      blocks[i,j].Top:=20*j;
      blocks[i,j].Visible:=false;
      blocksnum[i,j]:=0;
    end;

  Label6.Caption:=inttostr(score);
  Image1.BringToFront;
  Label6.BringToFront;
  Image1.Visible:=false;
  Label6.Visible:=false;
  Timer1.Enabled:=True;
  Button1.TabStop:=False;
  Label7.Caption:=inttostr(lines);
  Label3.Visible:=false;
  Label1.Visible:=false;
  Label2.Visible:=false;
  Label5.Visible:=false;
  Label8.Visible:=false;
end;


procedure TForm6.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var t,t1:boolean;
i,j,k,max,min,l:integer;
begin
if key=39 then begin
                Label3.Caption:='Right';
                t:=false;
                t1:=false;
                k:=0;
                for j := 1 to 16 - 1 do
                for i := 1 to 16 - 1 do
                begin
                  if blocksnum[i,j]=2 then t:=true;
                  if (blocksnum[i,j]=2) and ((i+1>15) or (blocksnum[i+1,j]=1)) then t1:=true;

                end;
                if (t=true) and (t1=false) then
                  begin
                   for j := 1 to 16 - 1 do
                   for i := 1 to 16 - 1 do
                     if (blocksnum[i,j]=2) then
                     begin
                        k:=k+1;
                        x[k]:=i;
                        y[k]:=j;
                     end;
                   min:=100;
                   for i := 1 to k do
                     if x[k]<min then begin min:=x[k]; l:=k; end;
                   for i := 1 to k do
                     blocksnum[x[i],y[i]]:=0;
                   for i := 1 to k do
                   begin
                     blocksnum[x[i]+1,y[i]]:=2;
                   end;
                  end;
               end;
if key=37 then begin
                Label3.Caption:='Left';
                t:=false;
                t1:=false;
                k:=0;
                for j := 1 to 16 - 1 do
                for i := 1 to 16 - 1 do
                begin
                  if blocksnum[i,j]=2 then t:=true;
                  if (blocksnum[i,j]=2) and ((i-1<1) or (blocksnum[i-1,j]=1)) then t1:=true;

                end;
                if (t=true) and (t1=false) then
                  begin
                   for j := 1 to 16 - 1 do
                   for i := 1 to 16 - 1 do
                     if (blocksnum[i,j]=2) then
                     begin
                        k:=k+1;
                        x[k]:=i;
                        y[k]:=j;
                     end;
                   for i := 1 to k do
                     blocksnum[x[i],y[i]]:=0;
                   for i := 1 to k do
                   begin
                     blocksnum[x[i]-1,y[i]]:=2;
                   end;
                  end;
               end;
if key=32 then begin
                 Label3.Caption:='Space';
                 t:=false;
                 if (figcur=1) and (pos=1) then begin
                                                k:=1;
                                                for j := 1 to 16 - 1 do
                                                  for i := 1 to 16 - 1 do
                                                    if blocksnum[i,j]=2 then begin x[k]:=i; y[k]:=j; k:=k+1; end;
                                                if (blocksnum[x[2]+2,y[2]-2]=0) and (blocksnum[x[1],y[1]]=2) and (blocksnum[x[4],y[4]]=2) and (y[2]-2>0) and (blocksnum[x[3]+1,y[2]-1]=0) then begin blocksnum[x[2]+2,y[2]-2]:=2; blocksnum[x[2],y[2]]:=0; blocksnum[x[3],y[3]]:=0;  blocksnum[x[3]+1,y[2]-1]:=2; t:=true; end;
                                                end;
                 if (figcur=1) and (pos=2) then begin
                                                k:=1;
                                                for j := 1 to 16 - 1 do
                                                  for i := 1 to 16 - 1 do
                                                    if blocksnum[i,j]=2 then begin x[k]:=i; y[k]:=j; k:=k+1; end;
                                                if (blocksnum[x[3]-1,y[3]-1]=0) and (x[4]-2>0) and (blocksnum[x[4]-2,y[4]-2]=0) then begin blocksnum[x[3]-1,y[3]-1]:=2; blocksnum[x[3],y[3]]:=0; blocksnum[x[4],y[4]]:=0;  blocksnum[x[4]-2,y[4]-2]:=2; t:=true; end;
                                                end;
                 if (figcur=1) and (pos=3) then begin
                                                k:=1;
                                                for j := 1 to 16 - 1 do
                                                  for i := 1 to 16 - 1 do
                                                    if blocksnum[i,j]=2 then begin x[k]:=i; y[k]:=j; k:=k+1; end;
                                                if (blocksnum[x[2]-1,y[2]+1]=0) and (y[3]+2<16) and (blocksnum[x[3]-2,y[3]+2]=0) then begin blocksnum[x[2]-1,y[2]+1]:=2; blocksnum[x[2],y[2]]:=0; blocksnum[x[3],y[3]]:=0;  blocksnum[x[3]-2,y[3]+2]:=2; t:=true; end;
                                                end;
                 if (figcur=1) and (pos=4) then begin
                                                k:=1;
                                                for j := 1 to 16 - 1 do
                                                  for i := 1 to 16 - 1 do
                                                    if blocksnum[i,j]=2 then begin x[k]:=i; y[k]:=j; k:=k+1; end;
                                                if (blocksnum[x[1]+2,y[1]+2]=0) and (x[1]+2<16) and (blocksnum[x[2]+1,y[2]+1]=0) then begin blocksnum[x[2]+1,y[2]+1]:=2; blocksnum[x[2],y[2]]:=0; blocksnum[x[1],y[1]]:=0;  blocksnum[x[1]+2,y[1]+2]:=2; t:=true; end;
                                                end;
                 if (figcur=2) and (pos=1) then begin
                                                k:=1;
                                                for j := 1 to 16 - 1 do
                                                  for i := 1 to 16 - 1 do
                                                    if blocksnum[i,j]=2 then begin x[k]:=i; y[k]:=j; k:=k+1; end;
                                                if (blocksnum[x[1]+4,y[1]-4]=0) and (blocksnum[x[2]+3,y[2]-3]=0) and (blocksnum[x[3]+2,y[3]-2]=0) and (blocksnum[x[4]+1,y[4]-1]=0) and (y[1]-5>0) and (y[2]-3>0) and (y[3]-2>0) and (y[4]-1>0) then begin for i := 1 to k - 1 do begin blocksnum[x[i],y[i]]:=0; blocksnum[x[i]+k-i-1,y[i]-k+i]:=2; end; t:=true; end;
                                                end;
                 if (figcur=2) and (pos=2) then begin
                                                k:=1;
                                                for i := 1 to 16 - 1 do
                                                  for j := 1 to 16 - 1 do
                                                    if blocksnum[i,j]=2 then begin x[k]:=i; y[k]:=j; k:=k+1; end;
                                                if (blocksnum[x[1]-4,y[1]+4]=0) and (blocksnum[x[2]-3,y[2]+3]=0) and (blocksnum[x[3]-2,y[3]+2]=0) and (blocksnum[x[4]-1,y[4]+1]=0) and (x[1]-5>0) and (x[2]-3>0) and (x[3]-2>0) and (x[4]-1>0) then begin for i := 1 to k - 1 do begin blocksnum[x[i],y[i]]:=0; blocksnum[x[i]-k+i+1,y[i]+k-i-1]:=2; end; t:=true; end;
                                                end;
                 if (figcur=4) and (pos=1) then begin
                                                k:=1;
                                                for j := 1 to 16 - 1 do
                                                  for i := 1 to 16 - 1 do
                                                    if blocksnum[i,j]=2 then begin x[k]:=i; y[k]:=j; k:=k+1; end;
                                                if (blocksnum[x[1]+1,y[1]-1]=0) and (blocksnum[x[4]-2,y[4]]=0) and (y[1]-1>0) then begin blocksnum[x[1],y[1]]:=0; blocksnum[x[1]+1,y[1]-1]:=2; blocksnum[x[3],y[3]]:=0; blocksnum[x[3]-1,y[3]-1]:=2; blocksnum[x[4],y[4]]:=0; blocksnum[x[4]-2,y[4]]:=2; t:=true; end;
                                                end;
                 if (figcur=4) and (pos=2) then begin
                                                k:=1;
                                                for j := 1 to 16 - 1 do
                                                  for i := 1 to 16 - 1 do
                                                    if blocksnum[i,j]=2 then begin x[k]:=i; y[k]:=j; k:=k+1; end;
                                                if (blocksnum[x[1],y[1]+2]=0) and (blocksnum[x[1]+1,y[1]+2]=0) and (x[1]+1<16) then begin blocksnum[x[1],y[1]]:=0; blocksnum[x[4],y[4]]:=0; blocksnum[x[1],y[1]+2]:=2; blocksnum[x[4]+2,y[4]]:=2; t:=true; end;
                                                end;
                 if (figcur=5) and (pos=1) then begin
                                                k:=1;
                                                for j := 1 to 16 - 1 do
                                                  for i := 1 to 16 - 1 do
                                                    if blocksnum[i,j]=2 then begin x[k]:=i; y[k]:=j; k:=k+1; end;
                                                if (blocksnum[x[1],y[1]-1]=0) and (blocksnum[x[1]+1,y[1]+1]=0) and (y[1]-1>=0) then begin blocksnum[x[3],y[3]]:=0; blocksnum[x[4],y[4]]:=0; blocksnum[x[3]+1,y[3]-2]:=2; blocksnum[x[4]+1,y[4]]:=2; t:=true; end;
                                                end;
                 if (figcur=5) and (pos=2) then begin
                                                k:=1;
                                                for j := 1 to 16 - 1 do
                                                  for i := 1 to 16 - 1 do
                                                    if blocksnum[i,j]=2 then begin x[k]:=i; y[k]:=j; k:=k+1; end;
                                                if (blocksnum[x[1],y[1]+2]=0) and (blocksnum[x[1]-1,y[1]+2]=0) and (x[1]-1>=0) then begin blocksnum[x[1],y[1]]:=0; blocksnum[x[4],y[4]]:=0; blocksnum[x[1],y[1]+2]:=2; blocksnum[x[4]-2,y[4]]:=2; t:=true; end;
                                                end;
                 if t=true then pos:=pos+1;
                 if ((figcur=5) or (figcur=2) or (figcur=4)) and (pos>2) then pos:=pos-2;
                 if pos>4 then pos:=pos-4;
                 Label8.Caption:=inttostr(pos);

               end;
if key=16 then begin
                 Label3.Caption:='Shift';
                 k:=0;
                 for j := 1 to 16 - 1 do
                   for i := 1 to 16 - 1 do
                     if (blocksnum[i,j]=2) then
                     begin
                        k:=k+1;
                        x[k]:=i;
                        y[k]:=j;
                     end;
                 min:=16;
                 t:=false;
                 for i := 1 to k do
                   for j := 1 to 15 do
                     if (blocksnum[x[i],j]=1) and (j<min) then begin min:=j; t:=true; end;
                 if t=true then begin
                                for i := k downto 1 do
                                begin
                                  blocksnum[x[i],y[i]]:=0;
                                  blocksnum[x[i],min-1+y[i]-y[k]]:=2;
                                end;
                                end;
                 if t=false then begin
                                 for i := k downto 1 do
                                 begin
                                   blocksnum[x[i],y[i]]:=0;
                                   blocksnum[x[i],15+y[i]-y[k]]:=2;
                                 end;
                                 end;
               end;


end;



procedure TForm6.Timer1Timer(Sender: TObject);
var
  t,t1,t2,t3:boolean;
  j: Integer;
  i: Integer;
  l: integer;
  k: integer;
  fig: integer;
begin
  Label5.Caption:='';
  for j := 1 to 16 - 1 do
  begin
    for i := 1 to 16 - 1 do
      Label5.Caption:=Label5.Caption+inttostr(blocksnum[i,j])+' ';
    Label5.Caption:=Label5.Caption+#13;
  end;
  randomize;
  t:=false;
  t1:=false;
  k:=0;
  for j := 1 to 16 - 1 do
    for i := 1 to 16 - 1 do
      begin
        if blocksnum[i,j]=2 then t:=true;
      end;
  if t=false then begin

                  figcur:=fignext;
                  fignext:=random(5)+1;
                  pos:=1;
                  if fignext=1 then Image3.Picture.LoadFromFile('t.bmp')
                  else if fignext=2 then Image3.Picture.LoadFromFile('i.bmp')
                  else if fignext=3 then Image3.Picture.LoadFromFile('sq.bmp')
                  else if fignext=4 then Image3.Picture.LoadFromFile('z.bmp')
                  else if fignext=5 then Image3.Picture.LoadFromFile('s.bmp')
                  else if fignext=6 then Image3.Picture.LoadFromFile('l.bmp')
                  else if fignext=7 then Image3.Picture.LoadFromFile('j.bmp');
                  if (figcur=1) and (blocksnum[7,1]<>1) and (blocksnum[6,2]<>1) and (blocksnum[7,2]<>1) and (blocksnum[8,2]<>1) then begin blocksnum[7,1]:=2; blocksnum[6,2]:=2; blocksnum[7,2]:=2; blocksnum[8,2]:=2; end
                                                                                                                             else
                  if (figcur=2) and (blocksnum[7,1]<>1) and (blocksnum[6,1]<>1) and (blocksnum[5,1]<>1) and (blocksnum[8,1]<>1) and (blocksnum[9,1]<>1) then begin blocksnum[7,1]:=2; blocksnum[6,1]:=2; blocksnum[5,1]:=2; blocksnum[8,1]:=2; blocksnum[9,1]:=2; end
                                                                                                                             else
                  if (figcur=3) and (blocksnum[6,1]<>1) and (blocksnum[7,1]<>1) and (blocksnum[6,2]<>1) and (blocksnum[7,2]<>1) then begin blocksnum[6,1]:=2; blocksnum[7,1]:=2; blocksnum[6,2]:=2; blocksnum[7,2]:=2; end
                                                                                                                             else
                  if (figcur=4) and (blocksnum[6,1]<>1) and (blocksnum[7,1]<>1) and (blocksnum[7,2]<>1) and (blocksnum[8,2]<>1) then begin blocksnum[6,1]:=2; blocksnum[7,2]:=2; blocksnum[8,2]:=2; blocksnum[7,1]:=2; end
                                                                                                                             else
                  if (figcur=5) and (blocksnum[6,2]<>1) and (blocksnum[7,2]<>1) and (blocksnum[7,1]<>1) and (blocksnum[8,1]<>1) then begin blocksnum[6,2]:=2; blocksnum[7,2]:=2; blocksnum[7,1]:=2; blocksnum[8,1]:=2; end
                                                                                                                             else
                  if (figcur=6) and (blocksnum[5,2]<>1) and (blocksnum[6,2]<>1) and (blocksnum[7,2]<>1) and (blocksnum[7,1]<>1) then begin blocksnum[5,2]:=2; blocksnum[6,2]:=2; blocksnum[7,2]:=2; blocksnum[7,1]:=2; end
                                                                                                                             else
                  if (figcur=7) and (blocksnum[5,1]<>1) and (blocksnum[5,2]<>1) and (blocksnum[6,2]<>1) and (blocksnum[7,2]<>1) then begin blocksnum[5,1]:=2; blocksnum[5,2]:=2; blocksnum[6,2]:=2; blocksnum[7,2]:=2; end
                                                                                                                             else lose:=true;



                  {for i := 7 to 10 - 1 do
                  begin
                    blocksnum[i,1]:=2;
                    blocksnum[i,2]:=2;
                    blocksnum[i,3]:=2;
                  end;}
                 { for i := 1 to 16 - 1 do
                    for j := 1 to 16 - 1 do
                      if blocksnum[i,j]=2 then
                      begin
                        k:=k+1;
                        x[k]:=i;
                        y[k]:=1;
                      end;}
                  end;
  k:=0;
  if t=true then begin
                   for j := 1 to 16 - 1 do
                   for i := 1 to 16 - 1 do
                     if (blocksnum[i,j]=2) then
                     begin
                        k:=k+1;
                        x[k]:=i;
                        y[k]:=j;
                        x1[k]:=x[k]+1;
                        y1[k]:=y[k]+1;
                     end;
                   t1:=false;
                   for i := 1 to k do
                     if (blocksnum[x[i],y[i]+1]=1) or (y[i]+1>15) then t1:=true;
                   if (t1=true) then begin
                                      score:=score+10;
                                      for i :=1 to k do
                                        blocksnum[x[i],y[i]]:=1;
                                     end;
                   if (t1=false) then begin
                   for i := 1 to k do
                     blocksnum[x[i],y[i]]:=0;
                   for i := 1 to k do
                   begin
                     blocksnum[x[i],y[i]+1]:=2;
                   end;
                   end;

                 end;

  for j := 1 to 16 - 1 do
  begin
    t2:=true;
    for i := 1 to 16 - 1 do
      begin
        if blocksnum[i,j]<>1 then begin t2:=false; end;
      end;
    if t2=true then begin
                      Timer1.Interval:=Timer1.Interval-25;
                      score:=score+100;
                      lines:=lines+1;
                      l:=j;
                      for i := 1 to 16 - 1 do
                        blocksnum[i,j]:=0;
                      for i := 1 to 16 - 1 do
                        for k := j downto 1 do
                          begin
                            if blocksnum[i,k-1]=1 then blocksnum[i,k]:=1;
                            blocksnum[i,k-1]:=0
                          end;
                    end;
  end;
  Label4.Caption:=IntToStr(Score);
  Label7.Caption:=inttostr(lines);
  Label1.Caption:=TimeToStr(Now);
  if t=true then Label2.Caption:='True';
  if t=false then Label2.Caption:='False';
  if lose=true then begin
                    Image1.Visible:=True;
                    Label6.Visible:=True;
                    Label6.Caption:=inttostr(score);
                    Timer1.Enabled:=false;
                    Button2.Visible:=true;
                    Timer1.Interval:=500;
                    end;
end;

procedure TForm6.Timer2Timer(Sender: TObject);
var
i,j:integer;
begin
 for i := 1 to 16 - 1 do
    for j := 1 to 16 - 1 do
      begin
        if blocksnum[i,j]>0 then
        blocks[i,j].Visible:=true;
        if blocksnum[i,j]=0 then
        blocks[i,j].Visible:=false;
      end;
end;

end.
