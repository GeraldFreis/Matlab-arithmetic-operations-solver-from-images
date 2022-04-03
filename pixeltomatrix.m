function array_of_img = pixeltomatrix(pics)
    
    %% producing a matrix of gradients from the greyscaled image
    
    % initialising the image we want to read and producing the size of the
    % array we need
    img = imread(pics, 'png');
%     pixe = [];
    [rows, columns] = size(img);
    array_of_img = zeros(rows, columns);
    
    % iterating through each pixel of the image and adding its greyscale  colour to the
    % matrix
    % we are going to do this by creating a new page of dimension 257*257 
    % for each iteration and append this to the array_of_img vector
    for i = 1:rows
        for j = 1:columns % j = 1: 3: 257
            array_of_img(i, j) = img(i, j);
        end

    end
    
    % ensuring that the program works
    fprintf("Matrix compiled\n");
    % returning the multi-dimensional array created
%     convertingimage = array_of_img;
end
