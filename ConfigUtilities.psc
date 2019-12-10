; Utility Scripts
; Automatically copied from scorpio-utilities (https://github.com/scorpiosixnine/scorpio-utilities).

int[] _toggles
bool[] _toggleValues
int[] _toggleTags
String[] _toggleIDs
int _toggleCount = 0

function ResetOptions()
  ResetToggles()
  ResetMenus()
endFunction

function ResetToggles()
  _toggles = new int[100]
  _toggleValues = new bool[100]
  _toggleTags = new int[100]
  _toggleIDs = new String[100]
  _toggleCount = 0
endFunction

function SetupToggle(String identifier, String name, bool initialState, int tag = 0)
  if _toggleCount < _toggles.Length
    _toggles[_toggleCount] = AddToggleOption(name, initialState)
    _toggleValues[_toggleCount] = initialState
    _toggleIDs[_toggleCount] = identifier
    _toggleTags[_toggleCount] = tag
    _toggleCount += 1
  endif
endFunction

Bool function UpdateStandardToggle(String identifier, bool value, int tag)
  if identifier == "Debugging"
    rQuest.pDebugMode = value
    return true
  endif

  return false
endFunction


int[] _menus
int[] _menuValues
int[] _menuTags
String[] _menuIDs
int _menuCount = 0

function ResetMenus()
  _menus = new int[100]
  _menuValues = new int[100]
  _menuTags = new int[100]
  _menuIDs = new String[100]
  _menuCount = 0
endFunction

function SetupMenu(String identifier, String name, String[] values, int initial, int tag = 0)
  if _menuCount < _menus.Length
    _menus[_menuCount] = AddMenuOption(name, values[initial])
    _menuValues[_menuCount] = initial
    _menuIDs[_menuCount] = identifier
    _menuTags[_menuCount] = tag
    _menuCount += 1
  endif
endFunction
