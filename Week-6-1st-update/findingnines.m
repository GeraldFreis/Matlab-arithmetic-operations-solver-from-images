function nines = findingnines(matrix)
    [rows, columns] = size(matrix); % finding the number of rows and columns in the matrix

    % logic for nines:
        % as with the number 8, we can multithread nine by taking two vectors at the same time, around
            % the initial circular aspect of the nine
            % we will do this by initially moving 8 rows and columns outwards from the centre of the top of
            % the 9, which we will adjust by having new variables for each vector
                % column_left will be the updated column from which the left vector must initialise itself
                    % every stage
                % column_right will be the updated column from which the right vector must initialise itself
                    % after every stage
                % new_row will be the row for both vectors, until the proportions need to differ (i.e we need
                    % to focus on applying either vector individually, at which point we will use new_row for the
                    % row element of the right vector, and new_row_left as the element for the left vector.
            % if every pixel that we iterated across in the previous vectors was black, we have passed
            % the first stage, and hence can move another 13 rows and columns outward with each vector
            % if this passes we can now move 12 rows down with either vector, as we are on the outside
                % of the curve of the nine on either side of the nine.

            % now we need to focus on the left vector, as our right vector is on the almost vertical
            % right side of the nine.
                % first we will move 20 down and then 9 right and down to take us inwards from the outside of the circular
                % curve of the 9, and if every pixel iterated over is black we just need to move 23
                % pixels to the right. This is because we are on the almost horizontal middle branch of
                % the 9. By moving 23 the terminal point for the left vector is almost on the vertical branch of
                % the 9. We just need to now move 4 up and right and we are on the vertical branch of the nine.

            % now we can continue with the right vector
                % as we are along the vertical branch of the 9 we want to move downwards, down
                % and left, and the leftwards and this will bring us to the end of the 'tail' of the 9
                % We will do this by iterating 14 rows down with the right vector
                % if all of the pixels it iterates over are black, we will then move 18 columns down and
                % left
                % if all of these pixels are once more black, it moves 25 columns left. And if that pixel
                % is still black we have passed all of our tests for the number 9, and hence the number
                % we are iterating over is a nine.
                % we can then return nines = 1; as one nine was found and return to the calling function
             
    % iterating over every pixel in the matrix to check if the pixel is a zero (black) and if so applying
    % our logic to test if it is a nine onto that pixel and the surrounding number.
    for row = 1:rows
        for column = 1:columns
            if(matrix(row, column)==0) % if the pixel is black applying our logic
                
                % intialising variables
                column_left = column+2; % we will use this var to control the column of our left vector
                column_right = column_left; % we will use this var to control the column of our right vector
                new_row = row; % this var controls the initial rows of both vector, and will control the row of the right vector after the first stage has been passed
                test = false; % controls the while loop
                stage = 1; % stage will determine what vector to apply, if the test for the current vector has passed
                xcrement_var = 0;% variable to move the 'cursor' over each pixel by changing the row and column (i.e it will be added to row to symbolise moving down and added to column to symbolise moving right)
    
                while ~test
                    if(stage == 1) % moving 8 columns down and outwards
                        if(matrix(new_row+xcrement_var, column_left-xcrement_var)==0 ...
                                && matrix(new_row+xcrement_var, column_right+xcrement_var)==0 ...
                                && xcrement_var < 8) % if the current pixel iterated over is still black and the length of the current vector is less than that required
                            xcrement_var = xcrement_var + 1;
                        elseif(xcrement_var == 8) % if every pixel iterated over was black we have made it to the end of this vector and hence can move to the next stage / vector
                            column_right = column_right+xcrement_var;  % updating the row and column so that the terminal row and column of this vector are the initial row and columns of the next vector
                            column_left = column_left - xcrement_var;
                            new_row = new_row + xcrement_var;
                            new_row_left = new_row - 7;
                            stage = stage + 1;
                            xcrement_var = 0;
                        else % if a pixel we iterate over is not black returning to the main file as the vector test has not been passed
                            fprintf("Not a nine");
                            nines = 0;
                            return;
                        end
                        
                    elseif(stage==2) % moving 13 pixels down and outwards
                        if(matrix(new_row_left+xcrement_var, column_left - xcrement_var)==0 ...
                                && matrix(new_row + xcrement_var, column_right+xcrement_var)==0 ...
                                && xcrement_var < 13) % if the current pixel iterated over is still black and the length of the current vector is less than that required
                            xcrement_var = xcrement_var + 1;
                        elseif(xcrement_var == 13) % if every pixel iterated over was black we have made it to the end of this vector and hence can move to the next stage / vector
                            new_row_left = new_row_left + xcrement_var;  % updating the row and column so that the terminal row and column of this vector are the initial row and columns of the next vector
                            column_left = column_left - xcrement_var;
                            column_right = column_right + xcrement_var;
                            new_row = new_row + xcrement_var;
                            stage = stage + 1;
                            xcrement_var = 0;
                        else % if a pixel we iterate over is not black returning to the main file as the vector test has not been passed
                            fprintf("Not a nine");
                            nines = 0;
                            return;
                        end
                    
                    elseif(stage==3) % moving 20 pixels down on each side of the 9
                        if(matrix(new_row_left + xcrement_var, column_left)==0 ...
                                && matrix(new_row+xcrement_var, column_right)==0 ...
                                && xcrement_var < 20) % if the current pixel iterated over is still black and the length of the current vector is less than that required
                            xcrement_var = xcrement_var + 1;
                        elseif(xcrement_var == 20) % if every pixel iterated over was black we have made it to the end of this vector and hence can move to the next stage / vector
                            new_row_left = new_row_left + xcrement_var;  % updating the row and column so that the terminal row and column of this vector are the initial row and columns of the next vector
                            new_row = new_row + xcrement_var;
                            stage = stage + 1;
                            xcrement_var = 0;
                        else % if a pixel we iterate over is not black returning to the main file as the vector test has not been passed
                            fprintf("Not a nine");
                            nines = 0;
                            return;
                        end
    
                    elseif(stage==4)  % focusing on the left vector
                            % moving 9 pixels down and inwards around the curve of the 9's circular top
                            if(matrix(new_row_left+xcrement_var, column_left+xcrement_var)==0 ...
                                    && xcrement_var < 9) % if the current pixel iterated over is still black and the length of the current vector is less than that required
                                xcrement_var = xcrement_var + 1;
                            elseif(xcrement_var == 9) % if every pixel iterated over was black we have made it to the end of this vector and hence can move to the next stage / vector
                                new_row_left = new_row_left + xcrement_var;  % updating the row and column so that the terminal row and column of this vector are the initial row and columns of the next vector
                                column_left = column_left + xcrement_var;
                                xcrement_var = 0;
                                stage = stage + 1;
                            else % if a pixel we iterate over is not black returning to the main file as the vector test has not been passed
                                fprintf("Not a nine");
                                nines = 0;
                                return;
                            end
            
                    elseif(stage==5) % moving 23 pixels to the right around the bottom of the 9's circular component
                        if(matrix(new_row_left, column_left+xcrement_var)==0 ...
                                && xcrement_var < 23) % if the current pixel iterated over is still black and the length of the current vector is less than that required
                            xcrement_var = xcrement_var + 1;
                        elseif(xcrement_var == 23) % if every pixel iterated over was black we have made it to the end of this vector and hence can move to the next stage / vector
                            column_left = column_left + xcrement_var;  % updating the column so that the terminal row and column of this vector are the initial row and columns of the next vector
                            xcrement_var = 0;
                            stage = stage + 1;
                        else % if a pixel we iterate over is not black returning to the main file as the vector test has not been passed
                            fprintf("Not a nine");
                            nines = 0;
                            return;
                        end
                        
                    elseif(stage==6) % moving 4 pixels up and right and linking into the vertical component of the nine (on the right)
                        if(matrix(new_row_left-xcrement_var, column_left+xcrement_var)==0 ...
                                && xcrement_var < 4) % if the current pixel iterated over is still black and the length of the current vector is less than that required
                            xcrement_var = xcrement_var + 1;
                        elseif(xcrement_var == 4) % if every pixel iterated over was black we have made it to the end of this vector and hence can move to the next stage / vector
                            stage = stage + 1;
                            xcrement_var = 0;
                        else % if a pixel we iterate over is not black returning to the main file as the vector test has not been passed
                            fprintf("Not a nine");
                            nines = 0;
                            return;
                        end
                        
                    % continuing with the right branch
                    elseif(stage==7) % moving 14 rows downwards with the right vector
                        if(matrix(new_row+xcrement_var, column_right)==0 ...
                                && xcrement_var < 14) % if the current pixel iterated over is still black and the length of the current vector is less than that required
                            xcrement_var = xcrement_var + 1;
                        elseif(xcrement_var == 14) % if every pixel iterated over was black we have made it to the end of this vector and hence can move to the next stage / vector
                            new_row = new_row+xcrement_var;  % updating the row so that the terminal row and column of this vector are the initial row and columns of the next vector
                            xcrement_var = 0;
                            stage = stage + 1;
                        else % if a pixel we iterate over is not black returning to the main file as the vector test has not been passed
                            fprintf("Not a nine");
                            nines = 0;
                            return;
                        end
                        
                    elseif(stage==8) % moving 18 pixels down and left with the right vector
                        if(matrix(new_row+xcrement_var, column_right-xcrement_var)==0 ...
                                && xcrement_var < 18) % if the current pixel iterated over is still black and the length of the current vector is less than that required
                            xcrement_var = xcrement_var + 1;
                        elseif(xcrement_var == 18) % if every pixel iterated over was black we have made it to the end of this vector and hence can move to the next stage / vector
                            new_row = new_row + xcrement_var;  % updating the row and column so that the terminal row and column of this vector are the initial row and columns of the next vector
                            column_right = column_right - xcrement_var;
                            xcrement_var = 0;
                            stage = stage + 1;                         
                        else % if a pixel we iterate over is not black returning to the main file as the vector test has not been passed
                            fprintf("Not a nine");
                            nines = 0;
                            return;
                        end
                        
                    elseif(stage==9) % moving 25 columns left with the right vector
                        if(matrix(new_row, column_right-xcrement_var)==0 ...
                                && xcrement_var < 25) % if the current pixel iterated over is still black and the length of the current vector is less than that required
                            xcrement_var = xcrement_var + 1;
                        elseif(xcrement_var == 25) % we have reached the length of the final vector, and hence we know that the shape is a nine
                            stage = stage + 1;                         
                        else % if a pixel we iterate over is not black returning to the main file as the vector test has not been passed
                            fprintf("Not a nine");
                            nines = 0;
                            return;
                        end
                    else % as we have passed all vector tests we know that the number is a nine.
                        nines = 1;
                        fprintf("A nine was found");
                        return;    
                    end
                end
            end
        end
    end
    nines = 0;
end