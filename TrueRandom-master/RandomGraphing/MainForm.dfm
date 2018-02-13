object Form1: TForm1
  Left = 192
  Top = 125
  Width = 884
  Height = 491
  Caption = 'Random Plotter'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RndGph: TPerformanceGraph
    Left = 0
    Top = 0
    Width = 868
    Height = 452
    Align = alClient
    Kind = pgBar
    ForeColor = clPurple
    Gradient = 100
    Gridlines = False
    PenWidth = 15
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 24
    Top = 16
  end
end
