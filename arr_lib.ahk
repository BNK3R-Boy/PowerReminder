;------------------------------------------------------------------------------------------------------------------------------------
;Function:    Arr_Dim
;Parameters:  Array = Enter the variable you want to use as an array
;             Index = Comma separated list of indexes, the array should have
;             Optional:
;             Value = The starting value for all indexes
;Description: Puts all indexes inside a variable
;Returnvalue: None
;------------------------------------------------------------------------------------------------------------------------------------
Arr_Dim(ByRef Array,Index,Value="") {
  ;Create each element with set value
  Loop, Parse, Index, `,
    ;Only add if index doesn't exist
    If (Arr_IndexExist(Array,Index) = 0)
      Array .= A_LoopField . "=" . Arr_ValConvert(Value) . "|"
  ;Omit the closing separator
  Array := SubStr(Array,1,StrLen(Array) - 1)
}

;------------------------------------------------------------------------------------------------------------------------------------
;Function:    Arr_Add
;Parameters:  Array = Enter the array's variable
;             Index = The index to append to the array
;             Optional:
;             Value = The index's starting value
;Description: Puts all indexes inside a variable
;------------------------------------------------------------------------------------------------------------------------------------
Arr_Add(ByRef Array,Index,Value="") {
  ;Only add if index doesn't exist
  If (Arr_IndexExist(Array,Index) <> 0 || Index = "")
    Return 0 ;element exists, return false
  ;Only add leading separator if other elements exist
  Sep1 := (Array <> "") ? "|" : ""
  ;Append the Index to array
  Array .= Sep1 . Index . "=" . Arr_ValConvert(Value)
}

;------------------------------------------------------------------------------------------------------------------------------------
;Function:    Arr_Len
;Parameters:  Array = Enter the array's variable
;Description: Retrieves the count of all indexes inside the array
;------------------------------------------------------------------------------------------------------------------------------------
Arr_Len(ByRef Array) {
  ;Replace all separators
  RegExReplace(Array,"\|","",Length)
  ;Return the count of replaced separators
  Return Length + 1
}

;------------------------------------------------------------------------------------------------------------------------------------
;Function:    Arr_Display
;Parameters:  Array = Enter the array's variable
;             Gui   = Gui number that should be used for the window
;Description: Creates a window that contains the name's and values of all indexes
;------------------------------------------------------------------------------------------------------------------------------------
Arr_Display(ByRef Array,Gui=99) {
  Gui, %Gui%:Default
  Gui, Destroy
  Gui, +ToolWindow +LabelArr_

    Gui, Add, ListView, x0 y0 w285 h400 -Multi +AltSubmit +Grid gArr_GetSelected, Index|Value
    Loop, Parse, Array, |
      V := A_LoopField,P := InStr(V,"="),LV_Add("","[" . SubStr(V,1,P - 1) . "]",Arr_ValConvert(SubStr(V,P + 1,StrLen(V) - 1),1))

    Gui, Add, Button, x5 y405 w275 h20 gArr_CopySelected, Copy selected

  Gui, Show, w285 h430, Array Contents
  While (Arr_DisplayExist <> 0)
    Sleep, 1
  Return

  Arr_GetSelected:
    If (A_GuiEvent = "I")
      LV_GetText(Arr_RowVal,A_EventInfo,2)
    Return

  Arr_CopySelected:
    Clipboard := Arr_RowVal
    Return

  Arr_Close:
    Arr_DisplayExist := 0
    Gui, Destroy
    Return
}

;------------------------------------------------------------------------------------------------------------------------------------
;Function:    Arr_Get
;Parameters:  Array = Enter the array's variable
;             Index = The index whose value you want to retrieve
;Description: Retrieves the value of a specified index
;------------------------------------------------------------------------------------------------------------------------------------
Arr_Get(ByRef Array,Index) {
  ;If specified Index doesn't exist return error
  If (Arr_IndexExist(Array,Index) = 0 || Index = "")
    Return "" ;Return nothing
  ;If only one existant index, directly return it
  If (Arr_Len(Array) = 1)
    Return Arr_ValConvert(SubStr(Array,InStr(Array,"=") + 1,StrLen(Array)),1)
  ;Find position of Index and it's closing separator
  Pos := Arr_IndexExist(Array,Index),Pos := (Pos = 1) ? Pos + StrLen(Index) + 1 : Pos + StrLen(Index) + 2
  Size := InStr(Array,"|",0,Pos) - Pos
  ;Use string length as size, if it's last element
  Size := (Size < 0) ? StrLen(Array) : Size
  ;Return the index's value
  Return Arr_ValConvert(SubStr(Array,Pos,Size),1)
}

;------------------------------------------------------------------------------------------------------------------------------------
;Function:    Arr_GetMin
;Parameters:  Array = Enter the array's variable
;             Optional:
;             Mode  = Specify "Value" to retrieve lowest value, returns index where the lowest value occures otherwise
;Description: Checks the array for the lowest numerical value
;Returnvalue: None - No numerical value found
;------------------------------------------------------------------------------------------------------------------------------------
Arr_GetMin(ByRef Array,Mode="Value") {
  ;Parse through array elements
  Loop, Parse, Array, |
    ;If it's the first element, or if it's constant are lower than previous
    If (A_Index = 1 || SubStr(A_LoopField,InStr(A_LoopField,"=") + 1,StrLen(A_LoopField)) < Val) {
      ;Split the value from the string
      Val := SubStr(A_LoopField,InStr(A_LoopField,"=") + 1,StrLen(A_LoopField))
      ;If it's a numerical value
      If (Arr_ValType(Val,"Integer") = 1 || Arr_ValType(Val,"Float") = 1) {
        ;Check if value or index should be kept
        Out := (Mode = "Value") ? Val : A_Index
        ;Break if it's a null (this way it won't loop useless elements and returns first null
        If (Val = 0)
          Break
      }
    }
  ;Return the value
  Return Out
}

;------------------------------------------------------------------------------------------------------------------------------------
;Function:    Arr_GetMax
;Parameters:  Array = Enter the array's variable
;             Optional:
;             Mode  = Specify "Value" to retrieve highest value, returns index where the highest value occures otherwise
;Description: Checks the array for the highest numerical value
;Returnvalue: None - Nonnumerical value found
;------------------------------------------------------------------------------------------------------------------------------------
Arr_GetMax(ByRef Array,Mode="Value") {
  ;Parse through array elements
  Loop, Parse, Array, |
    ;If it's the first element, or if it's constant are lower than previous
    If (A_Index = 1 || SubStr(A_LoopField,InStr(A_LoopField,"=") + 1,StrLen(A_LoopField)) > Val) {
      ;Split the value from the string
      Val := SubStr(A_LoopField,InStr(A_LoopField,"=") + 1,StrLen(A_LoopField))
      ;If it's a numerical value
      If (Arr_ValType(Val,"Integer") = 1 || Arr_ValType(Val,"Float") = 1)
        ;Check if value or index should be kept
        Out := (Mode = "Value") ? Val : A_Index
    }
  ;Return the value
  Return Out
}

;------------------------------------------------------------------------------------------------------------------------------------
;Function:    Arr_Out
;Parameters:  Array     = Enter the array's variable
;             Prefix    = String that should be appended before the index's value
;             Delimiter = The index's value separator
;Description: Retrieves the values of all indexes
;------------------------------------------------------------------------------------------------------------------------------------
Arr_Out(ByRef Array,Prefix="",Delimiter="`n") {
  ;Loop through all entries
  Loop, Parse, Array, |
    ;Save the converted entry into the output list, also append the prefix and delimiter
    Out .= Prefix . Arr_ValConvert(SubStr(A_LoopField,InStr(A_LoopField,"=") + 1,StrLen(A_LoopField) - 1),1) . Delimiter
  ;Return all values
  Return SubStr(Out,1,StrLen(Out) - StrLen(Delimiter))
}

