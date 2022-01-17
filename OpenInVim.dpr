library OpenInVim;

uses
  System.SysUtils,
  System.Classes,
  Winapi.ShellAPI,
  Winapi.Windows,
  VCL.Menus,
  ToolsAPI;

{$R *.res}

type
  KeyboardBindings = class(TNotifierObject, IOTAKeyboardBinding)
  protected
    procedure BindKeyboard(const BindingServices: IOTAKeyBindingServices);
    function GetBindingType: TBindingType;
    function GetDisplayName: string;
    function GetName: string;
  private
    procedure OpenInVim(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
  end;

function SourceEditor(const Module: IOTAModule): IOTASourceEditor;
var
  I: Integer;
begin
  if not Assigned(Module) then
    Exit(nil);
  for I := 0 to Module.GetModuleFileCount - 1 do
    if Module.GetModuleFileEditor(I).QueryInterface(IOTASourceEditor, Result) = S_OK then
      Exit;
end;

procedure KeyboardBindings.OpenInVim(const Context: IOTAKeyContext; KeyCode: TShortcut;
  var BindingResult: TKeyBindingResult);
var
  MS: IOTAModuleServices;
  Source: IOTASourceEditor;
  CursorPos: TOTAEditPos;
begin
  if Supports(BorlandIDEServices, IOTAModuleServices, MS) then
  begin
    Source := SourceEditor(MS.CurrentModule);
    CursorPos := Source.EditViews[0].CursorPos;
    ShellExecute(0, '', 'vim', PWideChar(Format('"+call cursor(%d,%d)" "%s"',
      [CursorPos.Line, CursorPos.Col, Source.FileName])), '', SW_SHOWNORMAL);
  end;
  BindingResult := krHandled;
end;

procedure KeyboardBindings.BindKeyboard(const BindingServices: IOTAKeyBindingServices);
begin
  BindingServices.AddKeyBinding([TextToShortCut('Ctrl+Shift+V')], OpenInVim, nil);
end;

function KeyboardBindings.GetBindingType: TBindingType;
begin
  Result := btPartial;
end;

ResourceString
  OpenInVimName = 'Open in Vim';

function KeyboardBindings.GetDisplayName: string;
begin
  Result := OpenInVimName;
end;

function KeyboardBindings.GetName: string;
begin
  Result := OpenInVimName;
end;

type
  Wizard = class(TNotifierObject, IOTANotifier, IOTAWizard)
  private
    FKeyboardBindingIndex: Integer;
  protected
    procedure Execute;
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
  public
    constructor Create;
    destructor Destroy; override;
  end;

constructor Wizard.Create;
var
  KBS: IOTAKeyboardServices;
begin
  inherited;
  FKeyboardBindingIndex := -1;
  if Supports(BorlandIDEServices, IOTAKeyboardServices, KBS) then
    FKeyboardBindingIndex := KBS.AddKeyboardBinding(KeyboardBindings.Create);
end;

destructor Wizard.Destroy;
var
  KBS: IOTAKeyboardServices;
begin
  if Supports(BorlandIDEServices, IOTAKeyboardServices, KBS) then
    KBS.RemoveKeyboardBinding(FKeyboardBindingIndex);
  inherited;
end;

procedure Wizard.Execute;
begin
end;

function Wizard.GetIDString: string;
ResourceString
  ID = 'Open in Vim ID';
begin
  Result := ID;
end;

function Wizard.GetName: string;
ResourceString
  Name = 'Open in Vim ID';
begin
  Result := Name;
end;

function Wizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure Register;
begin
  RegisterPackageWizard(Wizard.Create);
end;

function InitWizard(const BorlandIDEServices: IBorlandIDEServices;
  RegisterProc: TWizardRegisterProc; var Terminate: TWizardTerminateProc)
  : Boolean; stdcall;
begin
  Result := BorlandIDEServices <> nil;
  RegisterProc(Wizard.Create);
end;

Exports InitWizard Name WizardEntryPoint;

begin

end.

