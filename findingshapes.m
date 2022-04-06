%% This function is going to take the matrix composed in pixeltomatrix and look for adjacent elements to find shapes

% iteratively taking the value of any pixel that is zero (black) and storing that in a new matrix of pixels, and any other value is white. 
% This is to clean the image such that shapes are easier to find as we now have the constraint that any number must be in complete black font.

function array_of_shapes = findingshapes(matrix)
    [rows, columns] = size(matrix);
    array_of_shapes = zeros(rows, columns/3);
    row = 1;
    while row <= rows
        for column = 1:columns/3
            if(matrix(row, column) == 0)
                array_of_shapes(row, column) = matrix(row, column);
            else
                array_of_shapes(row, column) = 255;
            end
            
        end
        row = row + 1;
    end
    imshow(array_of_shapes);
    fprintf("Finding shapes compiled\n");
end
