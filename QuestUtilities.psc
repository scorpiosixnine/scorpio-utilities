
; Utility Scripts
; Automatically copied from scorpio-utilities (https://github.com/scorpiosixnine/scorpio-utilities).

bool property pDebugMode auto

function Log(String msg)
	Debug.Notification(msg)
endFunction

function Trace(String msg)
	if pDebugMode
  	Debug.Trace(pName + ": " + msg)
	endif
endfunction

function Debug(String msg)
  if pDebugMode
		 Debug.Trace(pName + ": " + msg)
  endif
endFunction

function Warning(String msg)
  if pDebugMode
      Debug.Notification(pName + " warning: " + msg)
   else
     Debug.Trace(pName + " warning: " + msg)
  endif
endFunction

String function GetVersionString()
  return pMajorVersion + "." + pMinorVersion + "." + pPatchVersion
endFunction

String function GetFullVersionString()
  return pMajorVersion + "." + pMinorVersion + "." + pPatchVersion + " (" + pBuildNumber + ")"
endFunction
