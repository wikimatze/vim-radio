if !executable('mplayer')
    echoerr "mplayer is not installed!"
    finish
endif

command! -complete=customlist,Radios -nargs=1 Radio call GetRadioUrl('<args>')

function! Radios(A, L, P)
    if !exists('g:radio_stations')
        let g:radio_stations = {
            \ 'Streamingsoundtracks': 'http://www.streamingsoundtracks.com/modules/Listen/MP3-hi.pls',
            \ 'Groovesalad': 'http://somafm.com/groovesalad.pls',
            \ 'Dronezone': 'http://somafm.com/dronezone.pls',
            \ 'Cliqhop': 'http://somafm.com/cliqhop.pls',
            \ 'Beatblender': 'http://somafm.com/beatblender.pls',
            \ 'Tranceponder': 'http://ubuntu.hbr1.com:19800/trance.ogg',
            \ 'Dream Factory Ambient': 'http://ubuntu.hbr1.com:19800/ambient.ogg'
            \}
    endif
        return keys(g:radio_stations)
endfunction

function! GetRadioUrl(station)
    let result = index(keys(g:radio_stations), a:station)
    if result != -1
        echo "Playing the radio station ". a:station
        call StartMplayer(a:station)
    else
        echo "Radio station has not been found"
    endif
endfunction

function! StartMplayer(station)
    let url = get(g:radio_stations, a:station)
    execute "! mplayer -quiet " . url
endfunction
