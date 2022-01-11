@echo off

echo "STEP: Compile Arma Scripts"
.\ArmaScriptCompiler.exe

echo "STEP: Build using HEMTT"
hemtt build --release

echo "STEP: Cleanup *.sqfc files"
powershell -Command Remove-Item './addons/*' -Recurse -Include *.sqfc
