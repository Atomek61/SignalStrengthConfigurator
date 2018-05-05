unit PreviewDlg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, ComCtrls,
  Controls.SignalStrength;

type

  { TPreviewDialog }

  TPreviewDialog = class(TForm)
    LabelSize: TLabel;
    PanelPreview: TPanel;
    TrackBarLevel: TTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure TrackBarLevelChange(Sender: TObject);
  private
    SignalStrength :TSignalStrength;
  public

  end;

var
  PreviewDialog: TPreviewDialog;

implementation

uses
  MainDlg;

{$R *.lfm}

{ TPreviewDialog }

procedure TPreviewDialog.FormCreate(Sender: TObject);
begin
  SignalStrength := MainDialog.SignalStrength;
  with SignalStrength do begin
    Parent := PanelPreview;
    SignalStrength.Align := alClient;
    SignalStrength.Visible := true;
  end;
  MainDialog.PanelBackground.Color := PanelPreview.Color;
  FormResize(nil);
end;

procedure TPreviewDialog.FormResize(Sender: TObject);
begin
  with SignalStrength do
    LabelSize.Caption := Format('%dx%d', [Width, Height]);
end;

procedure TPreviewDialog.TrackBarLevelChange(Sender: TObject);
begin
  with SignalStrength do
    Level := MinLevel + TrackBarLevel.Position/100*(MaxLevel-MinLevel);
end;

end.

