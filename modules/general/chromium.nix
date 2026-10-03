{
  inputs,
  ...
}:
{
  flake.homeModules."chromium" =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      options.stylix.targets.chromium-webapps.enable =
        config.lib.stylix.mkEnableTarget "omniri-Noctalia" true;

      imports = [
        inputs.chromium-webapps.homeManagerModules.default
      ];

      config = {
        programs.chromium-webapps =
          lib.mkIf (config.stylix.enable && config.stylix.targets.chromium-webapps.enable)
            {
              enable = true;
              webApps = [
                {
                  name = "Mail";
                  url = "https://mail.proton.me";
                  icon = pkgs.writeText "mail.svg" ''
                    <svg width="2239" height="2064" viewBox="0 0 2239 2064" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M1383.38 799.476V1404.46H1483.66C1536.1 1404.46 1578.6 1361.37 1578.6 1308.32V680.947C1578.6 662.822 1557.77 652.952 1543.98 664.53L1383.38 799.476Z" fill="url(#paint0_linear_11864_192570)"/>
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M1243.5 917.151L1060.28 1081.04C1029.04 1108.94 982.419 1109.61 950.429 1082.65L660.453 838.574V681.042C660.453 662.917 681.28 652.952 695.07 664.53L1058.88 970.294C1094.06 999.902 1145.09 999.902 1180.27 970.294L1243.5 917.151Z" fill="url(#paint1_linear_11864_192570)"/>
                    <path d="M1383.38 799.571L1243.5 917.151L1243.59 917.15L1060.28 1081.04C1029.04 1108.94 982.419 1109.61 950.429 1082.65L660.453 838.574V1308.32C660.453 1361.37 702.95 1404.46 755.392 1404.46L1383.38 1404.46V799.571Z" fill="url(#paint2_radial_11864_192570)"/>
                    <defs>
                    <linearGradient id="paint0_linear_11864_192570" x1="2964.27" y1="1887.39" x2="2776.52" y2="23.7349" gradientUnits="userSpaceOnUse">
                    <stop offset="0.271" stop-color="#E3D9FF"/>
                    <stop offset="1" stop-color="#7341FF"/>
                    </linearGradient>
                    <linearGradient id="paint1_linear_11864_192570" x1="1202.98" y1="1411.37" x2="821.155" y2="-96.4539" gradientUnits="userSpaceOnUse">
                    <stop stop-color="#E3D9FF"/>
                    <stop offset="1" stop-color="#7341FF"/>
                    </linearGradient>
                    <radialGradient id="paint2_radial_11864_192570" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1574.6 750.728) scale(1070.72 1083.11)">
                    <stop offset="0.5561" stop-color="#6D4AFF"/>
                    <stop offset="0.9944" stop-color="#AA8EFF"/>
                    </radialGradient>
                    </defs>
                    </svg>
                  '';
                  appDataDir = false;
                }
                {
                  name = "FMD Server";
                  url = "https://server.fmd-foss.org/";
                  icon = pkgs.writeText "FMD.svg" ''
                    <?xml version="1.0" encoding="UTF-8" standalone="no"?>
                    <svg
                       width="868"
                       height="868"
                       viewBox="0 0 1024 1024"
                       fill="none"
                       version="1.1"
                       id="svg11"
                       sodipodi:docname="icon.svg"
                       inkscape:version="1.4.4 (dcaf3e7d9e, 2026-05-05)"
                       xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
                       xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
                       xmlns="http://www.w3.org/2000/svg"
                       xmlns:svg="http://www.w3.org/2000/svg">
                      <sodipodi:namedview
                         id="namedview11"
                         pagecolor="#505050"
                         bordercolor="#ffffff"
                         borderopacity="1"
                         inkscape:showpageshadow="0"
                         inkscape:pageopacity="0"
                         inkscape:pagecheckerboard="1"
                         inkscape:deskcolor="#505050"
                         inkscape:zoom="0.95967742"
                         inkscape:cx="433.47899"
                         inkscape:cy="434"
                         inkscape:window-width="1920"
                         inkscape:window-height="1046"
                         inkscape:window-x="0"
                         inkscape:window-y="0"
                         inkscape:window-maximized="1"
                         inkscape:current-layer="svg11" />
                      <circle
                         cx="512"
                         cy="512"
                         r="410"
                         fill="url(#paint0_linear_18_2)"
                         id="circle1"
                         style="fill:url(#paint0_linear_18_2);filter:url(#filter0_d_18_2)"
                         transform="matrix(1.1799068,0,0,1.1795591,-92.03273,-106.16032)" />
                      <circle
                         cx="512"
                         cy="512"
                         r="402"
                         stroke="url(#paint1_radial_18_2)"
                         stroke-opacity="0.5"
                         stroke-width="16"
                         id="circle2"
                         style="display:none;stroke:url(#paint1_radial_18_2);filter:url(#filter0_d_18_2)"
                         transform="matrix(1.1799068,0,0,1.1795591,-92.03273,-106.16032)"
                         sodipodi:insensitive="true" />
                      <path
                         d="m 657.25024,503.81509 c 6.28193,3.64212 6.28193,12.7438 0,16.38472 L 376.31232,683.02768 c -6.28193,3.64092 -14.13524,-0.90934 -14.13524,-8.19236 V 349.17959 c 0,-7.16832 7.60947,-11.69138 13.83958,-8.35791 l 0.29566,0.16554 z"
                         fill="url(#paint2_linear_18_2)"
                         stroke="url(#paint3_linear_18_2)"
                         stroke-width="9.44172"
                         stroke-linejoin="round"
                         id="path2"
                         style="fill:url(#paint2_linear_18_2);stroke:url(#paint3_linear_18_2)" />
                      <defs
                         id="defs11">
                        <filter
                           id="filter0_d_18_2"
                           x="78"
                           y="90"
                           width="868"
                           height="868"
                           filterUnits="userSpaceOnUse"
                           color-interpolation-filters="sRGB">
                          <feFlood
                             flood-opacity="0"
                             result="BackgroundImageFix"
                             id="feFlood2" />
                          <feColorMatrix
                             in="SourceAlpha"
                             type="matrix"
                             values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                             result="hardAlpha"
                             id="feColorMatrix2" />
                          <feOffset
                             dy="12"
                             id="feOffset2" />
                          <feGaussianBlur
                             stdDeviation="12"
                             id="feGaussianBlur2" />
                          <feComposite
                             in2="hardAlpha"
                             operator="out"
                             id="feComposite2" />
                          <feColorMatrix
                             type="matrix"
                             values="0 0 0 0 0.866667 0 0 0 0 0.141176 0 0 0 0 0.462745 0 0 0 0.4 0"
                             id="feColorMatrix3" />
                          <feBlend
                             mode="normal"
                             in2="BackgroundImageFix"
                             result="effect1_dropShadow_18_2"
                             id="feBlend3" />
                          <feBlend
                             mode="normal"
                             in="SourceGraphic"
                             in2="effect1_dropShadow_18_2"
                             result="shape"
                             id="feBlend4" />
                        </filter>
                        <linearGradient
                           id="paint0_linear_18_2"
                           x1="102"
                           y1="102"
                           x2="922"
                           y2="922"
                           gradientUnits="userSpaceOnUse">
                          <stop
                             stop-color="#FF632F"
                             id="stop4"
                             offset="0"
                             style="stop-color:#2fc4ff;stop-opacity:1;" />
                          <stop
                             offset="1"
                             stop-color="#DC148C"
                             id="stop5"
                             style="stop-color:#ea1cc3;stop-opacity:1;" />
                        </linearGradient>
                        <radialGradient
                           id="paint1_radial_18_2"
                           cx="0"
                           cy="0"
                           r="1"
                           gradientUnits="userSpaceOnUse"
                           gradientTransform="matrix(410.00031,410.00031,-410.00031,410.00031,512,512)">
                          <stop
                             offset="0.68"
                             stop-color="white"
                             stop-opacity="0"
                             id="stop6" />
                          <stop
                             offset="0.72"
                             stop-color="white"
                             id="stop7" />
                        </radialGradient>
                        <linearGradient
                           id="paint2_linear_18_2"
                           x1="512"
                           y1="329"
                           x2="512"
                           y2="695"
                           gradientUnits="userSpaceOnUse"
                           gradientTransform="matrix(1.1779368,0,0,1.1824998,-137.85707,-93.432445)">
                          <stop
                             stop-color="white"
                             id="stop8" />
                          <stop
                             offset="1"
                             stop-color="white"
                             stop-opacity="0.4"
                             id="stop9" />
                        </linearGradient>
                        <linearGradient
                           id="paint3_linear_18_2"
                           x1="512"
                           y1="329"
                           x2="512"
                           y2="695"
                           gradientUnits="userSpaceOnUse"
                           gradientTransform="matrix(1.1779368,0,0,1.1824998,-137.85707,-93.432445)">
                          <stop
                             stop-color="white"
                             stop-opacity="0"
                             id="stop10" />
                          <stop
                             offset="1"
                             stop-color="white"
                             stop-opacity="0.5"
                             id="stop11" />
                        </linearGradient>
                      </defs>
                    </svg>
                  '';
                  appDataDir = false;
                }
                {
                  name = "Cash App";
                  url = "https://cash.app/account";
                  icon = pkgs.writeText "cash-app.svg" ''
                    <?xml version="1.0" encoding="UTF-8" standalone="no"?>
                    <svg
                       height="800"
                       width="800"
                       class="app-icon"
                       viewBox="-9.6 -16 83.2 96"
                       version="1.1"
                       id="svg3"
                       sodipodi:docname="cash-app.svg"
                       inkscape:version="1.4.4 (dcaf3e7d9e, 2026-05-05)"
                       xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
                       xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
                       xmlns="http://www.w3.org/2000/svg"
                       xmlns:svg="http://www.w3.org/2000/svg">
                      <sodipodi:namedview
                         id="namedview3"
                         pagecolor="#505050"
                         bordercolor="#ffffff"
                         borderopacity="1"
                         inkscape:showpageshadow="0"
                         inkscape:pageopacity="0"
                         inkscape:pagecheckerboard="1"
                         inkscape:deskcolor="#505050"
                         inkscape:zoom="1.04125"
                         inkscape:cx="400"
                         inkscape:cy="400"
                         inkscape:window-width="1602"
                         inkscape:window-height="1014"
                         inkscape:window-x="0"
                         inkscape:window-y="0"
                         inkscape:window-maximized="0"
                         inkscape:current-layer="svg3" />
                      <defs
                         id="defs2">
                        <linearGradient
                           id="grad1"
                           x1="0"
                           x2="64"
                           y1="0"
                           y2="0"
                           gradientUnits="userSpaceOnUse">
                          <stop
                             offset="0%"
                             stop-color="${config.lib.stylix.colors.withHashtag.base03}"
                             id="stop1" />
                          <stop
                             offset="100%"
                             stop-color="${config.lib.stylix.colors.withHashtag.base02}"
                             id="stop2" />
                        </linearGradient>
                      </defs>
                      <g
                         fill="#ffffff"
                         id="g3"
                         transform="matrix(1.3749994,0,0,1.3749994,-12.00004,-12.00004)">
                        <path
                           fill="url(#grad1)"
                           d="m 41.7,0 c 6.4,0 9.6,0 13.1,1.1 a 13.6,13.6 0 0 1 8.1,8.1 C 64,12.7 64,15.9 64,22.31 v 19.37 c 0,6.42 0,9.64 -1.1,13.1 a 13.6,13.6 0 0 1 -8.1,8.1 C 51.3,64 48.1,64 41.7,64 H 22.3 C 15.88,64 12.66,64 9.2,62.9 A 13.6,13.6 0 0 1 1.1,54.8 C 0,51.3 0,48.1 0,41.69 V 22.3 C 0,15.88 0,12.66 1.1,9.2 A 13.6,13.6 0 0 1 9.2,1.1 C 12.7,0 15.9,0 22.3,0 Z"
                           id="path2"
                           style="fill:url(#grad1)" />
                        <path
                           d="m 42.47,23.8 c 0.5,0.5 1.33,0.5 1.8,0 l 2.5,-2.6 c 0.53,-0.5 0.5,-1.4 -0.06,-1.94 a 19.73,19.73 0 0 0 -6.72,-3.84 l 0.79,-3.8 c 0.17,-0.83 -0.45,-1.61 -1.28,-1.61 h -4.84 a 1.32,1.32 0 0 0 -1.28,1.06 l -0.7,3.38 c -6.44,0.33 -11.9,3.6 -11.9,10.3 0,5.8 4.51,8.29 9.28,10 4.51,1.72 6.9,2.36 6.9,4.78 0,2.49 -2.38,3.95 -5.9,3.95 -3.2,0 -6.56,-1.07 -9.16,-3.68 a 1.3,1.3 0 0 0 -1.84,0 l -2.7,2.7 a 1.36,1.36 0 0 0 0,1.92 c 2.1,2.07 4.76,3.57 7.792,4.4 l -0.74,3.57 c -0.17,0.83 0.44,1.6 1.27,1.61 l 4.85,0.04 a 1.32,1.32 0 0 0 1.3,-1.06 l 0.7,-3.39 C 40.28,49.07 45,44.8 45,38.57 45,32.83 40.3,30.41 34.6,28.44 31.34,27.23 28.52,26.4 28.52,23.91 c 0,-2.42 2.63,-3.38 5.27,-3.38 3.36,0 6.59,1.39 8.7,3.29 z"
                           id="path3" />
                      </g>
                    </svg>

                  '';
                  appDataDir = false;
                }
                {
                  name = "Github";
                  url = "https://github.com";
                  icon = pkgs.writeText "Github.svg" ''
                    <?xml version="1.0" encoding="UTF-8" standalone="no"?>
                    <svg
                       width="800"
                       height="800"
                       viewBox="0 0 128 128"
                       fill="none"
                       version="1.1"
                       id="svg2"
                       sodipodi:docname="Github.svg"
                       inkscape:version="1.4.4 (dcaf3e7d9e, 2026-05-05)"
                       xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
                       xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
                       xmlns="http://www.w3.org/2000/svg"
                       xmlns:svg="http://www.w3.org/2000/svg">
                      <sodipodi:namedview
                         id="namedview2"
                         pagecolor="#505050"
                         bordercolor="#ffffff"
                         borderopacity="1"
                         inkscape:showpageshadow="0"
                         inkscape:pageopacity="0"
                         inkscape:pagecheckerboard="1"
                         inkscape:deskcolor="#505050"
                         inkscape:zoom="1.04125"
                         inkscape:cx="361.10444"
                         inkscape:cy="429.77191"
                         inkscape:window-width="1507"
                         inkscape:window-height="1014"
                         inkscape:window-x="0"
                         inkscape:window-y="0"
                         inkscape:window-maximized="0"
                         inkscape:current-layer="svg2" />
                      <defs
                         id="defs2">
                        <linearGradient
                           id="grad1"
                           x1="15.943896"
                           x2="110.42624"
                           y1="17.273068"
                           y2="17.273068"
                           gradientTransform="matrix(1.1854066,0,0,1.1515379,-10.900001,-10.290591)"
                           gradientUnits="userSpaceOnUse">
                          <stop
                             offset="0%"
                             stop-color="${config.lib.stylix.colors.withHashtag.base03}"
                             id="stop1" />
                          <stop
                             offset="100%"
                             stop-color="${config.lib.stylix.colors.withHashtag.base02}"
                             id="stop2" />
                        </linearGradient>
                      </defs>
                      <path
                         d="M 55.359317,89.125862 C 40.921817,87.370809 30.75,76.950128 30.75,63.458222 c 0,-5.484537 1.96875,-11.407838 5.25,-15.356706 -1.421933,-3.619854 -1.203183,-11.298207 0.4375,-14.479181 4.375,-0.548512 10.28125,1.755052 13.78125,4.936027 4.15625,-1.31629 8.53125,-1.974434 13.890567,-1.974434 5.359433,0 9.734433,0.658144 13.671933,1.864801 3.390567,-3.071342 9.40625,-5.374906 13.78125,-4.826394 1.53125,2.961593 1.75,10.639946 0.328067,14.369432 3.5,4.168249 5.359433,9.762536 5.359433,15.466455 0,13.491906 -10.171933,23.693206 -24.828183,25.55789 3.71875,2.413197 6.234433,7.678353 6.234433,13.711398 v 11.40808 c 0,3.29014 2.734317,5.15518 6.015567,3.83889 C 104.46875,110.40552 120,90.551783 120,65.981051 120,34.938624 94.84375,9.6 63.890567,9.6 32.9375,9.6 8,34.938507 8,65.981051 8,90.332401 23.421817,110.5155 44.203067,118.08446 47.15625,119.18078 50,117.20693 50,114.24557 v -8.77584 c -1.53125,0.65814 -3.5,1.0969 -5.25,1.0969 -7.21875,0 -11.484433,-3.94886 -14.546933,-11.298087 C 29,92.306835 27.6875,90.551783 25.171817,90.222769 c -1.3125,-0.10975 -1.75,-0.658144 -1.75,-1.316289 0,-1.316289 2.1875,-2.303565 4.375,-2.303565 3.171933,0 5.90625,1.974434 8.75,6.033051 2.1875,3.180973 4.484433,4.607011 7.21875,4.607011 2.734433,0 4.484433,-0.987275 7,-3.510103 1.859433,-1.864802 3.28125,-3.510105 4.59375,-4.607012 z"
                         fill="url(#grad1)"
                         id="path2"
                         style="fill:url(#grad1);stroke-width:1.16835" />
                    </svg>

                  '';
                  appDataDir = false;
                }
              ];

              package = pkgs.ungoogled-chromium;
            };
      };

    };
}