;------------------------------------------------------------------------------------------------------------------------------------
;Function:    Arr_Set
;Parameters:  Array = Enter the array's variable
;             Index = The index whose value you want to alter
;             Optional:
;             Value = The index's new value
;Description: Changes the value of the specified index
;------------------------------------------------------------------------------------------------------------------------------------
Arr_Set(ByRef Array,Index,Value="") {
  ;If specified Index doesn't exist return error
  If (Arr_IndexExist(Array,Index) = 0 || Index = "")
    Return "" ;Return nothing
  ;Check if should be appended to current value
  If (SubStr(Value,1,1) = "!")
    Value := Arr_Get(Array,Index) . SubStr(Value,2,StrLen(Value))
  ;Find position of Index and it's closing separator
  Pos := Arr_IndexExist(Array,Index),Pos := (Pos <> 1) ? Pos + 1 : Pos,Size := InStr(Array,"|",0,Pos)
  ;Only append separator and rest of string, if it's not the last element
  Str := (Size <> 0) ? "|" . SubStr(Array,Size + 1,StrLen(Array)) : ""
  ;Set the index's value
  Array := SubStr(Array,1,Pos - 1) . Index . "=" . Arr_ValConvert(Value) . Str
}

;------------------------------------------------------------------------------------------------------------------------------------
;Function:    Arr_Swap
;Parameters:  Array  = Enter the array's variable
;             Index1 = The Name of the first index
;             Index2 = The Name of the second index
;Description: Swaps the values of the specified indexes (Index1 = Index2, Index2 = Index1)
;------------------------------------------------------------------------------------------------------------------------------------
Arr_Swap(ByRef Array,Index1,Index2) {
  Value1 := Arr_Get(Array,Index1),Value2 := Arr_Get(Array,Index2)
  Arr_Set(Array,Index1,Value2),Arr_Set(Array,Index2,Value1)
}

