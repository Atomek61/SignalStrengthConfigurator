unit MainDlg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Controls.SignalStrength, LclType, ExtCtrls, Types.Led;

type

  { TMainDialog }

  TMainDialog = class(TForm)
    ColorDialog: TColorDialog;
    EditLevel: TEdit;
    EditBarCount: TEdit;
    EditGapSize: TEdit;
    EditMinLevel: TEdit;
    EditMaxLevel: TEdit;
    GroupBoxLayout: TGroupBox;
    GroupBoxBars: TGroupBox;
    GroupBoxLevel: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PanelBrightColor: TPanel;
    PanelDarkColor: TPanel;
    PanelBackground: TPanel;
    procedure EditBarCountChange(Sender: TObject);
    procedure EditBarCountKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditGapSizeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditLevelKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditMaxLevelKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditMinLevelKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PanelBackgroundClick(Sender: TObject);
    procedure PanelBrightColorClick(Sender: TObject);
    procedure PanelDarkColorClick(Sender: TObject);
  private
    procedure OnSignalStrengthChanged(Sender :TObject);
  public
    SignalStrength :TSignalStrength;
  end;

var
  MainDialog: TMainDialog;

implementation

uses
  PreviewDlg;

{$R *.lfm}

{ TMainDialog }

procedure TMainDialog.FormCreate(Sender: TObject);
begin
  SignalStrength := TSignalStrength.Create(self);
  with SignalStrength do begin
    Level := 0.5;
    BorderSpacing.Around := 4;
    OnChanged := @OnSignalStrengthChanged;
  end;
end;

procedure TMainDialog.FormShow(Sender: TObject);
begin
  OnSignalStrengthChanged(nil);
  ColorSetsToStrings(ColorDialog.CustomColors);
end;

procedure TMainDialog.PanelBackgroundClick(Sender: TObject);
begin
  if ColorDialog.Execute then begin
    PreviewDialog.PanelPreview.Color := ColorDialog.Color;
    PanelBackground.Color := ColorDialog.Color;
  end;
end;

procedure TMainDialog.PanelBrightColorClick(Sender: TObject);
begin
  if ColorDialog.Execute then begin
    SignalStrength.BrightColor := ColorDialog.Color;
  end;
end;

procedure TMainDialog.PanelDarkColorClick(Sender: TObject);
begin
  if ColorDialog.Execute then begin
    SignalStrength.DarkColor := ColorDialog.Color;
  end;
end;

procedure TMainDialog.OnSignalStrengthChanged(Sender: TObject);
begin
  EditLevel.Text := Format('%.2f', [SignalStrength.Level]);
  EditMinLevel.Text := Format('%.2f', [SignalStrength.MinLevel]);
  EditMaxLevel.Text := Format('%.2f', [SignalStrength.MaxLevel]);
  EditBarCount.Text := IntToStr(SignalStrength.BarCount);
  PanelBrightColor.Color := SignalStrength.BrightColor;
  PanelDarkColor.Color := SignalStrength.DarkColor;
  EditGapSize.Text := IntToStr(SignalStrength.GapSize);
  with SignalStrength do
    PreviewDialog.TrackBarLevel.Position := round(100*Level/(MaxLevel-MinLevel));
end;

procedure TMainDialog.EditLevelKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then begin
    SignalStrength.Level := StrToFloat(EditLevel.Text);
    Key := 0;
  end;
end;

procedure TMainDialog.EditBarCountChange(Sender: TObject);
begin
end;

procedure TMainDialog.EditBarCountKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then begin
    SignalStrength.BarCount := StrToInt(EditBarCount.Text);
    Key := 0;
  end;
end;

procedure TMainDialog.EditGapSizeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then begin
    SignalStrength.GapSize := StrToInt(EditGapSize.Text);
    Key := 0;
  end;
end;

procedure TMainDialog.EditMaxLevelKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then begin
    SignalStrength.MaxLevel := StrToFloat(EditMaxLevel.Text);
    Key := 0;
  end;
end;

procedure TMainDialog.EditMinLevelKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RETURN then begin
    SignalStrength.MinLevel := StrToFloat(EditMinLevel.Text);
    Key := 0;
  end;
end;

end.

