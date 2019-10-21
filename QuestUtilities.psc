
; Utility Scripts
; Automatically copied from scorpio-utilities (https://github.com/scorpiosixnine/scorpio-utilities).

bool property pDebugMode auto

function Log(String msg)
	Debug.Notification(msg)
endFunction

function Trace(String msg)
  Debug.Trace(msg)
endfunction

function Debug(String msg)
  if pDebugMode
	   Debug.Notification("debug: " + msg)
   else
     Debug.Trace(msg)
  endif
endFunction

function Warning(String msg)
  if pDebugMode
      Debug.Notification("warning: " + msg)
   else
     Debug.Trace("warning: " + msg)
  endif
endFunction

String function GetVersionString()
  return pMajorVersion + "." + pMinorVersion + "." + pPatchVersion
endFunction

String function GetFullVersionString()
  return pMajorVersion + "." + pMinorVersion + "." + pPatchVersion + " (" + pBuildNumber + ")"
endFunction
