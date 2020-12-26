Config { font = "xft:Firacode-Medium  Mono:size=14:antialias=true, FontAwesome:size=14:antialias=true"
       , additionalFonts = []
       , borderColor = "#FEFEF8"
       , border = TopB
       , bgColor = "#EBEBEB"
       , fgColor = "#292C3E"
       , alpha = 255
       , position = Top
       , textOffset = -1
       , iconOffset = -1
       , lowerOnStart = True
       , pickBroadest = True
       , persistent = False
       , hideOnStart = False
       , iconRoot = "."
       , allDesktops = True
       , overrideRedirect = True
       , commands = [ Run DynNetwork     [ "--template" , "<rx>kB/s  <tx>kB/s "
                                         , "--Low"      , "1000"       -- units: B/s
                                         , "--High"     , "1000000"       -- units: B/s
                                         , "--low"      , "#1BA6FA"
                                         , "--normal"   , "#8763B8"
                                         , "--high"     , "#FF301B" ] 10
                    , Run MultiCpu       [ "--template" , ": <total>%"
                                         , "--Low"      , "50"
                                         , "--High"     , "85"
                                         , "--low"      , "#1BA6FA"
                                         , "--normal"   , "#8763B8"
                                         , "--high"     , "#FF301B" ] 10
                    , Run Memory         [ "--template" ,": <usedratio>%"
                                         , "--Low"      , "20"
                                         , "--High"     , "90"
                                         , "--low"      , "#1BA6FA"
                                         , "--normal"   , "#8763B8"
                                         , "--high"     , "#FF301B" ] 10
                    , Run Date "%H:%M:%S" "date" 10
                    , Run Battery        [ "--template" , "<acstatus>"
                                         , "--Low"      , "15"
                                         , "--High"     , "80"
                                         , "--low"      , "#FF301B"
                                         , "--normal"   , "#8763B8"
                                         , "--high"     , "#1BA6FA"
                                         , "--"
                                         , "-L"         , "15"
                                         , "-H"         , "62"
                                         , "--highs"    , "<fc=#292C3E>: </fc>"
                                         , "--mediums"  , "<fc=#292C3E>: </fc>"
                                         , "--lows"     , "<fc=#292C3E>: </fc>"
                                         , "-o"         , "<left><fc=#292C3E>%</fc>"
                                         , "-O"         , "<fc=#292C3E>:</fc> <left><fc=#292C3E>%</fc>"
                                         , "-i"         , "<fc=#1BA6FA></fc>" ] 50
                    , Run StdinReader ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% } <fc=#292C3E>%date%</fc> { %multicpu% | %memory% | %dynnetwork% | %battery% "}
