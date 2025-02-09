@ECHO OFF

CALL :Stage chapter-01-hellorust
CALL :Stage chapter-02-helloecs
CALL :Stage chapter-03-walkmap
CALL :Stage chapter-04-newmap
CALL :Stage chapter-05-fov
CALL :Stage chapter-06-monsters
CALL :Stage chapter-07-damage
CALL :Stage chapter-08-ui
CALL :Stage chapter-09-items
CALL :Stage chapter-10-ranged
CALL :Stage chapter-11-loadsave
CALL :Stage chapter-12-delvingdeeper
CALL :Stage chapter-13-difficulty
CALL :Stage chapter-14-gear
CALL :Stage chapter-16-nicewalls
CALL :Stage chapter-17-blood
CALL :Stage chapter-18-particles
CALL :Stage chapter-19-food
CALL :Stage chapter-20-magicmapping
CALL :Stage chapter-21-rexmenu
CALL :Stage chapter-22-simpletraps
CALL :Stage chapter-23-generic-map
CALL :Stage chapter-24-map-testing
CALL :Stage chapter-25-bsproom-dungeons
CALL :Stage chapter-26-bsp-interiors
CALL :Stage chapter-27-cellular-automota

REM Publish or perish
cd book\book\wasm
pscp -r * herbert@172.16.10.193:/var/www/bfnightly/rustbook/wasm
cd ..\..\..

EXIT /B 0

REM Usage: Stage Chapter
:Stage
cd %~1
cargo build --release --target wasm32-unknown-unknown
wasm-bindgen ..\target\wasm32-unknown-unknown\release\%~1.wasm --out-dir ../book/book/wasm/%~1 --no-modules --no-typescript
cd ..
move .\book\book\wasm\%~1\%~1.js .\book\book\wasm\%~1\myblob.js
move .\book\book\wasm\%~1\%~1_bg.wasm ./book/book/wasm/%~1/myblob_bg.wasm
copy index.html .\book\book\wasm\%~1
