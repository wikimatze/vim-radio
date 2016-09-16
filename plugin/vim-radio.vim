if !executable('mplayer')
    echoerr "mplayer is not installed!"
    finish
endif

command! -complete=customlist,Radios -nargs=1 Radio call GetRadioUrl('<args>')

function! Radios(A, L, P)
    return ['bill', 'hallo']
endfunction

function! GetRadioUrl(station)
    let stationAliases = ['bill', 'hallo']
    let result = index(stationAliases, a:station)
    if result != -1
        echo "Playing the radio station ". a:station
        call StartMplayer(a:station)
    else
        echo "Radio station has not been found"
    endif
endfunction

function! StartMplayer(station)
    let stations = { 'bill':'http://somafm.com/groovesalad.pls', 'hallo':2 }
    let url = get(stations, a:station)
    execute "! mplayer -quiet " . url
endfunction
