{ 
	Pascal Console Snake Game 
	  (c) Maxim (Maxymex) EXARI - January 2015
}
uses crt;

const entity = 'лл';

var
  angle, snakeLength, i, eX, eY, score : integer;
  timer, delay : longint;
  snake : array[1..150] of string[2];
  x, y : array[1..150] of integer;
  gameRunning : boolean;
  key : char;
  delayF : text;

begin
  assign(delayF, 'delay.ini');
  reset(delayF);
  read(delayF, delay);

  clrscr;
  GoToXY(9,12);
  x[1] := 9;
  y[1] := 12;
  snakeLength := 4;
  snake[1] := entity;
  snake[2] := entity;
  snake[3] := entity;
  snake[4] := entity;
  angle := 0;

  randomize;
  eX := random(77) + 2;
  randomize;
  eY := random(22) + 2;
  GoToXY(eX , eY);
  textcolor(red);
  write(entity);
  gameRunning := true;

  while gameRunning do
    begin
      inc(timer);
      if keypressed then
        begin
          case readkey of
            'd': if (angle <> 0) and (angle <> 2) then
              angle := 0;
            's': if (angle <> 1) and (angle <> 3) then
              angle := 1;
            'a': if (angle <> 0) and (angle <> 2) then
              angle := 2;
            'w': if (angle <> 1) and (angle <> 3) then
              angle := 3;
          end;
        end;
      if timer >= delay then
        begin
          timer := 0;
          clrscr;

          if ((x[1] = eX) or (x[1] = eX - 1) or (x[1] = eX + 1)) and
             ((y[1] = eY) or (y[1] = eY - 1) or (y[1] = eY + 1)) then
            begin
              inc(score);
              inc(snakeLength);
              snake[snakeLength] := entity;
              x[snakeLength] := x[snakeLength - 1];
              y[snakeLength] := y[snakeLength - 1];
              GoToXY(x[snakeLength], y[snakeLength]);
              textcolor(green);
              write(snake[snakeLength]);
              randomize;
              eX := random(77) + 2;
              randomize;
              eY := random(22) + 2;
              GoToXY(eX, eY);
              textcolor(red);
              write(entity);
              GoToXY(80, 25);
            end;

          goToXY(eX, eY);
          textcolor(red);
          write(entity);

          for i := -snakelength to -2 do
            begin
              if (x[1] = x[-i]) and (y[1] = y[-i]) then
                begin
                  clrscr;
                  textcolor(8);
                  gameRunning := false;
                  GoToXY(30, 13);
                  write('Game Over! Score: ', score);
                  GoToXY(22, 14);
                  write('Press "R" to try again, or "X" to quit...');
                  GoToXY(54, 25);
                  write('(c) Maxymex - January 2015');

                  while (key <> 'x') and (key <> 'r') do
                    key := readkey;
                  if key = 'x' then break
                  else if key = 'r' then
                    begin
                      clrscr;
                      snakeLength := 4;
                      x[1] := 9;
                      y[1] := 12;
                      angle := 0;
                      score := 0;
                      gameRunning := true;
                    end;
                  key := ' ';
                end;

              x[-i] := x[-i - 1];
              y[-i] := y[-i - 1];

              GoToXY(x[-i], y[-i]);
              textcolor(green);
              write(snake[-i]);
            end;

          case angle of
            0: x[1] := x[1] + 2;
            1: y[1] := y[1] + 1;
            2: x[1] := x[1] - 2;
            3: y[1] := y[1] - 1;
          end;

          if (x[1] > 80) or (x[1] < 1) or (y[1] > 25) or (y[1] < 1) then
            begin
              clrscr;
              textcolor(8);
              gameRunning := false;
              GoToXY(30, 13);
              write('Game Over! Score: ', score);
              GoToXY(22, 14);
              write('Press "R" to try again, or "X" to quit...');
              GoToXY(54, 25);
              write('(c) Maxymex - January 2015');

              while (key <> 'x') and (key <> 'r') do
                key := readkey;
              if key = 'x' then break
              else if key = 'r' then
                begin
                  clrscr;
                  snakeLength := 4;
                  x[1] := 9;
                  y[1] := 12;
                  angle := 0;
                  score := 0;
                  gameRunning := true;
                end;
              key := ' ';
            end;

          GoToXY(x[1], y[1]);
          textcolor(green);
          write(snake[1]);
          GoToXY(80, 25);
        end;
    end;
end.