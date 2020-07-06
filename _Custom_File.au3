#AutoIt3Wrapper_Au3Check_Parameters=-d -w- 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include-once
#include "_Custom_String.au3"

; #FUNCTION# ====================================================================================================================
; Name ..........: _FileCacheTemp
; Description ...: Copies a file to @tempdir and returns the new address
; Syntax ........: _FileCacheTemp($sFile)
; Parameters ....: $sFile				- a string value. The file to cache
; Return values .: Success				- String: FQPN of the new file
;				   Failure				- Empty string and @error flag as follows:
;										1 - Source file not found
;										2 - File copy failed
; Author ........: Sam Coates
; ===============================================================================================================================
Func _FileCacheTemp($sFile)

	If FileExists($sFile) = 0 Then Return(SetError(-1, 0, "File doesn't exist."))

	Local $sRandom = String(Random(999,99999, 1))

	Local $sFileTemp = @TempDir & "\" & _FileToFileName($sFile, False) & "_" & $sRandom & "." & _FileToFileExtension($sFile)

	FileCopy($sFile, $sFileTemp)

	If @error Then Return(SetError(-2, 0, "Unable to copy file locally."))

	Return($sFileTemp)

EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _LogOnline
; Description ...: Updates a file according to a flag.
; Syntax ........: _LogOnline($sFile[, $bOnline = True])
; Parameters ....: $sFile               - a string value. The file to update
;                  $bOnline             - [optional] a boolean value. Default is True (online)
; Return values .: Success				1
;				   Failure				None
; Author ........: Sam Coates
; ===============================================================================================================================
Func _LogOnline($sFile, $bOnline = True)
	If $bOnline = True Then
		IniDelete($sFile, "Offline", @ComputerName & "." & @UserName)
		IniWrite($sFile, "Online", @ComputerName & "." & @UserName, _DateTimeGet(1, True) & " v" & FileGetVersion(@ScriptFullPath))
	Else
		IniDelete($sFile, "Online", @ComputerName & "." & @UserName)
		IniWrite($sFile, "Offline", @ComputerName & "." & @UserName, _DateTimeGet(1, True) & " v" & FileGetVersion(@ScriptFullPath))
	EndIf
	Return(1)
EndFunc   ;==>_LogOnline

