
; Utility Scripts
; Automatically copied from scorpio-utilities (https://github.com/scorpiosixnine/scorpio-utilities).

bool property pDebugMode auto

bool gIsLogOpen = false

function OpenLog()
  if !gIsLogOpen
    Debug.OpenUserLog(pName)
    gIsLogOpen = true
  endif
endfunction

function Log(String msg)
	Debug.Notification(msg)
endFunction

function Trace(String msg)
	if pDebugMode
    OpenLog()
  	Debug.TraceUser(pName, pName + ": " + msg)
	endif
endfunction

function Debug(String msg)
  if pDebugMode
    OpenLog()
		Debug.TraceUser(pName, pName + ": " + msg)
  endif
endFunction

function Warning(String msg)
  if pDebugMode
      Debug.Notification(pName + " warning: " + msg)
   else
    OpenLog()
    Debug.TraceUser(pName, pName + " warning: " + msg, 1)
  endif
endFunction

String function GetVersionString()
  return pMajorVersion + "." + pMinorVersion + "." + pPatchVersion
endFunction

String function GetFullVersionString()
  return pMajorVersion + "." + pMinorVersion + "." + pPatchVersion + " (" + pBuildNumber + ")"
endFunction
