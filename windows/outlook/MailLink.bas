Attribute VB_Name = "MailLink"
' Copies a markdown link to the selected mail into the clipboard:
'   [Mail](outlook:<EntryID>)
' Clicking such a link opens the mail again, through the outlook: protocol
' handler that windows\deploy.ps1 -ImportRegistry registers.
' Import in Outlook: Alt+F11 > File > Import File. Keep the file in Windows-1252,
' the VBA editor does not read UTF-8.

Sub AddLinkToMessageInClipboard()
   Dim objMail As Outlook.MailItem
   Dim objShell As Object
   Dim strLink As String
   
   'Ein und NUR eine Nachricht muss ausgewählt sein
   If Application.ActiveExplorer.Selection.Count <> 1 Then
       MsgBox ("Wählen Sie eine und NUR eine Nachricht aus.")
       Exit Sub
   End If
   
   Set objMail = Application.ActiveExplorer.Selection.Item(1)
   
   ' Link für die Zwischenablage erstellen
   strLink = "[Mail](outlook:" & objMail.EntryID & ")"
   
   ' Verwenden Sie eine alternative Methode für die Zwischenablage
   Set objShell = CreateObject("WScript.Shell")
   
   ' Temporäre Datei erstellen
   Dim tempFile As String
   tempFile = Environ$("TEMP") & "\outlook_temp.txt"
   
   ' Text in Datei schreiben
   Open tempFile For Output As #1
   Print #1, strLink
   Close #1
   
   ' Datei öffnen, kopieren und schließen mit Clipbrd.exe
   objShell.Run "cmd /c type """ & tempFile & """ | clip", 0, True
   
   ' Temporäre Datei löschen
   Kill tempFile
   
   Set objShell = Nothing
   Set objMail = Nothing
   
   MsgBox "Link wurde in die Zwischenablage kopiert.", vbInformation
End Sub
