{==============================================================================
 ___  ___  ___  __  __  _ ™
| _ \/ __|| __||  \/  || |
|  _/\__ \| _| | |\/| || |__
|_|  |___/|_|  |_|  |_||____|
       SFML for Pascal

Copyright © 2024-present tinyBigGAMES™ LLC
All Rights Reserved.

Website: https://tinybiggames.com
Email  : support@tinybiggames.com
License: BSD 3-Clause

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
   this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

This product uses the following open-source libraries:

* CSFML   - https://github.com/SFML/CSFML
* minizip - https://github.com/madler/zlib/contrib/minizip
* pl_mpeg - https://github.com/phoboslab/pl_mpeg
==============================================================================}

unit URenderWindow01;

interface

procedure RunExample();

implementation

uses
  SysUtils,
  PSFML,
  UCommon;

procedure RunExample();
var
  LWindow: PsfRenderWindow;
  LMode: sfVideoMode;
  LSettings: sfContextSettings;
  LEvent: sfEvent;
  LFont: array[0..0] of PsfFont;
  LText: array[0..0] of PsfText;
  LHudPos: sfVector2f;
begin
  LMode.size.x := 1920 div 2;
  LMode.size.y := 1080 div 2;
  LMode.bitsPerPixel := 32;

  LSettings := Default(sfContextSettings);
  LSettings.depthBits := 24;
  LSettings.stencilBits := 8;
  LSettings.antialiasingLevel := 8; // Set anti-aliasing level
  LSettings.majorVersion := 2; // OpenGL major version
  LSettings.minorVersion := 1; // OpenGL minor version

  LWindow := sfRenderWindow_Create(LMode, 'PSFML: RenderWindow #01', sfClose, sfWindowed, @LSettings);
  sfRenderWindow_ScaleToDPI(LWindow, LMode.size.x, LMode.size.y, True);
  sfRenderWindow_SetFramerateLimit(LWindow, CFrameRate);
  sfRenderWindow_setVerticalSyncEnabled(LWindow, False);

  LFont[0] := sfFont_CreateDefaultFont();
  sfFont_SetSmooth(LFont[0], True);

  LText[0] := sfText_Create(LFont[0]);
  sfText_SetCharacterSizeDPI(LWindow, LText[0], 12);

  while sfRenderWindow_isOpen(LWindow) do
  begin
    while sfRenderWindow_pollEvent(LWindow, @LEvent) do
    begin
      case LEvent.&type of
        sfEvtClosed:
        begin
          sfRenderWindow_close(LWindow);
        end;

        sfEvtKeyReleased:
        begin
          case LEvent.key.code of
            sfKeyEscape:
            begin
              sfRenderWindow_close(LWindow);
            end;
          end;
        end;
      end;
    end;

    sfRenderWindow_ScaleOnDPIChange(LWindow);

    sfRenderWindow_Clear(LWindow, DARKSLATEBROWN);

    LHudPos := sfVector2f_Create(3, 3);
    sfRenderWindow_DrawTextXVarY(LWindow, LText[0], LHudPos.x, LHudPos.y, WHITE, '%d fps', [sfRenderWindow_GetFrameRate(LWindow)]);
    sfRenderWindow_DrawTextXVarY(LWindow, LText[0], LHudPos.x, LHudPos.y, DARKGREEN, 'ESC - Quit', []);

    sfRenderWindow_Display(LWindow);
  end;

  sfText_Destroy(LText[0]);
  sfFont_Destroy(LFont[0]);

  sfRenderWindow_Destroy(LWindow);
end;

end.
