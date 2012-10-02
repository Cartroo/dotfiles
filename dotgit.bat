@echo off
set GITHOME=%HOMEDRIVE%%HOMEPATH%
if exist %GITHOME% (
    git --git-dir=%GITHOME%\.config.git --work-tree=%GITHOME% %*
)

