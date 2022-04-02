function fives = findingfives(matrix)
    [rows, columns] = size(matrix);
    % logic for five:
    % fives, from the highest and most leftmost point have a right branch
        % for font 72 we move 33 right initially 
    % and then move down and around that curve
        % moving down we will move until the end is zero, take the row above that
        % and then use 3 vectors to move right down and back around
    for row = 1:rows
        for column = 1:columns
            if(matrix(row, column)==0)
                test = false;  % sentinel variable
                xcrement_var = 0;
                stage = 1;  % this is going to be the variable that contains the sta
                % of the loop, i.e what vector to initialise

                while ~test
                    if(stage==1)
                        if(matrix(row, column+xcrement_var)==0 && xcrement_var < 30)
                            xcrement_var =  xcrement_var + 1;
                        elseif(xcrement_var == 30)
                            stage = stage + 1;
                            xcrement_var = 0;
                        else
                            fprintf("Not a five\n");
                            
                            fives = 0;
                            return;
                        end
                    elseif(stage==2)
                        if(matrix(row+xcrement_var, column)==0 && xcrement_var < 33)
                            xcrement_var =  xcrement_var + 1;
                        elseif(xcrement_var == 33)
                            stage = stage + 1;
                            new_row = row + xcrement_var;
                            new_column = column;
                            xcrement_var = 0;
                        else
                            fprintf("Not a five\n");                            
                            fives = 0;
                            return;
                        end
                    elseif(stage == 3)
                        if(matrix(new_row, new_column+xcrement_var)==0 && xcrement_var < 23)
                            xcrement_var =  xcrement_var + 1;
                        elseif(xcrement_var == 23)
                            stage = stage + 1;
                            new_column = new_column + xcrement_var;
                            xcrement_var = 0;
                        else
                            fprintf("Not a five\n");
                            fives = 0;
                            return;
                        end
                    elseif(stage == 4)
                        if(matrix(new_row + xcrement_var, new_column+xcrement_var)==0 && xcrement_var < 16)
                            xcrement_var =  xcrement_var + 1;
                        elseif(xcrement_var == 16)
                            stage = stage + 1;
                            new_row = new_row + xcrement_var + 4;
                            new_column = new_column + xcrement_var;
                            xcrement_var =0;
                        else
                            fprintf("Not a five\n");
                            fives = 0;
                            return;
                        end
                    elseif(stage == 5)
                        if(matrix(new_row - xcrement_var, new_column-xcrement_var)==0 && xcrement_var < 18)
                            xcrement_var =  xcrement_var + 1;
                        elseif(xcrement_var == 18)
                            stage = stage + 1;
                            new_row = new_row + xcrement_var;
                            new_column = new_column - xcrement_var;
                            xcrement_var = 0;
                        else
                            fprintf("Not a five\n");
                            fives = 0;
                            return;
                        end
                    elseif(stage == 6)
                        if(matrix(new_row, new_column-xcrement_var)==0 && xcrement_var < 27)
                            xcrement_var =  xcrement_var + 1;
                        elseif(xcrement_var == 27)
                            test = true;
                        else
                            fprintf("Not a five\n");
%                             fprintf("1");
%                             fprintf("%d, %d", row, column+xcrement_var);
                            fives = 0;
                            return;
                        end
                    else
                        test = true;
                    end
                end

                fprintf("A five was found\n");
                fives = 1;
                return;
            end
        end
    end
    fives = 0;
end