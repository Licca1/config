Config { overrideRedirect = False
       , font     = "Fira Code Nerd Font 11"
       , bgColor  = "#272822"
       , fgColor  = "#75715e"
       , position = TopSize L 100 24 
       , commands = [ 
                      Run Com "sh" ["-c", "~/.config/scripts/vpn.py"]   "vpn" 100
                    , Run Cpu
                        [
                          "-p", "3"
                        , "-L", "3"
                        , "-H", "50"
                        , "--high"  , "#f92672"
                        , "--normal", "#a6e22e"
                        , "-t", "<fn=1>\xf4bc</fn> <total>"
                        ] 10
                    , Run Wireless "wlan0" [ "-t", "<fn=1>\xf1eb</fn>  <essid>" ] 100
                    , Run Memory 
                        [
                          "-p", "3"
                        ,  "-L", "3"
                        , "-H", "50"
                        , "--high"  , "#f92672"
                        , "--normal", "#a6e22e"
                        ,"-t", "<fn=1>\xefc5</fn> <usedratio>"
                        ] 10
                    , Run Volume "default" "Master" [
                        "--template", "<status> "
                        , "--"
                        , "-o", "<fc=#f92672><volume> <fn=1>\xeee8</fn></fc>"
                        , "-O", "<fc=#a6e22e><volume> <fn=1>\xf028</fn></fc>"
                        ] 10
                    , Run Date "%a %d.%m.%Y <fc=#66d9ef>%H:%M</fc>" "date" 10
                    , Run XMonadLog
                    , Run Com "whoami" [] "" 0
                    , Run Com "hostnamectl" ["hostname"] "hostname" 0
                    , Run Kbd []
                    , Run BatteryN ["BAT0"] 
                        [ "--template", "<acstatus>"
                          , "--Low"      , "10"        -- units: %
                          , "--High"     , "65"        -- units: %
                          , "--low"      , "#f92672"
                          , "--normal"   , "#e2e22e"
                          , "--high"     , "#a6e22e"

                          , "--" -- battery specific options
                                 -- discharging status
                          , "-o"	, "<fn=1>\xf19e6</fn> <left>% (<timeleft>)"
                                 -- AC "on" status
                          , "-O"	, "<fn=1>\xf089f</fn> <left>%"
                                 -- charged status
                          , "-i"	, "<fn=1>\xf1211</fn> <left>%"
                        ] 50 "bat0"
                    , Run BatteryN ["BAT1"] 
                        [ "--template", "<acstatus>"
                          , "--Low"      , "10"        -- units: %
                          , "--High"     , "65"        -- units: %
                          , "--low"      , "#f92672"
                          , "--normal"   , "#e2e22e"
                          , "--high"     , "#a6e22e"

                          , "--" -- battery specific options
                                 -- discharging status
                          , "-o"	, "<fn=1>\xf19e6</fn> <left>% (<timeleft>)"
                                 -- AC "on" status
                          , "-O"	, "<fn=1>\xf089f</fn> <left>%"
                                 -- charged status
                          , "-i"	, "<fn=1>\xf1211</fn> <left>%"
                        ] 50 "bat1"
                    ]
       , sepChar  = "%"
       , alignSep = "}{"
      , template = "%XMonadLog% }{ %wlan0wi%::<fc=#66d9ef>%vpn%</fc>::%bat0% %bat1%::%cpu%::%memory%::%default:Master%::<fc=#ae81ff>%kbd%</fc>::%date% <fc=#a6e22e>%whoami%</fc>@<fc=#819aff>%hostname%</fc> "
       }
