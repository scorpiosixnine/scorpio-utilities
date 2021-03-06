; Utility Scripts
; Automatically copied from scorpio-utilities (https://github.com/scorpiosixnine/scorpio-utilities).


int function GetVersion()
  return pQuest.pBuildNumber
endFunction

function ConfigResetOptions()
  ResetToggles()
  ResetMenus()
  ResetButtons()
endFunction

int[] _buttons
String[] _buttonInfos
int[] _buttonTags

int _buttonCount = 0

function ResetButtons()
  _buttons = new int[127]
  _buttonInfos = new String[127]
  _buttonTags = new int[127]
  _buttonCount = 0
endFunction

function SetupButton(String label, String name, String info, int tag = 0)
  if _buttonCount < _buttons.Length
    _buttons[_buttonCount] = AddTextOption(label, name)
    _buttonInfos[_buttonCount] = info
    _buttonTags[_buttonCount] = tag
    _buttonCount += 1
  endif
endFunction

int[] _toggles
bool[] _toggleValues
int[] _toggleTags
String[] _toggleIDs
int _toggleCount = 0

event OnOptionSelect(int option)
  int n = 0
  while(n < _toggleCount)
    if option == _toggles[n]
      bool newValue = !_toggleValues[n]
      _toggleValues[n] = newValue
      SetToggleOptionValue(_toggles[n], newValue)
      string identifier = _toggleIDs[n]
      int tag = _toggleTags[n]
      if !UpdateStandardToggle(identifier, newValue, tag)
        ConfigToggleChanged(identifier, newValue, tag)
      endif
    endif
    n += 1
  endWhile
  n = 0
  while(n < _buttonCount)
    if option == _buttons[n]
      ConfigButtonClicked(n, _buttonTags[n], option)
    endif
    n += 1
  endWhile
endEvent

event OnOptionHighlight(int option)
  int n = 0
  while(n < _buttonCount)
    if option == _buttons[n]
      SetInfoText(_buttonInfos[n])
    endif
    n += 1
  endWhile
endEvent

function ResetToggles()
  _toggles = new int[127]
  _toggleValues = new bool[127]
  _toggleTags = new int[127]
  _toggleIDs = new String[127]
  _toggleCount = 0
endFunction

function SetupToggle(String identifier, String name, bool initialState, int tag = 0)
  if _toggleCount < _toggles.Length
    _toggles[_toggleCount] = AddToggleOption(name, initialState)
    _toggleValues[_toggleCount] = initialState
    _toggleIDs[_toggleCount] = identifier
    _toggleTags[_toggleCount] = tag
    _toggleCount += 1
  else
    pQuest.Trace("run out of toggles")
  endif
endFunction

function SetupToggles(String identifier, int count, String[] names, bool[] values)
  int n = 0
  while(n < count)
    SetupToggle(identifier, names[n], values[n], n)
    n += 1
  endWhile
endFunction

Bool function UpdateStandardToggle(String identifier, bool value, int tag)
  if identifier == "Debugging"
    pQuest.pDebugMode = value
  elseif identifier == "Enabled"
    if pQuest.pEnabled != value
      pQuest.pEnabled = value
      pQuest.UpdatedEnabled()
    endif
  else
    return false
  endif

  return true
endFunction


int[] _menus
int[] _menuValues
int[] _menuTags
int _menuCount = 0

int function MenuIndexForOption(int option)
  int n = 0
  while(n < _menuCount)
    if option == _menus[n]
      return n
    endif
    n += 1
  endWhile
  return -1
endFunction

event OnOptionMenuOpen(int option)
  int index = MenuIndexForOption(option)
  if index != -1
    SetMenuDialogStartIndex(_menuValues[index])
  	SetMenuDialogDefaultIndex(0)
  	SetMenuDialogOptions(_kinds)
  endif
endEvent

event OnOptionMenuAccept(int option, int value)
  int index = MenuIndexForOption(option)
  if index != -1
    _menuValues[index] = value
    SetMenuOptionValue(option, _kinds[value])
    ConfigMenuChanged(index, _menuTags[index], value)
    endif
endEvent

function ResetMenus()
  _menus = new int[127]
  _menuValues = new int[127]
  _menuTags = new int[127]
  _menuCount = 0
endFunction

function SetupMenu(String name, String[] values, int initial, int tag = 0)
  if _menuCount < _menus.Length
    _menus[_menuCount] = AddMenuOption(name, values[initial])
    _menuValues[_menuCount] = initial
    _menuTags[_menuCount] = tag
    _menuCount += 1
  endif
endFunction
