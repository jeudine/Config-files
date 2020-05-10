Config {
    font = "xft:Firacode-Medium  Mono:size=14:antialias=true"
       , additionalFonts = []
       , borderColor = "#263238"
       , border = TopB
       , bgColor = "#263238"
       , fgColor = "#eceff1"
       , alpha = 255
       , position = Top
       , textOffset = -1
       , iconOffset = -1
       , lowerOnStart = True
       , pickBroadest = False
       , persistent = False
       , hideOnStart = False
       , iconRoot = "."
       , allDesktops = True
       , overrideRedirect = True
       , commands = [ Run DynNetwork     [ "--template" , "<dev>: <tx>kB/s|<rx>kB/s"
                                         , "--Low"      , "1000"       -- units: B/s
                                         , "--High"     , "5000"       -- units: B/s
                                         , "--low"      , "#8bc34a"
                                         , "--normal"   , "#ffc107"
                                         , "--high"     , "#ad1457"
                                         ] 10
                    , Run MultiCpu       [ "--template" , "Cpu: <total>%"
                                         , "--Low"      , "50"
                                         , "--High"     , "85"
                                         , "--low"      , "#8bc34a"
                                         , "--normal"   , "#ffc107"
                                         , "--high"     , "#ad1457"
                                         ] 10
                    , Run Memory         [ "--template" ,"Mem: <usedratio>%"
                                         , "--Low"      , "20"
                                         , "--High"     , "90"
                                         , "--low"      , "#8bc34a"
                                         , "--normal"   , "#ffc107"
                                         , "--high"     , "#ad1457"
                                         ] 10
                    , Run Date "%a %b %_d, %H:%M:%S" "date" 10
                    , Run Battery        [ "--template" , "Batt: <acstatus>"
                                         , "--Low"      , "15"
                                         , "--High"     , "80"
                                         , "--low"      , "#ad1457"
                                         , "--normal"   , "#ffc107"
                                         , "--high"     , "#8bc34a"
                                         , "--"
                                         , "-o"	, "<left>% (<timeleft>)"
                                         , "-O"	, "<fc=#ffc107>Charging</fc>"
                                         , "-i"	, "<fc=#8bc34a>Charged</fc>"
                                         ] 50
                                         , Run StdinReader
                    ]
                                         , sepChar = "%"
                                         , alignSep = "}{"
                                         , template = "%StdinReader% }\
                                             \{ %multicpu% | %memory% | %dynnetwork% | <fc=#ffc107>%date%</fc> | %battery% " }
