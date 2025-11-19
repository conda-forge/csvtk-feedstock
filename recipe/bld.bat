cd csvtk
go build -buildmode=pie -trimpath -o="%LIBRARY_BIN%\csvtk.exe" -ldflags="-s -w -X main.Version=%PKG_VERSION%" || goto :error
go-licenses save . --save_path=license-files  --ignore github.com/ajstarks/svgo --ignore github.com/golang/freetype/raster || goto :error


REM Create a copy named tsvtk.
REM When invoked as "tsvtk", csvtk will automatically enable the "-t/--tabs" flag.
copy /Y "%LIBRARY_BIN%\csvtk.exe" "%LIBRARY_BIN%\tsvtk.exe"

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit 1