;------------------------------------------------------------------------------------------------------------------------------------
;Function:    Arr_Del
;Parameters:  Array = Enter the array's variable
;             Index = The index to delete
;Description: Deletes an index from the array
;------------------------------------------------------------------------------------------------------------------------------------
Arr_Del(ByRef Array,Index) {
  ;If only one existant index, just clear the passed variable
  If (Arr_Len(Array) = 1 && Arr_IndexExist(Array,Index) <> 0)
    Return Array := ""
  ;Find position of Index and it's closing separator
  Pos := Arr_IndexExist(Array,Index),Pos := (Pos <> 1) ? Pos + 1 : Pos,Size := InStr(Array,"|",0,Pos)
  ;Only append rest of string, if it's not the last element
  Str := (Size <> 0) ? SubStr(Array,Size + 1,StrLen(Array)) : ""
  ;Delete separator if it's last element
  Pos := (Str = "") ? Pos - 1 : Pos
  ;Set the index's value
  Array := SubStr(Array,1,Pos - 1) . Str
}

;------------------------------------------------------------------------------------------------------------------------------------
;Internal
;------------------------------------------------------------------------------------------------------------------------------------
Arr_ValConvert(Input,Mode=0) {
  If (Mode = 0) {
    StringReplace, Output, Input, |, {D}, 1   ;Replace Delimiter
    StringReplace, Output, Output, `r, {R}, 1 ;Replace Carriage returns
    StringReplace, Output, Output, `n, {N}, 1 ;Replace Linefeeds
    StringReplace, Output, Output, =, {E}, 1  ;Replace equal sign
  } Else {
    StringReplace, Output, Input, {D}, |, 1   ;Change to Delimiter
    StringReplace, Output, Output, {R}, `r, 1 ;Change to Carriage returns
    StringReplace, Output, Output, {N}, `n, 1 ;Change to Linefeeds
    StringReplace, Output, Output, {E}, =, 1  ;Change to equal sign
  }
  Return Output
}

Arr_ValType(Input,Type="Digit") {
  If Input is %Type%
    Return 1
  Return 0
}

Arr_IndexExist(ByRef Array,Index) {
  ;If it's first entry; True
  If (SubStr(Array,1,StrLen(Index) + 1) = Index . "=")
    Return 1
  ;All other entries
  Return (InStr(Array,"|" . Index . "=") = 0) ? 0 : InStr(Array,"|" . Index . "=")
}