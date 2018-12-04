unit yedekal;

interface

uses
  Windows, Messages, SysUtils,Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,ExtCtrls,Data.Win.ADODB,DB,
  AbComCtrls, AbBase, AbBrowse, AbZBrows, AbZipper, AdoInt, OleDB, ComObj, ActiveX,filectrl,
  Vcl.Buttons;

type
  Tyedekfrm = class(TForm)
    Panel2: TPanel;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    kullanici: TEdit;
    sifre: TEdit;
    kayit_yeri1: TEdit;
    zipla: TCheckBox;
    kayit_yeri2: TEdit;
    kaydet: TButton;
    yukle: TButton;
    Label11: TLabel;
    Panel1: TPanel;
    baglan: TButton;
    yedekle: TButton;
    temizle: TButton;
    kapat: TButton;
    sunucu_baglan: TADOConnection;
    sorgu: TADOQuery;
    yardim: TButton;
    AbZipper1: TAbZipper;
    AbProgressBar1: TAbProgressBar;
    Label5: TLabel;
    Label6: TLabel;
    comboserver: TComboBox;
    combodb: TComboBox;
    klasorbuton1: TSpeedButton;
    diyalog1: TOpenDialog;
    klasorbuton2: TSpeedButton;
    log_memo: TMemo;
    sql_memo: TMemo;
    procedure FormCreate(Sender: TObject);

    procedure tus_pasif;
    procedure tus_aktif;
    procedure tus_yedekle;

    procedure baglanClick(Sender: TObject);
    procedure kapatClick(Sender: TObject);
    procedure yukleClick(Sender: TObject);
    procedure kaydetClick(Sender: TObject);
    procedure temizleClick(Sender: TObject);
    procedure ziplaClick(Sender: TObject);
    procedure yardimClick(Sender: TObject);
    procedure yedekleClick(Sender: TObject);
    procedure ziplimi;
    function dosya_adi(gelen_ad:string):string;
    procedure Panel2MouseEnter(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure klasorbuton1Click(Sender: TObject);
    procedure kullaniciExit(Sender: TObject);
    procedure sifreExit(Sender: TObject);
    procedure klasorbuton2Click(Sender: TObject);
    procedure comboserverExit(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
 yedekfrm: Tyedekfrm;
 UserName,PassWord,Server,baglanayar,mesaj:string;
 klasor,klasorzip: String;
 implementation

uses yardimprg,strutils ;

{$R *.dfm}
const CKEY1 = 53761;
      CKEY2 = 32618;

function EncryptStr(const S :WideString; Key: Word): String;
var   i          :Integer;
      RStr       :RawByteString;
      RStrB      :TBytes Absolute RStr;
begin
  Result:= '';
  RStr:= UTF8Encode(S);
  for i := 0 to Length(RStr)-1 do begin
    RStrB[i] := RStrB[i] xor (Key shr 8);
    Key := (RStrB[i] + Key) * CKEY1 + CKEY2;
  end;
  for i := 0 to Length(RStr)-1 do begin
    Result:= Result + IntToHex(RStrB[i], 2);
  end;
end;

function DecryptStr(const S: String; Key: Word): String;
var   i, tmpKey  :Integer;
      RStr       :RawByteString;
      RStrB      :TBytes Absolute RStr;
      tmpStr     :string;
begin
  tmpStr:= UpperCase(S);
  SetLength(RStr, Length(tmpStr) div 2);
  i:= 1;
  try
    while (i < Length(tmpStr)) do begin
      RStrB[i div 2]:= StrToInt('$' + tmpStr[i] + tmpStr[i+1]);
      Inc(i, 2);
    end;
  except
    Result:= '';
    Exit;
  end;
  for i := 0 to Length(RStr)-1 do begin
    tmpKey:= RStrB[i];
    RStrB[i] := RStrB[i] xor (Key shr 8);
    Key := (tmpKey + Key) * CKEY1 + CKEY2;
  end;
  Result:= UTF8Decode(RStr);

end;

procedure sqlserverlistele(Names : TStrings);
var
RSCon: ADORecordsetConstruction;
Rowset: IRowset;
SourcesRowset: ISourcesRowset;
SourcesRecordset: _Recordset;
SourcesName, SourcesType: TField;

function PtCreateADOObject(const ClassID: TGUID): IUnknown;
var
Status: HResult;
FPUControlWord: Word;
begin
asm
FNSTCW FPUControlWord
end;
Status := CoCreateInstance(
CLASS_Recordset,
nil,
CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER,
IUnknown,
Result);
asm
FNCLEX
FLDCW FPUControlWord
end;
OleCheck(Status);
end;
begin
SourcesRecordset := PtCreateADOObject(CLASS_Recordset) as _Recordset;
RSCon := SourcesRecordset as ADORecordsetConstruction;
SourcesRowset := CreateComObject(ProgIDToClassID('SQLOLEDB Enumerator')) as ISourcesRowset;
OleCheck(SourcesRowset.GetSourcesRowset(nil, IRowset, 0, nil, IUnknown(Rowset)));
RSCon.Rowset := RowSet;
with TADODataSet.Create(nil) do
try
Recordset := SourcesRecordset;
SourcesName := FieldByName('SOURCES_NAME'); { do not localize }
SourcesType := FieldByName('SOURCES_TYPE'); { do not localize }
Names.BeginUpdate;
try
while not EOF do
begin
if (SourcesType.AsInteger = DBSOURCETYPE_DATASOURCE) and (SourcesName.AsString <> '') then
Names.Add(SourcesName.AsString);
Next;
end;
finally
Names.EndUpdate;
end;
finally
Free;
end;
end;


procedure Tyedekfrm.Panel2MouseEnter(Sender: TObject);
begin
sifre.PasswordChar := '*';
sifre.Update;
end;

procedure Tyedekfrm.sifreExit(Sender: TObject);
begin
 if (trim(sifre.text)='') then
    begin
      Application.MessageBox('Þifre belirtmediniz'+#13+'Lütfen þifre Giriniz',
                            'Hata',
                            MB_OK+
                            MB_ICONERROR+
                            MB_DEFBUTTON1+
                            MB_SYSTEMMODAL);
                            sifre.SetFocus;
                            exit;
    end;
end;

procedure Tyedekfrm.klasorbuton1Click(Sender: TObject);
begin
  SelectDirectory('klasör seç', '', klasor);
  kayit_yeri1.Text := klasor+'\'+dosya_adi(combodb.Text)+'.bak';

  //ShowMessage(kayit_yeri2.Text+#13+kayit_yeri1.Text);
end;

procedure Tyedekfrm.klasorbuton2Click(Sender: TObject);
begin
 SelectDirectory('klasör seç', '', klasorzip);
 kayit_yeri2.Text := klasorzip+'\'+dosya_adi(combodb.Text)+'.zip';
end;

procedure Tyedekfrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
sunucu_baglan.Connected := false;
log_memo.Lines.Add('Yedekleme programý kapatýldý.          '+ datetostr(date)+' ' + timetostr(time())) ;
log_memo.Lines.SaveToFile('sql.log');
Action := caFree;
end;

procedure Tyedekfrm.FormCreate(Sender: TObject);

begin
  // program sadece 1 kez çalýþsýn kodu
  CreateMutex(nil,FALSE,'yedek.exe');
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
  ShowMessage('Yedek.exe calismakta.');
  Halt(0);
  end;
  yedekfrm.Tag :=0;
  mesaj :='';
  yukle.Click; // varsa ayarlý yükle
  tus_pasif;
  ziplimi;
  panel1.color:=clred;
  if fileexists('sql.log') then log_memo.Lines.LoadFromFile('sql.log');

  comboserver.items.Clear;
  sqlserverlistele(comboserver.Items);
  sql_memo.Clear;
end;


procedure Tyedekfrm.FormDestroy(Sender: TObject);
begin
 yedekfrm:=nil;
end;

procedure Tyedekfrm.kapatClick(Sender: TObject);
begin
yedekfrm.Close;
end;


procedure Tyedekfrm.tus_pasif;
begin
  // tuþlar pasif olsun
  yedekle.enabled:= false;
  baglan.Enabled := true;
  kaydet.Enabled := true;
  yukle.Enabled  := true;
  yardim.Enabled := true;
  temizle.Enabled:= true;
  kapat.enabled  :=true;
end;

procedure Tyedekfrm.yardimClick(Sender: TObject);
begin

Application.CreateForm(Tyardimfrm, yardimfrm);
try
   yardimfrm.ShowModal;
   finally
   yardimfrm.Free;
   end;
end;

procedure Tyedekfrm.yedekleClick(Sender: TObject);
var
   Save_Cursor:TCursor;
   hata:boolean;
   begin
    tus_yedekle;
    yedekfrm.Cursor := crsqlwait;
    hata:=true;
    Save_Cursor := Screen.Cursor;
    log_memo.Lines.Add('Yedekleme Baþladý                      ' + datetostr(date)+' ' + timetostr(time())) ;

        try
    sorgu.sql.Clear;
    sorgu.sql.Add(' BACKUP DATABASE ' + combodb.Text);
    sorgu.sql.Add(' TO DISK = '+''''+kayit_yeri1.Text+'''');
    sorgu.sql.Add(' WITH   INIT ,');
    sorgu.sql.Add(' NOUNLOAD ,');
    sorgu.sql.Add(' NAME = N'+''''+combodb.Text+' backup'+''''+',');
    sorgu.sql.Add(' NOSKIP ,');
    sorgu.sql.Add(' STATS = 10,');
    sorgu.sql.Add(' NOFORMAT');
    sorgu.ExecSQL;
     except
     on E: Exception do begin
                            tus_pasif;
                            ShowMessage(E.ClassName + '#10' + E.Message);
                             hata:=false;
                             log_memo.Lines.Add('Yedeklemede Hata Oluþtu '+ datetostr(date)+' ' + timetostr(time())) ;
                             yedekfrm.Cursor := Save_Cursor;
                             exit;
                            end;

    end;
    if (hata) then begin
    log_memo.Lines.Add('Yedekleme Bitti                        ' + datetostr(date)+' ' + timetostr(time())) ; ;
    yedekfrm.Cursor := Save_Cursor;
    tus_pasif;
    Application.ProcessMessages;
      if (zipla.Checked) then
      begin
      log_memo.Lines.Add('Sýkýþtýrma Ýþlemi Baþladý              '+ datetostr(date)+' ' + timetostr(time())) ;
      mesaj:='Sýkýþtýrma iþlemi yapýlýyor. Lütfen bekleyiniz.';

   AbZipper1.Password:=combodb.Text;
   abzipper1.FileName := kayit_yeri2.Text;
   abzipper1.BaseDirectory := AnsiLeftStr(kayit_yeri2.text, 3);
   abzipper1.AddFiles(kayit_yeri1.Text,0);
   abzipper1.AutoSave:=true;
   log_memo.Lines.Add('Sýkýþtýrýlan dosya(lar)  = '+ inttostr(abzipper1.Count)+'           '+ datetostr(date)+' ' + timetostr(time()));
   log_memo.Lines.Add('Sýkýþtýrma Ýþlemi Tamamlandý           '+ datetostr(date)+' ' + timetostr(time())) ;
   abprogressbar1.Reset;
   end;
    mesaj:='Yedekleme Tamamlandý.';
    tus_pasif;
    showmessage('Yedekleme Tamamlandý.');
   end;
end;

procedure Tyedekfrm.yukleClick(Sender: TObject);
begin
  if not fileexists('sql.ini') then
  begin
  Showmessage ('sql.ini Dosyasý Bulunamadý. Ayarlarýnýzý Yaparak Kaydet Düðmesine Basýn');
  exit;
  end
  else begin
  sql_memo.Clear;
  sql_memo.Lines.LoadFromFile('sql.ini');
  log_memo.Lines.Add('Database ayar bilgileri Yüklenmiþtir.  '+ datetostr(date)+' ' + timetostr(time())) ;
  end;

comboserver.Text := sql_memo.Lines[0]; // server name
kullanici.Text  := sql_memo.Lines[1]; // kullanici adý
sifre.Text      := DecryptStr(sql_memo.Lines[2],189); // sifre
combodb.Text  := sql_memo.Lines[3]; //database
kayit_yeri1.Text:= sql_memo.Lines[4]; //kayýt yeri
kayit_yeri2.Text:= sql_memo.Lines[5];  //sýkýþtýrma yeri
if sql_memo.Lines[6]= '0' then zipla.Checked:=true else zipla.Checked:=false;   // zýplama
    if not zipla.Checked then begin
    kayit_yeri2.Hide ;
    label1.Hide;
    end else begin
    kayit_yeri2.Show;
    label1.Show;
    end;
sql_memo.Clear;
end;

procedure Tyedekfrm.ziplaClick(Sender: TObject);
begin
ziplimi;
end;

procedure Tyedekfrm.kaydetClick(Sender: TObject);
begin
sql_memo.Lines.Add(comboserver.text);
sql_memo.Lines.add(kullanici.Text);
sql_memo.Lines.Add(EncryptStr(sifre.Text,189));
sql_memo.Lines.Add(combodb.Text);
sql_memo.Lines.Add(kayit_yeri1.Text);
sql_memo.Lines.Add(kayit_yeri2.Text);
if zipla.Checked then sql_memo.Lines.Add('0') else sql_memo.Lines.Add('1');
sql_memo.Lines.SaveToFile('sql.ini');
log_memo.Lines.Add('Ayarlar kaydedilmiþtir.                '+ datetostr(date)+' ' + timetostr(time())) ;
sql_memo.Clear;
end;

procedure Tyedekfrm.kullaniciExit(Sender: TObject);
begin
if (trim(kullanici.Text)=EmptyStr) then
    begin
    Application.MessageBox('Kullanýcý Adý Belirtilmemiþ'+#13+'Lütfen Kullanýcý Adýný Giriniz',
                            'Hata',
                            MB_OK+
                            MB_ICONERROR+
                            MB_DEFBUTTON1+
                            MB_SYSTEMMODAL);
                            kullanici.SetFocus;
                            exit;
    end
end;


procedure Tyedekfrm.Label6Click(Sender: TObject);
begin
sifre.PasswordChar := #0;
sifre.Update;
end;

procedure Tyedekfrm.temizleClick(Sender: TObject);
begin
tus_pasif;
comboserver.Text := '';
kullanici.Text  := '';
sifre.Text      := '';
combodb.Text  := '';
kayit_yeri1.Text:= '';
kayit_yeri2.Text:= '';
zipla.Checked:=false;
ziplimi;
sunucu_baglan.Connected := False; // database açýksa kapat
panel1.color:=clred;
log_memo.Lines.Add('Ayarlar sýfýrlandý.                    '+ datetostr(date)+' ' + timetostr(time())) ;
end;
procedure Tyedekfrm.tus_aktif;
begin
   yedekle.enabled:= true;
   baglan.Enabled := false;
   kaydet.Enabled := true;
   yukle.Enabled  := true;
   yardim.Enabled := true;

   end;
procedure Tyedekfrm.tus_yedekle;
begin
    baglan.Enabled:=false;
    temizle.Enabled:=false;
    yardim.Enabled:=false;
    kapat.Enabled:=false;
    kaydet.Enabled:=false;
    yukle.Enabled:=false;
 end;

 procedure Tyedekfrm.baglanClick(Sender: TObject);
var
dbquery:TADOQuery;
begin
sunucu_baglan.Connected := False; // database açýksa kapat
tus_aktif;
username:=kullanici.Text;
password:= sifre.Text;
server:=comboserver.Text;//server_adi.Text;
baglanayar:= 'Provider=SQLOLEDB.1;Persist Security Info=False;' +
  'User ID=%s;Password=%s;Data Source=%s;Use Procedure for Prepare=1;' +
  'Auto Translate=True;Packet Size=4096;Use Encryption for Data=False;'+
  'Tag with column collation when possible=False;';

log_memo.Lines.Add('Sunucu Baðlantýsý Yapýlýyor.           '+ datetostr(date)+' ' + timetostr(time())) ;
  panel1.Color:=clyellow;

  sunucu_baglan.ConnectionString:= Format(baglanayar,[UserName, PassWord, Server]);

  { Disable login prompt }
  sunucu_baglan.LoginPrompt := False;

  try
    sunucu_baglan.Connected := True;
    log_memo.Lines.Add('Sunucu Baðlantýsý Yapýldý.             ' + datetostr(date)+' ' + timetostr(time())) ;
    panel1.Color:=cllime;

    dbquery:=TADOQuery.Create(self);
    with dbquery do
     begin
        connection:=sunucu_baglan;
        close;
        sql.Clear;
        sql.Add('SELECT name FROM sys.databases WHERE name NOT IN (''master'',''model'',''msdb'',''tempdb'')');
        open;
        active;
        combodb.Enabled:=true;
        while not eof do
          begin
            combodb.items.Add(dbquery.fieldbyname('name').AsString);
            next;
          end;
        combodb.itemindex:=1;

     end;

  except
       yedekfrm.tus_pasif;
    log_memo.Lines.Add('Sunucu Baðlantýsýnda hata oluþtu.      ' + datetostr(date)+' ' + timetostr(time())) ;
       panel1.Color := clred;

   end; // try sonu

end;

procedure Tyedekfrm.ziplimi;
begin
if not zipla.Checked then begin
    kayit_yeri2.Hide ;
    label1.Hide;
    label5.Hide;
    AbProgressBar1.hide;
    klasorbuton2.Hide;
        end else begin
    kayit_yeri2.Show;
    label1.Show;
    label5.Show;
    AbProgressBar1.Show;
    klasorbuton2.Show;
    end;
end;

procedure Tyedekfrm.comboserverExit(Sender: TObject);
begin
if (trim(comboserver.text)=EmptyStr) then
    begin
      Application.MessageBox('Server seçmediniz'+#13+'Lütfen SQLserver seçin',
                            'Hata',
                            MB_OK+
                            MB_ICONERROR+
                            MB_DEFBUTTON1+
                            MB_SYSTEMMODAL);
                            comboserver.SetFocus;
                            exit;
    end;
end;

function tyedekfrm.dosya_adi(gelen_ad:string):string;
var
yil,ay,gun:Word;
begin
if gelen_ad = '' then exit;
DecodeDate(date,yil,ay,gun);// tarihi parçalara ayýr
gelen_ad := gelen_ad + '_' +IntToStr(gun)+ '_'+IntToStr(ay)+ '_'+IntToStr(yil);
Result := gelen_ad;
end;

end.
// geri yükleme için komut sql 2005
// RESTORE DATABASE [LKSDB] FROM  DISK = N'C:\lksdb.bck' WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10

