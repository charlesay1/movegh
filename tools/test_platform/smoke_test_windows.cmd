@echo off
setlocal

set ROOT=%~dp0\..\..

echo Running MoveGH smoke tests...
cmd /c "node %ROOT%\tools\test_platform\smoke_test.js"

endlocal
